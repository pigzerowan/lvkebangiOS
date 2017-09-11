//
//  LunarDateUntil.h
//  youqu
//
//  Created by chun.chen on 15/8/16.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunarSolarConverter.h"

/**
 *   eg:
 NSDate *gDate = [NSDate dateFromDateString:@"2000-02-12"];
 Lunar *lunar = [LunarDateUntil lunarForSolarDate:gDate];
 Solar *solar = [LunarDateUntil solarForLunar:lunar];
 Lunar *lunar2 = [LunarDateUntil lunarForSolar:solar];
 
 NSLog(@"lunar =%@| %@-%@-%@ \n%@-%@-%@-%@-%@",@(lunar.isleap),@(lunar.lunarYear),@(lunar.lunarMonth),@(lunar.lunarDay), lunar.chLunarMonth,lunar.chLunarDay,lunar.zodiac,lunar.tiangan,lunar.dizhi);
 
 NSLog(@"solar = %@-%@-%@",@(solar.solarYear),@(solar.solarMonth),@(solar.solarDay));
 
 NSLog(@"lunar2 =%@| %@-%@-%@ \n%@-%@-%@-%@-%@",@(lunar2.isleap),@(lunar2.lunarYear),@(lunar2.lunarMonth),@(lunar2.lunarDay), lunar2.chLunarMonth,lunar2.chLunarDay,lunar2.zodiac,lunar2.tiangan,lunar2.dizhi);
 */
@interface LunarDateUntil : NSObject

+ (LunarDateUntil *)sharedInstance;
/**< 公历转农历*/
+ (Lunar *)lunarForSolar:(Solar *)solar;
+ (Lunar *)lunarForSolarDate:(NSDate *)solarDate;
/**< 农历转公历*/
+ (Solar *)solarForLunar:(Lunar *)lunar;
/**< 生肖*/
+ (NSString *)shuxiangForSolar:(NSDate *)solarDate;
/**< 星座*/
+ (NSString *)constellationWithDate:(NSDate *)date;

@end



