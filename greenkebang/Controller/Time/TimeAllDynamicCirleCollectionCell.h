//
//  TimeAllDynamicCirleCollectionCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/9/9.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);

@interface TimeAllDynamicCirleCollectionCell : UICollectionViewCell
@property (nonatomic, copy) BottomBuyClickBlock clickBlock;

@property (nonatomic, assign) BOOL didSetupConstraints;

@property(nonatomic, strong)UIButton * backViewButton;
@property(nonatomic, strong)UIImageView * CirleImageView;
@property(nonatomic, strong)UILabel * CirleNameLabel;
- (void)handlerButtonAction:(BottomBuyClickBlock)block;

- (void)configGroupDetailModelCollectionCellWithGoodModel:(GroupDetailModel *)admirGood;
@end
