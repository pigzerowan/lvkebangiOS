//
//  AllArticTableViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 7/25/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionContentsModel.h"
#import "FindSearchModel.h"
@interface AllArticTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *ArticNumLable;
@property (strong, nonatomic) UILabel *columnNameLable;
@property (strong, nonatomic) UIView *lineView;
//@property (strong, nonatomic) UIButton *turnToAticBtn;
//@property (strong, nonatomic) UILabel *publishLable;
//@property (nonatomic, copy) NSString *featureId;


- (void)configAllArticTableCellWithGoodModel:(AttentionContentsListModel *)admirGood;
- (void)configSeperateGroupCellWithModel:(FindSearchModelDetailModel *)model;

@end
