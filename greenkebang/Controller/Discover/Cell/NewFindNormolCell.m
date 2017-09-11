//
//  NewFindNormolCell.m
//  greenkebang
//
//  Created by 郑渊文 on 1/19/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "NewFindNormolCell.h"
#import <UIImageView+WebCache.h>
#import "NewTimeDynamicModel.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"

@implementation NewFindNormolCell
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
        CellBounds = CGRectMake(0, 0, kDeviceWidth, height);
        cellHeight = height;
        self.backgroundColor = UIColorWithRGBA(244, 244, 244, 1);
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


- (void)configNewSeperateTableCellWithGoodModel:(NewFindDetailModel *)admirGood
{
    [self.headImageView sd_setImageWithURL:[admirGood.userAvatar lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    
    if ([admirGood.type isEqualToString:@"1"]) {
        _typeStr = @"发布文章";
    }else if ([admirGood.type isEqualToString:@"2"])
    {
        _typeStr = @"发布技术疑难";
    }
    else if ([admirGood.type isEqualToString:@"3"])
    {
        _typeStr = @"回复技术疑难";
    }else if ([admirGood.type isEqualToString:@"4"])
    {
        _typeStr = @"发布话题";
    }else if ([admirGood.type isEqualToString:@"5"])
    {
        _typeStr = @"创建群组";
    }

    
    self.coverImageView.backgroundColor = [UIColor redColor];
    
    self.coverImageView.hidden = [NSStrUtil isEmptyOrNull:admirGood.cover];
    
    [self.coverImageView sd_setImageWithURL:[admirGood.cover lkbImageUrl] placeholderImage:YQNormalBackGroundPlaceImage];
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:admirGood.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    
    self.nameLabel.text =[NSString stringWithFormat:@"%@---%@",admirGood.userName,_typeStr] ;
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
    NSMutableAttributedString* priAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元起", @"3"]];
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
    
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.detailView];
    
//    [self.coverImageView setFrame:CGRectMake(kDeviceWidth-145, 5, 120, 90)];
    if (self.coverImageView.hidden==YES) {
        [self.goodsTitleLabel setFrame:CGRectMake(10, 10, kDeviceWidth-40, 40)];
        [self.goodsDesLabel setFrame:CGRectMake(10, 50, kDeviceWidth-40, 40)];
    }
    else
    {
    [self.goodsTitleLabel setFrame:CGRectMake(10, 10, 160, 40)];
    [self.goodsDesLabel setFrame:CGRectMake(10, 50, 160, 40)];
    
  }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-2, 5, 1, 40)];
     
    lineView.backgroundColor = CCColorFromRGBA(210, 210, 210, 1);
    [self.controllerView addSubview:lineView];
        
    
    [self.contentView addSubview:self.controllerView];
    [self.controllerView addSubview:self.loveBtn];
    [self.controllerView addSubview:self.buyBtn];
    [self.detailView addSubview:self.coverImageView];
    [self.detailView addSubview:self.goodsDesLabel];
    [self.detailView addSubview:self.goodsTitleLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.loveTimeLabel];
    [self.contentView addSubview:self.loveButton];
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [_headImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(38, 38));
        }];
        
        [_loveButton mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        [_loveTimeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(_loveButton.left).offset(-2);
            make.centerY.mas_equalTo(_headImageView);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_headImageView.right).offset(10).priorityLow();
            make.right.mas_equalTo(_loveTimeLabel.left);
            make.centerY.mas_equalTo(_headImageView);
        }];
        
        [_detailView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_headImageView.bottom).offset(1).priorityHigh();
            make.left.mas_equalTo(_headImageView);
            make.width.mas_equalTo(kDeviceWidth-20);
            make.height.mas_equalTo(100);
        }];
        
        [_coverImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.right.mas_equalTo(10);
            make.left.mas_equalTo(_detailView.right).offset(10);
//            make.width.mas_equalTo(kDeviceWidth-20);
            make.height.mas_equalTo(100);
        }];
        
        [_controllerView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_detailView.bottom).offset(1).priorityHigh();
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(kDeviceWidth-20);
            make.height.mas_equalTo(50);
        }];
        
        //         [_coverImageView mas_makeConstraints:^(MASConstraintMaker* make) {
        //                make.top.mas_equalTo(_headImageView.bottom).offset(10).priorityHigh();
        //                make.bottom.mas_equalTo(-10);
        //                make.left.mas_equalTo(_headImageView);
        //                make.width.mas_equalTo(100);
        //         }];
        //        if (_coverImageView.hidden == YES) {
        //
        //
        //            [_coverImageView mas_makeConstraints:^(MASConstraintMaker* make) {
        //                make.top.mas_equalTo(_headImageView.bottom).offset(10).priorityHigh();
        //                make.bottom.mas_equalTo(-10);
        //                make.left.mas_equalTo(_headImageView);
        //                make.width.mas_equalTo(0);
        //            }];
        //
        //            [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        //                make.left.mas_equalTo(_headImageView.right).mas_equalTo(10);
        //                make.top.mas_equalTo(_coverImageView);
        //                make.right.mas_equalTo(self.contentView);
        //                return ;
        //            }];
        //        }
        //        if (_coverImageView.hidden == NO)
        //        {
        //        [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        //            make.left.mas_equalTo(_coverImageView.right).mas_equalTo(10);
        //            make.top.mas_equalTo(_coverImageView);
        //            make.right.mas_equalTo(self.contentView);
        //            return ;
        //        }];
        //        }
        //        [_goodsDesLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        //            make.left.right.mas_equalTo(_goodsTitleLabel);
        //            make.top.mas_equalTo(_goodsTitleLabel.bottom).offset(5);
        //        }];
        
        
        
        //        [_goodsTimeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        //            make.left.right.mas_equalTo(_goodsTitleLabel);
        //            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
        //        }];
        //        [_addressIconImageView mas_makeConstraints:^(MASConstraintMaker* make) {
        //            make.left.mas_equalTo(_goodsTitleLabel);
        //            make.top.mas_equalTo(_goodsTimeLabel.bottom).offset(10);
        //            make.size.mas_equalTo(CGSizeMake(14, 16));
        //        }];
        //        [_goodsAddressLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        //            make.left.mas_equalTo(_addressIconImageView.right).offset(1);
        //            make.centerY.mas_equalTo(_addressIconImageView);
        //            make.right.mas_equalTo(_goodsTitleLabel);
        //        }];
        //        [_goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        //            make.left.right.mas_equalTo(_goodsTitleLabel);
        //            make.bottom.mas_equalTo(_coverImageView.bottom).offset(-2);
        //        }];
        
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
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = [UIColor colorWithHex:0x666666];
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}
- (UILabel*)loveTimeLabel
{
    if (!_loveTimeLabel) {
        _loveTimeLabel = [[UILabel alloc] init];
        _loveTimeLabel.numberOfLines = 0;
        _loveTimeLabel.font = [UIFont systemFontOfSize:13];
        _loveTimeLabel.textColor = [UIColor colorWithHex:0x666666];
        _loveTimeLabel.textAlignment = NSTextAlignmentRight;
        _loveTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _loveTimeLabel;
}
- (UIButton*)loveButton
{
    if (!_loveButton) {
        _loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loveButton setImage:[UIImage imageNamed:@"yq_love_small.png"] forState:UIControlStateNormal];
        [_loveButton setImage:[UIImage imageNamed:@"yq_love_small_select.png"] forState:UIControlStateSelected];
        [_loveButton addTarget:self action:@selector(loveButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveButton;
}
- (UILabel*)goodsTitleLabel
{
    if (!_goodsTitleLabel) {
        _goodsTitleLabel = [[UILabel alloc] init];
        _goodsTitleLabel.numberOfLines = 0;
        _goodsTitleLabel.font = [UIFont systemFontOfSize:13];
        _goodsTitleLabel.textColor = [UIColor blackColor];
        _goodsTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsTitleLabel;
}
- (UILabel*)goodsDesLabel
{
    if (!_goodsDesLabel) {
        _goodsDesLabel = [[UILabel alloc] init];
        _goodsDesLabel.numberOfLines = 0;
        _goodsDesLabel.font = [UIFont systemFontOfSize:13];
        _goodsDesLabel.textColor = [UIColor colorWithHex:0x666666];
        _goodsDesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsDesLabel;
}
- (UILabel*)goodsTimeLabel
{
    if (!_goodsTimeLabel) {
        _goodsTimeLabel = [[UILabel alloc] init];
        _goodsTimeLabel.numberOfLines = 0;
        _goodsTimeLabel.font = [UIFont systemFontOfSize:13];
        _goodsTimeLabel.textColor = [UIColor colorWithHex:0x666666];
        _goodsTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsTimeLabel;
}

- (UILabel*)goodsAddressLabel
{
    if (!_goodsAddressLabel) {
        _goodsAddressLabel = [[UILabel alloc] init];
        _goodsAddressLabel.numberOfLines = 0;
        _goodsAddressLabel.font = [UIFont systemFontOfSize:13];
        _goodsAddressLabel.textColor = [UIColor colorWithHex:0x666666];
        _goodsAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsAddressLabel;
}
- (UILabel*)goodsPriceLabel
{
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] init];
        _goodsPriceLabel.numberOfLines = 0;
        _goodsPriceLabel.font = [UIFont systemFontOfSize:15];
        _goodsPriceLabel.textColor = [UIColor blackColor];
        _goodsPriceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsPriceLabel;
}
- (UIView*)detailView
{
    if (!_detailView) {
        _detailView = [[UIView alloc] init];
        _detailView.backgroundColor = CCColorFromRGBA(243, 243, 242, 1);
        _detailView.layer.borderColor = CCColorFromRGBA(210, 210, 210, 1).CGColor;
        _detailView.layer.borderWidth = 1;
    }
    return _detailView;
}

- (UIView*)controllerView
{
    if (!_controllerView) {
        _controllerView = [[UIView alloc] init];
        _controllerView.backgroundColor = [UIColor whiteColor];
    }
    return _controllerView;
}


- (UIButton *)loveBtn
{
    if (!_loveBtn) {
        _loveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loveBtn setFrame:CGRectMake(kDeviceWidth/2, 0, kDeviceWidth/2, 50)];
        _loveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        UIImage *loveImage = [UIImage imageNamed:@"yq_love_small_02.png"];
        [_loveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -loveImage.size.width-30, 0, loveImage.size.width)];
        [_loveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _loveBtn.titleLabel.bounds.size.width+80, 0, -_loveBtn.titleLabel.bounds.size.width)];
        [_loveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_loveBtn setTitle:@"赞" forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@"icon_praise_nor.png"] forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@"icon_praise_sel.png"] forState:UIControlStateSelected];
        [_loveBtn addTarget:self action:@selector(loveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveBtn;
}


- (UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setFrame:CGRectMake(0, 0, kDeviceWidth/2, 50)];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_buyBtn setTitle:@"评论" forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
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
