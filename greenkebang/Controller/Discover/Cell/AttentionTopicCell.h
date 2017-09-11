//
//  AttentionTopicCell.h
//  greenkebang
//
//  Created by 郑渊文 on 4/5/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionContentsModel.h"
@interface AttentionTopicCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;


@property(nonatomic, strong)UILabel *titleNameLabel;
@property(nonatomic, strong)UIImageView *commentImage;
@property(nonatomic, strong)UILabel *commentLabel;
@property(nonatomic, strong)UILabel *attentionLael;
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UILabel *groupNameLabel;
@property(nonatomic, strong)UIView *lineView;



- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID;

- (void)configAttentionTopicTableCellWithGoodModel:(AttentionContentsListModel *)admirGood;

- (void)configAttentionQuestionTableCellWithGoodModel:(AttentionContentsListModel *)admirGood;

@end
