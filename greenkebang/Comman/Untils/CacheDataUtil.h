//
//  CacheDataUtil.h
//  DangKe
//
//  Created by lv on 15/3/24.
//  Copyright (c) 2015年 lv. All rights reserved.
//

#import <Foundation/Foundation.h>

// 首页Banner 缓存数据
static NSString *const iDKHomeBannerDataName =  @"homeBannerData";
// 首页推荐 缓存数据
static NSString *const iDKHomeActivityDataName =  @"homeActivityData";
// 首页标签 缓存数据
static NSString *const iDKDangkeHomeHotTagDataName =  @"dangkeHomeyHotTagData";
// 用户爱好标签 缓存数据
static NSString *const iDKUserHobbyTagDataName =  @"userHobbyTagData";
// 首页 缓存数据
static NSString *const iDKDangkeHomeListDataName =  @"dangkeHomeListData";
// 首页 缓存数据
static NSString *const iDKDynamicHomeListDataName =  @"dynamicHomeListData";

@interface CacheDataUtil : NSObject

+ (void)saveData:(id)cacheObject withFileName:(NSString*)fileName;
+ (id)loadCacheObjectWithFileName:(NSString*)fileName;
+ (void)cleanAllUserCache;
+ (void)cleanCacheWithFileNmae:(NSString *)fileName;
@end
