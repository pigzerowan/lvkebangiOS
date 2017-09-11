//
//  PeopleTableViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//
#import "FansModel.h"
#import "FriendModel.h"
#import "GroupModel.h"
#import <UIKit/UIKit.h>


@interface PeopleTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *adressLable;
@property (strong, nonatomic) UIView *lineView;


- (void)configPeopleCellWithModel:(peopeleModel *)model;
- (void)configFriendCellWithModel:(friendDetailModel *)model;
- (void)configgroupCellWithModel:(GroupDetailModel *)model;
@end
