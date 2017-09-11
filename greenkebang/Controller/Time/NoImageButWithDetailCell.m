//
//  NoImageButWithDetailCell.m
//  greenkebang
//
//  Created by 郑渊文 on 1/22/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "NoImageButWithDetailCell.h"
#import <UIImageView+WebCache.h>
#import "NewTimeDynamicModel.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"


@implementation NoImageButWithDetailCell
{
    CGRect CellBounds;
    CGFloat cellHeight;
}
- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID

{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier: reuseID];
    if (self)
    {
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        CellBounds = CGRectMake(0, 0, SCREEN_WIDTH, height);
        cellHeight = height;
        
        [self configureSubview];
    }
    return  self;
    
}


#pragma mark - Getters & Setters
- (void)setDidLike:(BOOL)didLike
{
    _didLike = didLike;
    self.loveBtn.selected = didLike;
}

#pragma mark - Event response
- (void)loveButtonClicked:(id)sender
{
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }
    
}
- (void)buyButtonClicked:(id)sender
{
    if (self.clickBlock) {
        self.clickBlock(2);
    }
}
- (void)configNoImageButDetailTimeTableCellWithGoodModel:(NewDynamicDetailModel *)admirGood
{
    [self.headImageView sd_setImageWithURL:[admirGood.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    
    if ([admirGood.type isEqualToString:@"1"]) {
        _typeStr = @"专栏";
    }else if ([admirGood.type isEqualToString:@"2"])
    {
        _typeStr = @"问答";
    }
    
    
    [_replyBtn setTitle:admirGood.replyNum forState:UIControlStateNormal];
    [_loveBtn setTitle:admirGood.starNum forState:UIControlStateNormal];
    
    self.coverImageView.backgroundColor = [UIColor redColor];
    
    self.coverImageView.hidden = [NSStrUtil isEmptyOrNull:admirGood.cover];
    
    [self.coverImageView sd_setImageWithURL:[admirGood.cover lkbImageUrl2] placeholderImage:YQNormalBackGroundPlaceImage];
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:admirGood.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    
    NSString* priceStr = [NSString stringWithFormat:@"%@ | %@",_typeStr,admirGood.userName];
    
    NSMutableAttributedString* priAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ | %@",_typeStr,admirGood.userName] ];
    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, priceStr.length)];
    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor LkbgreenColor] range:NSMakeRange(0, 2)];
    
    self.nameLabel.attributedText =priAttributedStr;
    self.goodsTitleLabel.text = admirGood.title;
    self.goodsDesLabel.text = admirGood.summary;
    if (admirGood.pubDate != 0) {
        self.goodsTimeLabel.text = [NSString stringWithFormat:@"%@-%@",[NSDate timestampToYear:admirGood.pubDate/1000],[NSDate timestampToMonth:admirGood.pubDate/1000]];
    }else{
        self.goodsTimeLabel.text = @"";
    }
    self.goodsAddressLabel.text = admirGood.summary;
    self.addressIconImageView.hidden = [NSStrUtil isEmptyOrNull:admirGood.summary];
    
    //    NSString* priceStr = [NSString stringWithFormat:@"%@",@(admirGood.summary)];
//    NSMutableAttributedString* priAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元起", @"3"]];
    //    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, priceStr.length)];
    self.goodsPriceLabel.attributedText = priAttributedStr;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}


- (void)configNoImageButDetailUserTableCellWithGoodModel:(UserDynamicModelIntroduceModel *)model {
    
    NSLog(@"=========================================================================%@",model);
    [self.headImageView sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    
    if ([model.type isEqualToString:@"1"]) {
        _typeStr = @"专栏";
    }else if ([model.type isEqualToString:@"2"])
    {
        _typeStr = @"问答";
    }
   
    [_replyBtn setTitle:model.replyNum forState:UIControlStateNormal];
    [_loveBtn setTitle:model.starNum forState:UIControlStateNormal];
    
    self.coverImageView.backgroundColor = [UIColor redColor];
    
    self.coverImageView.hidden = [NSStrUtil isEmptyOrNull:model.cover];
    
    [self.coverImageView sd_setImageWithURL:[model.cover lkbImageUrl2] placeholderImage:YQNormalBackGroundPlaceImage];
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:model.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    NSString* priceStr = [NSString stringWithFormat:@"%@ | %@",_typeStr,model.userName];
    
    NSMutableAttributedString* priAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ | %@",_typeStr,model.userName] ];
    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, priceStr.length)];
    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor LkbgreenColor] range:NSMakeRange(0, 2)];
    
    self.nameLabel.attributedText =priAttributedStr;
    self.goodsTitleLabel.text = model.title;
    self.goodsDesLabel.text = model.summary;
    if (model.pubDate != 0) {
        self.goodsTimeLabel.text = [NSString stringWithFormat:@"%@-%@",[NSDate timestampToYear:model.pubDate/1000],[NSDate timestampToMonth:model.pubDate/1000]];
    }else{
        self.goodsTimeLabel.text = @"";
    }
    self.goodsAddressLabel.text = model.summary;
    self.addressIconImageView.hidden = [NSStrUtil isEmptyOrNull:model.summary];
    
    //    NSString* priceStr = [NSString stringWithFormat:@"%@",@(admirGood.summary)];
//    NSMutableAttributedString* priAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元起", @"3"]];
    //    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, priceStr.length)];
    self.goodsPriceLabel.attributedText = priAttributedStr;
    
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
    
    
    CGFloat padding = iPhone5 ? 24 : 44;
    
    [self.contentView addSubview:self.headImageView];
    
    [self.contentView addSubview:self.loveTimeLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.goodsTitleLabel];
    [self.contentView addSubview:self.goodsDesLabel];
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_headImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(12);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.top.mas_equalTo(15);
        }];
        
        [_loveTimeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(self.contentView).offset(-20);
            make.centerY.mas_equalTo(_headImageView);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_headImageView.right).offset(10).priorityLow();
            make.right.mas_equalTo(_loveTimeLabel.left);
            make.centerY.mas_equalTo(_headImageView);
        }];
        
        
        [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_loveTimeLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(self.contentView).offset(10);
        }];
        [_goodsDesLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsTitleLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(self.contentView).offset(-10);
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
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 10;
    }
    return _headImageView;
}


- (UIImageView*)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.clipsToBounds = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}
- (UIImageView*)addressIconImageView
{
    if (!_addressIconImageView) {
        _addressIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yq_goods_address_icon.png"]];
    }
    return _addressIconImageView;
}
- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}
- (UILabel*)loveTimeLabel
{
    if (!_loveTimeLabel) {
        _loveTimeLabel = [[UILabel alloc] init];
        _loveTimeLabel.numberOfLines = 0;
        _loveTimeLabel.font = [UIFont systemFontOfSize:12];
        _loveTimeLabel.textColor = [UIColor colorWithHex:0x666666];
        _loveTimeLabel.textAlignment = NSTextAlignmentRight;
        _loveTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _loveTimeLabel;
}

- (UILabel*)goodsTitleLabel
{
    if (!_goodsTitleLabel) {
        _goodsTitleLabel = [[UILabel alloc] init];
        _goodsTitleLabel.numberOfLines = 2;
        _goodsTitleLabel.font = [UIFont systemFontOfSize:16];
        _goodsTitleLabel.textColor = [UIColor colorWithHex:0x333333];
        _goodsTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsTitleLabel;
}
- (UILabel*)goodsDesLabel
{
    if (!_goodsDesLabel) {
        _goodsDesLabel = [[UILabel alloc] init];
        _goodsDesLabel.numberOfLines = 2;
        _goodsDesLabel.font = [UIFont systemFontOfSize:12];
        _goodsDesLabel.textColor = [UIColor colorWithHex:0x999999];
        _goodsDesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsDesLabel;
}
- (UILabel*)goodsTimeLabel
{
    if (!_goodsTimeLabel) {
        _goodsTimeLabel = [[UILabel alloc] init];
        _goodsTimeLabel.numberOfLines = 0;
        _goodsTimeLabel.font = [UIFont systemFontOfSize:12];
        _goodsTimeLabel.textColor = [UIColor colorWithHex:0x999999];
        _goodsTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsTimeLabel;
}

- (UILabel*)goodsAddressLabel
{
    if (!_goodsAddressLabel) {
        _goodsAddressLabel = [[UILabel alloc] init];
        _goodsAddressLabel.numberOfLines = 0;
        _goodsAddressLabel.font = [UIFont systemFontOfSize:12];
        _goodsAddressLabel.textColor = [UIColor colorWithHex:0x999999];
        _goodsAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsAddressLabel;
}
- (UILabel*)goodsPriceLabel
{
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] init];
        _goodsPriceLabel.numberOfLines = 0;
        _goodsPriceLabel.font = [UIFont systemFontOfSize:12];
        _goodsPriceLabel.textColor = [UIColor blackColor];
        _goodsPriceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsPriceLabel;
}

- (UIView*)controllerView
{
    if (!_controllerView) {
        _controllerView = [[UIView alloc] init];
        _controllerView.backgroundColor = [UIColor whiteColor];
    }
    return _controllerView;
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
