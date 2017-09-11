//
//  UserRootViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/19.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"



@interface UserRootViewController : BaseViewController<UIScrollViewDelegate>
@property (strong, nonatomic) NSArray *classArray;
@property (nonatomic, strong) HeaderView *headerView;

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
