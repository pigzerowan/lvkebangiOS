//
//  MyCollectionTableViewCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/7.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"

@interface MyCollectionTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UIImageView *readImage;
@property (strong, nonatomic) UILabel *readLabel;
@property (strong, nonatomic) UILabel *groupLabel;

- (void)configCollectionCellWithModel:(CollectionDetailModel *)model;

@end
