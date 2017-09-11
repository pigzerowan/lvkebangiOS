//
//  ModelToDictionary.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/30.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "ModelToDictionary.h"

@implementation ModelToDictionary

-(BOOL)reflectDataFromOtherObject:(NSDictionary *)dic
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *propertyType = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        
        if ([[dic allKeys] containsObject:propertyName]) {
            id value = [dic valueForKey:propertyName];
            if (![value isKindOfClass:[NSNull class]] && value != nil) {
                if ([value isKindOfClass:[NSDictionary class]]) {
                    id pro = [self createInstanceByClassName:[self getClassName:propertyType]];
                    [pro reflectDataFromOtherObject:value];
                    [self setValue:pro forKey:propertyName];
                }else{
                    [self setValue:value forKey:propertyName];
                }
            }
        }
    }
    free(properties);
    return true;
}


-(NSString *)getClassName:(NSString *)attributes
{
    NSString *type = [attributes substringFromIndex:[attributes rangeOfString:@"\""].location + 1];
    type = [type substringToIndex:[type rangeOfString:@"\""].location];
    return type;
}
-(id) createInstanceByClassName: (NSString *)className {
    NSBundle *bundle = [NSBundle mainBundle];
    Class aClass = [bundle classNamed:className];
    id anInstance = [[aClass alloc] init];
    return anInstance;
}

//-(NSDictionary *)convertModelToDictionary
//{
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    
//    for (NSString *key in [self propertyKeys]) {
//        id propertyValue = [self valueForKey:key];
//        //该值不为NSNULL，并且也不为nil
//        [dic setObject:propertyValue forKey:key];
//    }
//    
//    return dic;
//}
@end
