//
//  NewsNoticeCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetNoticeModel.h"
@interface NewsNoticeCell : UITableViewCell

@property (nonatomic, assign) BOOL didSetupConstraints;

@property(strong,nonatomic)UIImageView *headerImage;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UILabel *unreadLabel;
@property(strong,nonatomic)UILabel *detailLabel;
@property(strong,nonatomic)UIView *lineView;
@property (strong, nonatomic) UIImageView *noticeUnreadImage;

- (void)configSingelGetNoticeTableCellWithGoodModel:(GetDetailNoticeModel *)model;
@end
