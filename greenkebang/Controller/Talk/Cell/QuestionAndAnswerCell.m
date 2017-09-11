//
//  QuestionAndAnswerCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/30.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "QuestionAndAnswerCell.h"


#define Start_X 12.0f           // 第一个按钮的X坐标
#define Start_Y 14.0f           // 第一个按钮的Y坐标
#define Width_Space 14.0f        // 2个按钮之间的横间距
#define Button_Height 20.0f    // 高
#define Button_Width 20.0f      // 宽

@implementation QuestionAndAnswerCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configureSubview];
        
    }
    return self;
}


-(void)configureSubview {
    
    _headerImage = [[UIImageView alloc] init];
    _headerImage.frame = CGRectMake(12,14,20,20);
    _headerImage.backgroundColor = [UIColor cyanColor];
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = Button_Width / 2;
    [self.contentView addSubview:_headerImage];
    
    _headerImage_2 = [[UIImageView alloc] init];
    _headerImage_2.frame = CGRectMake(24 +2,14,20,20);
    _headerImage_2.backgroundColor = [UIColor cyanColor];
    _headerImage_2.layer.masksToBounds = YES;
    _headerImage_2.layer.cornerRadius = Button_Width / 2;
    [self.contentView addSubview:_headerImage_2];
    
    _headerImage_3 = [[UIImageView alloc] init];
    _headerImage_3.frame = CGRectMake(36,14,20,20);
    _headerImage_3.backgroundColor = [UIColor cyanColor];
    _headerImage_3.layer.masksToBounds = YES;
    _headerImage_3.layer.cornerRadius = Button_Width / 2;
    [self.contentView addSubview:_headerImage_3];


    _headerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth - 24, 34)];
//    _headerButton.backgroundColor = [UIColor clearColor];
    _headerButton.backgroundColor = [UIColor clearColor];

    [_headerButton addTarget:self action:@selector(headerImageButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 34)];
    View.backgroundColor = [UIColor cyanColor];
    
    [View addSubview:_headerButton];
    
    [self.contentView addSubview:_headerButton];

    _answerLabel = [[UILabel alloc]initWithFrame: CGRectMake(64,5, kDeviceWidth, 34)];
    _answerLabel.textColor = CCCUIColorFromHex(0x999999);
    _answerLabel.font = [UIFont systemFontOfSize:12];
//    _answerLabel.text = @"邀请你回答";
    [self.contentView addSubview:_answerLabel];


    _titleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 34, kDeviceWidth -50, 45)];
    
//    _titleButton.backgroundColor = [UIColor blackColor];
    _titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    _titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_titleButton setTitleColor:CCCUIColorFromHex(0x333333) forState:UIControlStateNormal];
    [_titleButton addTarget:self action:@selector(titleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_titleButton];
    
    
    _redImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 38 - 9, 52, 9, 9)];
    [_redImage setImage:[UIImage imageNamed:@"tabBardot"]];
    
    [self.contentView addSubview:_redImage];
    
    _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 79, kDeviceWidth, 0.5)];
    _lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    
    [self.contentView addSubview:_lineView];


}

- (void)handlerButtonAction:(BottomBuyClickBlock)block {
    
    self.clickBlock = block;
}


-(void)headerImageButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }
    
}

-(void)titleButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(2);
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
