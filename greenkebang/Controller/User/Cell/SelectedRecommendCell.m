//
//  SelectedRecommendCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 2017/2/15.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import "SelectedRecommendCell.h"

@implementation SelectedRecommendCell
#pragma mark - Life Cycle
- (void)dealloc
{
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.headerImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.attentionBtn];
        
    }
    return self;
}

- (void)configDiscoveryCellWithModel:(friendModel *)model {
    
    [self.headerImage sd_setImageWithURL:[model.cover lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
    
    self.titleLabel.text = model.title;
    self.contentLabel.text = [NSString stringWithFormat:@"%@人加入",model.memberNum];
    
    
//    if ([model.type isEqualToString:@"1"]) {
//        self.joinNum .text = [NSString stringWithFormat:@"%@篇文章",model.dynamicNum];
//    }
//    else {
//        self.joinNum .text = [NSString stringWithFormat:@"%@条动态",model.dynamicNum];
//    }
    
}


- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        if (iPhone5) {
            
            [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView).offset(24);
                make.centerX.mas_equalTo(self);
                make.size.mas_equalTo(CGSizeMake(51, 51));
            }];

        }else {
            
            [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView).offset(24);
                make.centerX.mas_equalTo(self);
                make.size.mas_equalTo(CGSizeMake(60, 60));
            }];

        }

        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headerImage.bottom).offset(10);
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(self.contentView).offset(5);
            make.right.mas_equalTo(self.contentView).offset(-5);
            make.height.mas_equalTo(16);
        }];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLabel.bottom).offset(10.5);
            make.left.mas_equalTo(self.contentView).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(11);
        }];
        
        if (iPhone5) {
            [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView.top).offset(128);
                make.left.mas_equalTo(self.contentView).offset(10);
                make.right.mas_equalTo(self.contentView).offset(-10);
                make.height.mas_equalTo(26);
            }];
        }
        else if (iPhone7p,iPhone6p){
            [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView.top).offset(183);
                make.left.mas_equalTo(self.contentView).offset(10);
                make.right.mas_equalTo(self.contentView).offset(-10);
                make.height.mas_equalTo(26);
            }];

            
        }else {
            [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView.top).offset(163);
                make.left.mas_equalTo(self.contentView).offset(10);
                make.right.mas_equalTo(self.contentView).offset(-10);
                make.height.mas_equalTo(26);
            }];

            
        }


        
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)handlerButtonAction:(SelectedRecommendToClickBlock)block {
    
    self.SelectedClickBlock = block;
    
}


- (UIImageView*)headerImage
{
    if (!_headerImage) {
        
        _headerImage = [[UIImageView alloc]init];
        //        _headerImage.frame =  CGRectMake(14, 14, 60, 60);
        _headerImage.backgroundColor = CCCUIColorFromHex(0xdddddd);
        _headerImage.layer.masksToBounds = YES;
        
        if (iPhone5) {
            _headerImage.layer.cornerRadius = 25.5;

        }
        else {
            
            _headerImage.layer.cornerRadius = 30;

        }
        
    }
    return _headerImage;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init ];
        //        _titleLabel.frame = CGRectMake(86,16, kDeviceWidth - 90, 16);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = CCCUIColorFromHex(0x333333);
        _titleLabel.textAlignment= NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        //        _contentLabel.frame = CGRectMake(86, 42, kDeviceWidth - 90, 12);
        _contentLabel.font = [UIFont systemFontOfSize:11];
        _contentLabel.textColor = CCCUIColorFromHex(0x999999);
        _contentLabel.textAlignment= NSTextAlignmentCenter;

    }
    return _contentLabel;
}



- (UIButton *)attentionBtn {
    
    if (!_attentionBtn) {
        _attentionBtn = [[UIButton alloc]init];
        //        _contentLabel.frame = CGRectMake(86, 42, kDeviceWidth - 90, 12);
        
//        [_attentionBtn setImage:[UIImage imageNamed:@"btn_followcircle_follow"] forState:UIControlStateNormal];
        
        [_attentionBtn addTarget:self action:@selector(attentionBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _attentionBtn;
}

-(void)attentionBtn:(id)sender{
    
    if (self.SelectedClickBlock) {
        self.SelectedClickBlock(1);
    }
    
    
}




- (void)setChecked:(BOOL)checked{
    if (checked)
    {
        [_attentionBtn setImage:[UIImage imageNamed:@"btn_followcircle_followed"] forState:UIControlStateNormal];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
    }
    else
    {
        [_attentionBtn setImage:[UIImage imageNamed:@"btn_followcircle_follow"] forState:UIControlStateNormal];
        self.backgroundView.backgroundColor = [UIColor clearColor];
    }
    m_checked = checked;
    
}





@end
