//
//  Utils.h
//  LocalNews
//
//  Created by wind on 15/5/20.
//  Copyright (c) 2015年 vobileinc. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "TransformObject.h"

@interface AppUtils : NSObject
+ (NSString *)URLEncodedString:(NSString *)str;
+ (UIImage *)resizeImage:(UIImage *)img maxSize:(CGSize)maxSize;
+ (int)parseInt:(NSString *)str;
+ (UIImage *)getImage:(NSString *)url;
+ (NSString *)formatTime:(int)time;

+ (NSString *)getPathOfDataCaches;

+ (NSString *)md5:(NSData *)data;
+ (void)copyToClipboard:(NSString *)message;


+(void)showMBMsg:(NSString *)msg inView: (UIView *)view;

+(void)showMBMsg:(NSString *)msg inView: (UIView *)view hideAfterdelay:(NSTimeInterval)delay;

+ (BOOL)checkPhoneNum: (NSString *)phoneNum;

+ (BOOL) checkCorrectPasswd:(NSString *)pswd;

+ (void)setExtraCellLineHidden: (UITableView *)tableView;

+ (UIImage*) createNavBgImageWithColor;

//根据指定格式将NSDate转换为NSString
+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter;
//根据指定格式将NSString转换为NSDate
+ (NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter;

+ (void) animateView:(UIView *)view Up:(BOOL) up MovementDistance:(int)movementDistance;

+ (NSUInteger) lenghtWithString:(NSString *)string;

+ (NSString *)getIPAddress;

//+ (NSDictionary *)CreateDicFromEntity:(id)entity;

+(void)setLabel:(UILabel *)label string:(NSString *)str withLineSpacing:(CGFloat)space;

+(BOOL)cacheTimeIsExpiredWithViewType:(NSUInteger)viewType;

+(void)clearCacheFileWithPath:(NSString *)path isDirectory:(BOOL)isDirectory;

+(id)getLoginUserId;

+(BOOL)isLogined;

+ (void)setApiToken:(id)value;

+ (NSString *)getApiToken;

+ (void)setUseToken:(id)value;

+ (NSString *)getUseToken;


@end
