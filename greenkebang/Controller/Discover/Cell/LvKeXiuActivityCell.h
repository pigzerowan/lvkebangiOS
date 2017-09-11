//
//  LvKeXiuActivityCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/22.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityListModel.h"
#import "ActivityModel.h"
@interface LvKeXiuActivityCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic,strong)UIImageView *headerImage;
@property (nonatomic,strong)UIImageView *markedImage;
@property (nonatomic,strong)UIImageView *blackImage;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *timeLabel;

- (void)configLvKeXiuActivityCellWithGoodModel:(ActivityListDetailModel *)admirGood;
- (void)configMyActivityCellWithGoodModel:(ActivityIntroduceModel *)admirGood;

@end
