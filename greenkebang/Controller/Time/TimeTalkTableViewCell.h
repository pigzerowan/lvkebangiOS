//
//  TimeTalkTableViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 9/28/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToPicModel.h"
#import "DynamicModel.h"
#import "InsightModel.h"
#import "InsetsLabel.h"
#import "GroupModel.h"

@interface TimeTalkTableViewCell : UITableViewCell

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


//给用户介绍赋值并且实现自动换行
-(void)setIntroductionText:(NSString*)text;
@end
