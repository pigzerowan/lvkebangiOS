//
//  Utils.m
///  LocalNews
//
//  Created by wind on 15/5/20.
//  Copyright (c) 2015年 vobileinc. All rights reserved.
//
//

#import "AppUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "MBProgressHUD+Add.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "UserDefaultsUtils.h"
#import "LKBVenderDefine.h"

#define kUserTokenId @"user_token"
#define kApiTokenId @"api_token"

#define IMAGE_CACHE [NSString stringWithFormat:@"%@/tmp/cache", NSHomeDirectory()]

@implementation AppUtils

+ (NSString *)getPathOfDataCaches{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[paths lastObject] stringByAppendingPathComponent:kCache_Folder];
}

+ (NSString *)md5:(NSData *)data{
	const char *cStr = [data bytes];
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, (CC_LONG)[data length], digest );
	NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				   digest[0], digest[1],
				   digest[2], digest[3],
				   digest[4], digest[5],
				   digest[6], digest[7],
				   digest[8], digest[9],
				   digest[10], digest[11],
				   digest[12], digest[13],
				   digest[14], digest[15]];
	return s;
	
}

+ (NSString *)URLEncodedString:(NSString *)str {
    NSString *encodedString = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                     (CFStringRef)str,
                                                                                                     (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                     NULL,
                                                                                                     kCFStringEncodingUTF8));
    return encodedString;
}

+ (UIImage *)resizeImage:(UIImage *)img maxSize:(CGSize)maxSize {
	float width = img.size.width;
	float height = img.size.height;
    
	if (width > maxSize.width || height > maxSize.height) {
		float scale = MIN(maxSize.width / width, maxSize.height / height);
		width = width * scale;
		height = height * scale;
	} else {
        return img;
    }
    
	CGSize newSize = CGSizeMake(width, height);
    
	UIGraphicsBeginImageContext(newSize);
    [img drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (int)parseInt:(NSString *)str {
    return [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] intValue];
}

+ (UIImage *)getImage:(NSString *)url {
    if (![[NSFileManager defaultManager] fileExistsAtPath:IMAGE_CACHE]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:IMAGE_CACHE
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", IMAGE_CACHE, [AppUtils md5:[url dataUsingEncoding:NSUTF8StringEncoding]]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [UIImage imageWithContentsOfFile:path];
    } else {
        // download it
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[AppUtils URLEncodedString:url]]];
        if (data) {
            return [UIImage imageWithData:data];
        }
    }
    
    return nil;
}

+ (NSString *)formatTime:(int)time {
    int h = time / 3600;
    int m = (time % 3600) / 60;
    int s = time % 60;
    
    NSString *str = @"";
    if (h > 0) {
        str = [str stringByAppendingFormat:@"%d:", h];
    }
    
    NSString *ss;
    if (s < 10) {
        ss = [NSString stringWithFormat:@"0%d", s];
    } else {
        ss = [NSString stringWithFormat:@"%d", s];
    }
    return [str stringByAppendingFormat:@"%d:%@", m, ss];
}

+ (void)copyToClipboard:(NSString *)message {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = message;
}



+(void)showMBMsg:(NSString *)msg inView: (UIView *)view {
    
//    if ((msg = [NSNull null])) {
//        return;
//    }
//    
    
//  else
    if (![msg isKindOfClass:[NSNull class]])
    {
      if (msg && msg.length > 0) {
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.margin = 20.f;
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabelText = msg;
        hud.detailsLabelFont = [UIFont systemFontOfSize:14.0];
        [hud hide:YES afterDelay:2];
    }
    }
}

+(void)showMBMsg:(NSString *)msg inView: (UIView *)view hideAfterdelay:(NSTimeInterval)delay
{
    if (msg && msg.length > 0) {
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.margin = 20.f;
        hud.removeFromSuperViewOnHide = YES;
        hud.detailsLabelText = msg;
        hud.detailsLabelFont = [UIFont systemFontOfSize:14.0];
        [hud hide:YES afterDelay:delay];
    }
}

+ (BOOL) checkCorrectPasswd:(NSString *)pswd
{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSRange userNameRange = [pswd rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        return NO;
    }
    return YES;
}

+ (BOOL)checkPhoneNum: (NSString *)phoneNum
{
    NSString * MOBILE = @"^((1[3-8])+\\d{9})$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:phoneNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}


+ (UIImage*) createNavBgImageWithColor
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [NAV_BG_COLOR CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:dateString];
}

+ (void) animateView:(UIView *)view Up:(BOOL) up MovementDistance:(int)movementDistance
{
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"animView" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    view.frame = CGRectOffset(view.frame, 0, movement);
    [UIView commitAnimations];
}

+ (NSUInteger) lenghtWithString:(NSString *)string
{
    NSUInteger len = string.length;
    NSString * pattern  = @"[\u4e00-\u9fa5]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSInteger numMatch = [regex numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    
    return len + numMatch;
}

//+ (NSString *)getIPAddress
//{
//    InitAddresses();
//    GetIPAddresses();
//    GetHWAddresses();
//    
//    int i;
//    NSString *deviceIP = nil;
//    for (i=0; i<MAXADDRS; ++i)
//    {
//        static unsigned long localHost = 0x7F000001;
//        unsigned long theAddr;
//        
//        theAddr = ip_addrs[i];
//        
//        if (theAddr == 0) break;
//        if (theAddr == localHost) continue;
//        
//        if(strcmp(if_names[i], "en0") == 0 || strcmp(if_names[i], "en1") == 0)
//        {
//            deviceIP = [NSString stringWithFormat:@"%s", ip_names[i]];
//            break;
//        }
//        
//        DLog(@"Name: %s MAC: %s IP: %s\n", if_names[i], hw_addrs[i], ip_names[i]);
//    }
//    return deviceIP;
//    
//}

+ (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

//+ (NSDictionary *)CreateDicFromEntity:(id)entity
//{
//    return [TransformObject getObjectData:entity];
//}

+(void)setLabel:(UILabel *)label string:(NSString *)str withLineSpacing:(CGFloat)space
{
    
    NSMutableAttributedString * mas=[[NSMutableAttributedString alloc]init];
    
    NSMutableParagraphStyle * style=[NSMutableParagraphStyle new];
    
    style.alignment=NSTextAlignmentLeft;
    
    style.lineSpacing=space;
    
    style.lineBreakMode = NSLineBreakByWordWrapping;
    
    style.paragraphSpacing=space;
    
    NSDictionary * attributesDict=@{
//                                    NSFontAttributeName:[UIFont systemFontOfSize:13],                                    NSForegroundColorAttributeName:[UIColor blackColor],
                                    NSParagraphStyleAttributeName:style
                                    };
    
    NSAttributedString *as=[[NSAttributedString alloc]initWithString:str attributes:attributesDict];
    
    [mas appendAttributedString:as];
    
    [label setAttributedText:mas];
}

+(BOOL)cacheTimeIsExpiredWithViewType:(NSUInteger)viewType;
{
//    NSString *lastRefreshTimeKey;
//    switch (viewType) {
//        case ViewTypePosition:
//            lastRefreshTimeKey = kRefresh_Time_Position_Info;
//            break;
//        case ViewTypeNewsLocal:
//            lastRefreshTimeKey = kRefresh_Time_News_Local;
//            break;
//        case ViewTypeNewsHot:
//            lastRefreshTimeKey = kRefresh_Time_News_Hot;
//            break;
//        case ViewTypeWechatLocal:
//            lastRefreshTimeKey = kRefresh_Time_Wechat_Local;
//            break;
//        case ViewTypeWechatHot:
//            lastRefreshTimeKey = kRefresh_Time_Wechat_Hot;
//            break;
//        case ViewTypeWechatFollow:
//            lastRefreshTimeKey = kRefresh_Time_Wechat_follow;
//            break;
//        case ViewTypeWechatInfo:
//            lastRefreshTimeKey = kRefresh_Time_Wechat_Info;
//            break;
//        case ViewTypeSearch:
//            lastRefreshTimeKey = kRefresh_Time_Search_Keyword;
//            break;
//            
//        default:
//            break;
//    }
//    
//    NSTimeInterval lastRefreshTime = [[UserDefaultsUtils valueWithKey:lastRefreshTimeKey] doubleValue];
//    NSTimeInterval nowTime = [[NSDate date] timeIntervalSinceReferenceDate];
//    if (nowTime - lastRefreshTime > CACHE_EXPIRED_SEC) {
//        
//        [UserDefaultsUtils saveValue:[NSString stringWithFormat:@"%f", nowTime] forKey:lastRefreshTimeKey];
//        
        return YES;
//    } else {
//        return NO;
//    }
}

+(void)clearCacheFileWithPath:(NSString *)path isDirectory:(BOOL)isDirectory;
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    if (isDirectory) {
        NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
        NSString *filePath;
        for (int i = 0; i < array.count; i++)
        {
            filePath = [path stringByAppendingPathComponent:array[i]];
            BOOL isDir;
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir]) {
                NSArray *subArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:nil];
                NSString *subPath;
                for (int i = 0; i < subArray.count; i++)
                {
                    subPath = [filePath stringByAppendingPathComponent:subArray[i]];
                    [[NSFileManager defaultManager] removeItemAtPath:subPath error:nil];
                }
            } else {
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            }
        }
        
//        NSEnumerator *e = [array objectEnumerator];
//        NSString *filename;
//        while ((filename = [e nextObject])) {
//            
//            if ([[filename pathExtension] isEqualToString:extension]) {
//                
//                [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
//            }
//        }
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }

//    });
}

+(id)getLoginUserId;
{
    NSDictionary *loginUserInfoDic = [UserDefaultsUtils valueWithKey:kLogin_UserInfo_Dic_Key];
    if (loginUserInfoDic) {
        NSString *loginUserId = [loginUserInfoDic objectForKey:kUser_User_Id_Key];
        if (loginUserId) {
            return loginUserId;
        } else {
//            return [NSNull null];
            return @"";
        }
    } else {
//        return [NSNull null];
        return @"";
    }
}

+(BOOL)isLogined;
{
    NSDictionary *loginUserInfoDic = [UserDefaultsUtils valueWithKey:kLogin_UserInfo_Dic_Key];
    if (loginUserInfoDic) {
        NSString *loginUserId = [loginUserInfoDic objectForKey:kUser_User_Id_Key];
        if (loginUserId && loginUserId.length > 0) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

+ (void)setApiToken:(id)value {
    [UserDefaultsUtils saveValue:value forKey:kApiTokenId];
}

+ (NSString *)getApiToken {
    return [UserDefaultsUtils valueWithKey:kApiTokenId];
}

+ (void)setUseToken:(id)value {
    [UserDefaultsUtils saveValue:value forKey:kUserTokenId];
}

+ (NSString *)getUseToken {
    return [UserDefaultsUtils valueWithKey:kUserTokenId];
}





@end
