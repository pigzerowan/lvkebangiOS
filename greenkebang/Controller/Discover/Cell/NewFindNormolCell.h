//
//  NewFindNormolCell.h
//  greenkebang
//
//  Created by 郑渊文 on 1/19/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewFindModel.h"
@interface NewFindNormolCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *buyBtn;
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
//定义一个contentLabel文本高度的属性
@property (nonatomic,assign) CGFloat contentLabelH;
- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID;
+ (CGFloat)heightWithModel:(NewFindDetailModel *)model;

- (void)configNewSeperateTableCellWithGoodModel:(NewFindDetailModel *)admirGood;
@end
