//
//  CacheDataUtil.m
//  DangKe
//
//  Created by lv on 15/3/24.
//  Copyright (c) 2015年 lv. All rights reserved.
//

#import "CacheDataUtil.h"
#import "ABSaveSystem.h"
@implementation CacheDataUtil

+ (void)saveData:(id)cacheObject withFileName:(NSString*)fileName
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [ABSaveSystem saveObject:cacheObject key:fileName];
    });

}
+ (id)loadCacheObjectWithFileName:(NSString*)fileName
{
   id object = [ABSaveSystem objectForKey:fileName];
    return object;
}
+ (void)cleanCacheWithFileNmae:(NSString *)fileName
{
    [ABSaveSystem removeValueForKey:fileName];
}
+ (void)cleanAllUserCache
{
    [ABSaveSystem removeValueForKey:iDKHomeBannerDataName];
    [ABSaveSystem removeValueForKey:iDKHomeActivityDataName];
    [ABSaveSystem removeValueForKey:iDKDangkeHomeHotTagDataName];
    [ABSaveSystem removeValueForKey:iDKUserHobbyTagDataName];
    [ABSaveSystem removeValueForKey:iDKDangkeHomeListDataName];
    [ABSaveSystem removeValueForKey:iDKDynamicHomeListDataName];
}

@end
