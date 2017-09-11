//
//  AttentionTopicCell.m
//  greenkebang
//
//  Created by 郑渊文 on 4/5/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "AttentionTopicCell.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"

@implementation AttentionTopicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configureSubview];
        
    }
    return self;
}

- (void)configAttentionTopicTableCellWithGoodModel:(AttentionContentsListModel *)admirGood{
    
    self.titleNameLabel.text = admirGood.topicSummary;
    self.commentLabel.text = [NSString stringWithFormat:@"%@",admirGood.replyNum];
    self.attentionLael.text = [NSString stringWithFormat:@"%@人关注",admirGood.attentionNum];
    self.groupNameLabel.text = [NSString stringWithFormat:@"%@",admirGood.groupName];
    
    self.commentImage.image = [UIImage imageNamed:@"attention_comment"];
    // 时间设置
    NSTimeInterval time= admirGood.topicDate ;
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:time];
    
    NSLog(@"<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>%f",time);
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[createDate timeAgo]];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

}

- (void)configAttentionQuestionTableCellWithGoodModel:(AttentionContentsListModel *)admirGood {
    
    self.titleNameLabel.text = admirGood.title;
    self.commentLabel.text = [NSString stringWithFormat:@"%@人评论",admirGood.answerNum];
    self.attentionLael.text = [NSString stringWithFormat:@"%@人关注",admirGood.fansNum];
    
    // 时间设置
    NSTimeInterval time=[admirGood.questionDate doubleValue];
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:time];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[createDate timeAgo]];
    self.commentImage.image = [UIImage imageNamed:@"icon_answer"];
   
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

}




#pragma maek - SubViews
- (void)configureSubview
{
    
    [self.contentView addSubview:self.titleNameLabel];
//    [self.contentView addSubview:self.attentionLael];
    [self.contentView addSubview:self.groupNameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.commentImage];
    [self.contentView addSubview:self.commentLabel];
    [self.contentView addSubview:self.lineView];



    
}


-(UILabel *)titleNameLabel {
    
    if (!_titleNameLabel) {
        
        _titleNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, kDeviceWidth -20, 32)];
        _titleNameLabel.numberOfLines = 2;
        _titleNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleNameLabel.textColor = CCCUIColorFromHex(0x333333);
        _titleNameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleNameLabel;
}

-(UIImageView *)commentImage {
    
    if (!_commentImage) {
        
        _commentImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 12 -15 -17, 45, 15, 15)];

    }
    
    return _commentImage;
}

- (UILabel *)commentLabel {
    
    if (!_commentLabel) {
        
        _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth -40- 12 , 45, 40, 12)];
        _commentLabel.textAlignment = NSTextAlignmentRight;
        _commentLabel.font = [UIFont systemFontOfSize:12];
        _commentLabel.textColor = CCColorFromRGBA(102, 102, 102, 1);

    }
    return _commentLabel;
}

- (UILabel *)attentionLael {
    
    if (!_attentionLael) {
        _attentionLael = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth *0.3, 57, 80, 12)];
        _attentionLael.font = [UIFont systemFontOfSize:12];
        _attentionLael.textColor = CCColorFromRGBA(102, 102, 102, 1);
    }
    return _attentionLael;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(60,45, 90, 12)];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor =CCCUIColorFromHex(0x999999);
    }
    return _timeLabel;
}

- (UILabel *)groupNameLabel {
    
    if (!_groupNameLabel) {
        _groupNameLabel= [[UILabel alloc]initWithFrame:CGRectMake(12,45, 50, 12)];
        _groupNameLabel.font = [UIFont systemFontOfSize:11];
        _groupNameLabel.textAlignment = NSTextAlignmentLeft;
        _groupNameLabel.textColor =CCCUIColorFromHex(0x999999);
    }
    return _groupNameLabel;
}


- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 0.5)];
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
