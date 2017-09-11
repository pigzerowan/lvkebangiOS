//
//  FindTopicCell.m
//  greenkebang
//
//  Created by 郑渊文 on 1/28/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "FindTopicCell.h"


#import "UIImageView+EMWebCache.h"

@implementation FindTopicCell
{
    CGRect CellBounds;
    CGFloat cellHeight;
}

- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier: reuseID];
    if (self)
    {
        
        [self.contentView setBackgroundColor:UIColorWithRGBA(244, 244, 244, 1)];
        CellBounds = CGRectMake(0, 0, SCREEN_WIDTH, height);
        cellHeight = height;
        [self configureSubview];
    }
    return  self;
}

#pragma mark - Getters & Setters

- (void)configNewFindTopicTableCellWithGoodModel:(NewFindDetailModel *)admirGood
{
    
    [self.headImageView sd_setImageWithURL:[admirGood.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    [_replyBtn setTitle:admirGood.replyNum forState:UIControlStateNormal];
    [_loveBtn setTitle:admirGood.starNum forState:UIControlStateNormal];
    self.nameLable.text = [NSString stringWithFormat:@"来自%@",admirGood.groupName];
    self.adressLable.text=admirGood.summary;
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
#pragma mark - Event response

#pragma maek - SubViews
- (void)configureSubview
{
    
    UIView *controllerView = [[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth/2, 35, kDeviceWidth/2, 30)];
    //    controllerView.backgroundColor = [UIColor redColor];
    [controllerView addSubview:self.replyBtn];
    [controllerView addSubview:self.loveBtn];

    
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.adressLable];
    [self.contentView addSubview:controllerView];
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {

        [_adressLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.top).offset(10);
            make.left.mas_equalTo(self.contentView.left).offset(10);
            make.right.mas_equalTo(self.contentView.right).offset(-10);
        }];
        
        
        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_adressLable.bottom).offset(8);
            make.left.mas_equalTo(_adressLable.left).offset(0);
            make.right.mas_equalTo(self.contentView.right).offset(-kDeviceWidth/2);
        }];

        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


- (UIButton *)loveBtn
{
    if (!_loveBtn) {
        _loveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loveBtn setFrame:CGRectMake(70, 0, 80, 30)];
        _loveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        UIImage *loveImage = [UIImage imageNamed:@"icon_unPushlove"];
        
        [_loveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, loveImage.size.width, 0,0)];
        [_loveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,_loveBtn.titleLabel.bounds.size.width)];
        [_loveBtn setTitleColor:[UIColor textGrayColor] forState:UIControlStateNormal];
        
        
        [_loveBtn setImage:[UIImage imageNamed:@"icon_unPushlove"] forState:UIControlStateNormal];
        [_loveBtn addTarget:self action:@selector(loveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveBtn;
}




- (UIButton *)replyBtn
{
    if (!_replyBtn) {
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setFrame:CGRectMake(0, 0,80, 30)];
        _replyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        UIImage *commentImage = [UIImage imageNamed:@"icon_comment"];
        
        //
        //        [_replyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, commentImage.size.width, 0,0)];
        //        [_replyBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,_replyBtn.titleLabel.bounds.size.width)];
        [_replyBtn setTitleColor:[UIColor textGrayColor] forState:UIControlStateNormal];
        
        
        //
        _replyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, _replyBtn.titleLabel.bounds.size.width, 0,-30);
        [_replyBtn setImage:[UIImage imageNamed:@"icon_comment"] forState:UIControlStateNormal];
        _replyBtn.imageEdgeInsets = UIEdgeInsetsMake(0,13,0,_replyBtn.titleLabel.bounds.size.width);
        _replyBtn.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
        _replyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_replyBtn addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBtn;
}





#pragma mark - Event response
- (void)loveButtonClicked:(id)sender
{
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }
    
}
- (void)buyButtonClicked:(id)sender
{
    if (self.clickBlock) {
        self.clickBlock(2);
    }
}


- (UILabel*)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.numberOfLines = 1;
        _nameLable.font = [UIFont systemFontOfSize:10];
        _nameLable.textColor = [UIColor blackColor];
        _nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLable;
}

- (UILabel*)adressLable
{
    if (!_adressLable) {
        _adressLable = [[UILabel alloc] init];
        _adressLable.numberOfLines = 2;
        _adressLable.clipsToBounds = YES;
        _adressLable.font = [UIFont systemFontOfSize:12];
        _adressLable.textColor = [UIColor blackColor];
        _adressLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _adressLable;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
