//
//  DynamicNoticeCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "DynamicNoticeCell.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"
#import "UIImage+HBClass.h"
#import "UIImage+EMWebP.h"
@implementation DynamicNoticeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configureSubview];
        
    }
    return self;
}


- (void)configSingelGetNoticeTableCellWithGoodModel:(GetDetailNoticeModel *)admirGood {
    
    UIImageView *headerImage = [[UIImageView alloc]init];
    
    
    [headerImage sd_setImageWithURL:[admirGood.avatar lkbImageUrl4] placeholderImage:LKBUserInvitePlaceImage];

        [_headerButton setImage:headerImage.image forState:UIControlStateNormal];
    UILabel *nameLabel = [[UILabel alloc]init];
    
    nameLabel.text = [NSString stringWithFormat:@"%@",admirGood.userName];
    
    NSString *str = [NSString stringWithFormat:@"%@",admirGood.userName];
    CGSize size = [str sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, nameLabel.frame.size.height)];
    
    

    [_nameButton setTitle:nameLabel.text forState:UIControlStateNormal];
    
    if (size.width > 90) {
        
        [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.contentView).offset(15);
            make.left.mas_equalTo(_headerButton.right).offset(10);
            make.width.mas_equalTo(90 );
            
        }];
    }
    else {
        
        [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.contentView).offset(15);
            make.left.mas_equalTo(_headerButton.right).offset(10);
            make.width.mas_equalTo(size.width +6 );
            
        }];
    }
    
    

    


    
    if ([admirGood.objType isEqualToString:@"0"]) {
        // 回答
        _answerLabel.text = @"评论了你关注的动态";
    }
    else {
        // 话题
        _answerLabel.text = @"评论了你关注的动态";
        
    }
    // 时间设置
    NSTimeInterval time=[admirGood.noticeDate doubleValue];
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:time];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[createDate timeAgo]];
    
    [_titleButton setTitle:[NSString stringWithFormat:@"%@",admirGood.objTitle] forState:UIControlStateNormal];


    
    
    
    
}
-(void)configureSubview {
    
    [self.contentView addSubview:self.headerButton];
    [self.contentView addSubview:self.nameButton];
    [self.contentView addSubview:self.answerLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.titleButton];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.unreadImage];

}


- (void)updateConstraints {
    
    if (!self.didSetupConstraints) {
        
        // 头像
        [_headerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(15);
            make.left.mas_equalTo(self.contentView).offset(12);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            
        }];
        
//        [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.mas_equalTo(self.contentView).offset(15);
//            make.left.mas_equalTo(_headerButton.right).offset(10);
//            make.width.mas_equalTo(90);
//            
//        }];
        
        [_answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.contentView).offset(15);
            make.left.mas_equalTo(_nameButton.right).offset(0);
            make.right.mas_equalTo(_timeLabel.left).offset(10);
            make.height.mas_equalTo(30);
            
        }];

        
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20);
            make.right.offset(-12);
            make.size.mas_equalTo(CGSizeMake(80, 20));
            
        }];
        
        [_titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headerButton.bottom).offset(0);
            make.right.mas_equalTo(self.contentView).offset(-50);
            make.left.mas_equalTo(self.contentView).offset(12);
            make.height.mas_equalTo(45);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleButton.bottom).offset(0);
            make.right.offset(0);
            make.left.offset(0);
            make.height.mas_equalTo(0.5);
            //        make.width.mas_equalTo(SCREEN_WIDTH /5);
            
        }];
        
        
        self.didSetupConstraints = YES;
        
    }
    
    [super updateConstraints];
}


- (UIButton *)headerButton {
    
    if (!_headerButton) {
        _headerButton = [[UIButton alloc]init];
        _headerButton.layer.masksToBounds = YES;
        _headerButton.layer.cornerRadius = 15;
        [_headerButton addTarget:self action:@selector(headerButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerButton;
    
}


- (UIButton *)nameButton {
    
    if (!_nameButton) {
        _nameButton = [[UIButton alloc]init];
        _nameButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_nameButton addTarget:self action:@selector(nameButton:) forControlEvents:UIControlEventTouchUpInside];
        _nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _nameButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _nameButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_nameButton setTitleColor:CCCUIColorFromHex(0x333333) forState:UIControlStateNormal];
    }
    return _nameButton;
}

- (UILabel *)answerLabel {
    
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc]init];
        _answerLabel.textColor =CCCUIColorFromHex(0x999999);
        _answerLabel.font = [UIFont systemFontOfSize:12];
        _answerLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _answerLabel;
}



- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor =CCCUIColorFromHex(0x999999);
        _timeLabel.font = [UIFont systemFontOfSize:12];
        //        _timeLabel.text= @"时间2233";
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}







- (UIButton *)titleButton {
    
    if (!_titleButton) {
        _titleButton = [[UIButton alloc]init];
        
        _titleButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_titleButton setTitleColor:CCCUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_titleButton setContentEdgeInsets:UIEdgeInsetsMake(0,0, 0, 10)];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_titleButton addTarget:self action:@selector(titleButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleButton;
}


- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
        
    }
    return _lineView;
}


- (UIImageView *)unreadImage {
    
    if (!_unreadImage) {
        _unreadImage = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-19, 60 +4, 9, 9)];
        [_unreadImage setImage:[UIImage imageNamed:@"tabBardot"]];
        
        

    }
    return _unreadImage;
}


- (void)handlerButtonAction:(BottomBuyClickBlock)block {
    
    self.clickBlock = block;
}

-(void)headerButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }

}


-(void)nameButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(2);
    }

}

-(void)titleButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(3);
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
