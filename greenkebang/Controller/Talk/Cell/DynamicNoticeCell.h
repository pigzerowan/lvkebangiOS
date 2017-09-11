//
//  DynamicNoticeCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetNoticeModel.h"
typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);

@interface DynamicNoticeCell : UITableViewCell
@property (nonatomic, copy) BottomBuyClickBlock clickBlock;
@property (nonatomic, assign) BOOL didSetupConstraints;

@property(strong,nonatomic)UIButton *headerButton;
@property(strong,nonatomic)UIButton *nameButton;
@property(strong,nonatomic)UILabel * answerLabel;
@property(strong,nonatomic)UILabel * timeLabel;
@property(strong,nonatomic)UIButton * titleButton;
@property(strong,nonatomic)UIView * lineView;
@property(nonatomic,strong)UIImageView *unreadImage;

- (void)handlerButtonAction:(BottomBuyClickBlock)block;
- (void)configSingelGetNoticeTableCellWithGoodModel:(GetDetailNoticeModel *)admirGood;

@end
