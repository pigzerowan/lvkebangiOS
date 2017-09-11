//
//  ActivityTableViewCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/8/1.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}


- (void)configActivityIntroduceCellWithModel:(ActivityIntroduceModel *)model {
    
    self.titleLabel.text = model.name;
    
    // 活动未开始
    if ([model.isEnd isEqualToString:@"0"]) {
        self.activityLabel.text = @"活动未开始";
        self.activityLabel.textColor = CCCUIColorFromHex(0x7bb4f7);
        
    }
    // 活动进行中
    if ([model.isEnd isEqualToString:@"1"]) {
        self.activityLabel.text = @"正在进行中";
        self.activityLabel.textColor = CCCUIColorFromHex(0x22a941);

    }
    // 活动已结束
    if ([model.isEnd isEqualToString:@"2"]) {
        self.activityLabel.text = @"活动已结束";
        self.activityLabel.textColor = CCCUIColorFromHex(0x999999);

    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM年dd日"];
    // 开始时间
    NSString*strrr1=model.beginTime;
    NSTimeInterval time1=[strrr1 doubleValue]/1000;
    NSDate*detaildate1=[NSDate dateWithTimeIntervalSince1970:time1];
    NSString *confromTimespStr1 = [formatter stringFromDate:detaildate1];
    // 结束时间
    NSString*strrr2=model.endTime;
    NSTimeInterval time2=[strrr2 doubleValue]/1000;
    NSDate*detaildate2=[NSDate dateWithTimeIntervalSince1970:time2];
    NSString *confromTimespStr2 = [formatter stringFromDate:detaildate2];
    
    
    _timeLabel.text = [NSString stringWithFormat:@"%@-%@",confromTimespStr1,confromTimespStr2];
}

- (void)configureSubview
{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.activityLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.lineView];

    //    [self.contentView addSubview:self.userNameLable];
    
}


- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, kDeviceWidth -32, 16)];
        _titleLabel.textColor = CCCUIColorFromHex(0x333333);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
//        _titleLabel.clipsToBounds = YES;
//        _titleLabel.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _titleLabel;
}

- (UILabel*)activityLabel
{
    if (!_activityLabel) {
        _activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 45, 70, 14)];
//        _activityLabel.clipsToBounds = YES;
//        _activityLabel.contentMode = UIViewContentModeScaleAspectFill;
        _activityLabel.textColor = CCCUIColorFromHex(0x333333);
        _activityLabel.font = [UIFont systemFontOfSize:12];
        _activityLabel.textAlignment = NSTextAlignmentLeft;

    }
    return _activityLabel;
}


- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, kDeviceWidth -16 -90 -10, 14)];
        //        _timeLabel.clipsToBounds = YES;
        //        _timeLabel.contentMode = UIViewContentModeScaleAspectFill;
        _timeLabel.textColor = CCCUIColorFromHex(0x999999);
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _timeLabel;
}

- (UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, kDeviceWidth , 0.5)];
        _lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
        
    }
    return _lineView;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
