//
//  DynamicShareCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/12.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInforDynamicModel.h"
#import "LKBPrefixHeader.pch"

typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);


@interface DynamicShareCell : UITableViewCell
@property (nonatomic, copy) BottomBuyClickBlock clickBlock;

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (strong, nonatomic) UILabel *goodsDesLabel;
@property (strong, nonatomic) UILabel *loveTimeLabel;
@property (strong, nonatomic) UIButton *circleNameButton;
@property(nonatomic,strong)UIImageView* shareImg;
@property(nonatomic,strong)UIView* lableBackView;
@property(nonatomic,strong)UILabel* shareLable;
@property(nonatomic,strong)UIButton* shareCircleButton;

- (void)handlerButtonAction:(BottomBuyClickBlock)block;
- (void)configUserInforDynamicShareModel:(UserDynamicModelIntroduceModel *)model;



@end
