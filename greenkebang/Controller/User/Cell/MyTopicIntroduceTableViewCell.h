//
//  MyTopicIntroduceTableViewCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToPicModel.h"
@interface MyTopicIntroduceTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *toLabel;
@property (strong, nonatomic) UILabel *groupLabel;

- (void)configTopicCellWithModel:(PeoplestopicModel *)model;


@end
