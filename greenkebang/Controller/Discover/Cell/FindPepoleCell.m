//
//  FindPepoleCell.m
//  greenkebang
//
//  Created by 郑渊文 on 1/20/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "FindPepoleCell.h"
#import "UIImageView+EMWebCache.h"

@implementation FindPepoleCell
{
    CGRect CellBounds;
    CGFloat cellHeight;
}

- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier: reuseID];
    if (self)
    {
        
        [self.contentView setBackgroundColor:UIColorWithRGBA(244, 244, 244, 1)];;
        CellBounds = CGRectMake(0, 0, SCREEN_WIDTH, height);
        cellHeight = height;
        [self configureSubview];
    }
    return  self;
}

#pragma mark - Getters & Setters

- (void)configNewFindPepoleTableCellWithGoodModel:(NewFindDetailModel *)admirGood
{
    
    [self.headImageView sd_setImageWithURL:[admirGood.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    //    NSString *imageUrl = @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
    //    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:YQNormalPlaceImage];
    self.nameLable.text = admirGood.userName;
    self.adressLable.text= admirGood.remark;
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
#pragma mark - Event response

#pragma maek - SubViews
- (void)configureSubview
{
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.adressLable];
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(_headImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView);
        }];
        [_adressLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLable.bottom).offset(10);
            make.left.mas_equalTo(_nameLable.left);
            make.right.mas_equalTo(self.contentView.right).offset(-10);
            //            make.size.mas_equalTo(CGSizeMake(40, 200));
            //            make.width.mas_equalTo((int)kDeviceWidth/2);
        }];
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


#pragma mark - Getters & Setters
- (UIImageView*)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.clipsToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}

- (UILabel*)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.numberOfLines = 1;
        _nameLable.font = [UIFont systemFontOfSize:13];
        _nameLable.textColor = [UIColor blackColor];
        _nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLable;
}

- (UILabel*)adressLable
{
    if (!_adressLable) {
        _adressLable = [[UILabel alloc] init];
        _adressLable.numberOfLines = 2;
        _adressLable.clipsToBounds = YES;
        _adressLable.font = [UIFont systemFontOfSize:10];
        _adressLable.textColor = [UIColor blackColor];
        _adressLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _adressLable;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
