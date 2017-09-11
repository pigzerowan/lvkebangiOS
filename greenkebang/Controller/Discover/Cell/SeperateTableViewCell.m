//
//  SeperateTableViewCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/20.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SeperateTableViewCell.h"
#import "UIView+DKAddition.h"
#import <UIImageView+WebCache.h>
#import <UIImageView+WebCache.h>
#import "SearchTextManger.h"

@implementation SeperateTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}

// 群分组
- (void)configSeperateGroupCellWithModel:(FindSearchModelDetailModel *)model {
    
    [self.headerImage sd_setImageWithURL:[model.cover lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
    
    if (model.title.length!=0)
    {
    
    NSRange range;
    
    range = [model.title rangeOfString:[SearchTextManger shareInstance].searchText];
    
    
    if (range.location != NSNotFound) {
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.title]; ;
        
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        
        self.titleLabel.attributedText = string;
        NSLog(@"found at location = %d, length = %d",range.location,range.length);
        
    }else{
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.title]; ;
        self.titleLabel.attributedText = string;
        NSLog(@"Not Found");
        
        NSLog(@"Not Found");
        
    }}
    else
    {
        self.titleLabel.text =model.title;
    }
    
        
        
    if (model.summary.length!=0) {
        NSRange  range2 = [model.summary rangeOfString:[SearchTextManger shareInstance].searchText];
        
        if (range2.location != NSNotFound) {
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.summary]; ;
            
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
            
            self.signatureLabel.attributedText = string;
            NSLog(@"found at location = %d, length = %d",range2.location,range2.length);
            
        }else{
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.summary]; ;
            self.signatureLabel.attributedText = string;
            NSLog(@"Not Found");
            
        }

    }
        else
        {
            self.signatureLabel.text= model.summary;
        }
    
    
    
//    self.titleLabel.text =model.groupName;
//    self.signatureLabel.text= model.groupDesc;
     NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    

}


// 人分组
- (void)configSeperatePeopleCellWithModel:(FindSearchModelDetailModel *)model {
    
    [self.headerImage sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    
     if (model.userName.length!=0)
     {
    
    NSRange range;
    
    range = [model.userName rangeOfString:[SearchTextManger shareInstance].searchText];
    
    
    if (range.location != NSNotFound) {
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.userName]; ;
        
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        
        self.titleLabel.attributedText = string;
        NSLog(@"found at location = %d, length = %d",range.location,range.length);
        
    }else{
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.userName]; ;
        self.titleLabel.attributedText = string;
        NSLog(@"Not Found");
  
    }
     }else
     {
          self.titleLabel.text = model.userName;
     }
    

    
    if (model.remark.length!=0) {
        NSRange  range2 = [model.remark rangeOfString:[SearchTextManger shareInstance].searchText];
        
        if (range2.location != NSNotFound) {
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.remark]; ;
            
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
            
            self.signatureLabel.attributedText = string;
            NSLog(@"found at location = %d, length = %d",range2.location,range2.length);
            
        }else{
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.remark]; ;
            self.signatureLabel.attributedText = string;
            NSLog(@"Not Found");
            
        }

    }
    else
    {
        self.signatureLabel.text = model.remark;
    }
    
    
    
    
//    self.titleLabel.text = model.userName;
    
    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];
    
//    [self.headImageView sd_setImageWithURL:[model.avatar lkbImageUrl] placeholderImage:YQNormalPlaceImage];
//    self.nameLable.text = model.groupName;
//    NSString *remindStr = @"怎样缓解眼睛疲劳，保护视力，保护眼睛健康。上班族，整天对着电脑，眼睛发";
//    [NSString stringWithFormat:@"%@ %@",@"结婚纪念日",@"还有8天"];
//    self.adressLable.text= model.groupDesc;
//    NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:remindStr];
//    [remAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(remAttributedStr.length-2, 1)];

}


- (void)configureSubview {
    
    [self.contentView addSubview:self.headerImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.signatureLabel];
}

-(UIImageView *)headerImage {
    
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 60, 60)];
        _headerImage.clipsToBounds = YES;
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = 30;
        _headerImage.contentMode = UIViewContentModeScaleAspectFill;

    }
    return _headerImage;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, SCREEN_WIDTH -100, 25)];
        _titleLabel.textColor = [UIColor titleColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UILabel *)signatureLabel {
    
    if (!_signatureLabel) {
        _signatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, SCREEN_WIDTH -100, 25)];
        _signatureLabel.textColor = [UIColor blackColor];
        _signatureLabel.font = [UIFont systemFontOfSize:12];
    }
    return _signatureLabel;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
