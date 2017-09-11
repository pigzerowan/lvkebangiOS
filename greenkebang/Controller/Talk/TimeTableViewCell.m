//
//  TimeTableViewCell.m
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "TimeTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation TimeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}

#pragma mark - Public methods
- (void)configTimeTopicCellWithModel:(PeoplestopicModel *)model
{
//    NSString *imageUrl = @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
    [self.headImageView sd_setImageWithURL:[model.ownerAvatar lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    self.nameLable.text = model.ownerName;
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    [NSString stringWithFormat:@"%@ %@",@"结婚纪念日",@"还有8天"];
     self.timeLable.text= @"8.17";
    _nametimeLable.text = [NSString stringWithFormat:@"%@.%@",_nameLable.text,_timeLable.text];
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    //    self.remindLabel.attributedText = remAttributedStr;
   
    self.simpleLable.text = model.topicDesc;
}


- (void)configDynamicCellWithModel:(NewDynamicModel *)model
{
    [self.headImageView sd_setImageWithURL:[model.avatar lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    self.nameLable.text = model.userName;
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    [NSString stringWithFormat:@"%@ %@",@"结婚纪念日",@"还有8天"];
    self.timeLable.text= @"8.17";
    _nametimeLable.text = [NSString stringWithFormat:@"%@.%@",_nameLable.text,_timeLable.text];
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    //    self.remindLabel.attributedText = remAttributedStr;
    
    self.simpleLable.text = model.questionTitle;
}

- (void)configInsightCellWithModel:(NewInsightModel *)model
{
    
    
    [self.headImageView sd_setImageWithURL:[model.avatar lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    self.nameLable.text = model.userName;
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    [NSString stringWithFormat:@"%@ %@",@"结婚纪念日",@"还有8天"];
    self.timeLable.text= @"8.17";
    _nametimeLable.text = [NSString stringWithFormat:@"%@.%@",_nameLable.text,_timeLable.text];
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    //    self.remindLabel.attributedText = remAttributedStr;
    
    self.simpleLable.text = model.blogTitle;
}



- (void)configGroupCellWithModel:(GroupDetailModel *)model
{
    NSLog(@"==============%@",model.avatar);
    
     NSLog(@"==============%@",model.groupDesc);
    [self.headImageView sd_setImageWithURL:[model.avatar lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    self.nameLable.text = model.groupSubject;
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    [NSString stringWithFormat:@"%@ %@",@"结婚纪念日",@"还有8天"];
    self.timeLable.text= @"";
    _nametimeLable.text = [NSString stringWithFormat:@"%@.%@",_nameLable.text,_timeLable.text];
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    //    self.remindLabel.attributedText = remAttributedStr;
    
    self.simpleLable.text = model.groupDesc;
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
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        [_nametimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(_headImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView);
        }];
        [_simpleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nametimeLable.bottom).offset(5);
            make.left.mas_equalTo(_headImageView.right).offset(10);
//            make.width.mas_equalTo((int)kDeviceWidth-110);
             make.size.mas_equalTo(CGSizeMake(200, 50));
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
- (UILabel*)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.numberOfLines = 1;
        _nameLable.font = [UIFont systemFontOfSize:12];
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
        _nametimeLable.textColor = [UIColor lightGrayColor];
        _nametimeLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nametimeLable;
}
- (InsetsLabel*)simpleLable
{
    if (!_simpleLable) {
        _simpleLable = [[InsetsLabel alloc] initWithInsets:UIEdgeInsetsMake(5, 3, 3, 5)];
        _simpleLable.lineBreakMode = NSLineBreakByWordWrapping;
        _simpleLable.numberOfLines = 2;
        _simpleLable.layer.cornerRadius = 3;
        _simpleLable.layer.borderColor = UIColorWithRGBA(200, 200, 200, 1).CGColor;
        _simpleLable.layer.borderWidth = 1.0;
        _simpleLable.font = [UIFont systemFontOfSize:12];
        _simpleLable.textAlignment = NSTextAlignmentLeft;
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
