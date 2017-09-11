//
//  WeiboPlugin.m
//  NFMedia
//
//  Created by Zhou Feng on 2/7/14.
//
//

#import "WeiboPlugin.h"
#import "WeiboSDK.h"
#import "LKBVenderDefine.h"
#import "UserDefaultsUtils.h"
@interface WeiboPlugin () <WeiboSDKDelegate, WBHttpRequestDelegate>
@property (strong, nonatomic) NSString *wbtoken;
@end

@implementation WeiboPlugin

+ (WeiboPlugin *)sharedInstance
{
    @synchronized(self)
    {
        static WeiboPlugin *weiboShare = nil;
        if (weiboShare == nil)
        {
            weiboShare = [[self alloc] init];
        }
        return weiboShare;
    }
}

- (void)share:(NSString *)thumbUrl Content:(NSString *)content{
    
//    if (![WeiboSDK isWeiboAppInstalled]
//        || [[WeiboSDK getWeiboAppSupportMaxSDKVersion] floatValue] < [[WeiboSDK getSDKVersion] floatValue]) {
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//        UIView *currentView = [window rootViewController].view;
//        [AppUtils showMBMsg:@"没有安装微博客户端，不能使用此功能" inView:currentView];
//        return;
//    }
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare:thumbUrl Content:content]];

    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShare:(NSString *)thumbUrl Content:(NSString *)content
{
    
    WBMessageObject *wbMessage = [WBMessageObject message];
    
    wbMessage.text = content;
    
    if (thumbUrl) {
        WBImageObject *image = [WBImageObject object];
        image.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:thumbUrl]];
        wbMessage.imageObject = image;
    }
    
    return wbMessage;
}

// 新浪第三方登录
- (void)loginByWeibo {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = LKBWEBOLOGINCALLBACK_Network;

    request.scope = @"email,direct_messages_read,direct_messages_write,friendships_groups_read,friendships_groups_write,statuses_to_me_read";

    [WeiboSDK sendRequest:request];
}


- (void)logoutByWeibo {
    
    
    NSString *token = [UserDefaultsUtils valueWithKey:LKBWeibo_Token_key];
    if (token) {
        [WeiboSDK logOutWithToken:token delegate:nil withTag:nil];
        [UserDefaultsUtils removeWithKey:LKBWeibo_Token_key];
    }
}


- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        // 登录成功
        if ((int)response.statusCode == 0) {
            self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
            
//            DLog(@"accessToken:[%@]", [(WBAuthorizeResponse *)response accessToken]);
//            DLog(@"openId:[%@]", [(WBAuthorizeResponse *)response userID]);
//            DLog(@"expirationDate:[%@]", [(WBAuthorizeResponse *)response expirationDate]);
            [UserDefaultsUtils saveValue:self.wbtoken forKey:LKBWeibo_Token_key];
            [self getWeiboData:[(WBAuthorizeResponse *)response userID]];
        } else {
            [self code:response.statusCode desc:[(WBAuthorizeResponse *)response userID]];

        }
    }
}

// 通过accessToken调用API用GET的方式获取微博的其他信息
// API官方文档：http://open.weibo.com/wiki/微博API#.E7.94.A8.E6.88.B7
// API测试地址：http://open.weibo.com/tools/console
- (void)getWeiboData:(NSString *)uid
{
    NSString *urlStr = @"https://api.weibo.com/2/users/show.json";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%@",urlStr, self.wbtoken,uid]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *wbdata = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *weiboDic = [NSJSONSerialization JSONObjectWithData:wbdata
                                                             options:NSJSONReadingMutableLeaves
                                                               error:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInSuccessNoti
                                                        object:nil
                                                      userInfo:@{@"info":@{@"user_id": [weiboDic objectForKey:@"idstr"],
                                                                           @"nick_name":[weiboDic objectForKey:@"screen_name"],
                                                                           @"head_portrait":[weiboDic objectForKey:@"avatar_large"],
                                                              @"openId":[weiboDic objectForKey:@"idstr"],
                                                                           
                                                                           @"login_type":[NSNumber numberWithUnsignedInteger:LKBLoginType_Sina]}}];
}

- (void)code:(int)code desc:(NSString *)desc {
    if (desc) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:desc}];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:LKBLogin_Failed}];
    }
}

@end
