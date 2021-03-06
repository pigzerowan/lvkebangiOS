//
//  ColumnWithImageCell.m
//  greenkebang
//
//  Created by 郑渊文 on 1/25/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "ColumnWithImageCell.h"
#import <UIImageView+WebCache.h>
#import "NewTimeDynamicModel.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"
@implementation ColumnWithImageCell
{
    CGRect CellBounds;
    CGFloat cellHeight;
}


//- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID
//{
//    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier: reuseID];
//    if (self)
//    {
//        
//        [self.contentView setBackgroundColor:UIColorWithRGBA(244, 244, 244, 1)];;
//        CellBounds = CGRectMake(0, 0, SCREEN_WIDTH, height);
//        cellHeight = height;
//        [self configureSubview];
//    }
//    return  self;
//}


- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        [self configureSubview];
        
    }
    
    return self;
}

- (void)configFindSingelColumnTableCellWithGoodModel:(NewFindDetailModel *)admirGood
{
    [self.coverImageView sd_setImageWithURL:[admirGood.cover lkbImageUrl6] placeholderImage:YQNormalBackGroundPlaceImage];
    
    [_replyBtn setTitle:admirGood.replyNum forState:UIControlStateNormal];
    [_loveBtn setTitle:admirGood.starNum forState:UIControlStateNormal];
    NSDate *createDate = [NSDate dateFormJavaTimestamp:admirGood.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    
    self.nameLabel.text =[NSString stringWithFormat:@"%@",admirGood.userName] ;
    self.goodsTitleLabel.text = admirGood.title;
    self.goodsDesLabel.text = admirGood.summary;
    
    

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}
- (void)configSingelColumnTableCellWithGoodModel:(SingelColumnModel *)admirGood
{
    [self.coverImageView sd_setImageWithURL:[admirGood.cover lkbImageUrl6] placeholderImage:YQNormalBackGroundPlaceImage];

    NSLog(@"=========%@=========",[admirGood.cover lkbImageUrl]);
    self.coverImageView.backgroundColor = [UIColor redColor];
    

    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:admirGood.pubDate];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",[createDate timeAgo]] ;
    self.goodsTitleLabel.text = admirGood.title;
    self.goodsDesLabel.text = admirGood.summary;
    
    
    if ([admirGood.starNum isEqualToString:@"0"] && ![admirGood.replyNum isEqualToString:@"0"]) {
        self.goodCommentLabel.text = [NSString stringWithFormat:@"%@评论",admirGood.replyNum];
        
    }
    else if ([admirGood.replyNum isEqualToString:@"0"]&& ![admirGood.starNum isEqualToString:@"0"]) {
        
        self.goodCommentLabel.text = [NSString stringWithFormat:@"%@点赞",admirGood.starNum];
        
    }
    else if (![admirGood.replyNum isEqualToString:@"0"]&& ![admirGood.starNum isEqualToString:@"0"]) {
        
        self.goodCommentLabel.text = [NSString stringWithFormat:@"%@点赞   %@评论",admirGood.starNum,admirGood.replyNum];
        
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}


- (void)configColumnArticleListTableCellWithGoodModel:(SingelColumnModel *)admirGood{
    
    [self.coverImageView sd_setImageWithURL:[admirGood.cover lkbImageUrl6] placeholderImage:YQNormalBackGroundPlaceImage];
    
    NSLog(@"=========%@=========",[admirGood.cover lkbImageUrl]);
    self.coverImageView.backgroundColor = [UIColor redColor];
    
    self.nameLabel.text = admirGood.userName;
    self.goodsTitleLabel.text = admirGood.title;
    
    
    if ([admirGood.starNum isEqualToString:@"0"] && ![admirGood.replyNum isEqualToString:@"0"]) {
        self.goodCommentLabel.text = [NSString stringWithFormat:@"%@评论",admirGood.replyNum];
        
    }
    else if ([admirGood.replyNum isEqualToString:@"0"]&& ![admirGood.starNum isEqualToString:@"0"]) {
        
        self.goodCommentLabel.text = [NSString stringWithFormat:@"%@点赞",admirGood.starNum];
        
    }
    else if (![admirGood.replyNum isEqualToString:@"0"]&& ![admirGood.starNum isEqualToString:@"0"]) {
        
        self.goodCommentLabel.text = [NSString stringWithFormat:@"%@点赞   %@评论",admirGood.starNum,admirGood.replyNum];
        
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

}


#pragma maek - SubViews
- (void)configureSubview
{

//    UIView *lineView = [[UIView alloc]init];
//    lineView.backgroundColor = CCColorFromRGBA(73, 170, 60, 1);
//    
//    UIView *controllerView = [[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth/2, 90, kDeviceWidth/2, 30)];
////    controllerView.backgroundColor = [UIColor redColor];
//    [controllerView addSubview:self.replyBtn];
//    [controllerView addSubview:self.loveBtn];
//    
//    
//    if (iPhone5) {
//        [lineView setFrame:CGRectMake(10, 31, 200, 1)];
////        [self.goodsTitleLabel setFrame:CGRectMake(10, 10, 200, 20)];
//        [self.goodsDesLabel setFrame:CGRectMake(10, 25, 200, 80)];
//    }
//
//    else
//    {
//        [lineView setFrame:CGRectMake(10, 31, 250, 1)];
////        [self.goodsTitleLabel setFrame:CGRectMake(10, 10, 250, 20)];
//        [self.goodsDesLabel setFrame:CGRectMake(10, 25, 250, 80)];
//
//    }
//    
////    [self.nameLabel setFrame:CGRectMake(10, 90, 100, 30)];
//    
//    [self.loveTimeLabel setFrame:CGRectMake(100, 90, 100, 30)];

    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.goodsTitleLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.goodCommentLabel];
    [self.contentView addSubview:self.lineView];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    //     应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    //        self.goodsTitleLabel.preferredMaxLayoutWidth = w - 110;
    
    
    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.goodsTitleLabel.preferredMaxLayoutWidth = w-110 ;
    self.goodsTitleLabel.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
    //                                   initWithTarget:self
    //                                   action:@selector(onTap)];
    //    [self.goodsDesLabel addGestureRecognizer:tap];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 16;


//    [self.contentView addSubview:controllerView];
//    [self.contentView addSubview:lineView];

}



- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.left).offset(14);
            make.top.mas_equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(112, 73));
        }];
        
        [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coverImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-14);
            make.top.mas_equalTo(self.contentView).offset(10);
//            make.size.mas_equalTo(CGSizeMake(112, 73));
//            make.height.mas_equalTo(40);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coverImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-14);
            make.top.mas_equalTo(self.contentView).offset(63);

//            make.top.mas_equalTo(self.goodsTitleLabel.bottom).offset(16);
            //            make.size.mas_equalTo(CGSizeMake(112, 73));
            //            make.height.mas_equalTo(40);
        }];
        
        [_goodCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.coverImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-14);
            make.top.mas_equalTo(self.contentView).offset(63);

//            make.top.mas_equalTo(self.goodsTitleLabel.bottom).offset(16);
            //            make.size.mas_equalTo(CGSizeMake(112, 73));
            //            make.height.mas_equalTo(40);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.contentView).offset(14);
            make.right.mas_equalTo(self.contentView).offset(-14);
            make.top.mas_equalTo(self.coverImageView.bottom).offset(16);
            make.height.mas_equalTo(0.5);
        }];





        
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
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
//        _replyBtn.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
        _replyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_replyBtn addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBtn;
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




- (UIImageView*)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.clipsToBounds = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}
- (UIImageView*)addressIconImageView
{
    if (!_addressIconImageView) {
        _addressIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yq_goods_address_icon.png"]];
    }
    return _addressIconImageView;
}
- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor colorWithHex:0x989898];
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
        _loveTimeLabel.textAlignment = NSTextAlignmentLeft;
        _loveTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _loveTimeLabel;
}

- (UILabel*)goodsTitleLabel
{
    if (!_goodsTitleLabel) {
        _goodsTitleLabel = [[UILabel alloc] init];
        _goodsTitleLabel.numberOfLines = 2;
        _goodsTitleLabel.font = [UIFont systemFontOfSize:16];
        _goodsTitleLabel.textColor = CCCUIColorFromHex(0x333333);
        _goodsTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _goodsTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_goodsTitleLabel sizeToFit];
        
    }
    return _goodsTitleLabel;
}
- (UILabel*)goodsDesLabel
{
    if (!_goodsDesLabel) {
        _goodsDesLabel = [[UILabel alloc] init];
        _goodsDesLabel.numberOfLines = 3;
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
- (UILabel*)goodsPriceLabel
{
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] init];
        _goodsPriceLabel.numberOfLines = 0;
        _goodsPriceLabel.font = [UIFont systemFontOfSize:15];
        _goodsPriceLabel.textColor = [UIColor blackColor];
        _goodsPriceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsPriceLabel;
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

//- (UIView*)controllerView
//{
//    if (!_controllerView) {
//        _controllerView = [[UIView alloc] init];
//        _controllerView.backgroundColor = [UIColor whiteColor];
//    }
//    return _controllerView;
//}
//


- (UILabel *)goodCommentLabel {
    
    if (!_goodCommentLabel) {
        _goodCommentLabel = [[UILabel alloc]init];
        
        _goodCommentLabel.font = [UIFont systemFontOfSize:10];
        _goodCommentLabel.textColor = CCCUIColorFromHex(0x989898);
        _goodCommentLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _goodCommentLabel;
    
}

- (UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
        
    }
    return _lineView;
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
