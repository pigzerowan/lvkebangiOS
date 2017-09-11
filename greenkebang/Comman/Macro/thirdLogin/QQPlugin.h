//
//  QQPlugin.h
//  NFMedia
//
//  Created by Liu Xiaozhi on 6/5/14.
//
//

@interface QQPlugin : NSObject

+ (QQPlugin *)sharedInstance;

- (void)sendContent:(NSString *)content scene:(NSString *)scene;

- (void)loginByQQ;

- (void)logoutByQQ;

@end
