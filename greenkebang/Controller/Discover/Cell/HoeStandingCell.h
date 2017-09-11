//
//  HoeStandingCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/19.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HoeListModel.h"
#import "ActivityListModel.h"
@interface HoeStandingCell : UITableViewCell
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIImageView *headerImage;
@property (nonatomic,strong)UIImageView *back;
@property (nonatomic,strong)UILabel *authorLabel;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIImageView *goodImage;
@property (nonatomic,strong)UILabel *goodNum;
@property (nonatomic,strong)UILabel *joinNum;

+ (CGFloat)getHeight;

- (void)configHoeListTableCellWithGoodModel:(HoeListModelDetailModel *)admirGood;

- (void)configActivityListTableCellWithGoodModel:(ActivityListDetailModel *)admirGood;


@end
