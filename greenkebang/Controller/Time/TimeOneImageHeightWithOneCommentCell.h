//
//  TimeOneImageHeightWithOneCommentCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/9/22.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTimeDynamicModel.h"
#import "TTTAttributedLabel.h"
typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);

@interface TimeOneImageHeightWithOneCommentCell : UITableViewCell<TTTAttributedLabelDelegate>

@property (nonatomic, copy) BottomBuyClickBlock clickBlock;

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (strong, nonatomic) UIButton *headImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *goodsDesLabel;
@property (strong, nonatomic) UIImageView *coverListImage;
@property (strong, nonatomic) UIButton *circleNameButton;
@property (strong, nonatomic) UILabel *loveTimeLabel;
@property (strong, nonatomic) UILabel *comentNumLable;
@property (strong, nonatomic) UIImageView *repleyImageView;
@property (strong, nonatomic) UIImageView *goodImageView;
@property (strong, nonatomic) UILabel *attentionNumLable;
@property (strong, nonatomic) UIImageView *squeImage;
@property (strong, nonatomic) UIButton *squeBtn;
//@property (strong, nonatomic) UIImageView *upCommentImage;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UILabel *showMoreLabel;
@property (strong, nonatomic) TTTAttributedLabel *commentlabel_1;
@property (strong, nonatomic) UIButton *commentButton_1;
@property (strong, nonatomic) UIButton *repleyBtn;
@property (strong, nonatomic) UIButton *goodBtn;
@property (strong, nonatomic) UIImageView *CommentImageView;

@property(strong,nonatomic)UIImageView *goodImage;
@property(strong,nonatomic)UIImageView *headerImage;
@property(strong,nonatomic)UIImageView *headerImage_2;
@property(strong,nonatomic)UIImageView *headerImage_3;
@property(strong,nonatomic)UIImageView *headerImage_4;
@property(strong,nonatomic)UIView *lastView;
@property (strong, nonatomic) UIButton *shareBtn;
- (void)OneImageHeightWithOneCommenthandlerButtonAction:(BottomBuyClickBlock)block;
- (void)configTimeOneImageHeightWithOneCommentCellTimeNewDynamicDetailModel:(NewDynamicDetailModel *)model;
- (void)configFarmerOneImageHeightWithOneCommentCellTimeNewDynamicDetailModel:(NewDynamicDetailModel *)model;

@end
