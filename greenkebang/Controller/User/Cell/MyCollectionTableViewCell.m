//
//  MyCollectionTableViewCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/7.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "MyCollectionTableViewCell.h"
@implementation MyCollectionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}

- (void)configCollectionCellWithModel:(CollectionDetailModel *)model {
    
    _titleLabel.text = model.title;
    // 作者
    NSString *nameString = [[NSString alloc]initWithFormat:@"%@",model.featureName];
    CGSize nameSize = [nameString sizeWithFont:_groupLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 25)];
    _groupLabel.frame = CGRectMake(10, 60, nameSize.width, 10) ;
    _groupLabel.text = nameString;

    _readLabel.text = [NSString stringWithFormat:@"(%@)",model.readNum];
//    // 时间设置
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString*strrr= model.pubDate;
    NSTimeInterval time=[strrr doubleValue]/1000;
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSString *confromTimespStr = [formatter stringFromDate:detaildate];

    // 时间

    CGSize timeSize = [confromTimespStr sizeWithFont:_timeLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 25)];
    _timeLabel.frame = CGRectMake(nameSize.width+30, 60, timeSize.width, 10) ;
    _timeLabel.text = confromTimespStr;


    
}


- (void)configureSubview
{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.groupLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.readImage];
    [self.contentView addSubview:self.readLabel];


    //    [self.contentView addSubview:self.groupLabel];
    
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -20, 50)];
        _titleLabel.numberOfLines = 2;
        //        _titleLabel.backgroundColor = [UIColor cyanColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    
    return _titleLabel;
}




- (UILabel *)groupLabel {
    
    if (!_groupLabel) {
        
        _groupLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 110, 20)];
        _groupLabel.textColor = CCColorFromRGBA(194, 139, 83, 1);
        _groupLabel.font = [UIFont systemFontOfSize:12];
    }
    return _groupLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth *0.3, 60, 150, 20)];
        _timeLabel.textColor = CCColorFromRGBA(102, 102, 102, 1);
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UIImageView *)readImage {
    
    if (!_readImage) {
        
        _readImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 70, 60, 15, 15)];
        _readImage.image = [UIImage imageNamed:@"tab_comment"];
    }
    return _readImage;
}

- (UILabel *)readLabel {
    
    if (!_readLabel) {
        
        _readLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 55, 40, 20)];
        _readLabel.textColor = CCColorFromRGBA(102, 102, 102, 1);
        _readLabel.font = [UIFont systemFontOfSize:12];
        _readLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _readLabel;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
