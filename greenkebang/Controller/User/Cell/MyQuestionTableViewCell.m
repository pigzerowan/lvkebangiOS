//
//  MyQuestionTableViewCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "MyQuestionTableViewCell.h"

@implementation MyQuestionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}

- (void)configQuestionCellWithModel:(QuestionModelIntroduceModel *)model {
    
    self.titleLabel.text = model.title;
    NSString * count = model.answerNum;
    self.commentLabel.text = [NSString stringWithFormat:@"评论%@条",count];

    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    [NSString stringWithFormat:@"%@ %@",@"结婚纪念日",@"还有8天"];
    
    //    self.timeLabel.text= model.topicDate;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
//    NSString*strrr1= model.questionDate;
//    NSTimeInterval time=[strrr1 doubleValue]/1000;
    NSTimeInterval time = model.questionDate /1000;
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSString *confromTimespStr = [formatter stringFromDate:detaildate];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@",confromTimespStr];
    
    
//    NSLog(@"######################%@",model.summary);
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];

}


-(void)configureSubview {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.commentLabel];

}


- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 25)];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 80, 25)];
        _timeLabel.font =[UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UILabel *)commentLabel {
    
    if (!_commentLabel) {
        
        _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 40, 60, 25)];
        _commentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _commentLabel;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
