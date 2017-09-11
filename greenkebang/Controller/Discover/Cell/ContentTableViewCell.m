//
//  ContentTableViewCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/20.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "ContentTableViewCell.h"
#import "SearchTextManger.h"

@implementation ContentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
    }
    return self;
}

- (void)configSeperateContentCellWithModel:(FindSearchModelDetailModel *)model {
    
//    NSDictionary *dic = (NSDictionary *)model;
    
    
    if (model.title.length!=0) {
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
            
        }

    }else
    {
        self.titleLabel.text = model.title;
    }
    
    
    if (model.summary.length!=0) {
        NSRange  range2 = [model.summary rangeOfString:[SearchTextManger shareInstance].searchText];
        
        if (range2.location != NSNotFound) {
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.summary]; ;
            
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
            
            self.contentLabel.attributedText = string;
            NSLog(@"found at location = %d, length = %d",range2.location,range2.length);
            
        }else{
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.summary]; ;
            self.contentLabel.attributedText = string;
            
            NSLog(@"Not Found");
            
        }

    }
    else
    {
        self.contentLabel.text = model.summary;
    }
    
    
//    self.contentLabel.text = model.summary;
    

}


- (void)configureSubview {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-30, 25)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = [UIColor titleColor];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        //    _titleLabel.text = @"背景郊区创意农业发展的七大典型模式及其主要经营";
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-30, 40)];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.numberOfLines =2;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;

//            _contentLabel.text = @"背景郊区创意农业发展的七大典型模式及其主要经营5555555555555599999999999999999999977788888888888888888888888888888888888888888888888888888888888888888888888888888888888888855555555555555555555555555555555555555555555555";
    }
    return _contentLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
