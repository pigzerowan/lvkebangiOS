//
//  NSObject+Properties.m
//  youqu
//
//  Created by chun.chen on 15/8/18.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import "NSObject+Properties.h"
#import <objc/runtime.h>

@implementation NSObject (Properties)

- (NSString*)propertiesValues
{
    unsigned int numIvars = 0;
    Ivar * ivars = class_copyIvarList([self class], &numIvars);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:numIvars];
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        NSLog(@"ivar name is :%s",ivar_getName(thisIvar));
        NSString* key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
//        const char *type = ivar_getTypeEncoding(thisIvar);
//        NSString *stringType =  [[NSString stringWithCString:type encoding:NSUTF8StringEncoding] lowercaseString];
        id obj = object_getIvar(self, thisIvar);
        if (obj) {
            [dic setObject:obj forKey:key];
        } else {
            [dic setObject:@"nil" forKey:key];
        }
    }
    free(ivars);
    
    return [NSString stringWithFormat:@"<%@ : %p, %@>",
            [self class],
            self,
            dic];
}
#pragma private - 私有方法

// 获取一个类的属性名字列表
- (NSArray*)propertyNames:(Class)class
{
    NSMutableArray  *propertyNames = [[NSMutableArray alloc] init];
    unsigned int     propertyCount = 0;
    objc_property_t *properties    = class_copyPropertyList(class, &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; ++i)
    {
        objc_property_t  property = properties[i];
        const char      *name     = property_getName(property);
        
        [propertyNames addObject:[NSString stringWithUTF8String:name]];
    }
    
    free(properties);
    
    return propertyNames;
}

// 根据属性数组获取该属性的值
- (NSDictionary*)propertiesAndValuesDictionary:(id)obj properties:(NSArray *)properties
{
    NSMutableDictionary *propertiesValuesDic = [NSMutableDictionary dictionary];
    
    for (NSString *property in properties)
    {
        SEL getSel = NSSelectorFromString(property);
        
        if ([obj respondsToSelector:getSel])
        {
            NSMethodSignature  *signature  = nil;
            signature                      = [obj methodSignatureForSelector:getSel];
            NSInvocation       *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:obj];
            [invocation setSelector:getSel];
            NSObject * __unsafe_unretained valueObj = nil;
            [invocation invoke];
            [invocation getReturnValue:&valueObj];
            
            //assign to @"" string
            if (valueObj == nil)
            {
                valueObj = @"";
            }
            
            propertiesValuesDic[property] = valueObj;
        }
    }
    
    return propertiesValuesDic;
}
@end
