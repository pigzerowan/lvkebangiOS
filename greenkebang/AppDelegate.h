//
//  AppDelegate.h
//  greenkebang
//
//  Created by 郑渊文 on 8/25/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ApplyViewController.h"
#import "IChatManagerDelegate.h"
#import "LKBBaseTabBarController.h"
#import "LKBUserBaseTabbarController.h"
#import "GeTuiSdk.h"

#define kGtAppId           @"nJHTHnj3ud8Tzs2L62Wzq4"
#define kGtAppKey          @"UVsocldNpz5nFLVaYyT3c8"
#define kGtAppSecret       @"jCRikNpkLm6Ur5vgzygNl5"



typedef void (^ReturnMyInfoBlock)(NSString *code);
@interface AppDelegate : UIResponder <UIApplicationDelegate,IChatManagerDelegate,GeTuiSdkDelegate>
{
    EMConnectionState _connectionState;
}

+(AppDelegate *)shareInstance;
@property(nonatomic,copy)NSString *access_token;
@property(nonatomic,copy)NSString *openid;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,strong)UIImageView *wxHeadImg;
@property (nonatomic,strong)LKBBaseTabBarController *lkbbaseVc;
@property (nonatomic,strong)LKBUserBaseTabbarController *lkbUserbaseVc;
@property (strong, nonatomic) UIWindow *window;
@property (copy, nonatomic) NSString *wxcode;
@property (strong, nonatomic) NSDictionary *myInfoDic;
@property (strong, nonatomic) NSDictionary *userInfo;
@property (strong, nonatomic) NSDictionary *noticeInfoDic;

@property (strong, nonatomic) LKBBaseTabBarController *mainController;


@property (nonatomic, copy) ReturnMyInfoBlock returnTextBlock;

- (void)returnText:(ReturnMyInfoBlock)block;

- (void)showUserTabBarViewController;
- (void)showUserBaseTabBarViewController;
//- (void)showUserTabBarViewController2;

@end

