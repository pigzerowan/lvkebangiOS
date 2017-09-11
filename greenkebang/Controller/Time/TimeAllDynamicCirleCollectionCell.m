//
//  TimeAllDynamicCirleCollectionCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/9/9.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "TimeAllDynamicCirleCollectionCell.h"
#import <UIImageView+WebCache.h>

@implementation TimeAllDynamicCirleCollectionCell

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //initialize code...
        [self configureSubview];

        
    }
    
    return self;
    
}

- (void)configGroupDetailModelCollectionCellWithGoodModel:(GroupDetailModel *)admirGood {
    
    self.CirleNameLabel.text = admirGood.groupName;
    
//    UIImageView * cirleImage = [[UIImageView alloc]init];
    
    [self.CirleImageView sd_setImageWithURL:[admirGood.groupAvatar lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
    
//    [self.CirleImageView setImage:cirleImage.image];
}


- (void)configureSubview
{
    [self.contentView addSubview:self.backViewButton];
    [self.contentView addSubview:self.CirleImageView];
    [self.contentView addSubview:self.CirleNameLabel];

}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_backViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(60,80));
        }];
        
        [_CirleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(48, 48));

        }];
        [_CirleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(60, 20));
            make.top.mas_equalTo(_CirleImageView.bottom).offset(8);


        }];

        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (UIButton *)backViewButton {
    
    if (!_backViewButton) {
        _backViewButton = [[UIButton alloc]init];
        _backViewButton.backgroundColor= [UIColor clearColor];
        
        [_backViewButton addTarget:self action:@selector(headerButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _backViewButton;
}


- (UIImageView *)CirleImageView {
    if (!_CirleImageView) {
        
        _CirleImageView = [[UIImageView alloc]init];
        _CirleImageView.backgroundColor = [UIColor redColor];
        _CirleImageView.layer.masksToBounds = YES;
        _CirleImageView.layer.cornerRadius = 24;
        
    }
    return _CirleImageView;
}

- (UILabel *)CirleNameLabel {
    
    if (!_CirleNameLabel) {
        
        _CirleNameLabel = [[UILabel alloc]init];
//        _CirleNameLabel.backgroundColor = [UIColor blackColor];
        _CirleNameLabel.font = [UIFont systemFontOfSize:12];
        _CirleNameLabel.textColor = CCCUIColorFromHex(0x333333);
        _CirleNameLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _CirleNameLabel;
}

- (void)handlerButtonAction:(BottomBuyClickBlock)block {
    
    self.clickBlock = block;
}
-(void)headerButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }
    
}




@end
