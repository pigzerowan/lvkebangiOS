/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "AppDelegate+UMeng.h"
#import <UMMobClick/MobClick.h>

@implementation AppDelegate (UMeng)

-(void)setupUMeng{
    //友盟
    NSString *bundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
//    if ([bundleID isEqualToString:@"com.easemob.enterprise.demo.ui"]) {
      //  [MobClick startWithAppkey:@"5641be04e0f55a6d63000010"
         //           reportPolicy:BATCH
               //        channelId:Nil];
        
        UMConfigInstance.appKey = @"5641be04e0f55a6d63000010";
        UMConfigInstance.channelId = @"App Store";
//        UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
        [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
#if DEBUG
        [MobClick setLogEnabled:YES];
#else
        [MobClick setLogEnabled:NO];
#endif
//    }
}

@end
