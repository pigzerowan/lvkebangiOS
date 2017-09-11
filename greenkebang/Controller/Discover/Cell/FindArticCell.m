//
//  FindArticCell.m
//  greenkebang
//
//  Created by 郑渊文 on 1/20/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "FindArticCell.h"
#import <UIImageView+WebCache.h>
#import "NewTimeDynamicModel.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"

@implementation FindArticCell
{
    CGRect CellBounds;
    CGFloat cellHeight;
}



- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier: reuseID];
    if (self)
    {
        
        [self.contentView setBackgroundColor:UIColorWithRGBA(244, 244, 244, 1)];;
        CellBounds = CGRectMake(0, 0, SCREEN_WIDTH, height);
        cellHeight = height;
        self.backgroundColor = UIColorWithRGBA(244, 244, 244, 1);
        [self configureSubview];
    }
    return  self;
}

#pragma mark - Getters & Setters
- (void)setDidLike:(BOOL)didLike
{
    _didLike = didLike;
    self.loveBtn.selected = didLike;
}


- (void)configNewArticTableCellWithGoodModel:(NewFindDetailModel *)admirGood
{
   
    
    if ([admirGood.type isEqualToString:@"1"]) {
        _typeStr = @"发布文章";
    }else if ([admirGood.type isEqualToString:@"2"])
    {
        _typeStr = @"发布技术疑难";
    }
    else if ([admirGood.type isEqualToString:@"3"])
    {
        _typeStr = @"回复技术疑难";
    }else if ([admirGood.type isEqualToString:@"4"])
    {
        _typeStr = @"发布话题";
    }else if ([admirGood.type isEqualToString:@"5"])
    {
        _typeStr = @"创建群组";
    }

    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:admirGood.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    
    self.nameLabel.text =[NSString stringWithFormat:@"%@---%@",admirGood.userName,_typeStr] ;
    self.goodsTitleLabel.text = admirGood.title;
    self.goodsDesLabel.text = admirGood.summary;
    if (admirGood.pubDate != 0) {
        self.goodsTimeLabel.text = [NSString stringWithFormat:@"%@-%@",[NSDate timestampToYear:admirGood.pubDate/1000],[NSDate timestampToMonth:admirGood.pubDate/1000]];
    }else{
        self.goodsTimeLabel.text = @"";
    }
    self.goodsAddressLabel.text = admirGood.summary;

    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

#pragma mark - Event response
- (void)loveButtonDidClicked:(id)sender
{
}
#pragma maek - SubViews
- (void)configureSubview
{
    
    [self.goodsTitleLabel setFrame:CGRectMake(10, 5, kDeviceWidth-40, 30)];
    [self.goodsDesLabel setFrame:CGRectMake(10, 10, kDeviceWidth-40, 80)];
    [self.nameLabel setFrame:CGRectMake(10, 90, kDeviceWidth/2, 30)];
    [self.buyBtn setFrame:CGRectMake(kDeviceWidth-140, 90, 50, 30)];
    [self.loveBtn setFrame:CGRectMake(kDeviceWidth-100, 90, 50, 30)];

    [self.contentView addSubview:self.detailView];
    [self.detailView addSubview:self.loveBtn];
    [self.detailView addSubview:self.buyBtn];
    [self.detailView addSubview:self.goodsDesLabel];
    [self.detailView addSubview:self.goodsTitleLabel];
    [self.detailView addSubview:self.nameLabel];

}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {

        [_detailView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(self.contentView.top).offset(10);
            make.left.mas_equalTo(self.contentView.left).offset(10);
            make.width.mas_equalTo(kDeviceWidth-20);
            make.height.mas_equalTo(120);
        }];

        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


#pragma mark - Getters & Setters


- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = [UIColor colorWithHex:0x666666];
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}
- (UILabel*)loveTimeLabel
{
    if (!_loveTimeLabel) {
        _loveTimeLabel = [[UILabel alloc] init];
        _loveTimeLabel.numberOfLines = 0;
        _loveTimeLabel.font = [UIFont systemFontOfSize:13];
        _loveTimeLabel.textColor = [UIColor colorWithHex:0x666666];
        _loveTimeLabel.textAlignment = NSTextAlignmentRight;
        _loveTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _loveTimeLabel;
}
- (UIButton*)loveButton
{
    if (!_loveButton) {
        _loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loveButton setImage:[UIImage imageNamed:@"yq_love_small.png"] forState:UIControlStateNormal];
        [_loveButton setImage:[UIImage imageNamed:@"yq_love_small_select.png"] forState:UIControlStateSelected];
        [_loveButton addTarget:self action:@selector(loveButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveButton;
}
- (UILabel*)goodsTitleLabel
{
    if (!_goodsTitleLabel) {
        _goodsTitleLabel = [[UILabel alloc] init];
        _goodsTitleLabel.numberOfLines = 0;
        _goodsTitleLabel.font = [UIFont systemFontOfSize:13];
        _goodsTitleLabel.textColor = [UIColor blackColor];
        _goodsTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsTitleLabel;
}
- (UILabel*)goodsDesLabel
{
    if (!_goodsDesLabel) {
        _goodsDesLabel = [[UILabel alloc] init];
        _goodsDesLabel.numberOfLines = 2;
        _goodsDesLabel.font = [UIFont systemFontOfSize:13];
        _goodsDesLabel.textColor = [UIColor colorWithHex:0x666666];
        _goodsDesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsDesLabel;
}
- (UILabel*)goodsTimeLabel
{
    if (!_goodsTimeLabel) {
        _goodsTimeLabel = [[UILabel alloc] init];
        _goodsTimeLabel.numberOfLines = 0;
        _goodsTimeLabel.font = [UIFont systemFontOfSize:13];
        _goodsTimeLabel.textColor = [UIColor colorWithHex:0x666666];
        _goodsTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsTimeLabel;
}

- (UILabel*)goodsAddressLabel
{
    if (!_goodsAddressLabel) {
        _goodsAddressLabel = [[UILabel alloc] init];
        _goodsAddressLabel.numberOfLines = 0;
        _goodsAddressLabel.font = [UIFont systemFontOfSize:13];
        _goodsAddressLabel.textColor = [UIColor colorWithHex:0x666666];
        _goodsAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsAddressLabel;
}

- (UIView*)detailView
{
    if (!_detailView) {
        _detailView = [[UIView alloc] init];
        _detailView.backgroundColor = CCColorFromRGBA(243, 243, 242, 1);
        _detailView.layer.borderColor = CCColorFromRGBA(210, 210, 210, 1).CGColor;
        _detailView.layer.borderWidth = 1;
    }
    return _detailView;
}

- (UIView*)controllerView
{
    if (!_controllerView) {
        _controllerView = [[UIView alloc] init];
        _controllerView.backgroundColor = [UIColor whiteColor];
    }
    return _controllerView;
}


- (UIButton *)loveBtn
{
    if (!_loveBtn) {
        _loveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_loveBtn setFrame:CGRectMake(kDeviceWidth/2, 0, kDeviceWidth/2, 50)];
//        _loveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        UIImage *loveImage = [UIImage imageNamed:@"icon_praise_nor.png"];
//        [_loveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -loveImage.size.width-30, 0, loveImage.size.width)];
//        [_loveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _loveBtn.titleLabel.bounds.size.width+80, 0, -_loveBtn.titleLabel.bounds.size.width)];
//        [_loveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [_loveBtn setTitle:@"赞" forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@"icon_praise_nor.png"] forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@"icon_praise_sel.png"] forState:UIControlStateSelected];
        [_loveBtn addTarget:self action:@selector(loveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveBtn;
}


- (UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_buyBtn setFrame:CGRectMake(0, 0, kDeviceWidth/2, 50)];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_buyBtn setTitle:@"评论" forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
