//
//  WechatPlugin.m
//  NFMedia
//
//  Created by Liu Xiaozhi on 5/7/14.
//
//

#import "WechatPlugin.h"
#import "WXApi.h"
#import "LKBVenderDefine.h"
#import "AppUtils.h"
@interface WechatPlugin () <WXApiDelegate>

@end

@implementation WechatPlugin

+ (WechatPlugin *)sharedInstance
{
    @synchronized(self)
    {
        static WechatPlugin *wechatShare = nil;
        if (wechatShare == nil)
        {
            wechatShare = [[self alloc] init];
        }
        return wechatShare;
    }
}

- (void)send:(NSString *)scene Content:(NSString *)content {
    // check if wechat is available and version supported
    if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi]) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIView *currentView = [window rootViewController].view;
        [AppUtils showMBMsg:@"没有安装微信客户端，不能使用此功能" inView:currentView];
        
        return;
    }

    NSError *err = nil;
    NSDictionary *msg = [NSJSONSerialization JSONObjectWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
    if (!msg) {
        return;
    }

    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    NSString *type = [msg objectForKey:@"type"];
    NSDictionary *message = [msg objectForKey:@"message"];
    NSString *title = [message objectForKey:@"title"];

    if ([type isEqualToString:@"text"]) {
        req.bText = YES;
        req.text = title;
    } else {
        req.bText = NO;

        NSString *description = [message objectForKey:@"description"];
        NSString *thumbURL = [message objectForKey:@"thumb"];
        NSString *data = [message objectForKey:@"data"];

        WXMediaMessage *wxMsg = [WXMediaMessage message];
        wxMsg.title = title;
        wxMsg.description = description;
        
        NSData *thumbData= [NSData dataWithContentsOfURL:[NSURL URLWithString:thumbURL]];
        //UIImage *image =[MZConstant OriginImage:[UIImage imageWithData:thumbData] scaleToSize:CGSizeMake(50, 50)];
        UIImage *image = [AppUtils resizeImage:[UIImage imageWithData:thumbData] maxSize:CGSizeMake(200, 200)];
        thumbData = UIImageJPEGRepresentation(image,1.0);
        CGFloat compressValue = 1.0;
        int length = (int)thumbData.length/1024;
        while (length>30)
        {
            if (compressValue<=0)
            {
                break;
            }
            else {
                compressValue -=0.05;
            }
            thumbData = UIImageJPEGRepresentation(image,compressValue);
            length = (int)thumbData.length/1024;
        }
        [wxMsg setThumbImage:[UIImage imageWithData:thumbData]];
        NSObject *ext;

        if ([type isEqualToString:@"image"]) {
            ext = [WXImageObject object];
            ((WXImageObject*)ext).imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:data]];
        } else if ([type isEqualToString:@"link"]) {
            ext = [WXWebpageObject object];
            ((WXWebpageObject*)ext).webpageUrl = data;
        } else if ([type isEqualToString:@"video"]) {
            ext = [WXVideoObject object];
            ((WXVideoObject*)ext).videoUrl = data;
        } else
        {
            return;
        }

        wxMsg.mediaObject = ext;
        req.message = wxMsg;
    }

    req.scene = [scene intValue];

    [WXApi sendReq:req];
}

- (void)loginByWechat {
    
    if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:@"Wechat not installed, or version not supported."}];
        return;
    } else {
        //构造SendAuthReq结构体
        SendAuthReq* req =[[SendAuthReq alloc ] init];
        req.scope = @"snsapi_userinfo" ;
        req.state = @"123" ;
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req];
    }
}

- (void)logoutByWechat {
    
//    TODO:退出登录
}


#pragma mark WXApiDelegate
- (void)onResp:(BaseResp*)resp {
    if([resp isKindOfClass:[SendMessageToWXResp class]]) {
        NSString *msg = resp.errStr;
        if (!msg) {
            msg = @"";
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:msg}];
    } else if([resp isKindOfClass:[SendAuthResp class]]) {
        NSLog(@"=============%d",((SendAuthResp *)resp).errCode);
        
        if (((SendAuthResp *)resp).errCode==-2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:LKBLogin_Canceled}];
        }
        
     else   if (((SendAuthResp *)resp).errCode == 0) {
            
            NSString *urlStr = @"https://api.weixin.qq.com/sns/oauth2/access_token";
            NSURL *accUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?appid=%@&secret=%@&code=%@&grant_type=authorization_code",urlStr, YQ_WeiXin_APPID, YQ_WeiXin_Secret, ((SendAuthResp *)resp).code]];
            NSURLRequest *request = [NSURLRequest requestWithURL:accUrl];
            NSData *wxdata = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSDictionary *wechatRetDic = [NSJSONSerialization JSONObjectWithData:wxdata
                                                                         options:NSJSONReadingMutableLeaves
                                                                           error:nil];
            if ([wechatRetDic objectForKey:@"errcode"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:[wechatRetDic objectForKey:@"errmsg"]}];
            } else if ([wechatRetDic objectForKey:@"access_token"]) {
                
                urlStr = @"https://api.weixin.qq.com/sns/userinfo";
                NSURL *infoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&openid=%@",urlStr, [wechatRetDic objectForKey:@"access_token"], [wechatRetDic objectForKey:@"openid"]]];
                request = [NSURLRequest requestWithURL:infoUrl];
                wxdata = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                wechatRetDic = [NSJSONSerialization JSONObjectWithData:wxdata
                                                               options:NSJSONReadingMutableLeaves
                                                                 error:nil];
                if ([wechatRetDic objectForKey:@"errcode"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInFailedNoti object:nil userInfo:@{LKBErr_Msg_key:[wechatRetDic objectForKey:@"errmsg"]}];
                } else if ([wechatRetDic objectForKey:@"openid"]) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kThirdLogInSuccessNoti
                                                                        object:nil
                                                                      userInfo:@{@"info":@{@"user_id": [wechatRetDic objectForKey:@"unionid"],
                                                                                           @"nick_name":[wechatRetDic objectForKey:@"nickname"],
                                                               @"openId":[wechatRetDic objectForKey:@"unionid"],
                             @"head_portrait":[wechatRetDic objectForKey:@"headimgurl"],
                                                                                           @"login_type":[NSNumber numberWithUnsignedInteger:LKBLoginType_Wechat]}}];
                }
            }
        }
    }
}
@end
