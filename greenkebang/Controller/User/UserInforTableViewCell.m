//
//  UserInforTableViewCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/13.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforTableViewCell.h"
#import "LKBPrefixHeader.pch"
#import <UIImageView+WebCache.h>
@implementation UserInforTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configureSubview];
        
    }
    return self;
}

- (void)configUserInforCellWithModel:(UserDynamicModelIntroduceModel *)model {
    
    NSLog(@"=========================================================================%@",model);
    [self.headerImage sd_setImageWithURL:[model.avatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    //    NSString *imageUrl = @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
    //    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:YQNormalPlaceImage];
    self.titleLabel.text = model.title;
    self.nameLabel.text= model.userName;
    self.commentLabel.text = model.replyNum;
    self.goodLabel.text = model.starNum;
    self.contentLabel.text = model.summary;
//    // 时间戳
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
////    NSString*strrr1=model.pubDate;
//    NSTimeInterval time=[strrr1 doubleValue]/1000;
//    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//    
//    
//    NSString *confromTimespStr = [formatter stringFromDate:detaildate];
//
//    self.timeLabel.text = [NSString stringWithFormat:@"%@",confromTimespStr];

    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
}

- (void)configureSubview {
    
    [self addSubview:self.headerImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.issueLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.personalLabel];
    [self addSubview:self.articleView];
    [self addSubview:self.commentButton];
    [self addSubview:self.line_2];
    [self addSubview:self.goodButton];

    if (!self.didSetupConstraints) {

    // 头像
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.left.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(45, 45));
//        make.width.mas_equalTo(SCREEN_WIDTH /5);
        
    }];
    // 名字
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.left.mas_equalTo(_headerImage.right).offset(5);
//        make.right.mas_equalTo(_myTopicBut.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 20));
//        make.width.mas_equalTo(SCREEN_WIDTH /5);
        
    }];

    // 发布文章
    [_issueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.left.mas_equalTo(_nameLabel.right).offset(0);
//        make.right.mas_equalTo(_myQuestionBut.left).offset(0);
        //        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(80, 20));
//        make.width.mas_equalTo(SCREEN_WIDTH /5);
        
    }];
    // 时间
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
//        make.left.mas_equalTo(_myTopicBut.mas_right).offset(0);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 20));
//        make.width.mas_equalTo(SCREEN_WIDTH /5);
        
    }];
    // 个人介绍
    [_personalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.bottom).offset(5);
        make.left.mas_equalTo(_headerImage.right).offset(5);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
//        make.width.mas_equalTo(SCREEN_WIDTH /5);
        
    }];
    // 文章
    [_articleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headerImage.bottom).offset(10);
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 85));
        //        make.width.mas_equalTo(SCREEN_WIDTH /5);
        
    }];
    // 评论
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_articleView.bottom).offset(10);
        make.left.mas_equalTo(self).offset(62);
//        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        //        make.width.mas_equalTo(SCREEN_WIDTH /5);
        
    }];
    // 线条2
    [_line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_articleView.bottom).offset(10);
//        make.left.mas_equalTo(self).offset(10);
//        make.right.mas_equalTo(self).offset(-10);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(1, 30));
        //        make.width.mas_equalTo(SCREEN_WIDTH /5);
        
    }];
    // 点赞
    [_goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_articleView.bottom).offset(10);
//        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-96);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        //        make.width.mas_equalTo(SCREEN_WIDTH /5);
        
    }];
    
    self.didSetupConstraints = YES;
    }



}

- (UIImageView *)headerImage {
    
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]init];
        _headerImage.backgroundColor = [UIColor redColor];
    }
    return _headerImage;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor magentaColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor blackColor];
//        _nameLabel.text = @"苏子凉";
    }
    return _nameLabel;
}

- (UILabel *)issueLabel {
    
    if (!_issueLabel) {
        _issueLabel = [[UILabel alloc]init];
        _issueLabel.backgroundColor = [UIColor magentaColor];
        _issueLabel.font = [UIFont systemFontOfSize:12];
        _issueLabel.textColor = [UIColor grayColor];
//        _issueLabel.text = @"-发表专栏文章";
    }
    return _issueLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
      
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.backgroundColor = [UIColor grayColor];
    }
    return _timeLabel;
}

- (UILabel *)personalLabel {
    
    if (!_personalLabel) {
        
        _personalLabel = [[UILabel alloc]init];
        _personalLabel.backgroundColor = [UIColor magentaColor];
        _personalLabel.font = [UIFont systemFontOfSize:13];
        _personalLabel.textColor = [UIColor grayColor];
//        _personalLabel.text = @"1222333333333333333333333333333333333333";
    }
    return _personalLabel;
}


- (UIView *)articleView {
    if (!_articleView) {
        
        _articleView = [[UIView alloc]init];
        _articleView.backgroundColor = [UIColor grayColor];
        //    _articleView.frame = CGRectMake(10, 70, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 90);
        _articleView.layer.borderWidth = 1;
        _articleView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(10, 5, SCREEN_WIDTH - 40, 25);
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
//        _titleLabel.text = @"1222333333333333333333333333333333333333";
        
        [_articleView addSubview:_titleLabel];
        
        _line_1 = [[UIView alloc]init];
        _line_1.frame = CGRectMake(15, 35, SCREEN_WIDTH - 40, 1);
        
        _line_1.backgroundColor = [UIColor LkbgreenColor];
        
        [_articleView addSubview:_line_1];
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.frame = CGRectMake(10, 40, SCREEN_WIDTH - 40, 38);
        _contentLabel.backgroundColor = [UIColor redColor];
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textColor = [UIColor grayColor];
//        _contentLabel.text = @"1222333333333333333333333333333333333333";
        
        [_articleView addSubview:_contentLabel];
    }
     return _articleView;
}

- (UIButton *)commentButton {
    
    if (!_commentButton) {
        
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.backgroundColor = [UIColor greenColor];
        [_commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.frame = CGRectMake(_commentButton.bounds.size.width+20, _commentButton.bounds.size.height, 50, 20);
        _commentLabel.backgroundColor = [UIColor magentaColor];
        [_commentButton addSubview:_commentLabel];
    }
    return _commentButton;
}

- (UIView *)line_2 {
    
    _line_2 = [[UIView alloc]init];
    _line_2.backgroundColor = [UIColor grayColor];
    return _line_2;
}

- (UIButton *)goodButton {
    
    _goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _goodButton.backgroundColor = [UIColor grayColor];
    [_goodButton setImage:[UIImage imageNamed:@"good"] forState:UIControlStateNormal];
    _goodLabel = [[UILabel alloc]init];
    _goodLabel.frame = CGRectMake(_goodButton.bounds.size.width +20, _goodButton.bounds.size.height, 50, 20);
    _goodLabel.backgroundColor = [UIColor magentaColor];
    [_goodButton addSubview:_goodLabel];

    return _goodButton;
}


@end
