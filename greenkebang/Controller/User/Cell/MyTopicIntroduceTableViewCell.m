//
//  MyTopicIntroduceTableViewCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "MyTopicIntroduceTableViewCell.h"
#import "NSStrUtil.h"
#import "NSDate+TimeInterval.h"
#import "NSDate+TimeAgo.h"
@implementation MyTopicIntroduceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}



- (void)configTopicCellWithModel:(PeoplestopicModel *)model;
{

    self.titleLabel.text = model.topicSummary;
    
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    [NSString stringWithFormat:@"%@ %@",@"结婚纪念日",@"还有8天"];
    
//    self.timeLabel.text= model.topicDate;
    NSDate *createDate = [NSDate dateFormJavaTimestamp:model.topicDate];
//    self.timeLabel.text = [createDate timeAgo];

    self.timeLabel.text = [NSString stringWithFormat:@"%@  %@",[createDate timeAgo],model.groupName];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"MM-dd"];
//    NSString*strrr1=model.topicDate;
//    NSTimeInterval time=[strrr1 doubleValue]/100;
//    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//    
//    NSString *confromTimespStr = [formatter stringFromDate:detaildate];
    
//    self.timeLabel.text = [NSString stringWithFormat:@"%@.发布于",confromTimespStr];
//    self.groupLabel.text = model.groupName;

    
    NSLog(@"######################%@",model.groupName);
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    //    self.remindLabel.attributedText = remAttributedStr;
}

#pragma maek - SubViews
- (void)configureSubview
{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
//    [self.contentView addSubview:self.groupLabel];
    
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -20, 25)];
//        _titleLabel.backgroundColor = [UIColor cyanColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    
    return _titleLabel;
}


- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 40, 150, 20)];
//        _timeLabel.backgroundColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}


- (UILabel *)groupLabel {
    
    if (!_groupLabel) {
        
        _groupLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 40, 70, 20)];
//        _groupLabel.backgroundColor = [UIColor magentaColor];
        _groupLabel.font = [UIFont systemFontOfSize:12];
    }
    return _groupLabel;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
