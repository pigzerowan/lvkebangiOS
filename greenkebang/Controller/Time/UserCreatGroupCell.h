//
//  UserCreatGroupCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInforDynamicModel.h"

typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);

@interface UserCreatGroupCell : UITableViewCell
@property (nonatomic, copy) BottomBuyClickBlock clickBlock;

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *replyBtn;
@property (nonatomic, assign) BOOL didLike;
//@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UIImageView *addressIconImageView;
@property (strong, nonatomic) UILabel *nameLabel;
//@property (strong, nonatomic) UILabel *loveTimeLabel;
@property (strong, nonatomic) UILabel *goodsTitleLabel;
@property (strong, nonatomic) UILabel *goodsDesLabel;
@property (strong, nonatomic) UILabel *goodsTimeLabel;
@property (strong, nonatomic) UILabel *goodsAddressLabel;
@property (strong, nonatomic) UILabel *goodsPriceLabel;
@property (strong, nonatomic) UIButton *loveButton;
@property (strong, nonatomic) UIButton *iocnBtn;
@property (strong, nonatomic) UIView *detailView;
@property (strong, nonatomic) UIView *controllerView;
@property (strong, nonatomic) NSString *typeStr;
//@property (strong, nonatomic) UIButton *squeBtn;
@property (strong, nonatomic) UIButton *jionBtn;
@property (strong, nonatomic) NSString *userId;


- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID;

- (void)configUserTableCellWithModel:(UserDynamicModelIntroduceModel *)model;
//定义一个contentLabel文本高度的属性
- (void)handlerButtonAction:(BottomBuyClickBlock)block;

@end
