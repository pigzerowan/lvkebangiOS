//
//  NewsNoticeCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "NewsNoticeCell.h"

@implementation NewsNoticeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self = [super initWithStyle:style reuseIdentifier:
            reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}


- (void)configSingelGetNoticeTableCellWithGoodModel:(GetDetailNoticeModel *)model {
    
    
}

-(void)configureSubview  {
    
    _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 45, 45)];
    _headerImage.backgroundColor = [UIColor lightGrayColor];
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 22.5;
    [self.contentView addSubview:_headerImage];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(69, 15, 150, 16)];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = CCCUIColorFromHex(0x333333);
    [self.contentView addSubview:_nameLabel];
    
    
    // Initialization code
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-96, 14, 80, 16)];
    _timeLabel.font = [UIFont systemFontOfSize:12];
//    _timeLabel.backgroundColor = [UIColor blackColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = [UIColor textGrayColor];
    [self.contentView addSubview:_timeLabel];
    
    _unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-34, 35, 18, 18)];
    _unreadLabel.backgroundColor = CCCUIColorFromHex(0xf35824);
    _unreadLabel.textColor = [UIColor whiteColor];
    
    _unreadLabel.textAlignment = NSTextAlignmentCenter;
    _unreadLabel.font = [UIFont systemFontOfSize:10];
    _unreadLabel.layer.cornerRadius = 9;
    _unreadLabel.text = @"2";
    _unreadLabel.clipsToBounds = YES;
    [self.contentView addSubview:_unreadLabel];
    

    
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(69, 33, kDeviceWidth -69-34 -18 -20 , 20)];
    _detailLabel.backgroundColor = [UIColor clearColor];
    _detailLabel.font = [UIFont systemFontOfSize:12];
    _detailLabel.textColor = [UIColor textGrayColor];
    [self.contentView addSubview:_detailLabel];
    
    
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(69,64, kDeviceWidth, 0.5)];
    _lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    [self.contentView addSubview:_lineView];
    
    
    _noticeUnreadImage = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-34 -5, 35 +4, 9, 9)];
    [_noticeUnreadImage setImage:[UIImage imageNamed:@"tabBardot"]];

    [self.contentView addSubview:_noticeUnreadImage];

}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
