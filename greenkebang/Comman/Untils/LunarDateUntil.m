//
//  LunarDateUntil.m
//  youqu
//
//  Created by chun.chen on 15/8/16.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import "LunarDateUntil.h"

@implementation LunarDateUntil

//公历每月前面的天数
static const int wMonthAdd[12] = { 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 };

//农历数据
static const int wNongliData[100] = { 2635, 333387, 1701, 1748, 267701, 694, 2391, 133423, 1175, 396438, 3402, 3749, 331177, 1453, 694, 201326, 2350, 465197, 3221, 3402, 400202, 2901, 1386, 267611, 605, 2349, 137515, 2709, 464533, 1738, 2901, 330421, 1242, 2651, 199255, 1323, 529706, 3733, 1706, 398762, 2741, 1206, 267438, 2647, 1318, 204070, 3477, 461653, 1386, 2413, 330077, 1197, 2637, 268877, 3365, 531109, 2900, 2922, 398042, 2395, 1179, 267415, 2635, 661067, 1701, 1748, 398772, 2742, 2391, 330031, 1175, 1611, 200010, 3749, 527717, 1452, 2742, 332397, 2350, 3222, 268949, 3402, 3493, 133973, 1386, 464219, 605, 2349, 334123, 2709, 2890, 267946, 2773, 592565, 1210, 2651, 395863, 1323, 2707, 265877 };

+ (LunarDateUntil*)sharedInstance
{
    static LunarDateUntil* sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
#pragma mark - 农历转换函数
+ (Lunar *)lunarForSolar:(Solar *)solar
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:solar.solarYear];
    [components setMonth:solar.solarMonth];
    [components setDay:solar.solarDay];
//    [components setHour:14];
//    [components setMinute:20];
//    [components setSecond:0];
    NSLog(@"Awesome time: %@", [calendar dateFromComponents:components]);
    return [self lunarForSolarDate:[calendar dateFromComponents:components]];
}
+ (Lunar *)lunarForSolarDate:(NSDate *)solarDate
{

    static NSInteger wCurYear, wCurMonth, wCurDay;
    static NSInteger nTheDate, nIsEnd, m, k, n, i, nBit;

    //取当前公历年、月、日
    NSDateComponents* components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:solarDate];
    wCurYear = [components year];
    wCurMonth = [components month];
    wCurDay = [components day];
    if (wCurYear <= 1921) {
        return nil;
    }
    Solar *solar = [[Solar alloc] initWithSolarYear:wCurYear solarMonth:wCurMonth solarDay:wCurDay];
    
    Lunar *lunar = [LunarSolarConverter solarToLunar:solar];
    
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    if ((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;

    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    while (nIsEnd != 1) {
        if (wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while (n >= 0) {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for (i = 1; i < n + 1; i++)
                nBit = nBit / 2;

            nBit = nBit % 2;

            if (nTheDate <= (29 + nBit)) {
                nIsEnd = 1;
                break;
            }

            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if (nIsEnd)
            break;
        m = m + 1;
    }
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12) {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }

    //生成农历天干、地支、生肖
    lunar.zodiac = (NSString *)[self.cZodiacs objectAtIndex:((wCurYear - 4) % 60) % 12];
    lunar.tiangan = (NSString*)[self.cTianGans objectAtIndex:((wCurYear - 4) % 60) % 10];
    lunar.dizhi = (NSString*)[self.cDiZhis objectAtIndex:((wCurYear - 4) % 60) % 12];

    //生成农历月、日
    NSString* szNongliMonth;
    if (wCurMonth < 1) {
        szNongliMonth = [NSString stringWithFormat:@"闰%@", (NSString*)[self.cMonNames objectAtIndex:-1 * wCurMonth]];
    }
    else {
        szNongliMonth = (NSString*)[self.cMonNames objectAtIndex:wCurMonth];
    }

    lunar.chLunarMonth = szNongliMonth;
    lunar.chLunarDay = (NSString*)[self.cDayNames objectAtIndex:wCurDay];

    return lunar;
}
+ (Solar *)solarForLunar:(Lunar *)lunar
{
    return [LunarSolarConverter lunarToSolar:lunar];
}
+ (NSString*)shuxiangForSolar:(NSDate*)solarDate
{
    NSDateComponents* components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:solarDate];
    NSInteger wCurYear = [components year];
    NSString* szShuXiang = (NSString*)[self.cZodiacs objectAtIndex:((wCurYear - 4) % 60) % 12];
    return szShuXiang;
}
+ (NSString*)constellationWithDate:(NSDate*)date
{
    NSString* returnString = @"";
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    NSInteger i_month = 0;
    NSString* theMonth = [dateFormat stringFromDate:date];
    if ([[theMonth substringToIndex:0] isEqualToString:@"0"]) {
        i_month = [[theMonth substringFromIndex:1] integerValue];
    }
    else {
        i_month = [theMonth integerValue];
    }

    [dateFormat setDateFormat:@"dd"];
    NSInteger i_day = 0;
    NSString* theDay = [dateFormat stringFromDate:date];
    if ([[theDay substringToIndex:0] isEqualToString:@"0"]) {
        i_day = [[theDay substringFromIndex:1] integerValue];
    }
    else {
        i_day = [theDay integerValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
    case 1:
        if (i_day >= 20 && i_day <= 31) {
            returnString = @"水瓶座";
        }
        if (i_day >= 1 && i_day <= 19) {
            returnString = @"摩羯座";
        }
        break;
    case 2:
        if (i_day >= 1 && i_day <= 18) {
            returnString = @"水瓶座";
        }
        if (i_day >= 19 && i_day <= 31) {
            returnString = @"双鱼座";
        }
        break;
    case 3:
        if (i_day >= 1 && i_day <= 20) {
            returnString = @"双鱼座";
        }
        if (i_day >= 21 && i_day <= 31) {
            returnString = @"白羊座";
        }
        break;
    case 4:
        if (i_day >= 1 && i_day <= 19) {
            returnString = @"白羊座";
        }
        if (i_day >= 20 && i_day <= 31) {
            returnString = @"金牛座";
        }
        break;
    case 5:
        if (i_day >= 1 && i_day <= 20) {
            returnString = @"金牛座";
        }
        if (i_day >= 21 && i_day <= 31) {
            returnString = @"双子座";
        }
        break;
    case 6:
        if (i_day >= 1 && i_day <= 21) {
            returnString = @"双子座";
        }
        if (i_day >= 22 && i_day <= 30) {
            returnString = @"巨蟹座";
        }
        break;
    case 7:
        if (i_day >= 1 && i_day <= 22) {
            returnString = @"巨蟹座";
        }
        if (i_day >= 23 && i_day <= 31) {
            returnString = @"狮子座";
        }
        break;
    case 8:
        if (i_day >= 1 && i_day <= 22) {
            returnString = @"狮子座";
        }
        if (i_day >= 23 && i_day <= 31) {
            returnString = @"处女座";
        }
        break;
    case 9:
        if (i_day >= 1 && i_day <= 22) {
            returnString = @"处女座";
        }
        if (i_day >= 23 && i_day <= 30) {
            returnString = @"天秤座";
        }
        break;
    case 10:
        if (i_day >= 1 && i_day <= 23) {
            returnString = @"天秤座";
        }
        if (i_day >= 24 && i_day <= 31) {
            returnString = @"天蝎座";
        }
        break;
    case 11:
        if (i_day >= 1 && i_day <= 21) {
            returnString = @"天蝎座";
        }
        if (i_day >= 22 && i_day <= 30) {
            returnString = @"射手座";
        }
        break;
    case 12:
        if (i_day >= 1 && i_day <= 21) {
            returnString = @"射手座";
        }
        if (i_day >= 22 && i_day <= 31) {
            returnString = @"摩羯座";
        }
        break;
    default:
        break;
    }
    return returnString;
}
#pragma mark- Getter & Setter
// 农历天干
+ (NSArray *)cTianGans
{
    static NSArray *_cTianGans;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cTianGans = @[ @"甲", @"乙", @"丙", @"丁", @"戊", @"己", @"庚", @"辛", @"壬", @"癸" ];
    });
    return _cTianGans;
}
///**< 农历地支*/
+ (NSArray *)cDiZhis
{
    static NSArray *_cDiZhis;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cDiZhis = @[ @"子", @"丑", @"寅", @"卯", @"辰", @"巳", @"午", @"未", @"申", @"酉", @"戌", @"亥" ];
    });
    return _cDiZhis;
}
///**< 生肖*/
+ (NSArray *)cZodiacs
{
    static NSArray *_cZodiacs;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cZodiacs = @[ @"鼠", @"牛", @"虎", @"兔", @"龙", @"蛇", @"马", @"羊", @"猴", @"鸡", @"狗", @"猪" ];
    });
    return _cZodiacs;
}
///**< 农历月份*/
+ (NSArray *)cMonNames
{
    static NSArray *_cMonNames;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cMonNames = @[ @"*", @"正", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @"十一", @"腊" ];
    });
    return _cMonNames;
}
///**< 农历天数*/
+ (NSArray *)cDayNames
{
    static NSArray *_cDayNames;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cDayNames = @[ @"*", @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十" ];
    });
    return _cDayNames;
}
@end
