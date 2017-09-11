//
//  GroupTableViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 9/10/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
#import "InvitePeopleModel.h"
@interface GroupTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLable;
//@property (strong, nonatomic) UILabel *adressLable;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UILabel *passLable;

- (void)configUserInforGroupCellWithModel:(GroupDetailModel *)model;
- (void)configNewsInvitePeopleCellWithModel:(InvitePeopleDetailModel *)model;

@end
