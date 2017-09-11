//
//  UserCoulmmNoImageCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserCoulmmNoImageCell.h"
#import <UIImageView+WebCache.h>
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"
@implementation UserCoulmmNoImageCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        [self configureSubview];
        
    }
    
    return self;
}

- (void)configNoImageDetailUserTableCellWithModel:(UserDynamicModelIntroduceModel *)model {
    
//    [self.headImageView sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    
    
    if ([model.type isEqualToString:@"1"]) {
        _typeStr = @"专栏";

    }
    else {
        _typeStr = model.groupName;

    }
    
    [_replyBtn setTitle:model.replyNum forState:UIControlStateNormal];
    [_loveBtn setTitle:model.starNum forState:UIControlStateNormal];
    
    _comentNumLable.text = model.replyNum;
    _attentionNumLable.text = [NSString stringWithFormat:@"%@人关注",model.starNum];
    
    self.coverImageView.backgroundColor = [UIColor redColor];
    
    self.coverImageView.hidden = [NSStrUtil isEmptyOrNull:model.cover];
    
    [self.coverImageView sd_setImageWithURL:[model.cover lkbImageUrl2] placeholderImage:YQNormalBackGroundPlaceImage];
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:model.pubDate];
//    self.loveTimeLabel.text = [createDate timeAgo];
    
    NSString* priceStr = [NSString stringWithFormat:@"%@ %@",_typeStr,[createDate timeAgo]];
    NSMutableAttributedString* priAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",_typeStr,[createDate timeAgo]] ];
    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, priceStr.length)];
    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor LkbgreenColor] range:NSMakeRange(0, _typeStr.length)];
    
    self.nameLabel.attributedText =priAttributedStr;
    self.goodsTitleLabel.text = model.title;
//    if (![model.title isEqualToString:@""]|| model.title != nil) {
//    // 行间距
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_goodsTitleLabel.text];;
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    [paragraphStyle setLineSpacing:5];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _goodsTitleLabel.text.length)];
//    _goodsTitleLabel.attributedText = attributedString;
//    }
    self.goodsDesLabel.text = model.summary;
    
    if (![model.summary isEqualToString:@""]|| model.summary != nil) {
    // 行间距
    NSMutableAttributedString *DesString = [[NSMutableAttributedString alloc]initWithString:_goodsDesLabel.text];;
    NSMutableParagraphStyle *DesStyle = [[NSMutableParagraphStyle alloc]init];
    [DesStyle setLineSpacing:3];
    [DesString addAttribute:NSParagraphStyleAttributeName value:DesStyle range:NSMakeRange(0, _goodsDesLabel.text.length)];
    _goodsDesLabel.attributedText = DesString;
    
    }
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


#pragma maek - SubViews
- (void)configureSubview
{
    
    
//    [self.contentView addSubview:self.headImageView];
//    [self.contentView addSubview:self.squeBtn];
    [self.contentView addSubview:self.nameLabel];
//    [self.contentView addSubview:self.loveTimeLabel];
//    [self.contentView addSubview:self.goodsTitleLabel];
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
    self.hyb_bottomOffsetToCell = 35;
    
}

- (void)updateConstraints
{
    
    CGFloat padding = iPhone5_Before ? 13 : 15;
    if (!self.didSetupConstraints) {
        
//        [_headImageView mas_makeConstraints:^(MASConstraintMaker* make) {
//            make.left.mas_equalTo(10);
//            make.size.mas_equalTo(CGSizeMake(20, 20));
//            make.top.mas_equalTo(5);
//        }];
//        
//        [_squeBtn mas_makeConstraints:^(MASConstraintMaker* make) {
//            make.right.mas_equalTo(self.contentView.right).offset(-10);
//            make.size.mas_equalTo(CGSizeMake(20, 20));
//            make.top.mas_equalTo(5);
//        }];
//        
//        
//        [_loveTimeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
//            make.right.mas_equalTo(_squeBtn.left).offset(-5);
//            make.centerY.mas_equalTo(_headImageView);
//        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(self.contentView.right).offset(-12);
            make.top.mas_equalTo(15);
        }];
        
        
        
//        [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
//            make.top.mas_equalTo(_nameLabel.bottom).offset(10);
//            make.left.mas_equalTo(_nameLabel);
//            make.right.mas_equalTo(self.contentView.right).offset(-10);
//        }];
        
        [_goodsDesLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_nameLabel.bottom).offset(6);
            make.left.mas_equalTo(_nameLabel);
            make.right.mas_equalTo(self.contentView.right).offset(-10);
        }];
        
        
        
        [_repleyImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_nameLabel);
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



//- (UIButton*)squeBtn
//{
//    if (!_squeBtn) {
//        _squeBtn = [[UIButton alloc] init];
//        
//        [_squeBtn setImage:[UIImage imageNamed:@"square_btn_arrow_nor"] forState:UIControlStateNormal];
//        [_squeBtn addTarget:self action:@selector(pushToChoose:)  forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    return _squeBtn;
//}

- (UILabel*)attentionNumLable
{
    if (!_attentionNumLable) {
        _attentionNumLable = [[UILabel alloc] init];
        _attentionNumLable.numberOfLines = 1;
        _attentionNumLable.font = [UIFont systemFontOfSize:12];
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
        _comentNumLable.font = [UIFont systemFontOfSize:12];
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
//- (UIImageView*)headImageView
//{
//    if (!_headImageView) {
//        _headImageView = [[UIImageView alloc] init];
//        _headImageView.clipsToBounds = YES;
//        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _headImageView.layer.masksToBounds = YES;
//        _headImageView.layer.cornerRadius = 10;
//    }
//    return _headImageView;
//}


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
//- (UILabel*)loveTimeLabel
//{
//    if (!_loveTimeLabel) {
//        _loveTimeLabel = [[UILabel alloc] init];
//        _loveTimeLabel.numberOfLines = 0;
//        _loveTimeLabel.font = [UIFont systemFontOfSize:13];
//        _loveTimeLabel.textColor = [UIColor colorWithHex:0x666666];
//        _loveTimeLabel.textAlignment = NSTextAlignmentRight;
//        _loveTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    }
//    return _loveTimeLabel;
//}

- (UILabel*)goodsTitleLabel
{
    if (!_goodsTitleLabel) {
        _goodsTitleLabel = [[UILabel alloc] init];
        _goodsTitleLabel.numberOfLines = 2;
        _goodsTitleLabel.font = [UIFont systemFontOfSize:16];
        _goodsTitleLabel.textColor = CCCUIColorFromHex(0x333333);
        _goodsTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsTitleLabel;
}
- (UILabel*)goodsDesLabel
{
    if (!_goodsDesLabel) {
        _goodsDesLabel = [[UILabel alloc] init];
        _goodsDesLabel.numberOfLines = 2;
        _goodsDesLabel.font = [UIFont systemFontOfSize:16];
        _goodsDesLabel.textColor = CCCUIColorFromHex(0x333333);
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


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
