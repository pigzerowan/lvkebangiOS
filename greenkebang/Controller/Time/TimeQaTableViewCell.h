//
//  TimeQaTableViewCell.h
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

@interface TimeQaTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) UILabel *nametimeLable;
@property (strong, nonatomic) UILabel *questionTitleLab;
@property (strong, nonatomic) UILabel *questionDescLab;
@property (copy, nonatomic) NSString *questionDescStr;

- (void)configDynamicCellWithModel:(NewDynamicModel *)model;

@end
