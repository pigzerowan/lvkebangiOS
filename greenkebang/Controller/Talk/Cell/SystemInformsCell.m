//
//  SystemInformsCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 2017/3/17.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import "SystemInformsCell.h"

@implementation SystemInformsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configureSubview];
        
    }
    return self;
}
- (void)configSystemInformsCellWithGoodModel:(SystemInformsDetailModel *)admirGood{
    
NSString * re = @"YYYY-MM-dd HH:mmYYYY-MM-dd HH:mmYYYY-MM-dd HH:mmYYYY-MM-dd HH:mmYYYY-MM-dd HH:mmYYYY-MM-dd HH:mmYYYY-MM-dd HH:mmYYYY-MM-dd HH:mmYYYY-MM-dd HH:mmYYYY-MM-dd HH:mmYYYY-MM-dd HH:mmYYYY-MM-dd HH:mmYYYY-MM-dd HH:mm";
    
    CGSize  size = [self sizeWithFont:[UIFont systemFontOfSize:12.0f] maxSize:CGSizeMake(kDeviceWidth - 108 , 10000) textString:re];
    // 拉伸图片 参数1 代表从左侧到指定像素禁止拉伸，该像素之后拉伸，参数2 代表从上面到指定像素禁止拉伸，该像素以下就拉伸
    UIImage * image = [UIImage imageNamed:@"systemInformsBackImage"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:27];
    self.backImageView.image = image;
    self.backImageView.frame = CGRectMake(68, 40, kDeviceWidth - 88, size.height+20);
    _connectLabel.frame = CGRectMake(88, 50, kDeviceWidth - 108, size.height);
//    _connectLabel.text = [NSString stringWithFormat:@"%@",admirGood.msgContent];
    
//    _connectLabel.text = [NSString stringWithFormat:@"%@",re];

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString*strrr1=[NSString stringWithFormat:@"%ld",(long)admirGood.sendDate];
    NSTimeInterval time1=[strrr1 doubleValue]/1000;
    NSDate*detaildate1=[NSDate dateWithTimeIntervalSince1970:time1];
    NSString *confromTimespStr1 = [formatter stringFromDate:detaildate1];
    
    
//    _timeLabel.text = [NSString stringWithFormat:@"%@",confromTimespStr1];

    self.cellHeight = CGRectGetMaxY(self.backImageView.frame)+20;

    
    
    
    

    
}




-(void)configureSubview {
    
    
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.backImageView];
    [self.contentView addSubview:self.connectLabel];

}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.frame = CGRectMake(0, 15, kDeviceWidth, 12);
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = CCCUIColorFromHex(0xcfcfcf);
        _timeLabel.text = @"02-18 00:00";
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return _timeLabel;

}


-(UIImageView *)headImageView {
    
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.frame = CGRectMake(10, 40, 50, 50);
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 25;
        _headImageView.image = [UIImage imageNamed:@"icon.png"];
    }
    return _headImageView;
}


-(UIImageView *)backImageView {
    
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.frame = CGRectMake(10 +50 + 8, 40,kDeviceWidth - 10 -50 -8 -20, 200);
    }
    return _backImageView;
}

- (UILabel *)connectLabel {
    
    if (!_connectLabel) {
        
        _connectLabel = [[UILabel alloc]init];
        
        _connectLabel.frame = CGRectMake(10 +50 + 8, 40, kDeviceWidth - 10 -50 -20 - 8, 60);
        _connectLabel.numberOfLines = 0;
        _connectLabel.font = [UIFont systemFontOfSize:12];
        _connectLabel.textColor = CCCUIColorFromHex(0x999999);
    }
    return _connectLabel;

}

//计算文本size
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize textString:(NSString *)textString
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [textString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}





- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
