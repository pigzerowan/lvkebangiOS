//
//  JHEmotion.h
//  emotions
//
//  Created by zhou on 16/7/6.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** 表情的png图片的路径 */
@property (nonatomic,copy) NSString *pngPath;
/** emoji表情的16进制编码 */
@property (nonatomic, copy) NSString *code;

+ (instancetype)emotionDictWith:(NSDictionary *)dict;

@end
