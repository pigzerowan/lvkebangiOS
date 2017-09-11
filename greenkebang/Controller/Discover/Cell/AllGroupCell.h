//
//  AllGroupCell.h
//  greenkebang
//
//  Created by 郑渊文 on 8/9/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
#import "InvitePeopleModel.h"

@interface AllGroupCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *describleLable;
@property (strong, nonatomic) UILabel *statuLable;
@property (strong, nonatomic) UIView *lineView;


- (void)configUserInforGroupCellWithModel:(GroupDetailModel *)model;
- (void)configNewsInvitePeopleCellWithModel:(InvitePeopleDetailModel *)model;

@end
