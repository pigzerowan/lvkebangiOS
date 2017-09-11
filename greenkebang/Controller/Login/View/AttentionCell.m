//
//  AttentionCell.m
//  greenkebang
//
//  Created by 郑渊文 on 12/14/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "AttentionCell.h"
#import "UIView+DKAddition.h"
#import <UIImageView+WebCache.h>


@implementation AttentionCell

#pragma mark - Life Cycle
- (void)dealloc
{
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.backImageView];
        [self.contentView addSubview:self.goodsImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.attentionBtn];
        [self.contentView addSubview:self.passLabel];

    }
    return self;
}
- (void)configDiscoveryCircleCellWithModel:(GroupDetailModel *)good
{
    
    
    [self.goodsImageView sd_setImageWithURL:[good.groupAvatar lkbImageUrl5] placeholderImage:YQNormalPlaceImage];
    self.nameLabel.text = good.groupName;
    
    if ([good.passStatus isEqualToString:@"0"]) {
    
        self.goodsImageView.alpha = 0.4;
        self.passLabel.hidden = NO;
        self.nameLabel.textColor = CCCUIColorFromHex(0x999999);
        self.backImageView.hidden = YES;
        self.nameLabel.hidden = NO;
        
    }
    else {
        self.goodsImageView.alpha = 1;
        self.passLabel.hidden = YES;
        self.nameLabel.textColor = CCCUIColorFromHex(0x333333);
        self.backImageView.hidden = NO;
        self.nameLabel.hidden = NO;

    }
    
}

- (void)configDiscoveryOtherFallCellWithModel:(friendModel *)good
{
//    NSString *str = @"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg";

    friendModel *model = (friendModel *)good;

    
    
    [self.goodsImageView sd_setImageWithURL:[model.avatar lkbImageUrl4] placeholderImage:LKBSecruitPlaceImage];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.userName];
    
}

#pragma mark - Event response
- (void)loveButtonDidClicked:(id)sender
{
    
}
#pragma mark - Accessors

- (UIImageView*)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.backgroundColor = [UIColor clearColor];
        
        if (iPhone5) {
            _backImageView.frame = CGRectMake(1.5, -5, 71, 71);
            _backImageView.layer.cornerRadius = 29;
            [_backImageView setImage:[UIImage imageNamed:@"circleBack_5"]];

            
        }
        else if (iPhone6p) {
            
            _backImageView.frame = CGRectMake(1.5, -5, 73, 73);
            _backImageView.layer.cornerRadius = 30;
            [_backImageView setImage:[UIImage imageNamed:@"circleBack_6p"]];

        }
        else {
            _backImageView.frame = CGRectMake(1.5,-5, 73, 73);
            _backImageView.layer.cornerRadius = 30;
            [_backImageView setImage:[UIImage imageNamed:@"circleBack_6"]];

            
            
        }
        _backImageView.layer.masksToBounds = YES;
    }
    return _backImageView;
}




- (UIImageView*)goodsImageView
{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        
        if (iPhone5) {
            _goodsImageView.frame = CGRectMake(8, 0, 58, 58);
            _goodsImageView.layer.cornerRadius = 29;

        }
        else {
            _goodsImageView.frame = CGRectMake(8,0, 60, 60);
            _goodsImageView.layer.cornerRadius = 30;


        }
        _goodsImageView.layer.masksToBounds = YES;
        _goodsImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        // 描边
//        _goodsImageView.layer.cornerRadius = 50.0f;
//        _goodsImageView.layer.borderWidth = 1.0f;
//        _goodsImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        //添加两个边阴影
//        _goodsImageView.layer.shadowColor = [UIColor blackColor].CGColor;
//        _goodsImageView.layer.shadowOffset = CGSizeMake(0, 4);
//        _goodsImageView.layer.shadowOpacity = 0.5;
//        _goodsImageView.layer.shadowRadius = 2.0;
        //添加四个边阴影
//        _goodsImageView.layer.shadowColor = [UIColor blackColor].CGColor;
//        _goodsImageView.layer.shadowOffset = CGSizeMake(0,2);
//        _goodsImageView.layer.shadowOpacity = 0.2;//不透明度
//        _goodsImageView.layer.shadowRadius =2.0; //半径
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _goodsImageView;
}
- (UILabel*)nameLabel
{
    
    if (!_nameLabel) {
//        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (CGRectGetWidth(self.contentView.bounds) ), CGRectGetWidth(self.contentView.bounds) - 10, 20)];
        _nameLabel = [[UILabel alloc] init];
        if (iPhone5) {
            _nameLabel.frame = CGRectMake(0, 70, CGRectGetWidth(self.contentView.bounds) , 20);
        }
        else {
            
            _nameLabel.frame = CGRectMake(0, 70, CGRectGetWidth(self.contentView.bounds) , 20);
        }

        _nameLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _nameLabel.numberOfLines = 2;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}


- (UIImageView *)attentionBtn
{
    if (!_attentionBtn) {
        _attentionBtn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _attentionBtn.frame = CGRectMake( (CGRectGetWidth(self.contentView.bounds))-30,  (CGRectGetHeight(self.contentView.bounds)-50 ), 20, 20);
        _attentionBtn.backgroundColor = [UIColor clearColor];
       
    }
    return _attentionBtn;
}
- (UILabel *)passLabel {
    
    if (!_passLabel) {
        _passLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 22.5, 60, 15)];
        _passLabel.textAlignment = NSTextAlignmentCenter;
        _passLabel.textColor = CCCUIColorFromHex(0x333333);
        _passLabel.text = @"审核中";
    }
    return _passLabel;
}


- (void)setChecked:(BOOL)checked{
    if (checked)
    {
        _attentionBtn.image = [UIImage imageNamed:@"RecommendedFriends_Selected"];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
    }
    else
    {
        _attentionBtn.image = [UIImage imageNamed:@""];
        _attentionBtn.backgroundColor = [UIColor clearColor];
        self.backgroundView.backgroundColor = [UIColor clearColor];
    }
    m_checked = checked;
  
}
@end
