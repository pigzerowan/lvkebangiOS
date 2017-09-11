//
//  SelectedRecommendCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 2017/2/15.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecFriendModel.h"

typedef void(^SelectedRecommendToClickBlock)(NSInteger clickIndex);

@interface SelectedRecommendCell : UICollectionViewCell
{
    BOOL m_checked;
}

@property (nonatomic, copy) SelectedRecommendToClickBlock SelectedClickBlock;

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic,strong)UIImageView *headerImage;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic, strong) UIButton *attentionBtn;


- (void)handlerButtonAction:(SelectedRecommendToClickBlock)block;

- (void)setChecked:(BOOL)checked;

- (void)configDiscoveryCellWithModel:(friendModel *)model;

@end
