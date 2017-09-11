//
//  DynamicShareCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/12.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "DynamicShareCell.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"


@implementation DynamicShareCell
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        [self configureSubview];
        
    }
    
    return self;
}

- (void)configUserInforDynamicShareModel:(UserDynamicModelIntroduceModel *)model {
    
    [self.circleNameButton setTitle:model.groupName forState:UIControlStateNormal];
    self.goodsDesLabel.text = model.summary;
    
    
    _shareLable.text = model.shareTitle;
    NSURL *url = [NSURL URLWithString:model.shareImage];
    [_shareImg sd_setImageWithURL:url placeholderImage:YQNormalUserSharePlaceImage];

    
    if ([model.summary isEqualToString:@""]) {
        
//        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
//            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(0);
//            make.left.mas_equalTo(_goodsDesLabel);
//            make.size.mas_equalTo(CGSizeMake(kDeviceWidth -14 - 60 -12 , ((kDeviceWidth -14 - 60 -12)/3)*0.95));
//        }];
        
        [_shareImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(0);
            make.left.mas_equalTo(_goodsDesLabel);
            make.size.mas_equalTo(CGSizeMake(60, 60));
            
            
        }];
        
        [_lableBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(0);
            make.left.mas_equalTo(_shareImg.right).offset(0);
            make.size.mas_equalTo(CGSizeMake(kDeviceWidth-148, 60));
            
        }];
        
        
        
        [_shareLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(0);
            make.left.mas_equalTo(_lableBackView.left).offset(12);
            make.size.mas_equalTo(CGSizeMake(kDeviceWidth-160, 60));
            
        }];
        
        [_shareCircleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(0);
            make.left.mas_equalTo(_goodsDesLabel);
            make.size.mas_equalTo(CGSizeMake(kDeviceWidth -28, 60));
            
        }];

        
        [_circleNameButton mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_shareImg.bottom).offset(9);
            make.left.mas_equalTo(_goodsDesLabel);
            make.height.mas_equalTo(22);
            make.right.mas_equalTo(-100);
            
        }];
        
    }else {
        
//        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
//            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(12.5);
//            make.left.mas_equalTo(_goodsDesLabel);
//            make.size.mas_equalTo(CGSizeMake(kDeviceWidth -14 - 60 -12 , ((kDeviceWidth -14 - 60 -12)/3)*0.95));
//        }];
        
        [_shareImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(12);
            make.left.mas_equalTo(_goodsDesLabel);
            make.size.mas_equalTo(CGSizeMake(60, 60));
            
            
        }];
        
        [_lableBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(12);
            make.left.mas_equalTo(_shareImg.right).offset(0);
            make.size.mas_equalTo(CGSizeMake(kDeviceWidth-88, 60));
            
        }];
        
        
        
        [_shareLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(12);
            make.left.mas_equalTo(_lableBackView.left).offset(12);
            make.size.mas_equalTo(CGSizeMake(kDeviceWidth-146, 60));
            
        }];
        [_shareCircleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(12);
            make.left.mas_equalTo(_goodsDesLabel);
            make.size.mas_equalTo(CGSizeMake(kDeviceWidth -28, 60));
            
        }];


        
        [_circleNameButton mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_shareImg.bottom).offset(9);
            make.left.mas_equalTo(_goodsDesLabel);
            make.height.mas_equalTo(22);
            make.right.mas_equalTo(-100);
            
        }];
        
        
    }
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"dd        MM月"];
    NSDate*detaildate1=[NSDate dateWithTimeIntervalSince1970:model.pubDate/1000];
    //    NSString *confromTimespStr1 = [formatter stringFromDate:detaildate1];
    
    NSString * timesStr = [formatter stringFromDate:detaildate1];
    NSString * dayStr = [timesStr substringWithRange:NSMakeRange(0,10)];
    
    NSString * monthStr = [timesStr substringWithRange:NSMakeRange(10,3)];
    NSLog(@"======================%@",monthStr);
    
    if ([monthStr isEqualToString:@"01月" ]) {
        
        monthStr = @"一月";
    }if ([monthStr isEqualToString:@"02月" ]) {
        monthStr = @"二月";
    }if ([monthStr isEqualToString:@"03月" ]) {
        monthStr = @"三月";
    }if ([monthStr isEqualToString:@"04月" ]) {
        monthStr = @"四月";
    }if ([monthStr isEqualToString:@"05月" ]) {
        monthStr = @"五月";
    }if ([monthStr isEqualToString:@"06月" ]) {
        monthStr = @"六月";
    }if ([monthStr isEqualToString:@"07月" ]) {
        monthStr = @"七月";
    }if ([monthStr isEqualToString:@"08月" ]) {
        monthStr = @"八月";
    }if ([monthStr isEqualToString:@"09月" ]) {
        monthStr = @"九月";
    }if ([monthStr isEqualToString:@"10" ]) {
        monthStr = @"十月";
    }if ([monthStr isEqualToString:@"11月" ]) {
        monthStr = @"十一月";
    }if ([monthStr isEqualToString:@"12月" ]) {
        monthStr = @"十二月";
    }
    
    NSString * confromTimespStr1 = [NSString stringWithFormat:@"%@%@",dayStr, monthStr];
    
    
    
    
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:confromTimespStr1];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:CCCUIColorFromHex(0x555555) range:NSMakeRange(0, 2)];
    [remAttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:26] range:NSMakeRange(0, 2)];
    
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:CCCUIColorFromHex(0xaaaaaa) range:NSMakeRange(2, confromTimespStr1.length -2)];
    [remAttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2,confromTimespStr1.length -2)];
    self.loveTimeLabel.attributedText= remAttributedStr;
    
    if ([model.isDisplay  isEqualToString:@"0"]) {
        self.loveTimeLabel.hidden = NO;
    }
    else {
        self.loveTimeLabel.hidden = YES;
        
        
    }
    
    
    
}



- (void)configureSubview
{
    
    [self.contentView addSubview:self.loveTimeLabel];
    [self.contentView addSubview:self.goodsDesLabel];
    [self.contentView addSubview:self.shareImg];
    [self.contentView addSubview:self.lableBackView];
    [self.contentView addSubview:self.shareLable];
    [self.contentView addSubview:self.shareCircleButton];
    [self.contentView addSubview:self.circleNameButton];
    
    
    
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    //     应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    //    self.goodsTitleLabel.preferredMaxLayoutWidth = w - 110;
    
    
    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.goodsDesLabel.preferredMaxLayoutWidth = w-100 ;
    self.goodsDesLabel.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
    //                                   initWithTarget:self
    //                                   action:@selector(onTap)];
    //    [self.goodsDesLabel addGestureRecognizer:tap];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.circleNameButton;
    self.hyb_bottomOffsetToCell = 14;
    
}

- (void)updateConstraints
{
    
    CGFloat padding = iPhone5_Before ? 13 : 15;
    if (!self.didSetupConstraints) {
        
        
        [_loveTimeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            
            make.top.mas_equalTo(self).offset(8);
            make.left.mas_equalTo(self).offset(14);
            make.size.mas_equalTo(CGSizeMake(60, 50));
            
        }];
        
        [_goodsDesLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(self).offset(14.5);
            make.left.mas_equalTo(_loveTimeLabel.right).offset(0);
            make.width.mas_equalTo(self).offset(-74);
        }];
        
        
        //        [_coverListImage mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        //            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(12.5);
        //            make.left.mas_equalTo(_goodsDesLabel);
        //            make.size.mas_equalTo(CGSizeMake(kDeviceWidth -14 - 60 -12 , ((kDeviceWidth -14 - 60 -12)/3)*0.95));
        //        }];
        
        
        //        [_circleNameButton mas_makeConstraints:^(MASConstraintMaker* make) {
        //            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(9);
        //            make.left.mas_equalTo(_goodsDesLabel);
        //            make.height.mas_equalTo(22);
        //            make.right.mas_equalTo(-100);
        //        }];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}



// 内容
- (UILabel*)goodsDesLabel
{
    if (!_goodsDesLabel) {
        _goodsDesLabel = [[UILabel alloc] init];
        _goodsDesLabel.numberOfLines = 2;
        _goodsDesLabel.font = [UIFont systemFontOfSize:16];
        _goodsDesLabel.lineBreakMode = 3;
        _goodsDesLabel.textColor = [UIColor colorWithHex:0x333333];
        _goodsDesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsDesLabel;
}

// 圈名称
- (UIButton *)circleNameButton {
    
    if (!_circleNameButton) {
        _circleNameButton = [[UIButton alloc] init];
        [_circleNameButton setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
        _circleNameButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _circleNameButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _circleNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_circleNameButton addTarget:self action:@selector(circleNameButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _circleNameButton;
    
}
- (void)handlerButtonAction:(BottomBuyClickBlock)block {
    
    self.clickBlock = block;
}


-(void)circleNameButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }
    
}



// 时间
- (UILabel*)loveTimeLabel
{
    if (!_loveTimeLabel) {
        _loveTimeLabel = [[UILabel alloc] init];
        _loveTimeLabel.numberOfLines = 0;
        [_loveTimeLabel sizeToFit];
        _loveTimeLabel.font = [UIFont systemFontOfSize:25];
        _loveTimeLabel.textColor = [UIColor colorWithHex:0xaaaaaa];
        _loveTimeLabel.textAlignment = NSTextAlignmentLeft;
        _loveTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _loveTimeLabel;
}


- (UIView *)lableBackView {
    
    if (!_lableBackView) {
        _lableBackView = [[UIView alloc]init];
        _lableBackView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    }
    return _lableBackView;
}




- (UILabel*)shareLable
{
    if (!_shareLable) {
        _shareLable = [[UILabel alloc] init];
        _shareLable.textAlignment = NSTextAlignmentLeft;
        _shareLable.numberOfLines = 2;
        _shareLable.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        _shareLable.font = [UIFont systemFontOfSize:14];
        _shareLable.textColor = CCCUIColorFromHex(0x333333);
        _shareLable.lineBreakMode = NSLineBreakByTruncatingTail;
        
    }
    return _shareLable;
}

- (UIImageView *)shareImg
{
    if (!_shareImg) {
        _shareImg = [[UIImageView alloc] init];
        _shareImg.backgroundColor = CCCUIColorFromHex(0xdddddd);
    }
    return _shareImg;
}

- (UIButton *)shareCircleButton {
    
    if (!_shareCircleButton) {
        _shareCircleButton =  [[UIButton alloc]init];
        _shareCircleButton.backgroundColor = [UIColor clearColor];
        [_shareCircleButton addTarget:self action:@selector(shareCircleButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shareCircleButton;
}

-(void)shareCircleButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(2);
    }
    
}



@end
