//
//  UserTopicNoImageNoDetailCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/5.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserTopicNoImageNoDetailCell.h"

@implementation UserTopicNoImageNoDetailCell



- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        [self configureSubview];
        
    }
    
    return self;
}

- (void)configNoImageNoDetailUserTopicTableCellWithGoodModel:(PeoplestopicModel *)model{
    _groupId = model.groupId;

    [_replyBtn setTitle:model.replyNum forState:UIControlStateNormal];
//    [_loveBtn setTitle:model.starNum forState:UIControlStateNormal];
    
    self.coverImageView.backgroundColor = [UIColor redColor];
    
    self.coverImageView.hidden = [NSStrUtil isEmptyOrNull:model.topicAvatar];
    
    [self.coverImageView sd_setImageWithURL:[model.topicAvatar lkbImageUrl2] placeholderImage:YQNormalBackGroundPlaceImage];
    
    _nameLabel.text = model.topicSummary;
    
    [_GroupButton setTitle:model.groupName forState:UIControlStateNormal];
    
    _starLabel.text = model.starNum;
    _comentNumLable.text = model.replyNum;
    
    _attentionNumLable.text = [NSString stringWithFormat:@"%@人关注",model.attentionNum];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];


}

#pragma maek - SubViews
- (void)configureSubview
{
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.fromGroup];
    [self.contentView addSubview:self.GroupButton];
    [self.contentView addSubview:self.repleyImageView];
    [self.contentView addSubview:self.comentNumLable];
    [self.contentView addSubview:self.attentionNumLable];
    [self.contentView addSubview:self.starImage];
    [self.contentView addSubview:self.starLabel];
    [self.contentView addSubview:self.goodsDesLabel];
    
    
    
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    //     应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    //    self.goodsTitleLabel.preferredMaxLayoutWidth = w - 110;
    
    
    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.goodsDesLabel.preferredMaxLayoutWidth = w-20 ;
    self.goodsDesLabel.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
    //                                   initWithTarget:self
    //                                   action:@selector(onTap)];
    //    [self.goodsDesLabel addGestureRecognizer:tap];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.repleyImageView;
    self.hyb_bottomOffsetToCell = 15;
    
}

- (void)updateConstraints
{
    
    CGFloat padding = iPhone5_Before ? 13 : 15;
    if (!self.didSetupConstraints) {
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(self.contentView.right).offset(-12);
            make.top.mas_equalTo(15);
            //            make.centerY.mas_equalTo(_headImageView);
        }];
        
        [_fromGroup mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_nameLabel);
            make.top.mas_equalTo(_nameLabel.bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(60, 20));
            
        }];
        
        [_GroupButton mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(self.contentView).offset(75);
//            make.right.mas_equalTo(self.contentView.right).offset(-12);
            make.top.mas_equalTo(_nameLabel.bottom).offset(12);
            make.width.mas_equalTo(kDeviceWidth -60);
        }];

        
        [_goodsDesLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_fromGroup.bottom).offset(15);
            make.left.mas_equalTo(_nameLabel);
            make.width.mas_equalTo(self.contentView).offset(-20);
        }];
        
        
        [_starImage mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_nameLabel);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(padding, padding));
        }];

        [_starLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_starImage.right).offset(10);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(padding, padding));
        }];

        
        [_repleyImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_starLabel.right).offset(10);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(padding, padding));
        }];
        
        [_comentNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_repleyImageView.right).offset(10);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 15));
        }];
        
        [_attentionNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_comentNumLable.right).offset(10);
            make.top.mas_equalTo(_goodsDesLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        
        
        self.didSetupConstraints = YES;
        
        
    }
    
    [super updateConstraints];
}




#pragma mark - Getters & Setters

- (UIImageView*)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.clipsToBounds = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}

- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
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

- (UILabel*)goodsDesLabel
{
    if (!_goodsDesLabel) {
        _goodsDesLabel = [[UILabel alloc] init];
        _goodsDesLabel.numberOfLines = 2;
        _goodsDesLabel.font = [UIFont systemFontOfSize:14];
        
        _goodsDesLabel.textColor = [UIColor blackColor];
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


- (UILabel*)attentionNumLable
{
    if (!_attentionNumLable) {
        _attentionNumLable = [[UILabel alloc] init];
        _attentionNumLable.numberOfLines = 1;
        _attentionNumLable.font = [UIFont systemFontOfSize:11];
        _attentionNumLable.textColor = [UIColor lightGrayColor];
        _attentionNumLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _attentionNumLable;
}


- (UILabel*)comentNumLable
{
    if (!_comentNumLable) {
        _comentNumLable = [[UILabel alloc] init];
        _comentNumLable.numberOfLines = 1;
        _comentNumLable.font = [UIFont systemFontOfSize:11];
        _comentNumLable.textColor = [UIColor lightGrayColor];
        _comentNumLable.textAlignment = NSTextAlignmentLeft;
        _comentNumLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _comentNumLable;
}

- (UIImageView*)starImage {
    
    if (!_starImage) {
        _starImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_unPushlove"]];
    }
    return _starImage;
}


- (UILabel*)starLabel {
    
    if (!_starLabel) {
        _starLabel = [[UILabel alloc]init];
        _starLabel.font = [UIFont systemFontOfSize:11];
        _starLabel.textColor = [UIColor lightGrayColor];
        _starLabel.textAlignment = NSTextAlignmentLeft;
        _starLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _starLabel;
}

- (UIImageView*)repleyImageView
{
    if (!_repleyImageView) {
        _repleyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_comment"]];
    }
    return _repleyImageView;
}


- (UILabel *)fromGroup {
    
    if (!_fromGroup) {
        _fromGroup = [[UILabel alloc]init];
        _fromGroup.text = @"来自专栏:";
        _fromGroup.textColor = [UIColor lightGrayColor];
        _fromGroup.font = [UIFont systemFontOfSize:12];
        _fromGroup.textAlignment = NSTextAlignmentLeft;
//        _fromGroup.backgroundColor = [UIColor cyanColor];
        
    }
    return _fromGroup;
}

- (UIButton *)GroupButton {
    
    if (!_GroupButton) {
        _GroupButton = [[UIButton alloc]init];
        [_GroupButton setTitleColor:[UIColor LkbBtnColor] forState:UIControlStateNormal];
        _GroupButton.titleLabel.font = [UIFont systemFontOfSize:12];
//        _GroupButton.backgroundColor = [UIColor cyanColor];
        _GroupButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_GroupButton addTarget:self action:@selector(turnToGroup:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _GroupButton;
}

- (void)turnToGroup:(id)sender {
    
    [self.attentionCellDelegate turnToGroup:_groupId];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
