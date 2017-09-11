//
//  TimeTableViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToPicModel.h"
#import "DynamicModel.h"
#import "InsightModel.h"
#import "InsetsLabel.h"
#import "GroupModel.h"


@interface TimeTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) UILabel *nametimeLable;
@property (strong, nonatomic) InsetsLabel *simpleLable;

- (void)configTimeTopicCellWithModel:(PeoplestopicModel *)model;
- (void)configDynamicCellWithModel:(NewDynamicModel *)model;
- (void)configInsightCellWithModel:(NewInsightModel *)model;
- (void)configGroupCellWithModel:(GroupDetailModel *)model;

@end
