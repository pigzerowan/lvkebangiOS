//
//  PeopleTableViewCell.m
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "PeopleTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation PeopleTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}

#pragma mark - Public methods
- (void)configPeopleCellWithModel:(peopeleModel *)model
{
    
    [self.headImageView sd_setImageWithURL:[model.avatar lkbImageUrl4] placeholderImage:YQUserPlaceImage];
//    NSString *imageUrl = @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
//    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:YQNormalPlaceImage];
    self.nameLable.text = model.userName;
//    self.adressLable.text= model.singleDescription;
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    self.adressLable.text = model.remark;

}

- (void)configFriendCellWithModel:(friendDetailModel *)model
{
    
    [self.headImageView sd_setImageWithURL:[model.avatar lkbImageUrl4] placeholderImage:LKBUserInvitePlaceImage];
    //    NSString *imageUrl = @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
    //    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:YQNormalPlaceImage];
    self.nameLable.text = model.userName;
//    self.adressLable.text= model.singleDescription;
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    self.adressLable.text = model.remark;


}

- (void)configgroupCellWithModel:(GroupDetailModel *)model
{
    
    [self.headImageView sd_setImageWithURL:[model.avatar lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    //    NSString *imageUrl = @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
    //    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:YQNormalPlaceImage];
    self.nameLable.text = model.groupSubject;
    self.adressLable.text= model.groupDesc;
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
}
#pragma mark - Event response

#pragma maek - SubViews
- (void)configureSubview
{
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLable];
//    [self.contentView addSubview:self.adressLable];
//    [self.contentView addSubview:self.lineView];

}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
//            make.top.mas_equalTo(self.contentView).offset(12);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.contentView).offset(24);
            make.left.mas_equalTo(_headImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.contentView);

        }];
//        [_adressLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_nameLable.bottom).offset(10);
//            make.left.mas_equalTo(_nameLable.left);
//            make.right.mas_equalTo(self.contentView.right).offset(-10);
////            make.size.mas_equalTo(CGSizeMake(40, 200));
////            make.width.mas_equalTo((int)kDeviceWidth/2);
//        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.top.mas_equalTo(_nameLable.bottom).offset(10);
            make.left.mas_equalTo(_nameLable);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset (5);
            make.height.mas_equalTo(0.5);
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
        _headImageView.backgroundColor = CCCUIColorFromHex(0xdddddd);
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 20;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}

- (UILabel*)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.numberOfLines = 1;
        _nameLable.font = [UIFont systemFontOfSize:16];
        _nameLable.textColor = CCCUIColorFromHex(0x333333);
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

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    }
    return _lineView;
}










- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
