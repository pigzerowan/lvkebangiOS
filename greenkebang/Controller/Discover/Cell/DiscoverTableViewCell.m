//
//  DiscoverTableViewCell.m
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "GTMNSString+HTML.h"

@implementation DiscoverTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}

#pragma mark - Public methods
- (void)configDiscoveryRecommCellWithModel:(NewInsightModel *)model;
{
    [self.headImageView sd_setImageWithURL:[model.avatar lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    NSInteger sugterNum = model.readNum;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString*strrr1=model.addTime;
    NSTimeInterval time=[strrr1 doubleValue]/1000;
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSString *confromTimespStr = [formatter stringFromDate:detaildate];
    
//    NSString *timeStr = model.addTime;
//    float datetime = [timeStr floatValue];
//    NSDate * dt = [NSDate dateWithTimeIntervalSince1970: datetime];
//    NSDateFormatter * df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"MM.dd"];
//    NSString *regStr = [df stringFromDate:dt];
//    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~%@",regStr);
    

    self.nametimeLable.text = [NSString stringWithFormat:@"%@.发布于%@.%ld人看过",model.userName,confromTimespStr,(long)sugterNum];
    
 
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    [NSString stringWithFormat:@"%@ %@",@"结婚纪念日",@"还有8天"];
  
    
    NSString *strrr = [model.blogTitle gtm_stringByUnescapingFromHTML];
    NSString *myTitleLableText = [self filterHTML:strrr];

      self.simpleLable.text= myTitleLableText;
    
    
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];

}


#pragma mark - Public methods
- (void)configTimeTopicCellWithModel:(PeoplestopicModel *)model
{
    [self.headImageView sd_setImageWithURL:[model.topicAvatar lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    NSString *sugterNum = model.replyNum;
//    NSString *timeStr = model.operTime;
//    float datetime = [timeStr floatValue];
//    NSDate * dt = [NSDate dateWithTimeIntervalSince1970: datetime];
//    NSDateFormatter * df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"MM.dd"];
//    NSString *regStr = [df stringFromDate:dt];
//    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~%@",regStr);
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//    NSString*strrr1=model.operTime;
//    NSTimeInterval time=[strrr1 doubleValue]/1000;
//    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//    NSString *confromTimespStr = [formatter stringFromDate:detaildate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSTimeInterval time=model.topicDate;
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSString *confromTimespStr = [formatter stringFromDate:detaildate];

    
    self.nametimeLable.text = [NSString stringWithFormat:@"%@.发布于%@.%@人回复",model.userName,confromTimespStr,sugterNum];
    self.simpleLable.text = model.topicSummary;

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

#pragma mark - Event response

#pragma maek - SubViews
- (void)configureSubview
{

    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nametimeLable];
    [self.contentView addSubview:self.simpleLable];
}



- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
//        [_nametimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.contentView).offset(10);
//            make.left.mas_equalTo(_headImageView.right).offset(10);
//            make.right.mas_equalTo(self.contentView);
//        }];
//        [_simpleLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_nametimeLable.bottom).offset(10);
//            make.left.mas_equalTo(_nametimeLable.left);
//            make.right.mas_equalTo(self.contentView.right).offset(-10);
//            //            make.size.mas_equalTo(CGSizeMake(40, 200));
//            //            make.width.mas_equalTo((int)kDeviceWidth/2);
//        }];
        
        
        [_simpleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(_headImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-10);
            //            make.size.mas_equalTo(CGSizeMake(40, 200));
            //            make.width.mas_equalTo((int)kDeviceWidth/2);
        }];

        
        [_nametimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView).offset(-10);
            make.left.mas_equalTo(_simpleLable.left);
            make.right.mas_equalTo(self.contentView.right).offset(-10);

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
        _headImageView.clipsToBounds = YES;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}

- (UILabel*)nametimeLable
{
    if (!_nametimeLable) {
        _nametimeLable = [[UILabel alloc] init];
        _nametimeLable.numberOfLines = 1;
        _nametimeLable.font = [UIFont systemFontOfSize:13];
        _nametimeLable.textColor = [UIColor lightGrayColor];
        _nametimeLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nametimeLable;
}

- (UILabel*)simpleLable
{
    if (!_simpleLable) {
        _simpleLable = [[UILabel alloc] init];
        _simpleLable.numberOfLines = 2;
        _simpleLable.clipsToBounds = YES;
        _simpleLable.font = [UIFont systemFontOfSize:14];
        _simpleLable.textColor = [UIColor blackColor];
        _simpleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _simpleLable;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
