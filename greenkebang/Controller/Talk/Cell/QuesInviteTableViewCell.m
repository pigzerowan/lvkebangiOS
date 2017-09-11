//
//  QuesInviteTableViewCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "QuesInviteTableViewCell.h"

@implementation QuesInviteTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _headerImage = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth - 24, 34)];
        _headerImage.backgroundColor = [UIColor magentaColor];
        
        [self.contentView addSubview:_headerImage];
        
        _titleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 34, kDeviceWidth -50, 45)];
        _titleButton.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:_titleButton];
        
        
        _redImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 38 , 45, 18, 18)];
        _redImage.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_redImage];
        
    }
    return self;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
