//
//  NoImageDetailCell.h
//  greenkebang
//
//  Created by 郑渊文 on 1/22/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTimeDynamicModel.h"
#import "UserInforDynamicModel.h"
typedef void(^TouchCellBtnBlock)(void);

@interface NoImageDetailCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, copy) TouchCellBtnBlock btnBlock;
@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *replyBtn;
@property (nonatomic, assign) BOOL didLike;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UIImageView *addressIconImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *loveTimeLabel;
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
@property (strong, nonatomic) UILabel *comentNumLable;
@property (strong, nonatomic) UIImageView *repleyImageView;
@property (strong, nonatomic) UILabel *attentionNumLable;
@property (strong, nonatomic) UIButton *squeBtn;
//定义一个contentLabel文本高度的属性
@property (nonatomic,assign) CGFloat contentLabelH;
- (void)handlerButtonAction:(TouchCellBtnBlock)block;



- (void)configNoImageDetailTimeTableCellWithGoodModel:(NewDynamicDetailModel *)admirGood;
- (void)configNoImageDetailUserTableCellWithModel:(UserDynamicModelIntroduceModel *)model;

@end
