//
//  WeiboPlugin.h
//  NFMedia
//
//  Created by Zhou Feng on 2/7/14.
//
//

@interface WeiboPlugin : NSObject

+ (WeiboPlugin *)sharedInstance;

- (void)share:(NSString *)thumbUrl Content:(NSString *)content;

- (void)loginByWeibo;

- (void)logoutByWeibo;
@end
