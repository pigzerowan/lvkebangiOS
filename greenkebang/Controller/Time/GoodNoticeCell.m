//
//  GoodNoticeCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/26.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "GoodNoticeCell.h"
#import "ModelToDictionary.h"
#import <UIImageView+WebCache.h>

@implementation GoodNoticeCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        [self configureSubview];
        
    }
    
    return self;
}


- (void)configTimeGoodNoticeCellTimeNewDynamicDetailModel:(NewDynamicDetailModel *)model {
    
    
    NSLog(@"========================================%@",model.avatar);

    [_headerImage sd_setImageWithURL:[model.avatar lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];

    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    
    NSString * noticeType = [NSString stringWithFormat:@"LoginHomeViewController"];
    
    NSString *str = [userDefaultes objectForKey:noticeType];
    
    
    if ([str isEqualToString:@"isNewLogin"]) {
        
        
        NSMutableArray * dataArray = [[userDefaultes arrayForKey:@"isNewLoginModel"] mutableCopy];
        
        NSLog(@"========================================%lu",(unsigned long)dataArray.count);

        _numLabel.text = [NSString stringWithFormat:@"%lu条新消息",(unsigned long)dataArray.count];
    }
    else {
        
        NSMutableArray *myArray = [[userDefaultes arrayForKey:@"theGoodArr"] mutableCopy];
        _numLabel.text = [NSString stringWithFormat:@"%lu条新消息",(unsigned long)myArray.count];
        
        NSLog(@"========================================%lu",(unsigned long)myArray.count);


    }

    /*
     {
     msg = "\U70b9\U8d5e\U901a\U77e5";
     noticeName = "\U70b9\U8d5e\U901a\U77e5";
     noticeType = 5;
     object =     {
     avatar = "2016-08-20_s1PIqUUa.png";
     inviteAnswerNum = 0;
     noticeContent = "";
     objId = 960;
     objType = 1;
     userId = 128;
     userName = "\U5c0f\U82b1";
     };
     type = 0;
     }
     */

    
    
    
    
}


- (void)configureSubview
{
    
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.headerImage];
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.arrImage];

}

- (void)updateConstraints
{
    
    CGFloat padding = iPhone5_Before ? 13 : 15;
    if (!self.didSetupConstraints) {
        
        
        
        [_backView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(17);
            make.centerX.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(179, 40));
            
        }];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_backView.top).offset(4);
            make.left.mas_equalTo(_backView.left).offset(4);
            make.size.mas_equalTo(CGSizeMake(31, 31));
            
        }];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            
//            make.top.mas_equalTo(_backView.top).offset(4);
            make.centerY.mas_equalTo(_headerImage);
            make.left.mas_equalTo(_headerImage.right).offset(0);
            make.size.mas_equalTo(CGSizeMake(125,40));
            
        }];
        
        [_arrImage mas_makeConstraints:^(MASConstraintMaker* make) {
            
//            make.top.mas_equalTo(_backView.top).offset(4);
            make.centerY.mas_equalTo(_headerImage);

            make.right.mas_equalTo(_backView.right).offset(-13);
            make.size.mas_equalTo(CGSizeMake(5.5,9.5));
            
        }];


        
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


- (UIView *)backView {
    
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = CCCUIColorFromHex(0x505353);
        _backView.layer.cornerRadius = 20;
    }
    return _backView;
}


- (UIImageView *)headerImage {
    
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]init];
        _headerImage.backgroundColor = CCCUIColorFromHex(0xdddddd);
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = 15.5;
    }
    return _headerImage;
}

- (UILabel *)numLabel {
    
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        _numLabel.textColor = CCCUIColorFromHex(0xffffff);
        _numLabel.font = [UIFont systemFontOfSize:14];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.text = @"2条新消息";
    }
    return _numLabel;
}

- (UIImageView *)arrImage {
    
    if (!_arrImage) {
        _arrImage = [[UIImageView alloc]init];
        _arrImage.image = [UIImage imageNamed:@"like_arrow"];
        
    }
    return _arrImage;
}



@end
