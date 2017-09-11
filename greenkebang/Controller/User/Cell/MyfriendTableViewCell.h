//
//  MyfriendTableViewCell.h
//  youqu
//
//  Created by 郑渊文 on 8/11/15.
//  Copyright (c) 2015 youqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyfriendTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL ifLike;
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIImageView *headImg;
@property (strong, nonatomic) UIImageView *likeImg;
@property (strong, nonatomic) UILabel *nameLab;
- (void)configLoveGoodsTableCellWithModel:(id)model;
@end
