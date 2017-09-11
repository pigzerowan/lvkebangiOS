//
//  WechatPlugin.h
//  NFMedia
//
//  Created by Liu Xiaozhi on 5/7/14.
//
//

@interface WechatPlugin : NSObject

+ (WechatPlugin *)sharedInstance;

- (void)send:(NSString *)scene Content:(NSString *)content;

- (void)loginByWechat;

- (void)logoutByWechat;
@end
