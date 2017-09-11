//
//  GoodNoticeCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/26.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTimeDynamicModel.h"

@interface GoodNoticeCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIImageView *headerImage;
@property (nonatomic,strong)UIImageView *arrImage;
@property (nonatomic,strong)UILabel *numLabel;


- (void)configTimeGoodNoticeCellTimeNewDynamicDetailModel:(NewDynamicDetailModel *)model;

@end
