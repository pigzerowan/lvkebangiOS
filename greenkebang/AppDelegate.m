 //
//  AppDelegate.m
//  greenkebang
//
//  Created by 郑渊文 on 8/25/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LKBBaseTabBarController.h"
#import "LKBVenderDefine.h"
#import "LKBBaseNavigationController.h"
#import "EaseMob.h"
#import "AppDelegate+EaseMob.h"
#import "AppDelegate+UMeng.h"
#import "AppDelegate+Parse.h"
#import "OutWebViewController.h"
#import "LKBUserBaseTabbarController.h"
#import "TabbarManager.h"
#import "WXApi.h"
#import "SocialRigistManager.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import <UMMobClick/MobClick.h>
#import "BBLaunchAdMonitor.h"
#import "MyUserInfoManager.h"
#import "UMessage.h"
#import "WeiboSDK.h"
#import "WeiboPlugin.h"
#import "WechatPlugin.h"
#import "QQPlugin.h"
#import "YQWebDetailViewController.h"
#import "LoginHomeViewController.h"
#import "BaseTimeViewController.h"
#import "ShareArticleManager.h"
#import "MTVersionHelper.h"
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define _IPHONE80_ 80000

@interface AppDelegate ()<WXApiDelegate,UIAlertViewDelegate>

@end

@implementation AppDelegate

static AppDelegate *_shareInstance;

+(AppDelegate *)shareInstance
{
    @synchronized ([AppDelegate class])
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[AppDelegate alloc] init];
        }
    }
    return _shareInstance;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSArray *myarray = [NSArray arrayWithObjects:@"abre", @"ddd", @"beh", nil];
//    NSArray *resultArray = [myarray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//    NSString *str = [resultArray componentsJoinedByString:@""];
//    [str sha1];
    
//     [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
    
   //  [MTVersionHelper checkNewVersion];
    
//   [MTVersionHelper checkNewVersionAndCustomAlert:^(MTVersionModel *appInfo) {
       //CustomView
 //   }];
    
    
  NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:80 * 1024 * 1024
                                                         diskCapacity:100 * 1024 * 1024
                                                            diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [UMessage startWithAppkey:@"5641be04e0f55a6d63000010" launchOptions:launchOptions];
    [WeiboSDK registerApp:YQ_Sina_APPID];
    [UMSocialQQHandler setQQWithAppId:YQ_QQ_APPID appKey:YQ_QQ_APPKEY url:@"http://www.umeng.com/social"];
   
    [self steupVenderWithOptions:launchOptions];
//    [MobClick startWithAppkey:@"5641be04e0f55a6d63000010" reportPolicy:BATCH channelId:nil];
    
    [self setupUMeng];
    
    // 通过 appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"mailgreentechplacecom#lvkeb" apnsCertName:@"lvkebangdevelop"];
    _connectionState = eEMConnectionConnected;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self steupUserCity];
    
    
    
    
//    LoginHomeViewController * loginRootVC = [[LoginHomeViewController alloc]init];
//    LKBBaseNavigationController* loginNav = [[LKBBaseNavigationController alloc] initWithRootViewController:loginRootVC];
//    
//    [self.window setRootViewController:loginNav];
    
    BOOL isLogin = [[MyUserInfoManager shareInstance] userLogin];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *strUrl = [[infoDictionary objectForKey:@"CFBundleVersion"] stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    int ivalue = [strUrl intValue];
    
    NSLog(@"当前应用版本号码：%d",ivalue);

    if (isLogin) {
        
        
        

//        NSDictionary *IDdic =  @{@"clientType":@"2",
//                                 @"clientVersion":strUrl
//                                 };
//        [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Login_ClientVersion_Url parameters:IDdic success:^(id parserObject) {
//            
//            NSLog(@"记录成功");
//            
//        } failure:^(NSString *errorMessage) {
//            
//        }];

        
        LKBBaseTabBarController* baseTabBarVC = [[LKBBaseTabBarController alloc] init];
        baseTabBarVC.tabBar.translucent = NO;
        
        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[MyUserInfoManager shareInstance].userId password:@"dream" completion:^(NSDictionary *loginInfo, EMError *error) {
            if (!error && loginInfo) {
                
                NSLog(@"登陆成功");
                
                [self setUIWebviewcookie];

                NSDictionary *IDdic =  @{@"clientType":@"2",
                                         @"clientVersion":strUrl
                                         };
                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Login_ClientVersion_Url parameters:IDdic success:^(id parserObject) {
                    
                    NSLog(@"记录成功");
                    
                } failure:^(NSString *errorMessage) {
                    
                }];

                
            }
        } onQueue:nil];

        
        [self.window setRootViewController:baseTabBarVC];

    }else {
        LoginHomeViewController * loginRootVC = [[LoginHomeViewController alloc]init];
        
        LKBBaseNavigationController* loginNav = [[LKBBaseNavigationController alloc] initWithRootViewController:loginRootVC];
        [self.window setRootViewController:loginNav];
    }

    
   
//
//    
//    BOOL isLogin  ;
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *iflogin =   [userDefaults objectForKey:@"iflogin"];
//    if ([iflogin isEqualToString:@"1"]) {
//        isLogin = YES;
//    }
//    if (isLogin==YES) {
////        LoginRootViewController* loginRootVC = [[LoginRootViewController alloc] init];
//        
//        LoginHomeViewController * loginRootVC = [[LoginHomeViewController alloc]init];
//
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//      ;
//        LKBBaseNavigationController* loginNav = [[LKBBaseNavigationController alloc] initWithRootViewController:loginRootVC];
//        [self.window setRootViewController:loginNav];
////        [loginRootVC loginButtonClicked:nil];
//        if ([userDefaults objectForKey:@"myUserName"]!=nil) {
//            [MyUserInfoManager shareInstance].userId = [userDefaults objectForKey:@"myUserId"];
//            [MyUserInfoManager shareInstance].nickName = [userDefaults objectForKey:@"myNickName"];
//            [MyUserInfoManager shareInstance].avatar = [userDefaults objectForKey:@"myAvatar"];
//            
//            
//            NSDictionary *mydic = @{@"userName":[MyUserInfoManager shareInstance].nickName,
//                                    @"userAvatar":[MyUserInfoManager shareInstance].avatar
//                                    };
//            NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
//            [userDefaults setObject:dic  forKey:[MyUserInfoManager shareInstance].userId];
//            
//            
//            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[MyUserInfoManager shareInstance].userId password:@"dream" completion:^(NSDictionary *loginInfo, EMError *error) {
//                if (!error && loginInfo) {
//                
//                    NSLog(@"登陆成功");
//
//                }
//            } onQueue:nil];
//            
//           
//            
////            [MyUserInfoManager shareInstance].userId = [userDefaults objectForKey:@"myUserName"];
//            //主页
//            [self showUserTabBarViewController];
//            // 广告
//            NSString *path = @"http://www.greentechplace.com/upload/startImg/123456.jpg";
//            [BBLaunchAdMonitor showAdAtPath:path
//                                     onView:self.window.rootViewController.view
//                               timeInterval:3.
//                           detailParameters:@{@"carId":@(666666), @"name":@"绿科帮"}];
//            
////            [UMessage startWithAppkey:@"5641be04e0f55a6d63000010" launchOptions:launchOptions];
//
//        }
//        
////        LKBBaseTabBarController* baseTabBarVC = [[LKBBaseTabBarController alloc] init];
////        [self.window setRootViewController:baseTabBarVC];
//    }else {
//        
////        LoginRootViewController* loginRootVC = [[LoginRootViewController alloc] init];
//        LoginHomeViewController * loginRootVC = [[LoginHomeViewController alloc]init];
//
//        LKBBaseNavigationController* loginNav = [[LKBBaseNavigationController alloc] initWithRootViewController:loginRootVC];
//        [self.window setRootViewController:loginNav];
//    }
//    
//    
    
    
    
    

    
    
    // 环信UIdemo中有用到友盟统计crash，您的项目中不需要添加，可忽略此处。
    //[self setupUMeng];
    
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
//    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
//    {
//        //register remoteNotification types
//        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
//        action1.identifier = @"action1_identifier";
//        action1.title=@"Accept";
//        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
//        
//        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
//        action2.identifier = @"action2_identifier";
//        action2.title=@"Reject";
//        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
//        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
//        action2.destructive = YES;
//        
//        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
//        categorys.identifier = @"category1";//这组动作的唯一标示
//        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
//        
//        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
//                                                                                     categories:[NSSet setWithObject:categorys]];
//        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
//        
//    } else{
//        //register remoteNotification types
//        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
//         |UIRemoteNotificationTypeSound
//         |UIRemoteNotificationTypeAlert];
//    }
//#else
//    
//    //register remoteNotification types
//    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
//     |UIRemoteNotificationTypeSound
//     |UIRemoteNotificationTypeAlert];
    
//#endif
//    
//    //for log
//    [UMessage setLogEnabled:YES];
    
    

    
    
    NSString *path = @"http://imagetest.lvkebang.cn/static/app_startPage/appStartPage.jpg";
    [BBLaunchAdMonitor showAdAtPath:path
                             onView:self.window.rootViewController.view
                       timeInterval:3.
                   detailParameters:@{@"carId":@(666666), @"name":@"绿科帮"}];

    

    
     [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];

//    [[EaseMob sharedInstance] registerSDKWithAppKey:@"easemob-demo#chatdemoui" apnsCertName:nil];

    //NSString *sdkVersion = [EaseMob sharedInstance].sdkVersion;
//    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"zhengyw891213" password:@"123456"];
   // NSLog(@"sdkVersion----------------%@", sdkVersion);
//    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    // 初始化环信SDK，详细内容在AppDelegate+EaseMob.m 文件中
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    
        [self.window makeKeyAndVisible];
    return YES;

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


- (void)showAdDetail:(NSNotification *)noti
{
    NSLog(@"detail parameters:%@", noti.object);
}
// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    
    [UMessage registerDeviceToken:deviceToken];
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    //向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
     NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    NSLog(@"error -- %@",error);

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
//    [UMessage didReceiveRemoteNotification:userInfo];
}
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"接收推送消息");
}


- (void)steupVenderWithOptions:(NSDictionary *)launchOptions
{
    // 友盟分享
    [UMSocialData setAppKey:YQ_UM_Appkey];
    //打开调试log的开关
    //    [UMSocialData openLog:YES];
    
    //设置微信AppId，url地址传nil，将默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:YQ_WeiXin_APPID appSecret:YQ_WeiXin_Secret url:YQ_APP_URL];
    
    //设置手机QQ的AppId，指定你的分享url，若传nil，将使用友盟的网址
    [UMSocialQQHandler setQQWithAppId:YQ_QQ_APPID appKey:YQ_QQ_APPKEY url:YQ_APP_URL];
    //  设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    //打开新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}



//授权后回调 WXApiDelegate
-(void)onResp:(BaseReq *)resp  {
    /*     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效                         state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
    
        NSLog(@"微信分享回调");
    }
    else
    {
    SendAuthResp *aresp = (SendAuthResp *)resp;
    
    NSLog(@"微信denglu回调");
    if (aresp.errCode== 0) {
       
            _wxcode = aresp.code;
            if (self.returnTextBlock != nil) {
                self.returnTextBlock(_wxcode);
    

        }

        NSLog(@"=============code是============%@===",_wxcode);

    }}
}


- (void)returnText:(ReturnMyInfoBlock)block {
    self.returnTextBlock = block;
}

-(void)getAccess_token  {
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wx2bbba60852f9ec48",@"9cfe4184b7f59e0ad77aa9bc7494f0e4",_wxcode];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 "access_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWiusJMZwzQU8kXcnT1hNs_ykAFDfDEuNp6waj-bDdepEzooL_k1vb7EQzhP8plTbD0AgR8zCRi1It3eNS7yRyd5A";
                 "expires_in" = 7200;
                 openid = oyAaTjsDx7pl4Q42O3sDzDtA7gZs;
                 "refresh_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWi2ZzH_XfVVxZbmha9oSFnKAhFsS0iyARkXCa7zPu4MqVRdwyb8J16V8cWw7oNIff0l-5F-4-GJwD8MopmjHXKiA";
                 scope = "snsapi_userinfo,snsapi_base";
                 }
                 */
                
      

                self.access_token = [dic objectForKey:@"access_token"];
                self.openid= [dic objectForKey:@"openid"];
                NSLog(@"=============access_token是============%@===",self.access_token);
                NSLog(@"=============openid是============%@===",self.openid);
                if (self.openid.length!=0) {
                    [self getUserInfo];
                }
                                 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:@"openId" forKey:self.openid];
            }
        });
    });
}


-(void)getUserInfo  {
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",self.access_token,self.openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 city = Haidian;
                 country = CN;
                 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
                 language = "zh_CN";
                 nickname = "xxx";
                 openid = oyAaTjsDx7pl4xxxxxxx;
                 privilege =     (
                 );
                 province = Beijing;
                 sex = 1;
                 unionid = oyAaTjsxxxxxxQ42O3xxxxxxs;
                 }
                 */
                [SocialRigistManager shareInstance].nickName =[dic objectForKey:@"nickname"];
                [SocialRigistManager shareInstance].avatar =[dic objectForKey:@"headimgurl"];
                [SocialRigistManager shareInstance].openId =_openid;
                [SocialRigistManager shareInstance].gender =[dic objectForKey:@"sex"];
                [SocialRigistManager shareInstance].birthDay =[dic objectForKey:@"nickname"];
                

                BaseViewController *baseVc =  [[BaseViewController alloc]init];
                
                
                baseVc.requestParas = @{@"nickName":[dic objectForKey:@"nickname"],
                                        @"idType":@(2),
                                        @"avatar":[dic objectForKey:@"headimgurl"],
                                        @"openId":_openid,
                                        @"gender":[dic objectForKey:@"sex"],
                                        @"birthDay":@""
                                        };
//                baseVc.requestURL = LKB_Social_Regist_Url;
                baseVc.requestURL = LKB_Social_Login_Url;
                
                
            }
        });
    });
}



- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    LKBBaseModel* responseModel = (LKBBaseModel*)parserObject;
        NSLog(@"===========%@==============",responseModel.msg);
    
    if ([responseModel.msg isEqualToString:@"登录成功"]) {
               
        
        AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate showUserTabBarViewController];
    }else
    {
        
    }
    
    NSLog(@"***********************%@",responseModel.msg);
}
- (void)steupUserCity
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:iYQUserCityKey]) {
        [userDefaults setObject:@"上海" forKey:iYQUserCityKey];
        [userDefaults synchronize];
    }
}


- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    if (!error) {
        NSLog(@"login_Succeed");
        [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
    } else {
        NSLog(@"-------%@", error);
    }
}

// 显示tabbar界面
- (void)showUserTabBarViewController
{
    if (!_lkbbaseVc) {
         LKBBaseTabBarController *baseTabBarVC = [[LKBBaseTabBarController alloc] init];
        [TabbarManager shareInstance].lkbbaseVc = baseTabBarVC;
        [UIView transitionFromView:self.window.rootViewController.view
                            toView:baseTabBarVC.view
                          duration:0.65f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        completion:^(BOOL finished){
                            [self.window setRootViewController:baseTabBarVC];
                        }];
    }
    else{
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:_lkbbaseVc.view
                      duration:0.65f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished){
                        [self.window setRootViewController:_lkbbaseVc];
                    }];
    }
}



- (void)showUserBaseTabBarViewController
{
  
        LKBUserBaseTabbarController *baseTabBarVC = [[LKBUserBaseTabbarController alloc] init];
        [AppDelegate shareInstance].lkbUserbaseVc = baseTabBarVC;
        [UIView transitionFromView:self.window.rootViewController.view
                            toView:baseTabBarVC.view
                          duration:0.65f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        completion:^(BOOL finished){
                            [self.window setRootViewController:baseTabBarVC];
                        }];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [[EaseMob sharedInstance] applicationWillTerminate:application];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(NSString *)filterHTML:(NSString *)html
{
    //    两种方法
    //        NSRange range;
    //        NSString *string = html;
    //        while ((range = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
    //            string=[string stringByReplacingCharactersInRange:range withString:@""];
    //        }
    //        NSLog(@"Un block string : %@",string);
    
    NSString *newStr = html;
    newStr = [newStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@""];
    
    
    NSScanner * scanner = [NSScanner scannerWithString:newStr];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        newStr = [newStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    
    NSLog(@"解析HTML格式数据后：%@",newStr);
    return newStr;
}


#pragma mark - private
//登陆状态改变
-(void)loginStateChange:(NSNotification *)notification
{
    UINavigationController *nav = nil;
    
    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
    BOOL loginSuccess = [notification.object boolValue];
    
    if (isAutoLogin || loginSuccess) {//登陆成功加载主窗口控制器
        //加载申请通知的数据
        [[ApplyViewController shareController] loadDataSourceFromLocalDB];
        
        // 环信UIdemo中有用到Parse，您的项目中不需要添加，可忽略此处。
        [self initParse];
    }else{//登陆失败加载登陆页面控制器
       
        [self clearParse];
    }
    
    //设置7.0以下的导航栏
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0){
        nav.navigationBar.barStyle = UIBarStyleDefault;
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
                                forBarMetrics:UIBarMetricsDefault];
        
        [nav.navigationBar.layer setMasksToBounds:YES];
    }
    
    self.window.rootViewController = nav;
    
    [nav setNavigationBarHidden:YES];
    [nav setNavigationBarHidden:NO];
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL isSuc = YES;
    if ([url.absoluteString rangeOfString:YQ_WeiXin_APPID].location != NSNotFound) {
        isSuc = [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)[WechatPlugin sharedInstance]];
    } else if ([url.absoluteString rangeOfString:LKBKKK_QQ_APPID].location != NSNotFound) {
        if (YES == [TencentOAuth CanHandleOpenURL:url]) {
            isSuc = [TencentOAuth HandleOpenURL:url];
        }
    } else if ([url.absoluteString rangeOfString:YQ_Sina_APPID].location != NSNotFound) {
        isSuc =  [ WeiboSDK handleOpenURL:url delegate:(id<WeiboSDKDelegate>)[WeiboPlugin sharedInstance]];
    }
    return isSuc;
}


-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL isSuc = YES;
    if ([url.absoluteString rangeOfString:YQ_WeiXin_APPID].location != NSNotFound) {
        isSuc =  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)[WechatPlugin sharedInstance]];
    } else if ([url.absoluteString rangeOfString:LKBKKK_QQ_APPID].location != NSNotFound) {
        if (YES == [TencentOAuth CanHandleOpenURL:url]) {
            isSuc = [TencentOAuth HandleOpenURL:url];
        }
    } else if ([url.absoluteString rangeOfString:YQ_Sina_APPID].location != NSNotFound) {
        isSuc =  [WeiboSDK handleOpenURL:url delegate:(id<WeiboSDKDelegate>)[WeiboPlugin sharedInstance]];
    }
    return  isSuc;
}



//#pragma mark - APP运行中接收到通知(推送)处理
//
///** APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台) */
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    application.applicationIconBadgeNumber = 0; // 标签
//    
//    NSLog(@"\n>>>[Receive RemoteNotification]:%@\n\n", userInfo);
//}


/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    // 处理APN
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n", userInfo);
    

    
/*

 {
 "_ge_" = 1;
 "_gmid_" = "OSL-0109_Hrz03JZwdP9IV90oUGSdZ5:b610f9a882ed4058aa8736069fe00471:1cdbf30e97c9ee1f119cac5662fbcbb5";
 "_gurl_" = "sdk.open.extension.getui.com:8123";
 aps =     {
 alert =         {
 body = "\U63a8\U9001\U901a\U77e5";
 title = "{\n\t\"msg\":\"123123\",\n\t\"noticeName\":\"\U63a8\U9001\U901a\U77e5\",\n\t\"noticeType\":6,\n\t\"title\":\"\U6d4b\U8bd5\U6807\U9898\",\n\t\"type\":0,\n\t\"url\":\"http://www.lvkebang.cn/jianjie/764\"\n}";
 };
 "mutable-content" = 1;
 sound = default;
 };
 }
*/
   
    
    
    NSLog(@"================%@",[[[userInfo valueForKey:@"aps"] valueForKey:@"alert"]valueForKey:@"title"]);
    
    
//    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:userInfo[@"aps"][@"alert"]];
//    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
//    [synth speakUtterance:utterance];
    
//    _noticeInfoDic = [[NSDictionary alloc]initWithDictionary:[[[userInfo valueForKey:@"aps"] valueForKey:@"alert"]valueForKey:@"title"]];
//    _noticeInfoDic = [[NSDictionary alloc]init];
//    _noticeInfoDic =[[[userInfo valueForKey:@"aps"] valueForKey:@"alert"]valueForKey:@"title"];
    
    NSData *data = [[[[userInfo valueForKey:@"aps"] valueForKey:@"alert"]valueForKey:@"title"] dataUsingEncoding:NSUTF8StringEncoding];
    
    _noticeInfoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"=======================%@",_noticeInfoDic);

    
    
    NSLog(@"================%@",[_noticeInfoDic valueForKey:@"url"]);
    

    [self presentViewControllerWithPushInfo];


    
}

#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    
    
    
   
    
    if ([[MyUserInfoManager shareInstance]userId]) {
        
        
        NSDictionary *IDdic =  @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                 @"uid":    [GeTuiSdk clientId],
                                 @"token":[[MyUserInfoManager shareInstance]token]
                                 };
        
        
        
        [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_common_addUid_Url parameters:IDdic success:^(id parserObject) {
            
            NSLog(@"绑定成功b");
            
        } failure:^(NSString *errorMessage) {
            
        }];
        
        
     //   [GeTuiSdk bindAlias:[[MyUserInfoManager shareInstance]userId]];
        
        [GeTuiSdk bindAlias:[[MyUserInfoManager shareInstance]userId] andSequenceNum:@"lalal"];

    }
    
    
 }

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}


/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    
    // [4]: 收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    

    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@", taskId, msgId, payloadMsg, offLine ? @"<离线消息>" : @""];
    
    
    
    NSData *data = [payloadMsg dataUsingEncoding:NSUTF8StringEncoding];
    
    _noticeInfoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    
    NSLog(@"=======================%@",_noticeInfoDic);

    NSString *str = [NSString stringWithFormat:@"%@",[_noticeInfoDic valueForKey:@"noticeType"] ];
    if ([str isEqualToString:@"5"]) {
        
        //创建一个消息对象
        NSNotification * PushGoodNotice = [NSNotification notificationWithName:@"PushGoodMessage" object:nil userInfo:@{msg:@"msg"}];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:PushGoodNotice];
        NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);

    }
    
    else if ([str isEqualToString:@"6"]) {
        
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            
            NSLog(@"前台推送");
            
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            
            NSString *messageAlert = [_noticeInfoDic objectForKey:@"msg"];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"远程通知" message:messageAlert delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
            alertView.delegate = self;
//            self.pushAlertClickBtnFlag = 55;  // 判断是不是远程推送消息的弹窗
            [alertView show];

//            [UMessage didReceiveRemoteNotification:_noticeInfoDic];

            
            

        }
        
        
        else if([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
            
            NSLog(@"后台推送");
            


        }
        
    }

    else {
        
        //创建一个消息对象
        NSNotification * notice = [NSNotification notificationWithName:@"newMessage" object:nil userInfo:@{msg:@"msg"}];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);

        
    }
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;{
    
    // the user clicked OK
    
    if (buttonIndex == 0)
        
    {
        
        
        NSLog(@"取消");
        //do something here...
        
    }
    else {
        
        NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];

        NSString *FarmerStr = [pushJudge objectForKey:@"FarmerCircleViewController"];
        
        NSLog(@"=======================%@",FarmerStr);
        
//        [pushJudge setObject:@"push" forKey:@"FarmerCircleViewController"];

        
        
        
        [self presentViewControllerWithPushInfo];

        
        NSLog(@"-----------------------%@",_noticeInfoDic);
        
        

        /*{
         msg = 123123;
         noticeName = "\U63a8\U9001\U901a\U77e5";
         noticeType = 6;
         title = "\U6d4b\U8bd5\U6807\U9898";
         type = 0;
         url = "http://www.lvkebang.cn/jianjie/764";
         }
         */
        NSLog(@"前往");

    }
    
}


- (void)presentViewControllerWithPushInfo {
    
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@"push" forKey:@"push"];
    [pushJudge synchronize];
    
    NSString *FarmerStr = [pushJudge objectForKey:@"FarmerCircleViewController"];
    
    NSLog(@"=======================%@",FarmerStr);
    
    if ([[_noticeInfoDic valueForKey:@"url"] rangeOfString:@"jianjie"].location != NSNotFound) {
        
        NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/"];
        
        NSString * str = [[_noticeInfoDic valueForKey:@"url"] substringFromIndex: jianjie.length];
        
        
        NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,str] ;
        
        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:strmy];
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        
        
        outSideWeb.VcType = @"2";
        outSideWeb.rightButtonType = @"1";
        outSideWeb.sendMessageType = @"1";
        outSideWeb.circleDetailId = str;
        
        outSideWeb.urlStr = linkUrl;
        //                outSideWeb.circleId = insight.groupId;
        outSideWeb.shareType = @"2";
        outSideWeb.mytitle =[_noticeInfoDic valueForKey:@"title"];
        outSideWeb.squareType = @"1";
        [ShareArticleManager shareInstance].shareType = @"1";

        outSideWeb.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:outSideWeb animated:YES];
        
//        if ([FarmerStr isEqualToString:@"push"]) {
//            
//            [self.window.rootViewController presentViewController:outSideWeb animated:YES completion:nil];
//
//        }else {
        
            LKBBaseNavigationController* loginNav = [[LKBBaseNavigationController alloc] initWithRootViewController:outSideWeb];
            [self.window.rootViewController presentViewController:loginNav animated:YES completion:nil];

//        }

    }
    else if ([[_noticeInfoDic valueForKey:@"url"]  rangeOfString:@"huodong"].location != NSNotFound) {
        NSString *huodong = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/"];
        
        NSString * str = [[_noticeInfoDic valueForKey:@"url"]  substringFromIndex: huodong.length];
        
        NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/activity/%@",LKB_WSSERVICE_HTTP,str];
        
        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:strmy];
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        
        outSideWeb.VcType = @"7";
        outSideWeb.rightButtonType = @"1";
        outSideWeb.circleDetailId = str;
        
        outSideWeb.urlStr = linkUrl;
        outSideWeb.shareType = @"2";
        outSideWeb.mytitle = [_noticeInfoDic valueForKey:@"title"];
        outSideWeb.commendVcType = @"1";
        outSideWeb.squareType = @"1";
        [ShareArticleManager shareInstance].shareType = @"1";

        outSideWeb.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:outSideWeb animated:YES];
        LKBBaseNavigationController* loginNav = [[LKBBaseNavigationController alloc] initWithRootViewController:outSideWeb];
        [self.window.rootViewController presentViewController:loginNav animated:YES completion:nil];

        
    }
    else {
        
        
        YQWebDetailViewController* webDetailVC = [[YQWebDetailViewController alloc] init];
        webDetailVC.urlStr = [_noticeInfoDic valueForKey:@"url"];
        webDetailVC.mytitle = [_noticeInfoDic valueForKey:@"title"];
        //                webDetailVC.coverUrl = insight.shareImage;
        webDetailVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:webDetailVC animated:YES];
        LKBBaseNavigationController* loginNav = [[LKBBaseNavigationController alloc] initWithRootViewController:webDetailVC];
        [self.window.rootViewController presentViewController:loginNav animated:YES completion:nil];

    }

}






/** SDK收到sendMessage消息回调 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // [4-EXT]:发送上行消息结果反馈
    NSString *msg = [NSString stringWithFormat:@"sendmessage=%@,result=%d", messageId, result];
    NSLog(@"\n>>>[GexinSdk DidSendMessage]:%@\n\n", msg);
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // [EXT]:通知SDK运行状态
    NSLog(@"\n>>>[GexinSdk SdkState]:%u\n\n", aStatus);
}

/** SDK设置推送模式回调 */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    if (error) {
        NSLog(@"\n>>>[GexinSdk SetModeOff Error]:%@\n\n", [error localizedDescription]);
        return;
    }
    
    NSLog(@"\n>>>[GexinSdk SetModeOff]:%@\n\n", isModeOff ? @"开启" : @"关闭");
}
@end
