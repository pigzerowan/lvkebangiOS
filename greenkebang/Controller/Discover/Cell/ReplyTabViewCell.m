//
//  ReplyTabViewCell.m
//  greenkebang
//
//  Created by 郑渊文 on 9/23/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "ReplyTabViewCell.h"

@implementation ReplyTabViewCell
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =  [UIColor whiteColor];
        
        [self initLayuot];
        
    }
    return self;
}
//初始化控件
-(void)initLayuot{
    
    _borthView = [[UILabel alloc] init];
    _borthView.layer.borderWidth=1;
    _borthView.backgroundColor = [UIColor whiteColor];
    _borthView.layer.borderColor = UIColorWithRGBA(237, 238, 239, 1).CGColor;
    [self addSubview:_borthView];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(36, 10, 250, 10)];
    _name.textColor = CCCUIColorFromHex(0x333333);
    _name.font = [UIFont systemFontOfSize:10];
    [self addSubview:_name];
    
    UIView *controllerView = [[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth *0.6,5, kDeviceWidth*0.3, 30)];
    
    
    [controllerView addSubview:self.replyBtn];
    [controllerView addSubview:self.loveBtn];
    [self addSubview:controllerView];
    
    UIView *linView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    linView.backgroundColor = UIColorWithRGBA(237, 238, 239, 1);
    [self addSubview:linView];
    
    
    _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(36, 14, 100, 30)];
    _timeLable.font = [UIFont systemFontOfSize:10];
    _timeLable.textColor = CCCUIColorFromHex(0x999999);
    [self addSubview:_timeLable];
    //    _userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    //    [self addSubview:_userImage];
    
    _userImage = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
    
    _userImage.imageView.frame = _userImage.bounds;
    _userImage.imageView.hidden = NO;
    
    [_userImage addTarget:self action:@selector(choseReply:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_userImage];
    
    _introduction = [[UITextView alloc] initWithFrame:CGRectMake(5, 35, kDeviceWidth-20, 50)];
    _introduction.editable = NO;
    _introduction.delegate = nil;
    _introduction.scrollEnabled = NO;
//    _introduction.textColor = CCCUIColorFromHex(0x333333);
//    _introduction.font = [UIFont systemFontOfSize:13];
    [self addSubview:_introduction];
    
    
}



//赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(NSAttributedString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    [self.introduction setAttributedText: text];
    //设置label的最大行数
    


    
    
    CGFloat width = kDeviceWidth-20; // whatever your desired width is
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
 
    
      self.introduction.frame = CGRectMake(self.introduction.frame.origin.x, self.introduction.frame.origin.y,    rect.size.width+10,    rect.size.height+20);
    
    
       frame.size.height = rect.size.height+60;
    
//    self.introduction.frame = CGRectMake(self.introduction.frame.origin.x, self.introduction.frame.origin.y, labelSize.width, labelSize.height+20);
    //计算出自适应的高度
//    frame.size.height = labelSize.height+60;

    self.frame = frame;
    
    //    _borthView.frame = CGRectMake(0, 1, SCREEN_WIDTH, self.frame.size.height-2);
    
}


- (void)handlerButtonAction:(BottomBuyClickBlock)block {
    
    self.clickBlock = block;
}



- (void)choseReply:(UIButton *)button {
    
    if (self.clickBlock) {
        self.clickBlock(3);
    }

    
}
#pragma mark - Event response
- (void)loveButtonClicked:(id)sender
{
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }
    
}
- (void)buyButtonClicked:(id)sender
{
    if (self.clickBlock) {
        self.clickBlock(2);
    }
}



- (UIButton *)loveBtn
{
    if (!_loveBtn) {
        _loveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loveBtn setFrame:CGRectMake(60, 0, 80, 30)];
        _loveBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        UIImage *loveImage = [UIImage imageNamed:@"icon_unPushlove"];
        
        [_loveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, loveImage.size.width, 0,0)];
        [_loveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,_loveBtn.titleLabel.bounds.size.width)];
        [_loveBtn addTarget:self action:@selector(loveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveBtn;
}




- (UIButton *)replyBtn
{
    if (!_replyBtn) {
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setFrame:CGRectMake(0, 0,70, 30)];
        _replyBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        
        //
        //        [_replyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, commentImage.size.width, 0,0)];
        //        [_replyBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,_replyBtn.titleLabel.bounds.size.width)];
        [_replyBtn setTitleColor:[UIColor textGrayColor] forState:UIControlStateNormal];
        
        
        //
        _replyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, _replyBtn.titleLabel.bounds.size.width, 0,-30);
        [_replyBtn setImage:[UIImage imageNamed:@"icon_comment"] forState:UIControlStateNormal];
        _replyBtn.imageEdgeInsets = UIEdgeInsetsMake(0,13,0,_replyBtn.titleLabel.bounds.size.width);
//        _replyBtn.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:10];
        _replyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_replyBtn addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}
@end
