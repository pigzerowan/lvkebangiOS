//
//  ActivityTableViewCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/8/1.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
@interface ActivityTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *activityLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UIView *lineView;

- (void)configActivityIntroduceCellWithModel:(ActivityIntroduceModel *)model;

@end
