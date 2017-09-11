//
//  UserDefaultsUtils.h
//  LocalNews
//
//  Created by wind on 15/5/20.
//  Copyright (c) 2015年 vobileinc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtils : NSObject

+(void)saveValue:(id) value forKey:(NSString *)key;

+(id)valueWithKey:(NSString *)key;

+(BOOL)boolValueWithKey:(NSString *)key;

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

+(void)removeWithKey:(NSString *)key;

+(void)print;

@end
