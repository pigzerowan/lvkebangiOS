//
//  UILabel+Specif.m
//  youqu
//
//  Created by chun.chen on 15/8/6.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import "UILabel+Specif.h"

@implementation UILabel (Specif)
+ (UILabel *)specifLabelWithFontSize:(CGFloat)size
                           textColor:(UIColor *)textColor
                                text:(NSString *)text
{
    UILabel* specifLabel = [[UILabel alloc] init];
    specifLabel.numberOfLines = 1;
    specifLabel.font = [UIFont systemFontOfSize:size];
    specifLabel.textColor = textColor;
    specifLabel.text = text;
    return specifLabel;
}
@end
