//
//  TLTagsControl.m
//  TagsInputSample
//
//  Created by Антон Кузнецов on 11.02.15.
//  Copyright (c) 2015 TheLightPrjg. All rights reserved.
//

#import "TLTagsControl.h"
#import "MBProgressHUD+Add.h"
@interface TLTagsControl () <UITextFieldDelegate, UIGestureRecognizerDelegate, MBProgressHUDDelegate>

@property (strong, nonatomic) MBProgressHUD * hud;

@end

@implementation TLTagsControl {
//    UITextField                 *tagInputField_;
//    NSMutableArray              *tagSubviews_;
}

@synthesize tapDelegate;

- (instancetype)init {
    self = [super init];
    
    if (self != nil) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags withTagsControlMode:(TLTagsControlMode)mode {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        [self commonInit];
        [self setTags:[[NSMutableArray alloc]initWithArray:tags]];
        [self setMode:mode];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self != nil) {
        [self commonInit];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit {
    _tags = [NSMutableArray array];
    
    self.layer.cornerRadius = 5;
    
    _tagSubviews_ = [NSMutableArray array];
    
    _tagInputField_
    
    = [[UITextField alloc] initWithFrame:self.frame];
    _tagInputField_.layer.cornerRadius = 5;
    _tagInputField_.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    _tagInputField_.backgroundColor =  [UIColor whiteColor];
    _tagInputField_.delegate = self;
    _tagInputField_.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    _tagInputField_.placeholder = @"添加标签(可选填多个，用Return键生成)";
    [_tagInputField_ setValue:CCCUIColorFromHex(0x888888) forKeyPath:@"_placeholderLabel.textColor"];

    _tagInputField_.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (_mode == TLTagsControlModeEdit) {
        [self addSubview:_tagInputField_];
    }
}

#pragma mark - layout stuff

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize contentSize = self.contentSize;
    CGRect frame = CGRectMake(0, 0, 100, self.frame.size.height);
    CGRect tempViewFrame;
    NSInteger tagIndex = 0;
    for (UIView *view in _tagSubviews_) {
        tempViewFrame = view.frame;
        NSInteger index = [_tagSubviews_ indexOfObject:view];
        if (index != 0) {
            UIView *prevView = _tagSubviews_[index - 1];
            tempViewFrame.origin.x = prevView.frame.origin.x + prevView.frame.size.width + 4;
        } else {
            tempViewFrame.origin.x = 0;
        }
        tempViewFrame.origin.y = frame.origin.y =10;
        view.frame = tempViewFrame;
        
        if (_mode == TLTagsControlModeList) {
            view.tag = tagIndex;
            
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
            [tapRecognizer setNumberOfTapsRequired:1];
            [tapRecognizer setDelegate:self];
            [view setUserInteractionEnabled:YES];
            [view addGestureRecognizer:tapRecognizer];
        }
        
        tagIndex++;
    }
    
    if (_mode == TLTagsControlModeEdit) {
        frame = _tagInputField_.frame;
//        frame.size.height = self.frame.size.height;
        frame.size.height = 36;

        frame.origin.y = 10;
        
        if (_tagSubviews_.count == 0) {
            frame.origin.x = 7;
        } else {
            UIView *view = _tagSubviews_.lastObject;
            frame.origin.x = view.frame.origin.x + view.frame.size.width + 4;
        }
        
        if (self.frame.size.width - _tagInputField_.frame.origin.x > 100) {
            frame.size.width = self.frame.size.width - frame.origin.x - 12;
        } else {
            frame.size.width = 100;
        }
        _tagInputField_.frame = frame;
    } else {
        UIView *lastTag = _tagSubviews_.lastObject;
        if (lastTag != nil) {
            frame = lastTag.frame;
        } else {
            frame.origin.x = 7;
        }
    }
    
    contentSize.width = frame.origin.x + frame.size.width;
    contentSize.height = self.frame.size.height;
    
    self.contentSize = contentSize;
    
    _tagInputField_.placeholder = (_tagPlaceholder == nil) ? @"添加标签(可选填多个，用Return键生成)" : _tagPlaceholder;
    
    
    NSLog(@"==============================================%@",_tagInputField_.text);

}

- (void)addTag:(NSString *)tag {
    
    if (_tags.count < 5 ) {
        
        for (NSString *oldTag in _tags) {
            if ([oldTag isEqualToString:tag]) {
                return;
            }
        }
        _tagText = tag;
        
        NSLog(@"==================(((((((============================%@",_tagInputField_.text);
        NSLog(@"============~~~~~~~~~~~==================================%@",_tagText);

        
        [_tags addObject:tag];
        [self reloadTagSubviews];
        
        
        CGSize contentSize = self.contentSize;
        CGPoint offset = self.contentOffset;
        
        if (contentSize.width > self.frame.size.width) {
            if (_mode == TLTagsControlModeEdit) {
                offset.x = _tagInputField_.frame.origin.x + _tagInputField_.frame.size.width - self.frame.size.width;
            } else {
                UIView *lastTag = _tagSubviews_.lastObject;
                offset.x = lastTag.frame.origin.x + lastTag.frame.size.width - self.frame.size.width;
            }
        } else {
            offset.x = 0;
        }
        
        self.contentOffset = offset;

    }
    
    else {
        
        [self ShowProgressHUDwithMessage:@"最多添加5个标签哦~"];
    }

    
}

- (void)reloadTagSubviews {
    
    for (UIView *view in _tagSubviews_) {
        [view removeFromSuperview];
    }
    
    [_tagSubviews_ removeAllObjects];
    
    UIColor *tagBackgrounColor = _tagsBackgroundColor != nil ? _tagsBackgroundColor : CCCUIColorFromHex(0x18c56a);
    UIColor *tagTextColor = _tagsTextColor != nil ? _tagsTextColor : [UIColor whiteColor];
    UIColor *tagDeleteButtonColor = _tagsDeleteButtonColor != nil ? _tagsDeleteButtonColor : [UIColor whiteColor];
    
    
    
    for (NSString *tag in _tags) {
        float width = [tag boundingRectWithSize:CGSizeMake(3000,_tagInputField_.frame.size.height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:_tagInputField_.font}
                                        context:nil].size.width;
        
        UIView *tagView = [[UIView alloc] initWithFrame:_tagInputField_.frame];
        CGRect tagFrame = tagView.frame;
        tagView.layer.cornerRadius = 5;
        tagFrame.origin.y = _tagInputField_.frame.origin.y;
        tagView.backgroundColor = tagBackgrounColor;
        
        UILabel *tagLabel = [[UILabel alloc] init];
        CGRect labelFrame = tagLabel.frame;
        tagLabel.font = _tagInputField_.font;
        labelFrame.size.width = width + 16;
        labelFrame.size.height = _tagInputField_.frame.size.height;
        tagLabel.text = tag;
        tagLabel.textColor = tagTextColor;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.clipsToBounds = YES;
        tagLabel.layer.cornerRadius = 5;
        
        if (_mode == TLTagsControlModeEdit) {
            UIButton *deleteTagButton = [[UIButton alloc] initWithFrame:_tagInputField_.frame];
            CGRect buttonFrame = deleteTagButton.frame;
            [deleteTagButton.titleLabel setFont:_tagInputField_.font];
            [deleteTagButton addTarget:self action:@selector(deleteTagButton:) forControlEvents:UIControlEventTouchUpInside];
            buttonFrame.size.width = deleteTagButton.frame.size.height;
            buttonFrame.size.height = _tagInputField_.frame.size.height;
            [deleteTagButton setTag:_tagSubviews_.count];
            [deleteTagButton setTitle:@"✕" forState:UIControlStateNormal];
            [deleteTagButton setTitleColor:tagDeleteButtonColor forState:UIControlStateNormal];
            buttonFrame.origin.y = 0;
            buttonFrame.origin.x = labelFrame.size.width;
            
            deleteTagButton.frame = buttonFrame;
            tagFrame.size.width = labelFrame.size.width + buttonFrame.size.width;
            [tagView addSubview:deleteTagButton];
            labelFrame.origin.x = 0;
        } else {
            tagFrame.size.width = labelFrame.size.width + 5;
            labelFrame.origin.x = (tagFrame.size.width - labelFrame.size.width) * 0.5;
        }
        
        [tagView addSubview:tagLabel];
        labelFrame.origin.y = 0;
        UIView *lastView = _tagSubviews_.lastObject;
        
        if (lastView != nil) {
            tagFrame.origin.x = lastView.frame.origin.x + lastView.frame.size.width + 4;
        }
        
        tagLabel.frame = labelFrame;
        tagView.frame = tagFrame;
        [_tagSubviews_ addObject:tagView];
        [self addSubview:tagView];
    }
    
    
    if (_mode == TLTagsControlModeEdit) {
        if (_tagInputField_.superview == nil) {
            [self addSubview:_tagInputField_];
            
        }
        CGRect frame = _tagInputField_.frame;
        if (_tagSubviews_.count == 0) {
            frame.origin.x = 7;
        } else {
            UIView *view = _tagSubviews_.lastObject;
            frame.origin.x = view.frame.origin.x + view.frame.size.width + 4;
        }
        _tagInputField_.frame = frame;
        
    } else {
        if (_tagInputField_.superview != nil) {
            [_tagInputField_ removeFromSuperview];
        }
    }
    
    [self setNeedsLayout];
}

#pragma mark - buttons handlers

- (void)deleteTagButton:(UIButton *)sender {
    
    UIView *view = sender.superview;
    [view removeFromSuperview];
    
    NSInteger index = [_tagSubviews_ indexOfObject:view];
    [_tags removeObjectAtIndex:index];
    [self reloadTagSubviews];
}

- (void)tagButtonPressed:(id)sender {
    
    UIButton *button = sender;
    
    _tagInputField_.text = @"";
    [self addTag:button.titleLabel.text];
}

#pragma mark - textfield stuff

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length > 0) {
        NSString *tag = textField.text;
        textField.text = @"";
        [self addTag:tag];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *resultingString;
    NSString *text = textField.text;
    
    
    if (string.length == 1 && [string rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
        return NO;
    } else {
        if (!text || [text isEqualToString:@""]) {
            resultingString = string;
        } else {
            if (range.location + range.length > text.length) {
                range.length = text.length - range.location;
            }
            
            resultingString = [textField.text stringByReplacingCharactersInRange:range
                                                                      withString:string];
        }
        
//        NSArray *components = [resultingString componentsSeparatedByCharactersInSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]];
//        
//        if (components.count > 8) {
//            for (NSString *component in components) {
//                if (component.length > 0 && [component rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location == NSNotFound) {
//                    [self addTag:component];
//                    break;
//                }
//            }
//            
//            return NO;
//        }
//        
        return YES;
    }
}

#pragma mark - other

- (void)setMode:(TLTagsControlMode)mode {
    _mode = mode;
}

- (void)setTags:(NSMutableArray *)tags {
    _tags = tags;
    
}

- (void)setPlaceholder:(NSString *)tagPlaceholder {
    _tagPlaceholder = tagPlaceholder;
}

- (void)gestureAction:(id)sender {
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    [tapDelegate tagsControl:self tappedAtIndex:tapRecognizer.view.tag];
}


- (void)ShowProgressHUDwithMessage:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.dimBackground = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}



//#pragma mark - 屏幕上弹
//-( void )textFieldDidBeginEditing:(UITextField *)textField
//{
//    //键盘高度216
//    
//    //滑动效果（动画）
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
//    self.frame = CGRectMake(0.0f, -120.0f, self.frame.size.width, self.frame.size.height ); //64-216
//    
//    [UIView commitAnimations];
//}

//#pragma mark -屏幕恢复
//-( void )textFieldDidEndEditing:(UITextField *)textField
//{
//    //滑动效果
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //恢复屏幕
//    self.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height); //64-216
//    
//    [UIView commitAnimations];
//}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com