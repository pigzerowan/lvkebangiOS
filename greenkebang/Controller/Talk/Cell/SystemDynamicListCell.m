//
//  SystemDynamicListCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/6.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SystemDynamicListCell.h"

@implementation SystemDynamicListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configureSubview];
        
    }
    return self;
}


-(void)configureSubview  {
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, kDeviceWidth -50, 16)];
    
    _titleLabel.backgroundColor = [UIColor blackColor];
    
    [self.contentView addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 38, 30, 12)];
    _timeLabel.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_timeLabel];
    
    _redImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 30, 12, 9, 9)];
    [_redImage setImage:[UIImage imageNamed:@"tabBardot"]];
    
    [self.contentView addSubview:_redImage];

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 66, kDeviceWidth, 0.5)];
    lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    [self.contentView addSubview:lineView];

}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
