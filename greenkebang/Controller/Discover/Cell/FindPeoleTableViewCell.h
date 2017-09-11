//
//  FindPeoleTableViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 9/1/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindPeopleModel.h"

@interface FindPeoleTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *adressLable;


- (void)configFindPeopleCellWithModel:(FpeopeleModel *)model;
@end
