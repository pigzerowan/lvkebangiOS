//
//  JHTextPart.m
//  emotions
//
//  Created by zhou on 16/7/12.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "JHTextPart.h"

@implementation JHTextPart
/**
 *  nslog打印这个对象就回调用
 *
 *  @return <#return value description#>
 */
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
