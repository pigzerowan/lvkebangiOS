//
//  XinChuangTableViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 7/22/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarSchoolModel.h"

@interface XinChuangTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;


@property (strong, nonatomic) UIImageView *coverImageView;

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UILabel *goodsTitleLabel;
@property (strong, nonatomic) UILabel *goodsDesLabel;
@property (strong, nonatomic) UILabel *comentNumLable;
@property (strong, nonatomic) UIImageView *loveImage;
@property (strong, nonatomic) UILabel *loveLabel;
@property (strong, nonatomic) UIImageView *repleyImageView;
- (void)configxinChuangTableCellWithGoodModel:(StarSchoolModelDetailModel *)admirGood;

@end
