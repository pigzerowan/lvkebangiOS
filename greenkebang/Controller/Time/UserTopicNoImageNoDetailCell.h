//
//  UserTopicNoImageNoDetailCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/5.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToPicModel.h"


@protocol AttentionTopicCellDelegate <NSObject>

@optional

- (void)turnToGroup:(NSString *)sender;


@end
@interface UserTopicNoImageNoDetailCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *replyBtn;
@property (nonatomic, assign) BOOL didLike;
//@property (strong, nonatomic) UIImageView *headImageView;
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
@property (strong, nonatomic) NSString *typeStr;

@property (strong, nonatomic) UILabel *comentNumLable;
@property (strong, nonatomic) UIImageView *repleyImageView;
@property (strong, nonatomic) UIImageView *starImage;
@property (strong, nonatomic) UILabel *starLabel;

@property (strong, nonatomic) UILabel *attentionNumLable;
@property (strong, nonatomic) UILabel *fromGroup;
@property (strong, nonatomic) UIButton *GroupButton;
@property (nonatomic, copy) NSString *groupId;

@property (nonatomic , assign) id <AttentionTopicCellDelegate>attentionCellDelegate;


- (void)configNoImageNoDetailUserTopicTableCellWithGoodModel:(PeoplestopicModel *)admirGood;

@end
