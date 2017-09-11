//
//  PushGoodNewsCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/23.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "PushGoodNewsCell.h"
#import <UIImageView+WebCache.h>
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"

@implementation PushGoodNewsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self configureSubview];
    }
    return self;
}

- (void)configPushGoodNewsCell:(NSDictionary *)dic {
    
    UIImageView *headerImge = [[UIImageView alloc]init];
    [headerImge sd_setImageWithURL:[[dic valueForKey:@"avatar"] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
    [_headerButton setImage:headerImge.image forState:UIControlStateNormal];

    _nameLabel.text = [dic valueForKey:@"userName"];
    
    NSTimeInterval time=[[dic valueForKey:@"noticeDate"] doubleValue];

    NSDate *createDate = [NSDate dateFormJavaTimestamp:time];
    self.timeLabel.text = [createDate timeAgo];
    
    if ([dic valueForKey:@"cover"]== nil && [[dic valueForKey:@"noticeContent"]isEqualToString:@""]) {
        
        NSURL *url = [NSURL URLWithString:[dic valueForKey:@"cover"]];

        [_newsImage sd_setImageWithURL:url placeholderImage:YQNormalUserSharePlaceImage];
        
        _newsLabel.hidden = YES;
        _newsNoLabel .hidden = YES;

        
    }
    else if ([dic valueForKey:@"cover"] !=nil && ![[dic valueForKey:@"noticeContent"]isEqualToString:@""]) {
        
        [_newsImage sd_setImageWithURL:[[dic valueForKey:@"cover"] lkbImageUrlAllCover ]placeholderImage:YQNormalUserSharePlaceImage];
        
        _newsLabel.hidden = YES;
        
        _newsNoLabel .hidden = YES;
    }
    else {
        
        _newsImage.hidden = YES;
        
        _newsLabel.text =[dic valueForKey:@"noticeContent"];
        
        if (_newsLabel.text.length > 8) {
            _newsNoLabel .hidden = NO;
        }else {
            
            _newsNoLabel .hidden = YES;
            
        }

        
    }
    


    
}





- (void)configureSubview
{
    
    [self.contentView addSubview:self.headerButton];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.nameButton];
    [self.contentView addSubview:self.newsView];
    [self.contentView addSubview:self.newsImage];
    [self.contentView addSubview:self.newsLabel];
    [self.contentView addSubview:self.newsNoLabel];

    [self.contentView addSubview:self.goodImage];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.lineView];

    
    
}
- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [_headerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(48, 48));

        }];
        
        [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(_headerButton.right).offset(0);
            make.right.mas_equalTo(-70);
            make.height.mas_equalTo(30);
        }];

        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(8);
            make.left.mas_equalTo(_headerButton.right).offset(9);
            make.right.mas_equalTo(-70);
            make.height.mas_equalTo(12);
        }];

        
        [_newsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(8);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        
        [_newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(8);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        [_newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(8);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(58, 58));
        }];
        
        [_newsNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(48);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(60, 10));
        }];


        [_goodImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.bottom).offset(9);
            make.left.mas_equalTo(_nameLabel);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodImage.bottom).offset(9);
            make.left.mas_equalTo(_nameLabel);
            make.right.mas_equalTo(-70);
            make.height.mas_equalTo(12);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_timeLabel.bottom).offset(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(0.5);
        }];

        
        
        
        
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (UIButton *)headerButton {
    
    if (!_headerButton) {
        _headerButton = [[UIButton alloc]init];
        _headerButton.backgroundColor = CCCUIColorFromHex(0xdddddd);
        _headerButton.layer.masksToBounds = YES;
        _headerButton.layer.cornerRadius = 24;
        [_headerButton addTarget:self action:@selector(userInfobutton:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _headerButton;
}

- (void)PushGoodNewshandlerButtonAction:(BottomBuyClickBlock)block {
    
    self.clickBlock = block;

    
}
-(void)userInfobutton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }
    
}

- (UIButton *)nameButton {
    
    if (!_nameButton) {
        
        _nameButton = [[UIButton alloc]init];
        
        _nameButton.backgroundColor = [UIColor clearColor];
        [_nameButton addTarget:self action:@selector(userInfobutton:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _nameButton;
}






- (UIView *)newsView {
    
    if (!_newsView) {
        _newsView = [[UIView alloc]init];
        _newsView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        
    }
    return _newsView;
}

- (UIImageView *)newsImage {
    
    if (!_newsImage) {
        _newsImage = [[UIImageView alloc]init];
        
    }
    return _newsImage;
}
- (UILabel *)newsLabel {
    
    if (!_newsLabel) {
        _newsLabel = [[UILabel alloc]init];
        _newsLabel.font = [UIFont systemFontOfSize:12];
        _newsLabel.textColor = CCCUIColorFromHex(0x323232);
        _newsLabel.textAlignment = NSTextAlignmentCenter;
        _newsLabel.numberOfLines = 2;
        _newsLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _newsLabel;
}


- (UILabel *)newsNoLabel {
    
    if (!_newsNoLabel) {
        _newsNoLabel = [[UILabel alloc]init];
        _newsNoLabel.font = [UIFont systemFontOfSize:12];
        _newsNoLabel.textColor = CCCUIColorFromHex(0x323232);
        _newsNoLabel.textAlignment = NSTextAlignmentCenter;
        _newsNoLabel.numberOfLines = 1;
        _newsNoLabel.text = @"...";
    }
    return _newsNoLabel;
}


- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = CCCUIColorFromHex(0x333333);
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"徐飞";
    }
    return _nameLabel;
}

- (UIImageView *)goodImage {
    
    if (!_goodImage) {
        _goodImage = [[UIImageView alloc]init];
        _goodImage.image = [UIImage imageNamed:@"comment_btn_like_pre"];
        
    }
    return _goodImage;
}
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = CCCUIColorFromHex(0xaaaaaa);
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.text = @"1小时前";
    }
    return _timeLabel;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = CCCUIColorFromHex(0xd9d9d9);
        
    }
    return _lineView;
}





/*
 @property (nonatomic,strong)UIButton *headerImage;
 @property (nonatomic,strong)UIView *newsView;
 @property (nonatomic,strong)UIImageView *newsImage;
 @property (nonatomic,strong)UILabel *newsLabel;
 
 @property (nonatomic,strong)UIImageView *goodImage;
 @property (nonatomic,strong)UILabel *nameLabel;
 @property (nonatomic,strong)UILabel *timeLabel;

 
 
 
 */
@end
