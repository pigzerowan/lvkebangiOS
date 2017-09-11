//
//  JHEmotion.m
//  emotions
//
//  Created by zhou on 16/7/6.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "JHEmotion.h"

@interface JHEmotion ()<NSCoding>

@end

@implementation JHEmotion
+ (instancetype)emotionDictWith:(NSDictionary *)dict
{
    JHEmotion *obj = [[JHEmotion alloc]init];
    obj.chs = dict[@"chs"];
    obj.png = dict[@"png"];
    obj.code = dict[@"code"];
    obj.pngPath = dict[@"pngPath"];
    return obj;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
        self.pngPath = [decoder decodeObjectForKey:@"pngPath"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
    [encoder encodeObject:self.pngPath forKey:@"pngPath"];
}



- (BOOL)isEqual:(JHEmotion *)other
{
    //    if (self == other) {
    //        return YES;
    //    } else {
    //        return NO;
    //    }
    
    //    HWLog(@"%@--isEqual---%@", self.chs, other.chs);
    
    //    NSString *str1 = @"jack";
    //    NSString *str2 = [NSString stringWithFormat:@"jack"];
    //
    //    str1 == str2 // no
    //    [str1 isEqual:str2]; // NO
    //    [str1 isEqualToString:str2] // YES
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}


@end
