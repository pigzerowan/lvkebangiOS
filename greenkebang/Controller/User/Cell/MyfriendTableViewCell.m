//
//  MyfriendTableViewCell.m
//  youqu
//
//  Created by 郑渊文 on 8/11/15.
//  Copyright (c) 2015 youqu. All rights reserved.
//

#import "MyfriendTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MyfriendTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configureSubview];

    }
    return self;
}

#pragma maek - SubViews
- (void)configureSubview
{
    [self.contentView addSubview:self.headImg];
    [self.contentView addSubview:self.nameLab];
    
}

- (void)configLoveGoodsTableCellWithModel:(id)model
{
    NSString* imageUrl = @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:YQNormalPlaceImage];
//    self.nameLab.text = @"好友昵称";
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(_headImg.right).offset(10);
            make.right.mas_equalTo(self.contentView);
        }];
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - Getters & Setters
- (UIImageView*)headImg
{
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        _headImg.clipsToBounds = YES;
        _headImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImg;
}
- (UILabel*)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.numberOfLines = 1;
        _nameLab.font = [UIFont systemFontOfSize:15];
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLab;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
