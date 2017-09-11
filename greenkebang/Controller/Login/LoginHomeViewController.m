//
//  LoginHomeViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 15/12/1.
//  Copyright © 2015年 transfar. All rights reserved.
//

#import "LoginHomeViewController.h"
#import "LKBPrefixHeader.pch"
#import "AccountLoginViewController.h"
#import "WXApi.h"
#import "AccountRegisterViewController.h"
#import "QQPlugin.h"
#import "WechatPlugin.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "LKBVenderDefine.h"
#import "WeiboSDK.h"
#import "WeiboPlugin.h"
#import "MyUserInfoManager.h"
#import "GroupModel.h"
#import <EAIntroView.h>
#import "UIImage+HBClass.h"
#import "SelectedRecommendViewController.h"
static const NSInteger kWxLoginButtonTag = 1000;
static const NSInteger kSinaLoginButtonTag = 1001;
static const NSInteger kQqLoginButtonTag = 1002;
@interface LoginHomeViewController ()<MBProgressHUDDelegate>

{
    QQPlugin *qqPlugin;
    WechatPlugin *wechatPlugin;
    WeiboPlugin *weiboPlugin;
    BOOL weixinInstalled;
    BOOL qqInstalled;
    BOOL weiboInstalled;
    NSDictionary *userInfo;
     EMPushNotificationNoDisturbStatus _noDisturbingStatus;
}
@property (nonatomic, strong) UIImageView * backgroundImage ;
@property (nonatomic, strong) UIButton * accountImage ;
@property (strong, nonatomic) UIView *rootView;
@property (nonatomic, strong) UIButton * qqImage;
@property (nonatomic, strong) UIButton * weiboImage;
@property (nonatomic, strong) UIButton * wechatImage;
@property (nonatomic, strong) UIButton * lookButton;
@property (nonatomic, strong) UIButton * RegisterButton;
@property (strong, nonatomic) NSMutableArray *groupArray;
@property (strong,nonatomic) MBProgressHUD * hud;

@end



@implementation LoginHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
//    self.navigationController.navigationBarHidden = NO;
// _groupArray = [NSMutableArray array];
    self.view.backgroundColor =  [UIColor whiteColor];
    
    [self initializePageSubviews];
    
    [self judgeShowIntroView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thirdLogSuccess:) name:kThirdLogInSuccessNoti object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thirdLogFailed:) name:kThirdLogInFailedNoti object:nil];
    
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];

    NSString * noticeType = [NSString stringWithFormat:@"LoginHomeViewController"];
    [userDefaults setObject:@"isNewLogin" forKey:noticeType];
    
    
    
    NSString *str = [userDefaults objectForKey:noticeType];

    NSLog(@"------------------------------%@",str);

    
    //    self.navigationTitle.textColor = SeaGreen;
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        weixinInstalled = YES;
    }
    else
    {
        weixinInstalled = NO;
    }
    
    //    if ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]) {
    qqInstalled = YES;
    //    }
    //    else
    //    {
    //        qqInstalled = NO;
    //    }
    
    //    if ([WeiboSDK isWeiboAppInstalled]
    //        && [[WeiboSDK getWeiboAppSupportMaxSDKVersion] floatValue] >= [[WeiboSDK getSDKVersion] floatValue]) {
    weiboInstalled = YES;

    
    // Do any additional setup after loading the view.
}


#pragma mark - Private methods
// 首次使用引导图
- (void)judgeShowIntroView
{
    NSUserDefaults *userInfoxx = [NSUserDefaults standardUserDefaults];
    if ([userInfoxx floatForKey:iYQUserVersionKey] < iYQUserVersion) {
        _rootView = self.navigationController.view;
        [self showIntroWithCustomView];
    }
    [userInfoxx setFloat:iYQUserVersion forKey:iYQUserVersionKey];
    [userInfoxx synchronize];
}

#pragma mark - 首次使用引导
- (void)showIntroWithCustomView {
    UIImage *pageBackgroundImage1 = [[UIImage alloc] init];
    UIImage *pageBackgroundImage2 = [[UIImage alloc] init];
    UIImage *pageBackgroundImage3 = [[UIImage alloc] init];
//    UIImage *pageBackgroundImage4 = [[UIImage alloc] init];
    if (iPhone4) {
        pageBackgroundImage1 = CCImageNamed(@"newIntroduction_1");
        pageBackgroundImage2 = CCImageNamed(@"newIntroduction_2");
        pageBackgroundImage3 = CCImageNamed(@"newIntroduction_3");
//        pageBackgroundImage4 = CCImageNamed(@"introduce_4");
    } else {
        pageBackgroundImage1 = CCImageNamed(@"newIntroduction_1");
        pageBackgroundImage2 = CCImageNamed(@"newIntroduction_2");
        pageBackgroundImage3 = CCImageNamed(@"newIntroduction_3");
//        pageBackgroundImage4 = CCImageNamed(@"introduce_4");
    }
    UIImageView *titleImagePage1 = [[UIImageView alloc] initWithImage:pageBackgroundImage1];
    UIImageView *titleImagePage2 = [[UIImageView alloc] initWithImage:pageBackgroundImage2];
    UIImageView *titleImagePage3 = [[UIImageView alloc] initWithImage:pageBackgroundImage3];
//    UIImageView *titleImagePage4 = [[UIImageView alloc] initWithImage:pageBackgroundImage4];
    
    EAIntroPage *page1 = [EAIntroPage pageWithCustomView:titleImagePage1];
    EAIntroPage *page2 = [EAIntroPage pageWithCustomView:titleImagePage2];
    EAIntroPage *page3 = [EAIntroPage pageWithCustomView:titleImagePage3];
//    EAIntroPage *page4 = [EAIntroPage pageWithCustomView:titleImagePage4];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:_rootView.bounds andPages:@[page1,page2,page3]];
//    intro.skipButton = [self skipButton];
//    intro.skipButtonAlignment = EAViewAlignmentCenter;
//    intro.showSkipButtonOnlyOnLastPage = YES;
    intro.skipButtonY = 100;
    intro.pageControl.hidden = YES;
    [intro showFullscreen];
}

- (void)intro:(EAIntroView *)introView pageAppeared:(EAIntroPage *)page withIndex:(NSUInteger)pageIndex
{
    
}
- (void)intro:(EAIntroView *)introView pageStartScrolling:(EAIntroPage *)page withIndex:(NSUInteger)pageIndex
{
    
}
- (UIButton *)skipButton
{
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skipButton.frame = CGRectMake(0, 0, 156, 34);
    skipButton.layer.masksToBounds = YES;
    skipButton.layer.cornerRadius = 4;
    skipButton.layer.borderWidth = 1;
    skipButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    skipButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [skipButton setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [skipButton setTitle:@"进入绿科邦" forState:UIControlStateNormal];
    return skipButton;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    
    // 隐藏导航下的线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self setEdgesForExtendedLayout:UIRectEdgeAll];


    [MobClick beginLogPageView:@"LoginHomeViewController"];

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;

    [MobClick endLogPageView:@"LoginHomeViewController"];

}


- (void)initializePageSubviews {
    
    [self.view addSubview:self.backgroundImage];
    [self.view addSubview:self.accountImage];
    [self.view addSubview:self.qqImage];
    [self.view addSubview:self.weiboImage];
    [self.view addSubview:self.wechatImage];
    [self.view addSubview:self.RegisterButton];
    
    //    CGFloat padding = iPhone4 ? 24 : 44;
    
    [_backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(KDeviceHeight *0.22);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(68);
    }];
    
    
    // 账户登录
    [_accountImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([_wechatImage isHidden]) {
            
            
            if (iPhone5) {
                //            make.top.mas_equalTo(_backgroundImage.bottom).offset(165);
                make.bottom.mas_equalTo(-82);
                //            make.size.mas_equalTo(CGSizeMake(56,56));
                make.right.mas_equalTo(self.view.centerX).offset(-70);
                //            make.right.mas_equalTo(_qqImage.left).offset(-16);
                //            make.left.mas_equalTo(19);
                
                //            make.width.mas_equalTo((kDeviceWidth -19 * 4) /3);
                
            }
            else {
                //            make.top.mas_equalTo(_backgroundImage.bottom).offset(165);
                make.bottom.mas_equalTo(-82);
                //            make.size.mas_equalTo(CGSizeMake(56,56));
                make.right.mas_equalTo(self.view.centerX).offset(-100);
                //            make.right.mas_equalTo(_qqImage.left).offset(-16);
                //            make.left.mas_equalTo(19);
                
                //            make.width.mas_equalTo((kDeviceWidth -19 * 4) /3);
                
            }
            
        }
        else{
            
            if (iPhone4) {
                make.top.mas_equalTo(_backgroundImage.bottom).offset(150);

            }
            else {
                make.top.mas_equalTo(_backgroundImage.bottom).offset(180.5);

            }
            make.left.mas_equalTo(self.view.left).offset(0);
            make.right.mas_equalTo(_qqImage.left).offset(0);
            make.bottom.mas_equalTo(self.view.bottom).offset(-82);
            make.width.mas_equalTo(kDeviceWidth /4 );
        }
    }];
    
    
    // QQ
    [_qqImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([_wechatImage isHidden]) {
            
//            make.top.mas_equalTo(_backgroundImage.mas_bottom).offset(165);
            make.bottom.mas_equalTo(self.view).offset(-82);
            make.centerX.mas_equalTo(self.view.centerX);
            //            make.size.mas_equalTo(CGSizeMake(56,56));
            //            make.left.mas_equalTo(_accountImage.mas_right).offset(19);
//            make.width.mas_equalTo((kDeviceWidth -19 * 4) /3);

        }
        else{
            if (iPhone4) {
                make.top.mas_equalTo(_backgroundImage.bottom).offset(150);
                
            }
            else {
                make.top.mas_equalTo(_backgroundImage.bottom).offset(180.5);
                
            }
            make.left.mas_equalTo(_accountImage.right).offset(0);
            make.right.mas_equalTo(_weiboImage.left).offset(0);
            make.width.mas_equalTo(kDeviceWidth /4 );
            make.bottom.mas_equalTo(self.view).offset(-82);
        }
    }];
    
    
    // 微博
    [_weiboImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([_wechatImage isHidden]) {
            
            if (iPhone5) {
                //            make.top.mas_equalTo(_backgroundImage.bottom).offset(165);
                make.bottom.mas_equalTo(-82);
                //            make.size.mas_equalTo(CGSizeMake(56,56));
                make.left.mas_equalTo(self.view.centerX).offset(70);
                //            make.right.mas_equalTo(-19);
                
                //            make.width.mas_equalTo((kDeviceWidth -19 * 4) /3);

            }
            
            else {
                //            make.top.mas_equalTo(_backgroundImage.bottom).offset(165);
                make.bottom.mas_equalTo(-82);
                //            make.size.mas_equalTo(CGSizeMake(56,56));
                make.left.mas_equalTo(self.view.centerX).offset(100);
                //            make.right.mas_equalTo(-19);
                
                //            make.width.mas_equalTo((kDeviceWidth -19 * 4) /3);

            }

            
        }

        else {
            if (iPhone4) {
                make.top.mas_equalTo(_backgroundImage.bottom).offset(150);
                
            }
            else {
                make.top.mas_equalTo(_backgroundImage.bottom).offset(180.5);
                
            }
            make.left.mas_equalTo(_qqImage.right).offset(0);
            make.right.mas_equalTo(_wechatImage.left).offset(0);
            make.width.mas_equalTo(kDeviceWidth /4 );
            make.bottom.mas_equalTo(self.view).offset(-82);
        }
    }];
    
    if (![_wechatImage isHidden]) {
        
        // 微信
        [_wechatImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (iPhone4) {
                make.top.mas_equalTo(_backgroundImage.bottom).offset(150);
                
            }
            else {
                make.top.mas_equalTo(_backgroundImage.bottom).offset(180.5);
                
            }
            make.left.mas_equalTo(_weiboImage.right).offset(0);
            make.right.mas_equalTo(self.view).offset(0);
            make.width.mas_equalTo(kDeviceWidth /4 );
            make.bottom.mas_equalTo(self.view).offset(-82);
        }];

    }

    
    
    // 随便看看
    [_lookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kDeviceWidth * 0.3);
//        make.size.mas_equalTo(CGSizeMake(80, 90));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(19);
    }];
    
    // 注册
    [_RegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).offset(kDeviceWidth * 0.5);
        make.centerX.mas_equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(70, 90));
        make.width.mas_equalTo(95);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-19);
    }];
    
    
}

- (UIImageView *)backgroundImage {
    
    _backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"slogan_5"]];
    _backgroundImage.contentMode = UIViewContentModeScaleToFill;
    
    return _backgroundImage;
}

// 账户
- (UIButton *)accountImage {
    
    _accountImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_accountImage setImage:[UIImage imageNamed:@"login_btn_account" ]forState:UIControlStateNormal];
    [_accountImage addTarget:self action:@selector(accountVCButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return _accountImage;
}

- (void)accountVCButton:(id)sender {
    
    [MobClick event:@"accountButtonEvent"];

    
    AccountLoginViewController *accountVC = [[AccountLoginViewController alloc]init];
    
    
    [self.navigationController pushViewController:accountVC animated:YES];
}


// QQ
- (UIButton *)qqImage {
    
    _qqImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_qqImage setImage:[UIImage imageNamed:@"login_btn_QQ"] forState:UIControlStateNormal];
    [_qqImage addTarget:self action:@selector(qqTapped:) forControlEvents:UIControlEventTouchUpInside];
//    if ([QQApi isQQInstalled]==NO) {
//        _qqImage.hidden = YES;
//    }

    return _qqImage;

}


- (void)qqTapped:(id)sender
{
    [MobClick event:@"QQButtonEvent"];

    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [self.view addSubview: self.hud];
    _hud.delegate = self;
    self.hud.labelText = @"正在登录...";
    
    [self.view bringSubviewToFront:self.hud];
    if (!qqPlugin) {
        qqPlugin = [[QQPlugin alloc] init];
    }
    [qqPlugin loginByQQ];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThirdLogInSuccessNoti object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThirdLogInFailedNoti object:nil];
}


- (void)wechatBtnTapped:(id)sender
{
    [MobClick event:@"wechatButtonEvent"];
    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [self.view addSubview: self.hud];
    _hud.delegate = self;
    self.hud.labelText = @"正在登录...";
    [self.view bringSubviewToFront:self.hud];

    if (!wechatPlugin) {
        wechatPlugin = [[WechatPlugin alloc] init];
    }
    [wechatPlugin loginByWechat];
    
}


// 微博
- (UIButton *)weiboImage {
    
    _weiboImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_weiboImage setImage:[UIImage imageNamed:@"login_btn_weibo"] forState:UIControlStateNormal];
    [_weiboImage addTarget:self action:@selector(weboBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
//    if ([WeiboSDK isWeiboAppInstalled]==NO) {
//        _weiboImage.hidden = YES;
//    }
    return _weiboImage;

}

- (void)weboBtnTapped:(id)sender
{
    [MobClick event:@"weboButtonEvent"];

    
    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [self.view addSubview: self.hud];
    _hud.delegate = self;
    self.hud.labelText = @"正在登录...";
    [self.view bringSubviewToFront:self.hud];
    
    if (!weiboPlugin) {
        weiboPlugin = [[WeiboPlugin alloc] init];
    }
    [weiboPlugin loginByWeibo];
    
}

// 微信
- (UIButton *)wechatImage {
    

    _wechatImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wechatImage setImage:[UIImage imageNamed:@"login_btn_weixin"] forState:UIControlStateNormal];
    _weiboImage.tag =kWxLoginButtonTag;
    [_wechatImage addTarget:self action:@selector(wechatBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    if ([WXApi isWXAppInstalled]==NO) {
        _wechatImage.hidden = YES;
    }
    return _wechatImage;

}
- (void)platformButtonClicked:(UIButton *)sender
{
    if(sender.tag == kWxLoginButtonTag){
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSString *openId = [userDefaultes stringForKey:@"openId"];
        
        if (openId!=nil) {
            NSLog(@"=============emobId======%@===",openId);
            self.requestParas = @{@"openId":openId,
                                  @"idType":@"2",
                                  };
            self.requestURL = LKB_Social_Login_Url;
        }
        else {
            [self sendAuthRequest];
        }
    }else
    {
        _noDisturbingStatus = ePushNotificationNoDisturbStatusDay;
        EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
        
        [[EaseMob sharedInstance].chatManager updatePushOptions:options error:nil];
        
        AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate showUserTabBarViewController];
    }
}


-(void)sendAuthRequest  {
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    [WXApi sendReq:req];
}


// 随便看看
- (UIButton *)lookButton {
    
    _lookButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_lookButton setTitle:@"随便看看" forState:UIControlStateNormal];
    _lookButton.tintColor = [UIColor blackColor];
    [_lookButton addTarget:self action:@selector(lookButton:) forControlEvents:UIControlEventTouchUpInside];

    return _lookButton;
}

- (void)lookButton:(id)sender {
    
    self.requestURL = LKB_Browsing_Login_Url;
    

//    
//    
//    AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [appDelegate showUserTabBarViewController];
}

// 注册
- (UIButton *)RegisterButton {
    
    _RegisterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_RegisterButton setTitle:@"账号注册" forState:UIControlStateNormal];
    _RegisterButton.tintColor = [UIColor blackColor];
    
    [_RegisterButton addTarget:self action:@selector(registerButton:) forControlEvents:UIControlEventTouchUpInside];
    return _RegisterButton;
}

- (void)registerButton:(id)sender {
    
    [MobClick event:@"registerButtonEvent"];

    AccountRegisterViewController * registerVC = [[AccountRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
    
}


#pragma mark noti
- (void) thirdLogSuccess: (NSNotification *)noti
{
    userInfo = [noti.userInfo objectForKey:@"info"];
    
    self.requestParas = @{
                        @"openId": [userInfo objectForKey:@"user_id"],
                        @"clientType": @"2",
                        };
    
    self.requestURL = LKB_Social_Login_Url;

}



- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (errorMessage) {

        if ([errorMessage isEqualToString:@"用户不存在"]) {
            self.requestParas = @{
                                  @"openId": [userInfo objectForKey:@"user_id"],
                                  @"nickName": [userInfo objectForKey:@"nick_name"],
                                  @"avatar": [userInfo objectForKey:@"head_portrait"],
                                  @"regType": [userInfo objectForKey:@"login_type"],
                                  @"clientType": @"2",
                                  @"gender": @"",
                                  };
            
            
            self.requestURL = LKB_Social_Regist_Url;
        }
else
{
    [self ShowProgressHUDwithMessage:errorMessage];
    return;
}
    
        
    }
    else{
    
    if ([self.requestURL isEqualToString:LKB_Social_Login_Url]) {
        
//        self.requestParas =  @{@"userId":[[MyUserInfoManager shareInstance]userId],
//                               @"ownerId":[[MyUserInfoManager shareInstance]userId],
//                               @"token":[[MyUserInfoManager shareInstance]token]};
//        
//        self.requestURL = LKB_Group_List_Url;
        
          NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        NSString *strUrl = [[infoDictionary objectForKey:@"CFBundleVersion"] stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        int ivalue = [strUrl intValue];
        
        NSLog(@"当前应用版本号码：%d",ivalue);
        
        
        NSLog(@"当前应用版本号码：%@",@(ivalue));
        
        [self setUIWebviewcookie];
        
        NSDictionary *IDdic =  @{@"clientType":@"2",
                                 @"clientVersion":strUrl
                                 };
        [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Login_ClientVersion_Url parameters:IDdic success:^(id parserObject) {
            
            NSLog(@"记录成功");
            
        } failure:^(NSString *errorMessage) {
            
        }];

            NSLog(@"获取个人信息---------登陆成功");
        
            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[[MyUserInfoManager shareInstance]userId] password:@"dream" completion:^(NSDictionary *loginInfo, EMError *error) {
                if (!error && loginInfo) {
                       [self.hud hide:YES];
                    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
                    options.noDisturbStatus = ePushNotificationNoDisturbStatusDay;
                    [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options];

                    [appDelegate showUserTabBarViewController];
                    NSLog(@"登陆成功");
     
           
                    
                }
            } onQueue:nil];
    }
    
    if ([self.requestURL isEqualToString:LKB_Social_Regist_Url]) {
        
        NSLog(@"注册成功------获取个人信息");

        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        NSString *strUrl = [[infoDictionary objectForKey:@"CFBundleVersion"] stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        int ivalue = [strUrl intValue];
        
        NSLog(@"当前应用版本号码：%d",ivalue);
        
        
        NSLog(@"当前应用版本号码：%@",@(ivalue));
        
        [self setUIWebviewcookie];
        
        NSDictionary *IDdic =  @{@"clientType":@"2",
                                 @"clientVersion":strUrl
                                 };
        [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Login_ClientVersion_Url parameters:IDdic success:^(id parserObject) {
            
            NSLog(@"记录成功");
            
        } failure:^(NSString *errorMessage) {
            
        }];

        
        
        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[[MyUserInfoManager shareInstance]userId] password:@"dream" completion:^(NSDictionary *loginInfo, EMError *error) {
            if (!error && loginInfo) {
                   [self.hud hide:YES];
                NSLog(@"登陆成功");
                EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
                options.noDisturbStatus = ePushNotificationNoDisturbStatusDay;
                [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options];
                
                SelectedRecommendViewController * selectedRecommendVC = [[SelectedRecommendViewController alloc]init];
                
                [self.navigationController pushViewController:selectedRecommendVC animated:YES];
            
//                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                [appDelegate showUserTabBarViewController];
                
            }
        } onQueue:nil];
    }
        
        
        if ([self.requestURL isEqualToString:LKB_Browsing_Login_Url]) {
            
            NSLog(@"注册成功------获取个人信息");
            _noDisturbingStatus = ePushNotificationNoDisturbStatusDay;
            
            EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
            options.noDisturbStatus = ePushNotificationNoDisturbStatusDay;
            [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options];

            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate showUserTabBarViewController];
            
//            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[[MyUserInfoManager shareInstance]userId] password:@"dream" completion:^(NSDictionary *loginInfo, EMError *error) {
//                if (!error && loginInfo) {
//                    
//                    NSLog(@"登陆成功");
//                    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                    [appDelegate showUserTabBarViewController];
//                    
//                }
//            } onQueue:nil];
        }
        
    
    }
    
}



-(void)setUIWebviewcookie{
    //    NSString * strID = [NSString stringWithFormat:@"%@",[[UserInfoManager shareUserInfoManagerWithDic:nil] id]];LKB_WSSERVICE_HTTP http://192.168.1.199:8082 http://112.124.96.181:8099
    
    
    
    // 正式环境
    NSURL *cookieHost = [NSURL URLWithString:LKB_WSSERVICE_HTTP];
    
    // 测试环境
    //    NSURL *cookieHost = [NSURL URLWithString:@"http://192.168.1.199:8082/app"];
    // 设定 cookie
    NSHTTPCookie *cookie1 = [NSHTTPCookie cookieWithProperties:
                             [NSDictionary dictionaryWithObjectsAndKeys:
                              [cookieHost host], NSHTTPCookieDomain,
                              [cookieHost path], NSHTTPCookiePath,
                              @"userId",  NSHTTPCookieName,
                              [[MyUserInfoManager shareInstance] userId], NSHTTPCookieValue,
                              nil]];
    
    // 设定 cookie
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie1];
    //    NSString * mdStr = [UserInfoManager md5:[UserInfoManager md5:str]];
    // 定义 cookie 要设定的 host
    // 设定 cookie
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             [cookieHost host], NSHTTPCookieDomain,
                             [cookieHost path], NSHTTPCookiePath,
                             @"token",  NSHTTPCookieName,
                             [[MyUserInfoManager shareInstance] token], NSHTTPCookieValue,
                             nil]];
    // 设定 cookie
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
}



- (void)ShowProgressHUDwithMessage:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.dimBackground = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}
- (void) thirdLogFailed: (NSNotification *)noti
{
    
//    self.hud.hidden = YES;
    [MBProgressHUD showError:[noti.userInfo objectForKey:LKBErr_Msg_key]  toView:self.view];
    
    self.hud.hidden = YES;
//    [MBProgressHUD showMessag:[noti.userInfo objectForKey:LKBErr_Msg_key]  toView:self.view];
//    [AppUtils showMBMsg:[noti.userInfo objectForKey:kErr_Msg_key] inView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
