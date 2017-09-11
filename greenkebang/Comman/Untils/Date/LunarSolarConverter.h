//
//  LunarSolarConverter.h
//
//
//  Created by isee15 on 15/1/13.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lunar : NSObject
/**
*是否闰月
*/
@property(nonatomic, assign) BOOL isleap;
/**
*农历 日
*/
@property(nonatomic, assign) NSInteger lunarDay;
/**
*农历 月
*/
@property(nonatomic, assign) NSInteger lunarMonth;
/**
*农历 年
*/
@property(nonatomic, assign) NSInteger lunarYear;
/**
 *生肖
 */
@property(nonatomic, copy) NSString *zodiac;
/**
 *天干
 */
@property(nonatomic, copy) NSString *tiangan;
/**
 *地支
 */
@property(nonatomic, copy) NSString *dizhi;
/**
 * 中文 月
 */
@property(nonatomic, copy) NSString *chLunarMonth;
/**
 * 中文 日
 */
@property(nonatomic, copy) NSString *chLunarDay;

@end

@interface Solar : NSObject
/**
*公历 日
*/
@property(nonatomic, assign) NSInteger solarDay;
/**
*公历 月
*/
@property(nonatomic, assign) NSInteger solarMonth;
/**
*公历 年
*/
@property(nonatomic, assign) NSInteger solarYear;

- (instancetype)initWithSolarYear:(NSInteger)year solarMonth:(NSInteger)month solarDay:(NSInteger)day;
@end


@interface LunarSolarConverter : NSObject
/**
*农历转公历
*/
+ (Solar *)lunarToSolar:(Lunar *)lunar;

/**
*公历转农历
*/
+ (Lunar *)solarToLunar:(Solar *)solar;
@end
