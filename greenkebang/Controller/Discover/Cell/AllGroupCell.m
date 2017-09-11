//
//  AllGroupCell.m
//  greenkebang
//
//  Created by 郑渊文 on 8/9/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "AllGroupCell.h"
#import <UIImageView+WebCache.h>

@implementation AllGroupCell

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
    
    
    [self.headImageView sd_setImageWithURL:[model.groupAvatar lkbImageUrl5] placeholderImage:YQNormalPlaceImage];
    self.nameLable.text = model.groupName;
    self.describleLable .text= model.groupDesc;
    NSLog(@"=====%@===",model.topicNum);
    self.statuLable.text = [NSString stringWithFormat:@"%@条动态",model.topicNum];
    
    
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

}


- (void)configNewsInvitePeopleCellWithModel:(InvitePeopleDetailModel *)model {
    
    [self.headImageView sd_setImageWithURL:[model.avatar lkbImageUrl4] placeholderImage:LKBUserInvitePlaceImage];
    self.nameLable.text = model.userName;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

#pragma mark - Event response

#pragma maek - SubViews
- (void)configureSubview
{
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.describleLable];
    [self.contentView addSubview:self.statuLable];
    [self.contentView addSubview:self.lineView];

}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(19);
            make.left.mas_equalTo(14);
            //            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            //            make.centerY.mas_equalTo(self.contentView);
            
        }];
        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(14);
            make.left.mas_equalTo(_headImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-10);
            //            make.centerY.mas_equalTo(self.contentView);
        }];

        
        [_describleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLable.bottom).offset(8);
            make.left.mas_equalTo(_nameLable.left);
            make.right.mas_equalTo(self.contentView).offset(-10);
        }];
        [_statuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_describleLable.bottom).offset(5);
            make.left.mas_equalTo(_describleLable.left);
            make.right.mas_equalTo(self.contentView.right).offset(-10);
            
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLable);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset (-2);
            make.height.mas_equalTo(0.5);
        }];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    }
    return _lineView;
}

#pragma mark - Getters & Setters
- (UIImageView*)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        //        _headImageView.clipsToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 25;
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
        _nameLable.textColor = CCCUIColorFromHex(0x333333);
        _nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
        _nameLable.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLable;
}



- (UILabel*)describleLable
{
    if (!_describleLable) {
        _describleLable = [[UILabel alloc] init];
        _describleLable.numberOfLines = 1;
        _describleLable.font = [UIFont systemFontOfSize:11];
        _describleLable.textColor = CCCUIColorFromHex(0x999999);
        _describleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _describleLable;
}


- (UILabel*)statuLable
{
    if (!_statuLable) {
        _statuLable = [[UILabel alloc] init];
        _statuLable.numberOfLines = 1;
        _statuLable.font = [UIFont systemFontOfSize:11];
        _statuLable.textColor = CCCUIColorFromHex(0x999999);
        _statuLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _statuLable;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
