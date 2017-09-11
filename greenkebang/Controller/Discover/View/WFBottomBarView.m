//
//  WFBottomBarView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFBottomBarView.h"


@implementation WFBottomBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI:frame];
        
    }
    return self;
}

- (void)configUI:(CGRect)frame{
    
    UIImageView *barBackV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50.f)];
    barBackV.backgroundColor = CCColorFromRGBA(238, 238, 238, 1);
    barBackV.layer.shadowOffset = CGSizeMake(0, - 4.f);
    barBackV.layer.shadowColor = RGBColor(198.f, 198.f, 198.f, 1).CGColor;
    [self addSubview:barBackV];
    barBackV.layer.shadowOpacity = 0.2;
    
    NSArray *imgArr = @[@"tab_hold",@"tab_up",@"tab_comment",@"tab_share"];
    NSArray *naemeArr = @[@"收藏",@"点赞",@"评论",@"分享"];

    for (NSUInteger i = 0; i < imgArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:0];
        button.tag = kBottomTag + i;
        NSInteger leftWidth= (kDeviceWidth / imgArr.count - 40)/2;

        button.frame = CGRectMake(leftWidth + (45.f + 2 * leftWidth) * i - 10, 0, 70.f, 50.f);

        [button setImage:Image(imgArr[i]) forState:0];
        button.imageEdgeInsets = UIEdgeInsetsMake(-10,0,0,0);
        [button setTitle:naemeArr[i] forState:0];
        if (iPhone5) {
            button.titleEdgeInsets = UIEdgeInsetsMake(40,-50, 10, 0);

        }
        else {
            button.titleEdgeInsets = UIEdgeInsetsMake(40,-60, 10, 0);

        }
        [button setTitleColor:[UIColor grayColor] forState:0];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [button addTarget:self action:@selector(selectBtn:) forControlEvents:1<<6];
        [self addSubview:button];
        
            }

}

#pragma mark - Setter -
// 点赞
- (void)setNextArrowsEnable:(BOOL)nextArrowsEnable{
   
    UIButton *btn = (UIButton *)[self viewWithTag:kBottomTag+1];

    if (nextArrowsEnable==YES) {
        [btn setImage:[UIImage imageNamed:@"tab_haveup"] forState:UIControlStateNormal];
    }else
    {
        [btn setImage:[UIImage imageNamed:@"tab_up"] forState:UIControlStateNormal];
    }
    _voteLabel.text = _voteNum;

}


// 收藏
-(void)setCanCollection:(BOOL)canCollection
{
    UIButton *btn = (UIButton *)[self viewWithTag:kBottomTag ];
    
    if (canCollection==YES) {
        [btn setImage:[UIImage imageNamed:@"tab_havehold"] forState:UIControlStateNormal];
    }else
    {
         [btn setImage:[UIImage imageNamed:@"tab_hold"] forState:UIControlStateNormal];

    }
    _collLabel.text = _collNum;

}

// 分享
- (void)canShare:(BOOL)canShare{
    _shareLabel.text = _shareNum;
}


// 收藏
- (void)setCollNum:(NSString *)collNum{
    
    _collLabel = [[UILabel alloc]init];
    
    if (iPhone5) {
        _collLabel.frame = CGRectMake(kDeviceWidth / 4 -40, 27, 40, 25);
    }
    else {
        _collLabel.frame = CGRectMake(kDeviceWidth / 4 -40, 27, 40, 25);
    }
    _collLabel.text = collNum;
    _collLabel.textAlignment = NSTextAlignmentLeft;
    _collLabel.textColor = [UIColor redColor];
    _collLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_collLabel];
    
}

// 点赞
- (void)setVoteNum:(NSString *)voteNum{
    
    _voteLabel= [[UILabel alloc]init];
    if (iPhone5) {
        _voteLabel.frame = CGRectMake( kDeviceWidth / 2 - (kDeviceWidth/4)/2 +5 , 27, 40, 25);
    }
    else {
        _voteLabel.frame = CGRectMake( kDeviceWidth / 2 - (kDeviceWidth/4)/2  , 27, 40, 25);
    }
    _voteLabel.text = voteNum;
    _voteLabel.textAlignment = NSTextAlignmentLeft;
    _voteLabel.textColor = [UIColor redColor];
    _voteLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_voteLabel];
}

// 评论
- (void)setCommentNum:(NSString *)commentNum{
    
    
    UILabel *label = [[UILabel alloc]init];
    
    if (iPhone5) {
        label.frame = CGRectMake(kDeviceWidth / 2 + (kDeviceWidth/4)/2 +15, 27, 40, 25);

    }
    else {
        label.frame = CGRectMake(kDeviceWidth / 2 + (kDeviceWidth/4)/2 +10, 27, 40, 25);
    }
    label.text = commentNum;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
    [self addSubview:label];
    
}


// 分享
- (void)setShareNum:(NSString *)shareNum{
    
    
    [_shareLabel removeFromSuperview];
    _shareLabel = [[UILabel alloc]init];
    if (iPhone5) {
        _shareLabel.frame = CGRectMake(kDeviceWidth- kDeviceWidth / 4 +(kDeviceWidth/4)/2 +20, 27, 40, 25);
    }
    else {
        _shareLabel.frame = CGRectMake(kDeviceWidth- kDeviceWidth / 4 +(kDeviceWidth/4)/2 +10, 27, 40, 25);
    }
    _shareLabel.text = shareNum;
    _shareLabel.textAlignment = NSTextAlignmentLeft;
    _shareLabel.textColor = [UIColor redColor];
    _shareLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_shareLabel];

}


- (void)selectBtn:(UIButton *)button{
    
    [_delegate selectBtn:button];
}
@end
