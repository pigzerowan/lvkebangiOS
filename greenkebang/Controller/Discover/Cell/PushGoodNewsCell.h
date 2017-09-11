//
//  PushGoodNewsCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/23.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);

@interface PushGoodNewsCell : UITableViewCell

@property (nonatomic, copy) BottomBuyClickBlock clickBlock;

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic,strong)UIButton *headerButton;
@property (nonatomic,strong)UIView *newsView;
@property (nonatomic,strong)UIImageView *newsImage;
@property (nonatomic,strong)UILabel *newsLabel;
@property (nonatomic,strong)UILabel *newsNoLabel;

@property (nonatomic,strong)UIImageView *goodImage;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIButton *nameButton;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIView *lineView;

- (void)PushGoodNewshandlerButtonAction:(BottomBuyClickBlock)block;


- (void)configPushGoodNewsCell:(NSDictionary *)dic;

@end
