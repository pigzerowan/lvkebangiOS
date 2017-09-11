//
//  UserCollectionNoImageNoDetailCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/5.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserCollectionNoImageNoDetailCell.h"

@implementation UserCollectionNoImageNoDetailCell


- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        [self configureSubview];
        
    }
    
    return self;
}


- (void)configCollectionNoImageNoDetailCellWithModel:(CollectionDetailModel *)model {
    
    _nameLabel.text = model.title;
    
    [_GroupButton setTitle:model.featureName forState:UIControlStateNormal];
    _comentNumLable.text = model.replyNum;
    
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
    
    
    
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    //     应该始终要加上这一句
    // 不然在6/6plus上就不准确了

    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.nameLabel.preferredMaxLayoutWidth = w-20 ;
    self.nameLabel.userInteractionEnabled = YES;

    
    // 必须加上这句
    self.hyb_lastViewInCell = self.comentNumLable;
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
            make.top.mas_equalTo(_nameLabel.bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(60, 20));
            
        }];
        
        [_GroupButton mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(self.contentView).offset(75);
            //            make.right.mas_equalTo(self.contentView.right).offset(-12);
            make.top.mas_equalTo(_nameLabel.bottom).offset(7);
            make.width.mas_equalTo(kDeviceWidth -60);
        }];

        
        [_repleyImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(self.contentView).offset(-30);
            make.top.mas_equalTo(_nameLabel.bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(padding, padding));
        }];
        
        [_comentNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(self.contentView).offset(-5);
            make.top.mas_equalTo(_nameLabel.bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(20, 15));
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
        [_GroupButton addTarget:self action:@selector(groupButton:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _GroupButton;
}

- (void)handlerButtonAction:(AttentionColumnToClickBlock)block {
    
    self.AttentionColumnClickBlock = block;
    
}

- (void)groupButton:(id)sender {
    
    if (self.AttentionColumnClickBlock) {
        self.AttentionColumnClickBlock(1);
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
