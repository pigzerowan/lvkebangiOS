//
//  UIColor+Util.m
//  iosapp
//
//  Created by chenhaoxiang on 14-10-18.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import "UIColor+Util.h"

@implementation UIColor (Util)

#pragma mark - Hex

+ (UIColor*)colorWithHex:(int)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF)) / 255.0
                           alpha:alpha];
}

+ (UIColor*)colorWithHex:(int)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

#pragma mark - theme colors

+ (UIColor*)themeColor
{
    return [UIColor colorWithRed:235.0 / 255 green:235.0 / 255 blue:243.0 / 255 alpha:1.0];
}
+ (UIColor *)spotColor
{
    return [UIColor colorWithHex:0x0099ff];
}
+ (UIColor *)spotColor2
{
    return CCColorFromRGBA(70, 171, 53, 1);
}
//+ (UIColor *)LkbgreenColor
//{
//    return UIColorWithRGBA(67, 148, 86, 1);
//}
+ (UIColor *)LkbgreenColor
{
    return [UIColor colorWithHex:0x22a941];
}

+ (UIColor *)LkbBtnColor
{
    return UIColorWithRGBA(22, 153, 71, 1);
}
+ (UIColor *)textGrayColor
{
    return [UIColor colorWithHex:0x999999];
}
+ (UIColor*)nameColor
{
    return [UIColor colorWithHex:0x087221];
}

+ (UIColor*)navbarColor
{
    return [UIColor colorWithHex:0x22a941];
}




+ (UIColor*)titleColor
{
    return [UIColor colorWithHex:0x333333];
}

+ (UIColor*)separatorColor
{
    return [UIColor colorWithHex:0xCCCCCC];
}

+ (UIColor*)cellsColor
{
    return [UIColor whiteColor];
}

+ (UIColor*)titleBarColor
{
    return [UIColor colorWithHex:0xE1E1E1];
}

+ (UIColor*)selectTitleBarColor
{
    return [UIColor colorWithHex:0xE1E1E1];
}

+ (UIColor*)navigationbarColor
{
    return [UIColor colorWithHex:0x15A230]; //0x009000
}

+ (UIColor*)selectCellSColor
{
    return [UIColor colorWithRed:203.0 / 255 green:203.0 / 255 blue:203.0 / 255 alpha:1.0];
}
+ (UIColor*)infosBackViewColor
{
    return [UIColor colorWithHex:0xf7f7f7];
}

@end
