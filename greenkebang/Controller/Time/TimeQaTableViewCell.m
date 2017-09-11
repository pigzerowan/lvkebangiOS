//
//  TimeQaTableViewCell.m
//  greenkebang
//
//  Created by 郑渊文 on 9/28/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "TimeQaTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "GTMNSString+HTML.h"

@implementation TimeQaTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}




- (void)configDynamicCellWithModel:(NewDynamicModel *)model
{
    [self.headImageView sd_setImageWithURL:[model.avatar lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    self.nameLable.text = model.userName;
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    [NSString stringWithFormat:@"%@ %@",@"结婚纪念日",@"还有8天"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString*strrr1=model.operTime;
    NSTimeInterval time=[strrr1 doubleValue]/1000;
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSString *confromTimespStr = [formatter stringFromDate:detaildate];


    self.timeLable.text= confromTimespStr;
    _nametimeLable.text = [NSString stringWithFormat:@"%@.%@",_nameLable.text,_timeLable.text];
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    //    self.remindLabel.attributedText = remAttributedStr;
    
    self.questionTitleLab.text = model.questionTitle;
  
    
    NSString *strrr = [model.questionDesc gtm_stringByUnescapingFromHTML];
    _questionDescStr = [self filterHTML:strrr];
 [self setIntroductionText:_questionDescStr];
    
    
}

#pragma mark - Event response

#pragma maek - SubViews
- (void)configureSubview
{
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nametimeLable];
    [self.contentView addSubview:self.questionTitleLab];
    [self.contentView addSubview:self.questionDescLab];
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(12);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        [_nametimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(_headImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView);
        }];
        [_questionTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nametimeLable.bottom).offset(5);
            make.left.mas_equalTo(_headImageView.right).offset(10);
            //            make.width.mas_equalTo((int)kDeviceWidth-110);
                        make.size.mas_equalTo(CGSizeMake(230, 40));
        }];
        
        [_questionDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_questionTitleLab.bottom);
            make.left.mas_equalTo(_headImageView.right).offset(10);
            //            make.width.mas_equalTo((int)kDeviceWidth-110);
            make.size.mas_equalTo(CGSizeMake(230, 40));
        }];
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}


//赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.questionDescLab.text = text;
    //设置label的最大行数
    self.questionDescLab.numberOfLines = 0;
    CGSize size = CGSizeMake(220, 40);
    CGSize labelSize = [self.questionDescLab.text sizeWithFont:self.questionDescLab.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.questionDescLab.frame = CGRectMake(self.questionDescLab.frame.origin.x, self.questionDescLab.frame.origin.y, labelSize.width, labelSize.height);
    //计算出自适应的高度
    frame.size.height = labelSize.height+100;
    self.frame = frame;
}

#pragma mark - Getters & Setters
- (UIImageView*)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.clipsToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}
- (UILabel*)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.numberOfLines = 1;
        _nameLable.font = [UIFont systemFontOfSize:12];
        _nameLable.textColor = [UIColor blackColor];
        _nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLable;
}

- (UILabel*)timeLable
{
    if (!_timeLable) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.numberOfLines = 1;
        _timeLable.font = [UIFont systemFontOfSize:12];
        _timeLable.textColor = [UIColor blackColor];
        _timeLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _timeLable;
}
- (UILabel*)nametimeLable
{
    if (!_nametimeLable) {
        _nametimeLable = [[UILabel alloc] init];
        _nametimeLable.numberOfLines = 1;
        _nametimeLable.font = [UIFont systemFontOfSize:12];
        _nametimeLable.textColor = [UIColor colorWithHex:0x333333];
        _nametimeLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nametimeLable;
}
- (UILabel*)questionTitleLab
{
    if (!_questionTitleLab) {
        _questionTitleLab = [[UILabel alloc] init];
        _questionTitleLab.numberOfLines =0;
        _questionTitleLab.font = [UIFont systemFontOfSize:16];
        _questionTitleLab.textColor = [UIColor colorWithHex:0x333333];
        _questionTitleLab.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _questionTitleLab;
}

- (UILabel*)questionDescLab
{
    if (!_questionDescLab) {
        _questionDescLab = [[InsetsLabel alloc] init];
        _questionDescLab.lineBreakMode = NSLineBreakByWordWrapping;
        _questionDescLab.numberOfLines = 0;
//        _questionDescLab.layer.cornerRadius = 3;
//        _questionDescLab.layer.borderColor = UIColorWithRGBA(200, 200, 200, 1).CGColor;
//        _questionDescLab.layer.borderWidth = 1.0;
        _questionDescLab.font = [UIFont systemFontOfSize:12];
        _questionDescLab.textColor = [UIColor colorWithHex:0x999999];
        _questionDescLab.textAlignment = NSTextAlignmentLeft;
    }
    return _questionDescLab;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
