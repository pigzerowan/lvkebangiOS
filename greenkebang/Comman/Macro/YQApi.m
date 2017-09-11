
#import "YQApi.h"

@implementation YQApi

+ (NSString*)loginCookieName
{
    return @"login_id";
}
+ (void)saveCookiesWithUrl:(NSString*)url
{
    NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:url]];
    /********************cookie start******************************/
    //    for (NSHTTPCookie *cookie in cookies) {
    //        NSLog(@"cookie:\n%@", cookie);
    //        NSLog(@"cookie.value:\n%@",cookie.value);
    //    }
    /*******************cookie end*******************************/
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:iYQUsercookiesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)setupCookies
{
    NSData* cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:iYQUsercookiesKey];
    if ([cookiesdata length]) {
        NSArray* cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie* cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}
+ (void)deleteLoginCookie
{
    [self deleteCookieWithKey:[self loginCookieName]];
}
+ (void)deleteCookieWithKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:iYQUsercookiesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSHTTPCookieStorage* cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* cookies = [NSArray arrayWithArray:[cookieJar cookies]];
    for (NSHTTPCookie* cookie in cookies) {
        if ([[cookie name] isEqualToString:key]) {
            [cookieJar deleteCookie:cookie];
        }
    }
}
+ (void)deleteAllCookieWithKey
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:iYQUsercookiesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSHTTPCookieStorage* cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* cookies = [NSArray arrayWithArray:[cookieJar cookies]];
    for (NSHTTPCookie* cookie in cookies) {
        [cookieJar deleteCookie:cookie];
    }
}

@end
