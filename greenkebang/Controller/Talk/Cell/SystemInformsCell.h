//
//  SystemInformsCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 2017/3/17.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemInformsModel.h"
@interface SystemInformsCell : UITableViewCell
@property(strong,nonatomic)UIImageView *headImageView;
@property(strong,nonatomic)UIImageView *backImageView;
@property(strong,nonatomic)UILabel *connectLabel;
@property(strong,nonatomic)UILabel *timeLabel;



- (void)configSystemInformsCellWithGoodModel:(SystemInformsDetailModel *)admirGood;
@property (nonatomic,assign)CGFloat cellHeight;


@end
