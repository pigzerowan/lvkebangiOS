//
//  UserCreatGroupCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserCreatGroupCell.h"
#import <UIImageView+WebCache.h>
#import "NewTimeDynamicModel.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"
#import "MyUserInfoManager.h"
@implementation UserCreatGroupCell
{
    CGRect CellBounds;
    CGFloat cellHeight;
}


- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier: reuseID];
    if (self)
    {
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        CellBounds = CGRectMake(0, 0, SCREEN_WIDTH, height);
        cellHeight = height;
        
        [self configureSubview];
    }
    return  self;
}


- (void)configUserTableCellWithModel:(UserDynamicModelIntroduceModel *)model {
    
//    [self.headImageView sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    
    [_replyBtn setTitle:model.replyNum forState:UIControlStateNormal];
    [_loveBtn setTitle:model.starNum forState:UIControlStateNormal];
    self.coverImageView.backgroundColor = [UIColor redColor];
    
    self.coverImageView.hidden = [NSStrUtil isEmptyOrNull:model.cover];
    
    _userId = model.userId;
    if ([model.isJoin isEqualToString:@"0"]) {
        [_jionBtn setImage:[UIImage imageNamed:@"btn_joinsuccess_nor"] forState:UIControlStateNormal];
        
        _jionBtn.enabled = NO;

     }else
    {
        
        [_jionBtn setImage:[UIImage imageNamed:@"btn_join_nor"] forState:UIControlStateNormal];
        _jionBtn.enabled =YES;


    }
    
    
    
    if ([model.type isEqualToString:@"5"]) {
        [self.coverImageView sd_setImageWithURL:[model.cover lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
    }
    else
    {
        [self.coverImageView sd_setImageWithURL:[model.cover lkbImageUrl] placeholderImage:YQNormalBackGroundPlaceImage];
    }
    // 时间
    NSDate *createDate = [NSDate dateFormJavaTimestamp:model.pubDate];
//    self.loveTimeLabel.text = [createDate timeAgo];
    
    
    
    NSString* priceStr = [NSString stringWithFormat:@"%@ |%@",@"群组",[createDate timeAgo]];
    
    NSMutableAttributedString* priAttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ |%@",@"群组",[createDate timeAgo]] ];
    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, priceStr.length)];
    [priAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor LkbgreenColor] range:NSMakeRange(0, _typeStr.length)];
    
    
    self.nameLabel.attributedText =priAttributedStr;
    
    
    
    //    self.nameLabel.text =[NSString stringWithFormat:@"%@ |%@",@"群组",admirGood.userName] ;
    self.goodsTitleLabel.text = model.title;
    self.goodsDesLabel.text = model.label;
    if (model.pubDate != 0) {
        self.goodsTimeLabel.text = [NSString stringWithFormat:@"%@-%@",[NSDate timestampToYear:model.pubDate/1000],[NSDate timestampToMonth:model.pubDate/1000]];
    }else{
        self.goodsTimeLabel.text = @"";
    }
    self.goodsAddressLabel.text = model.label;
    self.addressIconImageView.hidden = [NSStrUtil isEmptyOrNull:model.label];
    
    
    
    
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
    
//    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLabel];
//    [self.contentView addSubview:self.squeBtn];
    [self.contentView addSubview:self.jionBtn];
//    [self.contentView addSubview:self.loveTimeLabel];
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.goodsDesLabel];
    [self.contentView addSubview:self.goodsTitleLabel];
    
    self.hyb_lastViewInCell = self.coverImageView;
    self.hyb_bottomOffsetToCell =45;

    
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
//        [_headImageView mas_makeConstraints:^(MASConstraintMaker* make) {
//            make.left.mas_equalTo(10);
//            make.size.mas_equalTo(CGSizeMake(20, 20));
//            make.top.mas_equalTo(5);
//        }];
//        
//        [_squeBtn mas_makeConstraints:^(MASConstraintMaker* make) {
//            make.right.mas_equalTo(self.contentView.right).offset(-10);
//            make.size.mas_equalTo(CGSizeMake(20, 20));
//            make.top.mas_equalTo(5);
//        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(self.contentView.right).offset(-12);
            //            make.centerY.mas_equalTo(_headImageView);
            make.top.mas_equalTo(self.contentView.top).offset(15);
            
        }];
        
        [_jionBtn mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(self.contentView.right).offset(-20);
            make.size.mas_equalTo(CGSizeMake(50, 24));
            make.top.mas_equalTo(_nameLabel.bottom).offset(25);

//            make.centerY.mas_equalTo(self.centerY);
        }];
        
        
//        [_loveTimeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
//            make.right.mas_equalTo(_squeBtn.left).offset(-5);
//            make.centerY.mas_equalTo(_headImageView);
//        }];
        
        

//        [_nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
//            make.left.mas_equalTo(_headImageView.right).offset(10).priorityLow();
//            make.right.mas_equalTo(_loveTimeLabel.left);
//            make.top.mas_equalTo(self.contentView.top).offset(10);
//        }];
        
        [_coverImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_nameLabel.bottom).offset(20);
            make.left.mas_equalTo(_nameLabel);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_nameLabel.bottom).offset(20);
            make.left.mas_equalTo(_coverImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView.right);
        }];
        
        [_goodsDesLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsTitleLabel.bottom).offset(5);
            make.left.mas_equalTo(_coverImageView.right).offset(10);
            make.right.mas_equalTo(self.contentView.right);
        }];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


//- (UIButton*)squeBtn
//{
//    if (!_squeBtn) {
//        _squeBtn = [[UIButton alloc] init];
//        _squeBtn.tag =10000;
//        [_squeBtn setImage:[UIImage imageNamed:@"square_btn_arrow_nor"] forState:UIControlStateNormal];
//        [_squeBtn addTarget:self action:@selector(pushToChoose:)  forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    return _squeBtn;
//}


- (UIButton*)jionBtn
{
    if (!_jionBtn) {
        _jionBtn = [[UIButton alloc] init];
        _jionBtn.tag =10001;
        [_jionBtn addTarget:self action:@selector(pushToChoose:)  forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _jionBtn;
}


- (void)handlerButtonAction:(BottomBuyClickBlock)block {
    
    self.clickBlock = block;
}

-(void)pushToChoose:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }
    
}

#pragma mark - Getters & Setters

- (UIImageView*)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.clipsToBounds = YES;
        _coverImageView.layer.masksToBounds = YES;
        _coverImageView.layer.cornerRadius = 20;
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
        _nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}
- (UIButton*)loveButton
{
    if (!_loveButton) {
        _loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loveButton setImage:[UIImage imageNamed:@"yq_love_small_select.png"] forState:UIControlStateNormal];
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
        _goodsTitleLabel.font = [UIFont systemFontOfSize:16];
        _goodsTitleLabel.textColor = CCCUIColorFromHex(0x333333);
        _goodsTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsTitleLabel;
}
- (UILabel*)goodsDesLabel
{
    if (!_goodsDesLabel) {
        _goodsDesLabel = [[UILabel alloc] init];
        _goodsDesLabel.numberOfLines = 1;
        _goodsDesLabel.font = [UIFont systemFontOfSize:12];
        _goodsDesLabel.textColor = [UIColor colorWithHex:0x999999];
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


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
