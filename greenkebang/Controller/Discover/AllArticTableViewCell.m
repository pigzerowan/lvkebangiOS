//
//  AllArticTableViewCell.m
//  greenkebang
//
//  Created by 郑渊文 on 7/25/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "AllArticTableViewCell.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"


@implementation AllArticTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configureSubview];
        
    }
    return self;
}



- (void)configAllArticTableCellWithGoodModel:(AttentionContentsListModel *)admirGood
{
    //    [self.headImageView sd_setImageWithURL:[admirGood.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    //        NSString *imageUrl = @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
    [self.headImageView sd_setImageWithURL:[admirGood.featureAvatar lkbImageUrl8] placeholderImage:YQNormalBackGroundPlaceImage];
    self.columnNameLable.text = admirGood.featureName;
    self.nameLable.text = [NSString stringWithFormat:@"作者 %@     %@篇文章",admirGood.userName,admirGood.insightNum];
    //    admirGood.userName;
//    self.ArticNumLable.text= [NSString stringWithFormat:@"%@篇文章",admirGood.insightNum];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)configSeperateGroupCellWithModel:(FindSearchModelDetailModel *)model {
    
    [self.headImageView sd_setImageWithURL:[model.cover lkbImageUrl8] placeholderImage:YQNormalPlaceImage];
    self.columnNameLable.text = model.title;
    self.nameLable.text = [NSString stringWithFormat:@"作者 %@     %@篇文章",model.userName,model.insightNum];
    //    admirGood.userName;
    //    self.ArticNumLable.text= [NSString stringWithFormat:@"%@篇文章",admirGood.insightNum];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

    
}

#pragma mark - Event response

#pragma maek - SubViews
- (void)configureSubview
{
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.columnNameLable];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.ArticNumLable];
     [self.contentView addSubview:self.lineView];

    
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        
        [_columnNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(21);
            make.left.mas_equalTo(_headImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView);
        }];
        

        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_columnNameLable.bottom).offset(7);
            make.left.mas_equalTo(_columnNameLable.left);
            make.right.mas_equalTo(self.contentView);
        }];
        [_ArticNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_columnNameLable.bottom).offset(7);
            make.left.mas_equalTo(_nameLable.right).offset(16);
            make.right.mas_equalTo(self.contentView.right).offset(-10);

        }];
        
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset (-1);
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
        _headImageView.clipsToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds =YES;
        _headImageView.layer.cornerRadius =25;
    }
    return _headImageView;
}


- (UILabel*)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.numberOfLines = 1;
        _nameLable.font = [UIFont systemFontOfSize:11];
        _nameLable.textColor = CCCUIColorFromHex(0x999999);
        _nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLable;
}


- (UILabel*)ArticNumLable
{
    if (!_ArticNumLable) {
        _ArticNumLable = [[UILabel alloc] init];
        _ArticNumLable.numberOfLines = 2;
        _ArticNumLable.clipsToBounds = YES;
        _ArticNumLable.font = [UIFont systemFontOfSize:11];
        _ArticNumLable.textColor = CCCUIColorFromHex(0x999999);
        _ArticNumLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _ArticNumLable;
}


- (UILabel*)columnNameLable
{
    if (!_columnNameLable) {
        _columnNameLable = [[UILabel alloc] init];
        _columnNameLable.numberOfLines = 2;
        _columnNameLable.clipsToBounds = YES;
        _columnNameLable.font = [UIFont systemFontOfSize:16];
        _columnNameLable.textColor = CCCUIColorFromHex(0x333333);
        _columnNameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _columnNameLable;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
