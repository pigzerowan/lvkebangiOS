//
//  AgricultureCircleHeaderView.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/10/13.
//  Copyright © 2016年 transfar. All rights reserved.
//


#define Start_X 0.0f           // 第一个按钮的X坐标
#define Start_Y 15.0f           // 第一个按钮的Y坐标
#define Width_Space 10.0f        // 2个按钮之间的横间距
#define Height_Space 10.0f      // 竖间距

#define Button_Height 30.0f    // 高
#define Button_Width 30.0f      // 宽

#import "AgricultureCircleHeaderView.h"
#import <UIImageView+WebCache.h>

@implementation AgricultureCircleHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
        return nil;
    [self configureSubview];
    
    return self;
}

- (void)configAgricultureCircleHeaderViewWithModel:(NewTimeDynamicModel*)model {
    
    UIImageView * headerImage = [[UIImageView alloc]init];
    [headerImage sd_setImageWithURL:[[model.object valueForKey:@"groupAvatar"] lkbImageUrl5] placeholderImage:YQNormalPlaceImage];
    [_headImageButton setImage:headerImage.image forState:UIControlStateNormal];

//    [_blurImageView sd_setImageWithURL:[[model.object valueForKey:@"groupAvatar"] lkbImageUrl5] placeholderImage:YQNormalPlaceImage];

    _nameLabel.text = [model.object valueForKey:@"groupName"];
    _memberNumLabel.text = [NSString stringWithFormat:@"成员 %@    动态 %@",[model.object valueForKey:@"memberNum"],[model.object valueForKey:@"topicNum"]];
    
    if ([[model.object valueForKey:@"isJoin"] isEqualToString:@"0"]) {
        
        _joinButton.hidden = YES;
        _circleIntNameLabel.text = @"圈子成员";
        _circleIntroduceLabel.hidden = YES;
        _memberInviteButton.hidden = NO;
        _memberNum.hidden = NO;
        _memberNum.text = [NSString stringWithFormat:@"%@",[model.object valueForKey:@"memberNum"]];
        _memberNumImage.hidden = NO;
        _memberInviteButton.hidden = NO;
        _memberView.hidden = NO;


        
        [_headImageButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(58);
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(77, 77));
        }];
        
        [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headImageButton.bottom).offset(14);
            make.centerX.mas_equalTo(self);
            make.right.left.mas_equalTo(self);
            make.height.mas_equalTo(18);
        }];
        [_memberNumLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.bottom).offset(10);
            make.centerX.mas_equalTo(self);
            make.right.left.mas_equalTo(self);
            make.height.mas_equalTo(18);
        }];
        
        _avatarsArray = [NSArray arrayWithArray:[model.object valueForKey:@"avatars"]];
        
        NSLog(@"----------------%@",_avatarsArray);
        
        if (iPhone5) {
            
            if (_avatarsArray.count == 6) {
               
                for (int i = 0 ; i < _avatarsArray.count -1; i++) {
                    
                    NSInteger index = 1/ 2;
                    
                    NSInteger page = i;
                    
                    // 图片
                    _avatarImage = [[UIImageView alloc]init];
                    
                    [_avatarImage sd_setImageWithURL:[_avatarsArray[i] lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
                    
                    _avatarImage.frame = CGRectMake(page * (Button_Width + Width_Space) + Start_X, index  * (Button_Height + Height_Space)+Start_Y , Button_Width, Button_Height);
                    _avatarImage.backgroundColor = [UIColor grayColor];
                    _avatarImage.layer.masksToBounds = YES;
                    _avatarImage.layer.cornerRadius = Button_Width / 2;
                    _avatarImage.hidden = NO;
                    
                    [_memberView addSubview:_avatarImage];
                    
                }
                


            }
            else {
                
                for (int i = 0 ; i < _avatarsArray.count ; i++) {
                    
                    NSInteger index = 1/ 2;
                    
                    NSInteger page = i;
                    
                    // 图片
                    _avatarImage = [[UIImageView alloc]init];
                    
                    [_avatarImage sd_setImageWithURL:[_avatarsArray[i] lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
                    
                    _avatarImage.frame = CGRectMake(page * (Button_Width + Width_Space) + Start_X, index  * (Button_Height + Height_Space)+Start_Y , Button_Width, Button_Height);
                    _avatarImage.backgroundColor = [UIColor grayColor];
                    _avatarImage.layer.masksToBounds = YES;
                    _avatarImage.layer.cornerRadius = Button_Width / 2;
                    _avatarImage.hidden = NO;
                    
                    [_memberView addSubview:_avatarImage];
                    
                }
                

            }
                
            

        }
        else {
            for (int i = 0 ; i < _avatarsArray.count; i++) {
                
                
                NSInteger index = 1/ 2;
                
                NSInteger page = i;
                
                // 图片
                _avatarImage = [[UIImageView alloc]init];
                
                [_avatarImage sd_setImageWithURL:[_avatarsArray[i] lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
                
                _avatarImage.frame = CGRectMake(page * (Button_Width + Width_Space) + Start_X, index  * (Button_Height + Height_Space)+Start_Y , Button_Width, Button_Height);
                _avatarImage.backgroundColor = [UIColor grayColor];
                _avatarImage.layer.masksToBounds = YES;
                _avatarImage.layer.cornerRadius = Button_Width / 2;
                _avatarImage.hidden = NO;
                [_memberView addSubview:_avatarImage];
                
            }

            
        }

    }
    else {
        
        _joinButton.hidden = NO;
        _circleIntNameLabel.text = @"圈子简介";
        _circleIntroduceLabel.hidden = NO;
        _circleIntroduceLabel.text = [model.object valueForKey:@"groupDesc"];
        _memberInviteButton.hidden = YES;
        _memberNum.hidden = YES;
        _memberNumImage.hidden = YES;
        _memberInviteButton.hidden = YES;
        _memberView.hidden = YES;
        
        
        [_headImageButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(48);
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(77, 77));
        }];
        
        [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headImageButton.bottom).offset(14);
            make.centerX.mas_equalTo(self);
            make.right.left.mas_equalTo(self);
            make.height.mas_equalTo(18);
        }];
        [_memberNumLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.bottom).offset(10);
            make.centerX.mas_equalTo(self);
            make.right.left.mas_equalTo(self);
            make.height.mas_equalTo(18);
        }];


    }
    

    
    
    
}


- (void)configureSubview
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.blurImageView];
//    [self.blurImageView addSubview:self.visualEffectView];
//    [self.visualEffectView.contentView addSubview:self.blurImageBackView];
//    [self addSubview:self.navBackButton];
//    [self addSubview:self.topmenubtn];
    [self addSubview:self.headImageButton];
    [self addSubview:self.nameLabel];
    [self addSubview:self.memberNumLabel];
    [self addSubview:self.circleBackView];
    [self addSubview:self.circleIntNameLabel];
    [self addSubview:self.circleIntroduceLabel];
    [self addSubview:self.joinButton];
    [self addSubview:self.memberNum];
    [self addSubview:self.memberNumImage];
    [self addSubview:self.circleIntNameLabel];
    [self addSubview:self.memberView];
    [self addSubview:self.circleIntroduceButton];
    [self addSubview:self.memberInviteButton];
    [self addSubview:self.joinButton];


//    [_navBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self).offset(36);
//        make.left.mas_equalTo(self).offset (14);
//        make.width.height.mas_equalTo(22);
//        
//    }];
//    [_topmenubtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self).offset(36);
//        make.right.mas_equalTo(self).offset (-14);
//        make.width.height.mas_equalTo(22);
//        
//    }];
//    
    [_blurImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self);
        make.height.mas_equalTo(210);
        
    }];
//    [_visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.left.mas_equalTo(self);
//        make.height.mas_equalTo(210);
//        
//    }];
//    [_blurImageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.left.mas_equalTo(self);
//        make.height.mas_equalTo(210);
//        
//    }];


    [_headImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(48);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(77, 77));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageButton.bottom).offset(17);
        make.centerX.mas_equalTo(self);
        make.right.left.mas_equalTo(self);
        make.height.mas_equalTo(18);
    }];
    [_memberNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.bottom).offset(10);
        make.centerX.mas_equalTo(self);
        make.right.left.mas_equalTo(self);
        make.height.mas_equalTo(18);
    }];
    
    [_circleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_blurImageView.bottom).offset(0);
        make.right.left.mas_equalTo(self);
        make.height.mas_equalTo(95);
        
    }];

    [_joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(186.5);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(95, 51));
    }];
    
    
    [_circleIntNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_blurImageView.bottom).offset(20);
        make.right.left.mas_equalTo(self).offset(14);
        make.height.mas_equalTo(16);

    }];
    [_circleIntroduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_circleIntNameLabel.bottom).offset(10);
        make.left.mas_equalTo(self).offset(14);
        make.right.mas_equalTo(self).offset(-14);

//        make.height.mas_equalTo(16);
    }];
    
    [_circleIntroduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_blurImageView.bottom).offset(0);
        make.right.left.mas_equalTo(self).offset(0);
        make.height.mas_equalTo(95);
    }];
    
    
    [_memberNumImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self).offset(188);
        make.centerY.mas_equalTo(_circleIntNameLabel);
        make.right.mas_equalTo(self.right).offset(-18);

        make.size.mas_equalTo(CGSizeMake(6,10.5));
    }];
    
    [_memberNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_circleIntNameLabel);
        make.right.mas_equalTo(_memberNumImage.left).offset(-8);
        make.height.mas_equalTo(14);
    }];
    
    [_memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_circleIntNameLabel.bottom).offset(0);
        make.left.mas_equalTo(_circleIntNameLabel);
        make.right.mas_equalTo(_memberInviteButton).offset(0);
        make.height.mas_equalTo(60);
    }];
    
    [_memberInviteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_circleIntroduceButton).offset(16.5);
        make.right.mas_equalTo(self.right).offset(-14);
        make.size.mas_equalTo(CGSizeMake(60, 26));
    }];

}

- (UIImageView *)blurImageView {
    
    if (!_blurImageView) {
        _blurImageView = [[UIImageView alloc]init];
        _blurImageView.backgroundColor = [UIColor clearColor];
//        [_blurImageView setImage:YQNormalPlaceImage];

    }
    return _blurImageView;
}

//- (UIVisualEffectView *)visualEffectView {
//    
//    if (!_visualEffectView) {
//        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//        _visualEffectView.alpha = 0.8;
//
//    }
//    return _visualEffectView;
//}
//
//- (UIView *)blurImageBackView {
//    
//    if (!_blurImageBackView) {
//        _blurImageBackView = [[UIView alloc]init];
//        _blurImageBackView.backgroundColor = [UIColor blackColor];
//        _blurImageBackView.alpha = 0.1;
//        
//    }
//    return _blurImageBackView;
//}



- (UIButton *)headImageButton {
    
    if (!_headImageButton) {
        _headImageButton = [[UIButton alloc]init];
        _headImageButton.backgroundColor = [UIColor whiteColor];
        CALayer *cicleLayer = [_headImageButton layer];
        [cicleLayer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [cicleLayer setCornerRadius:38.5];
        //设置边框线的宽
        [cicleLayer setBorderWidth:1];
        //设置边框线的颜色
        [cicleLayer setBorderColor:[UIColor whiteColor].CGColor];
        [_headImageButton addTarget:self action:@selector(headImageButton:) forControlEvents:UIControlEventTouchUpInside];
        _headImageButton.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _headImageButton.imageView.clipsToBounds = YES;
        _headImageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;

    }
    return _headImageButton;
}

- (void)handlerButtonAction:(AgricultureCircleToClickBlock)block {
    
    self.AgricultureClickBlock = block;

}


-(void)headImageButton:(id)sender{
    
    if (self.AgricultureClickBlock) {
        self.AgricultureClickBlock(2);
    }

    
}

- (UIButton *)navBackButton {
    
    if (!_navBackButton) {
        
        _navBackButton = [[UIButton alloc]init];
        [_navBackButton setImage:[UIImage imageNamed:@"nav_back_write_nor"] forState:UIControlStateNormal];
        [_navBackButton addTarget:self action:@selector(navBackButton:) forControlEvents:UIControlEventTouchUpInside];


    }
    return _navBackButton;
}
-(void)navBackButton:(id)sender{
    
    if (self.AgricultureClickBlock) {
        self.AgricultureClickBlock(1);
    }
}


- (UIButton *)topmenubtn {
    
    if (!_topmenubtn) {
        _topmenubtn = [[UIButton alloc]init];
        [_topmenubtn setImage:[UIImage imageNamed:@"topmenubtn"] forState:UIControlStateNormal];
        [_topmenubtn addTarget:self action:@selector(topmenubtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topmenubtn;
}

-(void)topmenubtn:(id)sender{
    
    if (self.AgricultureClickBlock) {
        self.AgricultureClickBlock(3);
    }
}





- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:18];
//        _nameLabel.text = @"有机农业";
        
    }
    return _nameLabel;
}

// memberNumLabel
- (UILabel *)memberNumLabel {
    
    if (!_memberNumLabel) {
        
        _memberNumLabel = [[UILabel alloc]init];
        _memberNumLabel.textColor = [UIColor whiteColor];
        _memberNumLabel.textAlignment = NSTextAlignmentCenter;
        _memberNumLabel.font = [UIFont systemFontOfSize:12];

        
    }
    return _memberNumLabel;

}

- (UIButton *)joinButton {
    
    if (!_joinButton) {
        _joinButton = [[UIButton alloc]init];
        [_joinButton setImage:[UIImage imageNamed:@"CircleJoin"] forState:UIControlStateNormal];
        _joinButton.hidden = YES;
        [_joinButton addTarget:self action:@selector(joinButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinButton;
}

-(void)joinButton:(id)sender{
    
    
    if (self.AgricultureClickBlock) {
        self.AgricultureClickBlock(4);
    }

    
}

- (UIView *)circleBackView {
    
    if (!_circleBackView) {
        _circleBackView = [[UIView alloc]init];
        _circleBackView.backgroundColor = [UIColor whiteColor];
        
    }
    return _circleBackView;
}

- (UILabel *)circleIntNameLabel {
    
    if (!_circleIntNameLabel) {
        _circleIntNameLabel = [[UILabel alloc]init];
        _circleIntNameLabel.textColor = CCCUIColorFromHex(0x333333);
        _circleIntNameLabel.font = [UIFont systemFontOfSize:16];
        _circleIntNameLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _circleIntNameLabel;
}

- (UILabel *)circleIntroduceLabel {
    
    if (!_circleIntroduceLabel) {
        _circleIntroduceLabel = [[UILabel alloc]init];
        _circleIntroduceLabel.textColor = CCCUIColorFromHex(0x999999);
        _circleIntroduceLabel.font = [UIFont systemFontOfSize:14];
        _circleIntroduceLabel.numberOfLines = 2;
        
    }
    return _circleIntroduceLabel;

}


- (UIButton *)circleIntroduceButton {
    
    if (!_circleIntroduceButton) {
        _circleIntroduceButton = [[UIButton alloc]init];
        _circleIntroduceButton.backgroundColor = [UIColor clearColor];
        [_circleIntroduceButton addTarget:self action:@selector(circleIntroduceButton:) forControlEvents:UIControlEventTouchUpInside];

        
    }
    return _circleIntroduceButton;

}
-(void)circleIntroduceButton:(id)sender{
    
    
    if (self.AgricultureClickBlock) {
        self.AgricultureClickBlock(5);
    }
    
    
}




- (UIImageView *)memberNumImage {
    
    if (!_memberNumImage) {
        _memberNumImage = [[UIImageView alloc]init];
        _memberNumImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        _memberNumImage.hidden = YES;
        
    }
    return _memberNumImage;
}

- (UILabel *)memberNum {
    
    if (!_memberNum) {
        _memberNum = [[UILabel alloc]init];
        _memberNum.textAlignment = NSTextAlignmentRight;
        _memberNum.textColor = CCCUIColorFromHex(0x999999);
        _memberNum.font = [UIFont systemFontOfSize:14];
    }
    return _memberNum;

}

- (UIView *)memberView {
    
    if (!_memberView) {
        _memberView = [[UIButton alloc]init];
        _memberView.backgroundColor = [UIColor clearColor];
    }
    return _memberView;

    
}

- (UIButton *)memberInviteButton {
    
    if (!_memberInviteButton) {
        _memberInviteButton = [[UIButton alloc]init];
        [_memberInviteButton setImage:[UIImage imageNamed:@"CircleShare"] forState:UIControlStateNormal];
        _memberInviteButton.hidden = YES;
        [_memberInviteButton addTarget:self action:@selector(memberInviteButton:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _memberInviteButton;
}

-(void)memberInviteButton:(id)sender{
    
    
    if (self.AgricultureClickBlock) {
        self.AgricultureClickBlock(6);
    }
    
    
}




@end
