//
//  JHEmotionTool.h
//  emotions
//
//  Created by zhou on 16/7/11.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHEmotion;

@interface JHEmotionTool : NSObject

+ (void)addRecentEmotion:(JHEmotion *)emotion;
+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;
+ (NSArray *)emojiEmotions;


+ (JHEmotion *)emotionWithChs:(NSString *)chs;

@end
