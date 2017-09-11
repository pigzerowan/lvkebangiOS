//
//  DiscoverTableViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsightModel.h"
#import "ToPicModel.h"

@interface DiscoverTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIImageView *headImageView;
//@property (strong, nonatomic) UILabel *nameLable;
//@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) UILabel *nametimeLable;
@property (strong, nonatomic) UILabel *simpleLable;

- (void)configDiscoveryRecommCellWithModel:(NewInsightModel *)model;

- (void)configTimeTopicCellWithModel:(PeoplestopicModel *)model;
@end
