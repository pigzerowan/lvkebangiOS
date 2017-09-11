//
//  ShareEditViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 12/5/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "ShareEditViewController.h"
#import "ZFActionSheet.h"
#import <UIImageView+WebCache.h>
#import "ShareArticleManager.h"
#import "MyUserInfoManager.h"
@interface ShareEditViewController ()<ZFActionSheetDelegate,UITextViewDelegate>

@property(nonatomic,strong)UITextView* shareTextView;
@property(nonatomic,strong)UIImageView* shareImg;
@property(nonatomic,strong)UIView* lableBackView;
@property(nonatomic,strong)UILabel* shareLable;
@property(nonatomic, strong)UIButton *publish;
@property (strong, nonatomic)ZFActionSheet *actionSheet;


@end

@implementation ShareEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    
    
    // 发布按钮
    _publish = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -48 - 8 , 8, 48, 33)];
    _publish.layer.cornerRadius = 3;
    _publish.backgroundColor = CCCUIColorFromHex(0x22a941);
    [_publish setTitle:@"发布" forState:UIControlStateNormal];
    [_publish addTarget:self action:@selector(publishButton:) forControlEvents:UIControlEventTouchUpInside];
    _publish.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.navigationController.navigationBar addSubview:_publish];
    
    [_shareTextView becomeFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_publish removeFromSuperview];
}


-(void)backToMain
{
    //    [self.navigationController popViewControllerAnimated:YES];
    
    [_shareTextView resignFirstResponder];
    
//    _actionSheet = [ZFActionSheet actionSheetWithTitle:@"退出后资料信息将不被保存" confirms:@[@"放弃分享",@"继续分享"] cancel:@"取消" style:ZFActionSheetStyleDefault];
//    _actionSheet.delegate = self;
//    [_actionSheet showInView:self.view.window];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]                                              animated:YES];

}

// 发布
-(void)publishButton:(id)sender
{
    
    
    if ([self stringContainsEmoji:_shareTextView.text] == YES) {
        
        [XHToast showTopWithText:@"不支持输入表情" topOffset:60.0];
        
    }
    else {
        if ([_shareTextView.text isEqualToString:@"这一刻的想法"]) {
            
            _shareTextView.text = @"";
        }

        
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"groupId":[ShareArticleManager shareInstance].groupId,
                              @"content":_shareTextView.text,
//                              @"shareObjId":[ShareArticleManager shareInstance].shareObjId,
//                              @"shareType":[ShareArticleManager shareInstance].shareType,
                              @"shareTitle":[ShareArticleManager shareInstance].shareTitle,
                              @"shareUrl":[ShareArticleManager shareInstance].shareUrl,
                              @"shareImage":[ShareArticleManager shareInstance].shareImage,
                              @"token":[MyUserInfoManager shareInstance].token
                              };
        self.requestURL = LKB_Agriculture_sharepub_Url;

    }

}

// 判断是否有表情
- (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }

    
    if(self.requestURL == LKB_Agriculture_sharepub_Url)
    {
        
        LKBBaseModel* responseModel = (LKBBaseModel*)parserObject;
        
        if ([responseModel.success isEqualToString:@"1"]) {
            [XHToast showTopWithText:responseModel.msg topOffset:60.0];
            
            if ([[ShareArticleManager shareInstance].shareType isEqualToString:@"1"]) {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]                                              animated:YES];
                

            }
            else {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3]                                              animated:YES];

            }

            

        }
        

    }
    
}




#pragma mark - ZFActionSheetDelegate
- (void)clickAction:(ZFActionSheet *)actionSheet atIndex:(NSUInteger)index
{
    NSLog(@"选中了 %zd",index);
    
    
    if (index==1) {
        
    }else
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]                                              animated:YES];
        
    }
}


-(void)initSubViews
{
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [backBtn setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    NSURL *url = [NSURL URLWithString:[ShareArticleManager shareInstance].shareImage];
    
    
    [self.shareImg sd_setImageWithURL:url placeholderImage:YQNormalUserSharePlaceImage];
    self.shareLable.text = [ShareArticleManager shareInstance].shareTitle;

    
    
    [self.view addSubview:self.shareTextView];
    [self.view addSubview:self.shareImg];
    [self.view addSubview:self.lableBackView];
    [self.view addSubview:self.shareLable];
    
    //    [self.view addSubview:self.nextBtn];
    
    //    CGFloat padding = iPhone4 ? 24 : 44;
    
    [_shareTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.view.left).offset(16);
        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-16, 100));
    }];
    
    
    [_shareImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_shareTextView.bottom).offset(17);
        make.left.mas_equalTo(self.view).offset(14);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        

    }];
    
    [_lableBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_shareTextView.bottom).offset(17);
        make.left.mas_equalTo(_shareImg.right).offset(0);
        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-88, 60));
        
    }];

    
    [_shareLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_shareTextView.bottom).offset(17);
        make.left.mas_equalTo(_lableBackView.left).offset(12);
        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-112, 60));

    }];
    
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"这一刻的想法"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"这一刻的想法";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

#pragma mark - Getters & Setters
- (UITextView*)shareTextView
{
    if (!_shareTextView) {
        
        _shareTextView = [[UITextView alloc] init];
        _shareTextView.font = [UIFont systemFontOfSize:15];
        _shareTextView.text = @"这一刻的想法";
        _shareTextView.textColor = [UIColor lightGrayColor];
        _shareTextView.delegate = self;
        [_shareTextView setTintColor:[UIColor LkbgreenColor]];

        _shareTextView.textAlignment = NSTextAlignmentLeft;

        
        
    }
    return _shareTextView;
}


- (UIView *)lableBackView {
    
    if (!_lableBackView) {
        _lableBackView = [[UIView alloc]init];
        _lableBackView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    }
    return _lableBackView;
}




- (UILabel*)shareLable
{
    if (!_shareLable) {
        _shareLable = [[UILabel alloc] init];
        _shareLable.textAlignment = NSTextAlignmentLeft;
        _shareLable.numberOfLines = 2;
        _shareLable.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        _shareLable.font = [UIFont systemFontOfSize:14];
        _shareLable.textColor = CCCUIColorFromHex(0x333333);
        _shareLable.lineBreakMode = NSLineBreakByTruncatingTail;
        
    }
    return _shareLable;
}

- (UIImageView *)shareImg
{
    if (!_shareImg) {
        _shareImg = [[UIImageView alloc]init];
        _shareImg.backgroundColor = CCCUIColorFromHex(0xdddddd);
    }
    return _shareImg;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
