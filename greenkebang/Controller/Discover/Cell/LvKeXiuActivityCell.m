//
//  LvKeXiuActivityCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/22.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "LvKeXiuActivityCell.h"
#import <UIImageView+WebCache.h>

@implementation LvKeXiuActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self configureSubview];
    }
    return self;
}

- (void)configLvKeXiuActivityCellWithGoodModel:(ActivityListDetailModel *)admirGood {
    
    [self.headerImage sd_setImageWithURL:[admirGood.img lkbImageUrlActivityCover] placeholderImage:YQNormalPlaceImage];
    _nameLabel.text = admirGood.name;
    // 进行中
    if ([admirGood.status isEqualToString:@"0"]) {
        _markedImage.image = [UIImage imageNamed:@"label_processing"];
    }
    else {
        _markedImage.image = [UIImage imageNamed:@"label_end"];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    // 开始时间
    NSString*strrr1=admirGood.beginTime;
    NSTimeInterval time1=[strrr1 doubleValue]/1000;
    NSDate*detaildate1=[NSDate dateWithTimeIntervalSince1970:time1];
    NSString *confromTimespStr1 = [formatter stringFromDate:detaildate1];
    // 结束时间
    NSString*strrr2=admirGood.endTime;
    NSTimeInterval time2=[strrr2 doubleValue]/1000;
    NSDate*detaildate2=[NSDate dateWithTimeIntervalSince1970:time2];
    NSString *confromTimespStr2 = [formatter stringFromDate:detaildate2];
    _timeLabel.text = [NSString stringWithFormat:@"%@至%@",confromTimespStr1,confromTimespStr2];
}


- (void)configMyActivityCellWithGoodModel:(ActivityIntroduceModel *)admirGood {
    
    [self.headerImage sd_setImageWithURL:[admirGood.img lkbImageUrlActivityCover] placeholderImage:YQNormalPlaceImage];
    _nameLabel.text = admirGood.name;
    // 进行中
    if ([admirGood.status isEqualToString:@"0"]) {
        _markedImage.image = [UIImage imageNamed:@"label_processing"];
    }
    else {
        _markedImage.image = [UIImage imageNamed:@"label_end"];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    // 开始时间
    NSString*strrr1=admirGood.beginTime;
    NSTimeInterval time1=[strrr1 doubleValue]/1000;
    NSDate*detaildate1=[NSDate dateWithTimeIntervalSince1970:time1];
    NSString *confromTimespStr1 = [formatter stringFromDate:detaildate1];
    // 结束时间
    NSString*strrr2=admirGood.endTime;
    NSTimeInterval time2=[strrr2 doubleValue]/1000;
    NSDate*detaildate2=[NSDate dateWithTimeIntervalSince1970:time2];
    NSString *confromTimespStr2 = [formatter stringFromDate:detaildate2];
    _timeLabel.text = [NSString stringWithFormat:@"%@至%@",confromTimespStr1,confromTimespStr2];

}



- (void)configureSubview
{
    
    [self.contentView addSubview:self.headerImage];
    [self.contentView addSubview:self.blackImage];
    [self.contentView addSubview:self.markedImage];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];

    
    
}
- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.mas_equalTo(8);
            make.right.mas_equalTo(-14);
            make.height.mas_equalTo(179);
        }];
        
        [_blackImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.mas_equalTo(8);
            make.right.mas_equalTo(-14);
            make.height.mas_equalTo(179);
        }];

        
        
        [_markedImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headerImage.top).offset(6);
            make.right.mas_equalTo(_headerImage.right).offset(0);
            make.size.mas_equalTo(CGSizeMake(39, 17.5));
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headerImage.top).offset(125);
            make.left.mas_equalTo(_headerImage.left).offset(8);
            make.right.mas_equalTo(-72);
            make.height.mas_equalTo(16);
        }];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.bottom).offset(9);
            make.left.mas_equalTo(_headerImage.left).offset(8);
            make.right.mas_equalTo(-14);
            make.height.mas_equalTo(12);
        }];



        
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}



- (UIImageView *)headerImage {
    
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]init];
//        _headerImage.backgroundColor = CCCUIColorFromHex(0xdddddd);
        _headerImage.backgroundColor = [UIColor cyanColor];

        _headerImage.contentMode = UIViewContentModeScaleToFill;
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = 3.0f;

    }
    return _headerImage;
}

- (UIImageView *)markedImage {
    
    if (!_markedImage) {
        _markedImage = [[UIImageView alloc]init];
    }
    return _markedImage;
}

- (UIImageView *)blackImage {
    
    if (!_blackImage) {
        _blackImage = [[UIImageView alloc]init];
        _blackImage.image = [UIImage imageNamed:@"Discover-_bg"];
        _blackImage.layer.masksToBounds = YES;
        _blackImage.layer.cornerRadius = 3.0f;

    }
    return _blackImage;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = CCCUIColorFromHex(0xffffff);
        
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = CCCUIColorFromHex(0xffffff);
    }
    return _timeLabel;
}






/*
 
 headerImage;
 @property (nonatomic,strong)UIImageView *markedImage;
 @property (nonatomic,strong)UIImageView *blackImage;
 @property (nonatomic,strong)UILabel *nameLabel;
 @property (nonatomic,strong)UILabel *timeLabel;
 
 
 */
@end
