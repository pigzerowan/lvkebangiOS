//
//  QQPlugin.m
//  NFMedia
//
//  Created by Liu Xiaozhi on 6/5/14.
//
//

#import "QQPlugin.h"
#import "TencentOpenAPI/QQApiInterface.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "LKBVenderDefine.h"

@interface QQPlugin () <QQApiInterfaceDelegate, TencentSessionDelegate>
@property (nonatomic, strong) TencentOAuth *oauth;
@property (nonatomic, strong) NSArray *permissions;
@end

@implementation QQPlugin

+ (QQPlugin *)sharedInstance
{
    @synchronized(self)
    {
        static QQPlugin *qqShare = nil;
        if (qqShare == nil)
        {
            qqShare = [[self alloc] init];
        }
        return qqShare;
    }
}

- (id)init {
    if (self = [super init]) {
        NSString *appid = YQ_QQ_APPID;
        _oauth = [[TencentOAuth alloc] initWithAppId:appid andDelegate:self];
        _oauth.redirectURI = nil;
    }
    return self;
}

- (NSArray *)permissions
{
    if (!_permissions) {
        _permissions = [NSArray arrayWithObjects:@"all", nil];
    }
    return _permissions;
}
- (void)sendContent:(NSString *)content scene:(NSString *)scene; {
//    if (![QQApiInterface isQQInstalled] || ![QQApiInterface isQQSupportApi]) {
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//        UIView *currentView = [window rootViewController].view;
//        [AppUtils showMBMsg:@"没有安装QQ客户端，不能使用此功能" inView:currentView];
//        return;
//    }
    
    NSError *err = nil;
    NSDictionary *msg = [NSJSONSerialization JSONObjectWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
    if (!msg) {
        return;
    }

    NSDictionary *message = [msg objectForKey:@"message"];
    NSString *title = [message objectForKey:@"title"];
    NSString *description = [message objectForKey:@"description"];
    NSString *data = [message objectForKey:@"data"];
    NSString *target = [message objectForKey:@"target"];

    QQApiNewsObject *obj =
    [QQApiNewsObject objectWithURL:[NSURL URLWithString:target]
                             title:title
                       description:description
                   previewImageURL:[NSURL URLWithString:data]];

    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
    QQApiSendResultCode sent;
    if ([scene caseInsensitiveCompare:LKBQQ_ShareType_QQ] == NSOrderedSame) {
        sent = [QQApiInterface sendReq:req];
    } else {
        sent = [QQApiInterface SendReqToQZone:req];
    }

    switch (sent) {
        case EQQAPIAPPNOTREGISTED:
        {
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            break;
        }
        case EQQAPISENDFAILD:
        {
            break;
        }
        case EQQAPIAPPSHAREASYNC:
        {
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)loginByQQ
{
    //NSArray *permissions =  [NSArray arrayWithObjects:@"get_user_info", @"add_t", nil];
    //NSArray *permissions =  [NSArray arrayWithObjects:@"all", nil];
    [self.oauth authorize:self.permissions inSafari:YES];
}


- (void)logoutByQQ {
    
    [_oauth logout:self];
}

#pragma mark - QQApiInterfaceDelegate
- (void)onReq:(QQBaseReq *)req {
    NSLog(@"onResp");
}


- (void)onResp:(QQBaseResp *)resp {
    NSLog(@"onResp");
}

- (void)isOnlineResponse:(NSDictionary *)response {
}

#pragma mark TencentSessionDelegate
- (void)tencentDidLogin
{
    if (self.oauth.accessToken && 0 != [self.oauth.accessToken length])
    {
        self.oauth.openId = [self.oauth openId];
        
        [self.oauth getUserInfo];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:LKBLogin_Failed}];
    }
    
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:LKBLogin_Canceled}];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:LKBLogin_Failed}];
    }
}

- (void)tencentDidNotNetWork {
    [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:LKBLogin_Failed_Network}];
}

- (void)getUserInfoResponse:(APIResponse*) response
{
    if (response.retCode == URLREQUEST_SUCCEED) {
        
        NSString * profileImg = [response.jsonResponse objectForKey:@"figureurl_qq_2"];
          NSString * unionid = [response.jsonResponse objectForKey:@"unionid"];
        if (!profileImg || profileImg.length <= 0) {
            profileImg = [response.jsonResponse objectForKey:@"figureurl_qq_1"];
        }
        
        NSDictionary *dic = response.jsonResponse;

        [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInSuccessNoti
                                                            object:nil
                                                          userInfo:@{@"info":@{@"user_id": self.oauth.openId,
                                                                               @"nick_name":[response.jsonResponse objectForKey:@"nickname"],
                                                                   @"openId":self.oauth.openId,              @"head_portrait":profileImg,
                                                                               @"login_type":[NSNumber numberWithUnsignedInteger:LKBLoginType_QQ],
                                                                               }}];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:response.errorMsg}];
    }
}

@end
