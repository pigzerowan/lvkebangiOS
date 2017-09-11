//
//  GroupTableViewCell.m
//  greenkebang
//
//  Created by 郑渊文 on 9/10/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "GroupTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation GroupTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}


- (void)configUserInforGroupCellWithModel:(GroupDetailModel *)model
{

    [self.headImageView sd_setImageWithURL:[model.groupAvatar lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
    self.nameLable.text = model.groupName;

    if ([model.passStatus isEqualToString:@"0"]) {
        self.passLable.hidden = NO;
    }else {
        self.passLable.hidden = YES;

        
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    //    self.remindLabel.attributedText = remAttributedStr;
}


- (void)configNewsInvitePeopleCellWithModel:(InvitePeopleDetailModel *)model {
    
    [self.headImageView sd_setImageWithURL:[model.avatar lkbImageUrl4] placeholderImage:LKBUserInvitePlaceImage];
    self.nameLable.text = model.userName;
    
    self.passLable.hidden = YES;
    
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

}

#pragma mark - Event response

#pragma maek - SubViews
- (void)configureSubview
{
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLable];
//    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.passLable];

//    [self.contentView addSubview:self.adressLable];
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(6);
            make.left.mas_equalTo(14);
//            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(40, 40));
//            make.centerY.mas_equalTo(self.contentView);

        }];
        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(16);
            make.left.mas_equalTo(_headImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView);
//            make.centerY.mas_equalTo(self.headImageView);
        }];
        
        [_passLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(16);
            make.centerY.mas_equalTo(self.nameLable);
            make.right.mas_equalTo(self.contentView).offset (-14);
            make.height.mas_equalTo(30);

            //            make.centerY.mas_equalTo(self.contentView);
        }];

        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_nameLable.bottom).offset(10);
            make.left.mas_equalTo(_nameLable);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset (-2);
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
//        _headImageView.clipsToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 20;
    }
    return _headImageView;
}

- (UILabel*)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.text = @"655656566";
        _nameLable.numberOfLines = 1;
        _nameLable.font = [UIFont systemFontOfSize:16];
        _nameLable.textColor = [UIColor blackColor];
        _nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
        _nameLable.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLable;
}

- (UILabel *)passLable {
    
    if (!_passLable) {
        _passLable = [[UILabel alloc] init];
        _passLable.text = @"审核中";
        _passLable.numberOfLines = 1;
        _passLable.font = [UIFont systemFontOfSize:12];
        _passLable.textColor = CCCUIColorFromHex(0xf47474);
        _passLable.lineBreakMode = NSLineBreakByTruncatingTail;
        _passLable.textAlignment = NSTextAlignmentLeft;
    }
    return _passLable;

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
