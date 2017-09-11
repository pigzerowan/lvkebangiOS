//
//  NewTimeTableViewCell.m
//  greenkebang
//
//  Created by 郑渊文 on 1/12/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "NewTimeTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "NewTimeDynamicModel.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"
@interface NewTimeTableViewCell ()

@property (nonatomic, assign) BOOL isExpandedNow;

@end
@implementation NewTimeTableViewCell
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        [self configureSubview];
        
    }
    
    return self;
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


- (void)configNewTimeTableCellWithGoodModel:(NewDynamicDetailModel *)admirGood
{
    [self.headImageView sd_setImageWithURL:[admirGood.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    
    
    
    if ([admirGood.type isEqualToString:@"1"]) {
        _typeStr = @"专栏";
        
        _attentionNumLable.hidden = YES;


    }else if ([admirGood.type isEqualToString:@"2"])
    {
        _typeStr = @"问答";
    }
    else if ([admirGood.type isEqualToString:@"3"])
    {
        _typeStr = @"问答";
    }
    
    _loveLabel.text = admirGood.starNum;
    [_replyBtn setTitle:admirGood.replyNum forState:UIControlStateNormal];
    [_loveBtn setTitle:admirGood.starNum forState:UIControlStateNormal];
    self.coverImageView.backgroundColor = [UIColor redColor];
    
    
    
    if ([admirGood.type isEqualToString:@"5"]) {
        [self.coverImageView sd_setImageWithURL:[admirGood.cover lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
    }
    else
    {
        [self.coverImageView sd_setImageWithURL:[admirGood.cover lkbImageUrl] placeholderImage:YQNormalBackGroundPlaceImage];
        
    }
    
    // 时间
    NSDate *createDate = [NSDate dateFormJavaTimestamp:admirGood.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    
    _comentNumLable.text = admirGood.replyNum;
    _attentionNumLable.text = [NSString stringWithFormat:@"%@人关注",admirGood.starNum];
    
    
    
    NSString* priceStr = [NSString stringWithFormat:@"%@ | %@",admirGood.userName,_typeStr];
    NSMutableAttributedString* priAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ | %@",admirGood.userName,_typeStr] ];
    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, priceStr.length)];
//    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor LkbgreenColor] range:NSMakeRange(0, 2)];
    
    self.nameLabel.attributedText =priAttributedStr;
    
    self.goodsTitleLabel.text = admirGood.title;
    
    if (![admirGood.title isEqualToString:@""]|| admirGood.title != nil) {
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
    
    
    self.goodsDesLabel.text = admirGood.summary;
    if (![admirGood.summary isEqualToString:@""]|| admirGood.summary != nil) {
    // 行间距
    NSMutableAttributedString *DesString = [[NSMutableAttributedString alloc]initWithString:_goodsDesLabel.text];;
    NSMutableParagraphStyle *DesStyle = [[NSMutableParagraphStyle alloc]init];
    [DesStyle setLineSpacing:3];
    [DesString addAttribute:NSParagraphStyleAttributeName value:DesStyle range:NSMakeRange(0, _goodsDesLabel.text.length)];
    _goodsDesLabel.attributedText = DesString;
    }
    
    
    if (admirGood.pubDate != 0) {
        self.goodsTimeLabel.text = [NSString stringWithFormat:@"%@-%@",[NSDate timestampToYear:admirGood.pubDate/1000],[NSDate timestampToMonth:admirGood.pubDate/1000]];
    }else{
        self.goodsTimeLabel.text = @"";
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}


- (void)configUserTableCellWithModel:(UserDynamicModelIntroduceModel *)model {
    
    [self.headImageView sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    
    
    
    if ([model.type isEqualToString:@"1"]) {
        _typeStr = @"专栏";
    }else if ([model.type isEqualToString:@"2"])
    {
        _typeStr = @"问答";
    }
    else if ([model.type isEqualToString:@"3"])
    {
        _typeStr = @"问答";
    }
    
    
    [_replyBtn setTitle:model.replyNum forState:UIControlStateNormal];
    [_loveBtn setTitle:model.starNum forState:UIControlStateNormal];
    self.coverImageView.backgroundColor = [UIColor redColor];
    
    
    
    if ([model.type isEqualToString:@"5"]) {
        [self.coverImageView sd_setImageWithURL:[model.cover lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
    }
    else
    {
        [self.coverImageView sd_setImageWithURL:[model.cover lkbImageUrl] placeholderImage:YQNormalBackGroundPlaceImage];
        
    }
    
    // 时间
    NSDate *createDate = [NSDate dateFormJavaTimestamp:model.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    
    _comentNumLable.text = model.replyNum;
    _attentionNumLable.text = [NSString stringWithFormat:@"%@人关注",model.starNum];
    
    
    
    NSString* priceStr = [NSString stringWithFormat:@"%@ | %@",model.userName,_typeStr];
    NSMutableAttributedString* priAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ | %@",model.userName,_typeStr] ];
    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, priceStr.length)];
//    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor LkbgreenColor] range:NSMakeRange(0, 2)];
    
    self.nameLabel.attributedText =priAttributedStr;
    
    self.goodsTitleLabel.text = model.title;
    // 行间距
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
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

    
}



#pragma maek - SubViews
- (void)configureSubview
{
    
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
    
    [self.contentView addSubview:self.loveImage];
    [self.contentView addSubview:self.loveLabel];

    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    //     应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.goodsTitleLabel.preferredMaxLayoutWidth = w - 110;
    
    
    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.goodsDesLabel.preferredMaxLayoutWidth = w - 110;
    self.goodsDesLabel.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
    //                                   initWithTarget:self
    //                                   action:@selector(onTap)];
    //    [self.goodsDesLabel addGestureRecognizer:tap];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.repleyImageView;
    self.hyb_bottomOffsetToCell = 15;
    self.isExpandedNow = YES;
    
    
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
            make.top.mas_equalTo(_goodsTitleLabel.bottom).offset(6);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(_coverImageView.left).offset(-10);
        }];
        
        
        
        [_repleyImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            
            if ((_attentionNumLable.hidden = YES)) {
                
                
                make.left.mas_equalTo(_loveLabel.right).offset(24);
                make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
                make.size.mas_equalTo(CGSizeMake(15, 15));
                
            }
            else {
                make.left.mas_equalTo(_headImageView);
                make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
                make.size.mas_equalTo(CGSizeMake(15, 15));
            }
        }];
        [_comentNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            
            make.left.mas_equalTo(_repleyImageView.right).offset(8);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(11);
            //            make.size.mas_equalTo(CGSizeMake(40, 15));
            
        }];
        
        [_attentionNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_comentNumLable.right).offset(24);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(11);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        
        
        
        
        [_loveImage mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_headImageView);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        [_loveLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_loveImage.right).offset(8);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(11);
            //            make.size.mas_equalTo(CGSizeMake(40, 15));
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
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont systemFontOfSize:13];
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
        //        _goodsDesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
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





- (UIButton*)squeBtn
{
    if (!_squeBtn) {
        _squeBtn = [[UIButton alloc] init];
        
        [_squeBtn setImage:[UIImage imageNamed:@"square_btn_arrow_nor"] forState:UIControlStateNormal];
        [_squeBtn addTarget:self action:@selector(pushToChoose:)  forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _squeBtn;
}


-(UIImageView *)loveImage {
    
    if (!_loveImage) {
        _loveImage = [[UIImageView alloc]init];
        _loveImage.image = [UIImage imageNamed:@"icon_unPushlove"];
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


@end
