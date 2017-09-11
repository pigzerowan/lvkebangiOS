//
//  NoImageDetailCell.m
//  greenkebang
//
//  Created by 郑渊文 on 1/22/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "NoImageDetailCell.h"
#import <UIImageView+WebCache.h>
#import "NewTimeDynamicModel.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"

@implementation NoImageDetailCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        [self configureSubview];
        
    }
    
    return self;
}



- (void)configNoImageDetailTimeTableCellWithGoodModel:(NewDynamicDetailModel *)admirGood
{
    [self.headImageView sd_setImageWithURL:[admirGood.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    

        _typeStr = @"问答";

    [_replyBtn setTitle:admirGood.replyNum forState:UIControlStateNormal];
    [_loveBtn setTitle:admirGood.starNum forState:UIControlStateNormal];
    
    _comentNumLable.text = admirGood.replyNum;
    _attentionNumLable.text = [NSString stringWithFormat:@"%@人关注",admirGood.attentionNum];

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
    // 行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_goodsTitleLabel.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _goodsTitleLabel.text.length)];
    _goodsTitleLabel.attributedText = attributedString;
    
    
    self.goodsDesLabel.text = admirGood.summary;
    // 行间距
    NSMutableAttributedString *DesString = [[NSMutableAttributedString alloc]initWithString:_goodsDesLabel.text];;
    NSMutableParagraphStyle *DesStyle = [[NSMutableParagraphStyle alloc]init];
    [DesStyle setLineSpacing:3];
    [DesString addAttribute:NSParagraphStyleAttributeName value:DesStyle range:NSMakeRange(0, _goodsDesLabel.text.length)];
    _goodsDesLabel.attributedText = DesString;
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

- (void)configNoImageDetailUserTableCellWithModel:(UserDynamicModelIntroduceModel *)model {
    
    [self.headImageView sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    
    if ([model.type isEqualToString:@"1"]) {
        _typeStr = @"发布文章";
    }else if ([model.type isEqualToString:@"2"])
    {
        _typeStr = @"发布技术疑难";
    }
    else if ([model.type isEqualToString:@"3"])
    {
        _typeStr = @"回复技术疑难";
    }else if ([model.type isEqualToString:@"4"])
    {
        _typeStr = @"发布话题";
    }else if ([model.type isEqualToString:@"5"])
    {
        _typeStr = @"创建群组";
    }

    self.coverImageView.backgroundColor = [UIColor redColor];
    
    self.coverImageView.hidden = [NSStrUtil isEmptyOrNull:model.cover];
    
    [self.coverImageView sd_setImageWithURL:[model.cover lkbImageUrl2] placeholderImage:YQNormalBackGroundPlaceImage];
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:model.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    
    self.nameLabel.text =[NSString stringWithFormat:@"%@---%@",model.userName,_typeStr] ;
    self.goodsTitleLabel.text = model.title;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_goodsTitleLabel.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _goodsTitleLabel.text.length)];
    _goodsTitleLabel.attributedText = attributedString;
//    //调节高度
//    CGSize size = CGSizeMake(kDeviceWidth, 500000);
//    CGSize labelSize = [_goodsTitleLabel sizeThatFits:size];

    
    
    
    self.goodsDesLabel.text = model.summary;
    
    // 行间距
    NSMutableAttributedString *DesString = [[NSMutableAttributedString alloc]initWithString:_goodsDesLabel.text];;
    NSMutableParagraphStyle *DesStyle = [[NSMutableParagraphStyle alloc]init];
    [DesStyle setLineSpacing:3];
    [DesString addAttribute:NSParagraphStyleAttributeName value:DesStyle range:NSMakeRange(0, _goodsDesLabel.text.length)];
    _goodsDesLabel.attributedText = DesString;
    if (model.pubDate != 0) {
        self.goodsTimeLabel.text = [NSString stringWithFormat:@"%@-%@",[NSDate timestampToYear:model.pubDate/1000],[NSDate timestampToMonth:model.pubDate/1000]];
    }else{
        self.goodsTimeLabel.text = @"";
    }
    self.goodsAddressLabel.text = model.summary;
    self.addressIconImageView.hidden = [NSStrUtil isEmptyOrNull:model.summary];
    
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
        [self.contentView addSubview:self.squeBtn];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.loveTimeLabel];
    [self.contentView addSubview:self.goodsTitleLabel];
    [self.contentView addSubview:self.goodsDesLabel];
    [self.contentView addSubview:self.repleyImageView];
    [self.contentView addSubview:self.comentNumLable];
    [self.contentView addSubview:self.attentionNumLable];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    //     应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.goodsTitleLabel.preferredMaxLayoutWidth = w - 20;
    
    
    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.goodsDesLabel.preferredMaxLayoutWidth = w - 20;
    self.goodsDesLabel.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
    //                                   initWithTarget:self
    //                                   action:@selector(onTap)];
    //    [self.goodsDesLabel addGestureRecognizer:tap];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.repleyImageView;
    self.hyb_bottomOffsetToCell = 15;

}

- (void)updateConstraints
{
    
      CGFloat padding = iPhone5_Before ? 13 : 15;
    if (!self.didSetupConstraints) {
        
        [_headImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(12);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.top.mas_equalTo(15);
        }];
        
        [_squeBtn mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(self.contentView.right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.top.mas_equalTo(15);
        }];

        
        [_loveTimeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(_squeBtn.left).offset(-5);
            make.centerY.mas_equalTo(_headImageView);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_headImageView.right).offset(10);
//            make.right.mas_equalTo(_loveTimeLabel.left).offset(-10);
             make.centerY.mas_equalTo(_headImageView);
            
            make.width.mas_equalTo(kDeviceWidth - 150);
        }];

        
        
        [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_loveTimeLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(self.contentView.right).offset(-10);
        }];
        [_goodsDesLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsTitleLabel.bottom).offset(6);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(self.contentView.right).offset(-10);
        }];
        


        [_repleyImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_headImageView);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(padding, padding));
        }];
        [_comentNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_repleyImageView.right).offset(10);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 15));
        }];
        
        [_attentionNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_comentNumLable.right).offset(10);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];


        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}



- (void)pushToChoose:(UIButton *)sender {
    if (self.btnBlock) {
        self.btnBlock();
    }
}

- (void)handlerButtonAction:(TouchCellBtnBlock)block
{
    self.btnBlock = block;
}

- (UIButton*)squeBtn
{
    if (!_squeBtn) {
        _squeBtn = [[UIButton alloc] init];
        
        [_squeBtn setImage:[UIImage imageNamed:@"square_btn_arrow_nor"] forState:UIControlStateNormal];
        [_squeBtn addTarget:self action:@selector(pushToChoose:)  forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _squeBtn;
}

- (UILabel*)attentionNumLable
{
    if (!_attentionNumLable) {
        _attentionNumLable = [[UILabel alloc] init];
        _attentionNumLable.numberOfLines = 1;
        _attentionNumLable.font = [UIFont systemFontOfSize:11];
        _attentionNumLable.textColor = [UIColor lightGrayColor];
        _attentionNumLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _attentionNumLable;
}


- (UILabel*)comentNumLable
{
    if (!_comentNumLable) {
        _comentNumLable = [[UILabel alloc] init];
        _comentNumLable.numberOfLines = 1;
        _comentNumLable.font = [UIFont systemFontOfSize:11];
        _comentNumLable.textColor = [UIColor lightGrayColor];
        _comentNumLable.textAlignment = NSTextAlignmentLeft;
        _comentNumLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _comentNumLable;
}

- (UIImageView*)repleyImageView
{
    if (!_repleyImageView) {
        _repleyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_comment"]];
    }
    return _repleyImageView;
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
        _nameLabel.numberOfLines = 1;
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
        _loveTimeLabel.textColor = [UIColor colorWithHex:0x999999];
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
        [_loveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -loveImage.size.width-30, 0, loveImage.size.width)];
        [_loveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, _loveBtn.titleLabel.bounds.size.width, 0, -_loveBtn.titleLabel.bounds.size.width)];
        [_loveBtn setTitleColor:[UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1] forState:UIControlStateNormal];
        
        
        [_loveBtn setImage:[UIImage imageNamed:@"icon_unPushlove"] forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@"icon_Pushlove"] forState:UIControlStateSelected];
        [_loveBtn addTarget:self action:@selector(loveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveBtn;
}




- (UIButton *)replyBtn
{
    if (!_replyBtn) {
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setFrame:CGRectMake(0, 0, kDeviceWidth/2, 50)];
        _replyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_replyBtn setTitleColor:[UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1] forState:UIControlStateNormal];
        
        //        _replyBtn.backgroundColor = [UIColor whiteColor];
        _replyBtn.titleEdgeInsets = UIEdgeInsetsMake(-25, _replyBtn.titleLabel.bounds.size.width, _replyBtn.titleLabel.bounds.size.width-30,-30);
        [_replyBtn setImage:[UIImage imageNamed:@"icon_comment"] forState:UIControlStateNormal];
        _replyBtn.imageEdgeInsets = UIEdgeInsetsMake(-25,13,_replyBtn.titleLabel.bounds.size.width-30,_replyBtn.titleLabel.bounds.size.width);
        _replyBtn.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
        _replyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_replyBtn addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBtn;
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
