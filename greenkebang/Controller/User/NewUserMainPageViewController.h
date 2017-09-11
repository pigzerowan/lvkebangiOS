//
//  NewUserMainPageViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 11/14/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

// 设置颜色
#define BXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define BXAlphaColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
/** BXImageH */
#define imageH [UIScreen mainScreen].bounds.size.width
@interface NewUserMainPageViewController : BaseViewController
@property (strong, nonatomic) NSArray *classArray;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *toUserId;
@property (nonatomic, strong) NSString *toUserName;
@property (nonatomic, strong) UIButton *OpenButton;
@property (nonatomic, strong) UILabel *describeLabel;
@property (strong, nonatomic) UIButton *setUpButton;// 设置按钮
@property (strong, nonatomic) UIButton *shareButton;// 分享按钮
@property (nonatomic, strong) NSString *headerDescribl;
@property (strong, nonatomic) UIButton *chatButton;// 聊天按钮

@property (strong, nonatomic) UIButton *attentionButton;// 关注按钮
@property (nonatomic, strong) NSString *ifAttention;
@property (nonatomic, strong) NSString *userInforRemark;
@property (nonatomic, strong) UILabel *titleText;

@property (strong, nonatomic) NSString *toName;
@property (strong, nonatomic) NSString *userAvatar;// 用户头像
@property (strong, nonatomic) NSString *urlStr;
@property (strong, nonatomic) NSString *shareCover;// 分享字典里的图片

@end
