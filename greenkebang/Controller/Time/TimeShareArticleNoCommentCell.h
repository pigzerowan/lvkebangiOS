//
//  TimeShareArticleNoCommentCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/7.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTimeDynamicModel.h"
#import "AttentionContentsModel.h"
typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);


@interface TimeShareArticleNoCommentCell : UITableViewCell


@property (nonatomic, copy) BottomBuyClickBlock clickBlock;

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (strong, nonatomic) UIButton *headImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *goodsDesLabel;
@property(nonatomic,strong)UIImageView* shareImg;
@property(nonatomic,strong)UIView* lableBackView;
@property(nonatomic,strong)UILabel* shareLable;
@property(nonatomic,strong)UIButton* shareCircleButton;

@property (strong, nonatomic) UIButton *circleNameButton;
@property (strong, nonatomic) UILabel *loveTimeLabel;
@property (strong, nonatomic) UILabel *comentNumLable;
@property (strong, nonatomic) UIImageView *repleyImageView;
@property (strong, nonatomic) UIImageView *goodImageView;
@property (strong, nonatomic) UILabel *attentionNumLable;
@property (strong, nonatomic) UIImageView *squeImage;
@property (strong, nonatomic) UIButton *squeBtn;
@property (strong, nonatomic) UIButton *repleyBtn;
@property (strong, nonatomic) UIButton *goodBtn;
@property(strong,nonatomic)UIImageView *goodImage;
@property(strong,nonatomic)UIImageView *headerImage;
@property(strong,nonatomic)UIImageView *headerImage_2;
@property(strong,nonatomic)UIImageView *headerImage_3;
@property(strong,nonatomic)UIImageView *headerImage_4;
@property(strong,nonatomic)UIView *lastView;
@property (strong, nonatomic) UIButton *shareBtn;

- (void)ShareArticleNoCommenthandlerButtonAction:(BottomBuyClickBlock)block;

- (void)configTimeShareArticleNoCommentCellTimeNewDynamicDetailModel:(NewDynamicDetailModel *)model;
- (void)configFarmerShareArticleNoCommentCellTimeNewDynamicDetailModel:(NewDynamicDetailModel *)model;
- (void)configAttentionTopicShareArticleCellTimeNewDynamicDetailModel:(AttentionContentsListModel *)model;

@end
