//
//  NewsCommentCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/30.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "NewsCommentCell.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"
#import "UIImage+HBClass.h"
#import "UIImage+EMWebP.h"
@implementation NewsCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configureSubview];
        
    }
    return self;
}


- (void)configSingelGetCommentTableCellWithGoodModel:(GetDetailCommentModel *)admirGood {
    

    
    _btnImage = [[UIImageView alloc]init];
    
   [_btnImage sd_setImageWithURL:[admirGood.avatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    if ([admirGood.avatar isEqualToString:@"" ] || admirGood.avatar == nil) {
        
        [_headerButton setImage:_btnImage.image forState:UIControlStateNormal];
    }
    else {
        [_headerButton setImage:_btnImage.image forState:UIControlStateNormal];
    }

    
    self.nameLabel.text = admirGood.userName;
    
    
    // 时间设置
    NSTimeInterval time=[admirGood.commentDate doubleValue];
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:time];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[createDate timeAgo]];
    

    self.commentLabel.text = admirGood.content;
    
    if (admirGood.commentType == 1) {
        _titleType  =@"评论了我的专栏文章:";
        [self.titleButton setTitle:[NSString stringWithFormat:@"%@%@",_titleType,admirGood.summary] forState:UIControlStateNormal];

    }
    if (admirGood.commentType == 2||admirGood.commentType == 3) {
        _titleType  =@"评论了我的动态:";
        [self.titleButton setTitle:[NSString stringWithFormat:@"%@%@",_titleType,admirGood.summary] forState:UIControlStateNormal];

    }
    if (admirGood.commentType == 4 || admirGood.commentType == 6) {
        _titleType  =@"回复了我的评论:";
        
        [self.titleButton setTitle:[NSString stringWithFormat:@"%@%@",_titleType,admirGood.parentReply] forState:UIControlStateNormal];

    }


    
    
    
}


-(void)configureSubview {
    
    [self.contentView addSubview:self.headerButton];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.commentLabel];
//    [self.contentView addSubview:self.replyImage];
    [self.contentView addSubview:self.replyButton];
    [self.contentView addSubview:self.titleButton];
    [self.contentView addSubview:self.lineView];

    



}


- (void)updateConstraints {
    
    if (!self.didSetupConstraints) {
        
        // 头像
        [_headerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(12);
            make.left.mas_equalTo(self.contentView).offset(12);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            //        make.width.mas_equalTo(SCREEN_WIDTH /5);
            
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.contentView).offset(15);
            make.left.mas_equalTo(_headerButton.right).offset(10);
//            make.size.mas_equalTo(CGSizeMake(80, 20));
            make.right.mas_equalTo(_timeLabel.left).offset(10);
            make.centerY.mas_equalTo(_headerButton);
            //        make.width.mas_equalTo(SCREEN_WIDTH /5);
            
        }];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(17);
            make.right.offset(-12);
            make.size.mas_equalTo(CGSizeMake(80, 20));
            //        make.width.mas_equalTo(SCREEN_WIDTH /5);
            
        }];
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headerButton.bottom).offset(10);
            make.left.offset(12);
            make.right.mas_equalTo(_replyButton.left).offset(-12);
            
        }];
//        [_replyImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_headerButton.bottom).offset(13);
//            make.right.mas_equalTo(_replyButton.left).offset(0);
//            make.size.mas_equalTo(CGSizeMake(13, 13));
//            
//        }];
        
        [_replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headerButton.bottom).offset(5);
            make.right.offset(-12);
            make.size.mas_equalTo(CGSizeMake(43, 25));
            //        make.width.mas_equalTo(SCREEN_WIDTH /5);
            
        }];
        [_titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_commentLabel.bottom).offset(8);
            make.right.offset(-12);
            make.left.offset(12);
            make.height.mas_equalTo(40);
            //        make.width.mas_equalTo(SCREEN_WIDTH /5);
            
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleButton.bottom).offset(15);
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
        _headerButton.backgroundColor = [UIColor lightGrayColor];
        _headerButton.layer.masksToBounds = YES;
        _headerButton.layer.cornerRadius = 15;
        [_headerButton addTarget:self action:@selector(headerButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerButton;
    
}

- (void)handlerButtonAction:(BottomBuyClickBlock)block {
    
    self.clickBlock = block;
}


-(void)headerButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }

}



- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = CCCUIColorFromHex(0x333333);
        _nameLabel.font = [UIFont systemFontOfSize:12];
//        _nameLabel.text = @"名字3333";
    }
    return _nameLabel;
}


- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor =CCCUIColorFromHex(0x888888);
        _timeLabel.font = [UIFont systemFontOfSize:12];
//        _timeLabel.text= @"时间2233";
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)commentLabel {
    
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.textColor = CCCUIColorFromHex(0x333333);
        _commentLabel.font = [UIFont systemFontOfSize:16];
//        _commentLabel.text = @"评论内容99999999999999999999999998887777";
    }
    return _commentLabel;
}


//- (UIImageView *)replyImage {
//    
//    if (!_replyImage) {
//        
//        _replyImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_icon_reply"]];
//        
//    }
//    return _replyImage;
//}



- (UIButton *)replyButton {
    
    if (!_replyButton) {
        _replyButton = [[UIButton alloc]init];
        
        [_replyButton setImage:[UIImage imageNamed:@"comment_icon_reply"] forState:UIControlStateNormal];
        
        _replyButton.imageEdgeInsets = UIEdgeInsetsMake(0,-1,0,6 );//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
        [_replyButton setTitle:@"回复" forState:UIControlStateNormal];
        _replyButton.titleEdgeInsets = UIEdgeInsetsMake(0, _replyButton.titleLabel.bounds.size.width-50, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
        [_replyButton setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
        _replyButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_replyButton addTarget:self action:@selector(replyButton:) forControlEvents:UIControlEventTouchUpInside];
        
         _replyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _replyButton;
}


-(void)replyButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(2);
    }
    
}


- (UIButton *)titleButton {
    
    if (!_titleButton) {
        _titleButton = [[UIButton alloc]init];
        
        if (iPhone5) {
            [_titleButton setBackgroundImage:[UIImage imageNamed:@"comment_bg_link_5"] forState:UIControlStateNormal];
        }
        if (iPhone6p) {
            [_titleButton setBackgroundImage:[UIImage imageNamed:@"comment_bg_link_6p"] forState:UIControlStateNormal];
        }
        else {
            [_titleButton setBackgroundImage:[UIImage imageNamed:@"comment_bg_link_6"] forState:UIControlStateNormal];

        }
        
//        [_titleButton setTitle:@"9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999" forState:UIControlStateNormal];
        _titleButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_titleButton setTitleColor:CCCUIColorFromHex(0x888888) forState:UIControlStateNormal];
        [_titleButton setContentEdgeInsets:UIEdgeInsetsMake(3,10, 0, 10)];//
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
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

-(void)titleButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(3);
    }
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
