//
//  AttentionArticTableViewCell.m
//  greenkebang
//
//  Created by 郑渊文 on 4/5/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "AttentionArticTableViewCell.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"

@implementation AttentionArticTableViewCell
#pragma mark - Getters & Setters




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configureSubview];
        
    }
    return self;
}
- (void)configAttentionArticTableCellWithGoodModel:(AttentionContentsListModel *)admirGood
{
//    [self.headImageView sd_setImageWithURL:[admirGood.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
//        NSString *imageUrl = @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
    [self.headImageView sd_setImageWithURL:[admirGood.featureAvatar lkbImageUrl8] placeholderImage:YQNormalPlaceImage];
    self.columnNameLable.text = [NSString stringWithFormat:@"%@的专栏",admirGood.userName];
    self.ArticNumLable.text= [NSString stringWithFormat:@"%@篇文章",admirGood.insightNum];
    
    self.publishLable.text = [NSString stringWithFormat:@"最新: %@",admirGood.title];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
#pragma mark - Event response


- (void)handlerButtonAction:(BottomBuyClickBlock)block {
    
    self.clickBlock = block;
}

#pragma maek - SubViews
- (void)configureSubview
{
    [self.contentView addSubview:self.headImageBackView];
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.columnNameLable];
    [self.contentView addSubview:self.nameImage];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.ArticNumLable];
    [self.contentView addSubview:self.publishLable];
    [self.contentView addSubview:self.lineView];

}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [_headImageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(42, 42));
        }];

        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(11);
            make.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(41, 41));
        }];
        

        [_columnNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(20);
            make.left.mas_equalTo(_headImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView);
        }];
        
        
        [_ArticNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(20);
            make.right.mas_equalTo(self.contentView).offset(-14);
            make.height.mas_equalTo(24);


        }];
        
        [_publishLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_columnNameLable.bottom).offset(10);
            make.left.mas_equalTo(_columnNameLable);
            make.right.mas_equalTo(self.contentView).offset(-14);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(14);
            make.right.mas_equalTo(self.contentView).offset(-14);
            make.bottom.mas_equalTo(self.contentView).offset (-1);
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
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 20.5;
        _headImageView.clipsToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}

- (UIImageView*)headImageBackView
{
    if (!_headImageBackView) {
        _headImageBackView = [[UIImageView alloc] init];
        _headImageBackView.backgroundColor = CCCUIColorFromHex(0xe6e6e6);
        _headImageBackView.layer.masksToBounds = YES;
        _headImageBackView.layer.cornerRadius = 21;
        _headImageBackView.clipsToBounds = YES;
        _headImageBackView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageBackView;
}


-(UIImageView *)nameImage {
    
    if (!_nameImage) {
        _nameImage = [[UIImageView alloc] init];
        _nameImage.clipsToBounds = YES;
        _nameImage.contentMode = UIViewContentModeScaleAspectFill;
        [_nameImage setImage:[UIImage imageNamed:@"icon_author"]];
    }
    return _nameImage;
}

- (UILabel*)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.numberOfLines = 1;
        _nameLable.font = [UIFont systemFontOfSize:12];
        _nameLable.textColor = CCCUIColorFromHex(0x666666);
        _nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLable;
}

//- (UILabel*)timeLable
//{
//    if (!_timeLable) {
//        _timeLable = [[UILabel alloc] init];
//        _timeLable.numberOfLines = 1;
//        _timeLable.font = [UIFont systemFontOfSize:13];
//        _timeLable.textColor = CCCUIColorFromHex(0x999999);
//        _timeLable.lineBreakMode = NSLineBreakByTruncatingTail;
//        _timeLable.textAlignment = NSTextAlignmentRight;
//    }
//    return _timeLable;
//}

- (UILabel*)ArticNumLable
{
    if (!_ArticNumLable) {
        _ArticNumLable = [[UILabel alloc] init];
        _ArticNumLable.numberOfLines = 2;
        _ArticNumLable.clipsToBounds = YES;
        _ArticNumLable.font = [UIFont systemFontOfSize:12];
        _ArticNumLable.textColor = CCCUIColorFromHex(0x9d9d9d);
        _ArticNumLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _ArticNumLable;
}

- (UILabel*)publishLable
{
    if (!_publishLable) {
        _publishLable = [[UILabel alloc] init];
        _publishLable.numberOfLines = 1;
        _publishLable.clipsToBounds = YES;
//        _publishLable.text = @"最新发表:";
        _publishLable.font = [UIFont systemFontOfSize:12];
        _publishLable.textColor = CCCUIColorFromHex(0x9d9d9d);
        _publishLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _publishLable;
}


- (UIButton*)turnToAticBtn
{
    if (!_turnToAticBtn) {
        _turnToAticBtn = [[UIButton alloc] init];
        _turnToAticBtn.clipsToBounds = YES;
        _turnToAticBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_turnToAticBtn setTitleColor:CCColorFromRGBA(74, 137, 220, 1) forState:UIControlStateNormal];
        _turnToAticBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_turnToAticBtn addTarget:self action:@selector(turnToAticBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _turnToAticBtn;
}


- (void)turnToAticBtn:(id)sender {
    
//    [self.attentionCellDelegate turnToArtic:_featureId];
    if (self.clickBlock) {
        self.clickBlock(1);
    }

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
