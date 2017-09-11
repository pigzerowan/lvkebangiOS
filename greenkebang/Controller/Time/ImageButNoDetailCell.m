//
//  ImageButNoDetailCell.m
//  greenkebang
//
//  Created by 郑渊文 on 1/22/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "ImageButNoDetailCell.h"
#import <UIImageView+WebCache.h>
#import "NewTimeDynamicModel.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"


@implementation ImageButNoDetailCell



- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        [self configureSubview];
        
    }
    
    return self;
}


- (void)configNewTimeTableCellWithGoodModel:(NewDynamicDetailModel *)admirGood
{
    [self.headImageView sd_setImageWithURL:[admirGood.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    
    
    
    if ([admirGood.type isEqualToString:@"1"]) {
        _typeStr = @"专栏";
        
    }else if ([admirGood.type isEqualToString:@"2"])
    {
        _typeStr = @"问答";
    }
    else if ([admirGood.type isEqualToString:@"3"])
    {
        _typeStr = @"问答";
    } else if ([admirGood.type isEqualToString:@"4"])
    {
        _typeStr = @"话题";
    }
    
    
    [_replyBtn setTitle:admirGood.replyNum forState:UIControlStateNormal];
    [_loveBtn setTitle:admirGood.starNum forState:UIControlStateNormal];
    self.coverImageView.backgroundColor = [UIColor redColor];
    
    self.coverImageView.hidden = [NSStrUtil isEmptyOrNull:admirGood.cover];
    
    if ([admirGood.type isEqualToString:@"5"]) {
        [self.coverImageView sd_setImageWithURL:[admirGood.cover lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
    }
    else
    {
        [self.coverImageView sd_setImageWithURL:[admirGood.cover lkbImageUrlAllCover] placeholderImage:YQNormalBackGroundPlaceImage];
    }
    _comentNumLable.text = admirGood.replyNum;
    _attentionNumLable.text = [NSString stringWithFormat:@"%@人关注",admirGood.attentionNum];
    // 时间
    NSDate *createDate = [NSDate dateFormJavaTimestamp:admirGood.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    NSString* priceStr = [NSString stringWithFormat:@"%@ | %@",admirGood.userName,admirGood.groupName];
    
    NSMutableAttributedString* priAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ | %@",admirGood.userName,admirGood.groupName] ];
    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, priceStr.length)];
//    NSRange range = [priceStr rangeOfString:admirGood.groupName];
//    
//    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor LkbgreenColor] range:range];
    
    

    

    
    
    
    self.nameLabel.text =priceStr;
    
    self.goodsTitleLabel.text = admirGood.summary;
    
    self.goodsDesLabel.text = admirGood.title;
    
    if (![admirGood.title isEqualToString:@""]|| admirGood.title != nil)  {
    // 行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_goodsTitleLabel.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _goodsTitleLabel.text.length)];
    _goodsTitleLabel.attributedText = attributedString;
    }
//    //调节高度
//    CGSize size = CGSizeMake(kDeviceWidth, 500000);
//    CGSize labelSize = [_goodsTitleLabel sizeThatFits:size];
    
    
    
    
    
    
    if (admirGood.pubDate != 0) {
        self.goodsTimeLabel.text = [NSString stringWithFormat:@"%@-%@",[NSDate timestampToYear:admirGood.pubDate/1000],[NSDate timestampToMonth:admirGood.pubDate/1000]];
    }else{
        self.goodsTimeLabel.text = @"";
    }
    self.goodsAddressLabel.text = admirGood.summary;
    
//    if (![admirGood.summary isEqualToString:@""]|| admirGood.summary != nil)  {
//    // 行间距
//    NSMutableAttributedString *DesString = [[NSMutableAttributedString alloc]initWithString:_goodsDesLabel.text];;
//    NSMutableParagraphStyle *DesStyle = [[NSMutableParagraphStyle alloc]init];
//    [DesStyle setLineSpacing:3];
//    [DesString addAttribute:NSParagraphStyleAttributeName value:DesStyle range:NSMakeRange(0, _goodsDesLabel.text.length)];
//    _goodsDesLabel.attributedText = DesString;
//    
//    }
    self.addressIconImageView.hidden = [NSStrUtil isEmptyOrNull:admirGood.summary];
    
    self.goodsPriceLabel.attributedText = priAttributedStr;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

- (void)configUserTableCellWithModel:(UserDynamicModelIntroduceModel *)model {
    
    [self.headImageView sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    
    
    self.coverImageView.backgroundColor = [UIColor redColor];
    
    self.coverImageView.hidden = [NSStrUtil isEmptyOrNull:model.cover];
    
    [self.coverImageView sd_setImageWithURL:[model.cover lkbImageUrl] placeholderImage:YQNormalBackGroundPlaceImage];
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:model.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    
    self.nameLabel.text =[NSString stringWithFormat:@"%@---专栏",model.userName] ;
    self.goodsTitleLabel.text = model.title;
    
    if (![model.title isEqualToString:@""]|| model.title != nil) {

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_goodsTitleLabel.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _goodsTitleLabel.text.length)];
    _goodsTitleLabel.attributedText = attributedString;
    }
//    //调节高度
//    CGSize size = CGSizeMake(kDeviceWidth, 500000);
//    CGSize labelSize = [_goodsTitleLabel sizeThatFits:size];
    
    
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
    NSMutableAttributedString* priAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元起", @"3"]];

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
    [self.contentView addSubview:self.squeBtn];
    [self.contentView addSubview:self.loveTimeLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.goodsTitleLabel];
    [self.contentView addSubview:self.goodsDesLabel];
    [self.contentView addSubview:self.repleyImageView];
    [self.contentView addSubview:self.comentNumLable];
    [self.contentView addSubview:self.attentionNumLable];

    
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    //     应该始终要加上这一句
    // 不然在6/6plus上就不准确了
//        self.goodsTitleLabel.preferredMaxLayoutWidth = w - 110;
    
    
    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.goodsDesLabel.preferredMaxLayoutWidth = w-110 ;
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
            make.right.mas_equalTo(self.contentView.right).offset(-12);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.top.mas_equalTo(15);
        }];
        
        
        [_loveTimeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(_squeBtn.left).offset(-5);
            make.centerY.mas_equalTo(_headImageView);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_headImageView.right).offset(10).priorityLow();
            make.right.mas_equalTo(_loveTimeLabel.left).offset(-10);
            make.centerY.mas_equalTo(_headImageView);
        }];
        
        
        [_coverImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(_squeBtn.right);
            make.top.mas_equalTo(_loveTimeLabel.bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 60));
        }];

        
        
        [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_loveTimeLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(_coverImageView.left).offset(-10);
        }];
        
        
        [_goodsDesLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsTitleLabel.bottom).offset(8);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(_coverImageView.left).offset(-10);
        }];
        
        
        
        [_repleyImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_headImageView);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        [_comentNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_repleyImageView.right).offset(8);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
//            make.size.mas_equalTo(CGSizeMake(40, 15));
        }];
        
        [_attentionNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_comentNumLable.right).offset(24);
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

#pragma mark - Getters & Setters
- (UIImageView*)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 10;
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
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor lightGrayColor];
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
- (UIButton*)loveButton
{
    if (!_loveButton) {
        _loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loveButton setImage:[UIImage imageNamed:@"yq_love_small_select.png"] forState:UIControlStateNormal];
        [_loveButton setImage:[UIImage imageNamed:@"yq_love_small_select.png"] forState:UIControlStateSelected];
        [_loveButton addTarget:self action:@selector(loveButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveButton;
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



- (UILabel*)attentionNumLable
{
    if (!_attentionNumLable) {
        _attentionNumLable = [[UILabel alloc] init];
        _attentionNumLable.numberOfLines = 1;
        _attentionNumLable.font = [UIFont systemFontOfSize:12];
        _attentionNumLable.textColor = [UIColor colorWithHex:0x999999];
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
        _comentNumLable.textColor = [UIColor colorWithHex:0x999999];
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
