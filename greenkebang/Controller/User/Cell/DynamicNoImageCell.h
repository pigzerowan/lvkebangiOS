//
//  DynamicNoImageCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/11/14.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInforDynamicModel.h"
#import "LKBPrefixHeader.pch"

typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);


@interface DynamicNoImageCell : UITableViewCell
@property (nonatomic, copy) BottomBuyClickBlock clickBlock;

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (strong, nonatomic) UILabel *goodsDesLabel;
@property (strong, nonatomic) UILabel *loveTimeLabel;
@property (strong, nonatomic) UIButton *circleNameButton;



- (void)handlerButtonAction:(BottomBuyClickBlock)block;
- (void)configUserInforDynamicNoImageModel:(UserDynamicModelIntroduceModel *)model;
@end
