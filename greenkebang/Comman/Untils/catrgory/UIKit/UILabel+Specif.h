//
//  UILabel+Specif.h
//  youqu
//
//  Created by chun.chen on 15/8/6.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Specif)

+ (UILabel *)specifLabelWithFontSize:(CGFloat)size
                                textColor:(UIColor *)textColor
                                text:(NSString *)text;

@end
