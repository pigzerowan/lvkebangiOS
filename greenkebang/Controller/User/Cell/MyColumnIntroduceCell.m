//
//  MyColumnIntroduceCell.m
//  greenkebang
//
//  Created by 郑渊文 on 1/26/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "MyColumnIntroduceCell.h"
#import <UIImageView+WebCache.h>

@implementation MyColumnIntroduceCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}

#pragma mark - Public methods
- (void)configColumnIntroduceCellWithModel:(ColumnIntroduceModel *)model
{
    
    NSLog(@"------------------------------------------%@",[model valueForKey:@"featureAvatar"]);
    
    [self.featureAvatarImage sd_setImageWithURL:[[model valueForKey:@"featureAvatar"] lkbImageUrl8] placeholderImage:YQNormalBackGroundPlaceImage];

    
//    self.userNameLable.text = model.userName;
    self.featureDescLable.text= [model valueForKey:@"featureDesc"];
    self.featureNameLable.text= [model valueForKey:@"featureName"];
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    
}


#pragma mark - Event response

#pragma maek - SubViews
- (void)configureSubview
{
    
    [self.contentView addSubview:self.featureAvatarImage];
    [self.contentView addSubview:self.featureNameLable];
    [self.contentView addSubview:self.featureDescLable];
//    [self.contentView addSubview:self.userNameLable];

}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_featureAvatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        [_featureNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(_featureAvatarImage.right).offset(10);
            make.right.mas_equalTo(self.contentView);
        }];
        [_featureDescLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_featureNameLable.bottom).offset(10);
            make.left.mas_equalTo(_featureNameLable.left);
            make.right.mas_equalTo(self.contentView.right).offset(-10);

        }];
//        [_userNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_featureAvatarImage.bottom).offset(5);
//            make.left.mas_equalTo(_featureAvatarImage.left);
//            make.right.mas_equalTo(self.contentView.right).offset(-10);
//
//        }];
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


#pragma mark - Getters & Setters
- (UIImageView*)featureAvatarImage
{
    if (!_featureAvatarImage) {
        _featureAvatarImage = [[UIImageView alloc] init];
        _featureAvatarImage.layer.masksToBounds = YES;
        _featureAvatarImage.layer.cornerRadius = 30;
        _featureAvatarImage.clipsToBounds = YES;
        _featureAvatarImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _featureAvatarImage;
}

- (UILabel*)featureNameLable
{
    if (!_featureNameLable) {
        _featureNameLable = [[UILabel alloc] init];
        _featureNameLable.numberOfLines = 1;
        _featureNameLable.font = [UIFont systemFontOfSize:16];
        _featureNameLable.textColor = [UIColor blackColor];
        _featureNameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _featureNameLable;
}

- (UILabel*)featureDescLable
{
    if (!_featureDescLable) {
        _featureDescLable = [[UILabel alloc] init];
        _featureDescLable.numberOfLines = 1;
        _featureDescLable.clipsToBounds = YES;
        _featureDescLable.font = [UIFont systemFontOfSize:12];
        _featureDescLable.textColor = CCCUIColorFromHex(0x888888);
        _featureDescLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _featureDescLable;
}

//- (UILabel*)userNameLable
//{
//    if (!_userNameLable) {
//        _userNameLable = [[UILabel alloc] init];
//        _userNameLable.numberOfLines = 1;
//        _userNameLable.clipsToBounds = YES;
//        _userNameLable.font = [UIFont systemFontOfSize:10];
//        _userNameLable.textColor = [UIColor blackColor];
//        _userNameLable.lineBreakMode = NSLineBreakByTruncatingTail;
//    }
//    return _userNameLable;
//}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
