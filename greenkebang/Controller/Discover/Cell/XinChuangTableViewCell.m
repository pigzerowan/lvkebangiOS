//
//  XinChuangTableViewCell.m
//  greenkebang
//
//  Created by 郑渊文 on 7/22/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "XinChuangTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation XinChuangTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self configureSubview];
    }
    return self;
}
#pragma mark - Public methods
- (void)configxinChuangTableCellWithGoodModel:(StarSchoolModelDetailModel *)admirGood
{
    
//    NSString *imageUrl = @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
    [self.coverImageView sd_setImageWithURL:[admirGood.couAvatar lkbImageUrlSTARCover] placeholderImage:YQNormalBackGroundPlaceImage];
    
    self.nameLabel.text = admirGood.couTeacher;
    self.goodsTitleLabel.text = admirGood.couTitle;
    self.goodsDesLabel.text=admirGood.teacherDesc;
    self.comentNumLable.text =admirGood.replyNum;
     self.loveLabel.text = admirGood.starNum;

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
#pragma mark - Event response
- (void)loveButtonDidClicked:(id)sender
{
}
#pragma maek - SubViews
- (void)configureSubview
{

    [self.contentView addSubview:self.coverImageView];
    
    
    
    UIImageView *playerImg = [[UIImageView alloc]initWithFrame:CGRectMake(8, 85-8-18, 20, 20)];
    playerImg.image = [UIImage imageNamed:@"icon_video_s"];
    [self.coverImageView addSubview:playerImg];
    
    
    
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.goodsTitleLabel];
    [self.contentView addSubview:self.goodsDesLabel];
    
    [self.contentView addSubview:self.repleyImageView];
    [self.contentView addSubview:self.comentNumLable];
      [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.loveImage];
    [self.contentView addSubview:self.loveLabel];
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {

        [_coverImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(14);
            make.bottom.mas_equalTo(-14);
            make.left.mas_equalTo(12);
            make.width.mas_equalTo(150);
        }];
        
        
        [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_coverImageView.right).mas_equalTo(10);
            make.top.mas_equalTo(_coverImageView);
            make.right.mas_equalTo(self.contentView).offset(-12);
        }];
        
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_coverImageView.right).offset(10);
            make.top.mas_equalTo(_goodsTitleLabel.bottom).offset(5);
            make.right.mas_equalTo(self.contentView).offset(-12);;
    
        }];
        [_goodsDesLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.right.mas_equalTo(_nameLabel);
            make.top.mas_equalTo(_nameLabel.bottom).offset(5);
        }];
        
        [_repleyImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            

                make.left.mas_equalTo(_loveLabel.right).offset(24);
                make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(11);
                make.size.mas_equalTo(CGSizeMake(14, 14));
   
        }];
        [_comentNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            
            make.left.mas_equalTo(_repleyImageView.right).offset(8);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(11);
            
        }];

        [_loveImage mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_coverImageView.right).offset(12);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        [_loveLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_loveImage.right).offset(8);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(11);
            //            make.size.mas_equalTo(CGSizeMake(40, 15));
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





#pragma mark - Getters & Setters


- (UIImageView*)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.clipsToBounds = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}


- (UIImageView*)repleyImageView
{
    if (!_repleyImageView) {
        _repleyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_comment"]];
    }
    return _repleyImageView;
}


- (UILabel*)comentNumLable
{
    if (!_comentNumLable) {
        _comentNumLable = [[UILabel alloc] init];
        _comentNumLable.numberOfLines = 1;
        _comentNumLable.font = [UIFont systemFontOfSize:12];
        _comentNumLable.textColor = [UIColor colorWithHex:0x999999];
        _comentNumLable.textAlignment = NSTextAlignmentLeft;
        _comentNumLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _comentNumLable;
}


- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 1;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor colorWithHex:0x666666];
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}


- (UILabel*)goodsTitleLabel
{
    if (!_goodsTitleLabel) {
        _goodsTitleLabel = [[UILabel alloc] init];
        _goodsTitleLabel.numberOfLines = 1;
        _goodsTitleLabel.font = [UIFont systemFontOfSize:16];
        _goodsTitleLabel.textColor = [UIColor blackColor];
        _goodsTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsTitleLabel;
}
- (UILabel*)goodsDesLabel
{
    if (!_goodsDesLabel) {
        _goodsDesLabel = [[UILabel alloc] init];
        _goodsDesLabel.numberOfLines = 1;
        _goodsDesLabel.font = [UIFont systemFontOfSize:12];
        _goodsDesLabel.textColor = [UIColor colorWithHex:0x666666];
        _goodsDesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsDesLabel;
}


- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    }
    return _lineView;
}

-(UIImageView *)loveImage {
    
    if (!_loveImage) {
        _loveImage = [[UIImageView alloc]init];
        _loveImage.image = [UIImage imageNamed:@"icon_like_nor"];
    }
    return _loveImage;
}


- (UILabel *)loveLabel {
    
    if (!_loveLabel) {
        _loveLabel = [[UILabel alloc]init];
        _loveLabel.font = [UIFont systemFontOfSize:12];
        _loveLabel.textColor = CCCUIColorFromHex(0x999999);
        
        
    }
    return _loveLabel;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
