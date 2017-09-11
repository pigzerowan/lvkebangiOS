//
//  JHEmotionTool.m
//  emotions
//
//  Created by zhou on 16/7/11.
//  Copyright © 2016年 zhou. All rights reserved.
//
// 最近表情的存储路径
#define JHRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

#import "JHEmotionTool.h"
#import "JHEmotion.h"

@implementation JHEmotionTool

static NSMutableArray *_recentEmotions;
static NSArray *_emojiEmotions, *_defaultEmotions, *_lxhEmotions;



+ (void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:JHRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

+ (JHEmotion *)emotionWithChs:(NSString *)chs
{
    NSArray *defaults = [self defaultEmotions];
    for (JHEmotion *emotion in defaults) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    
    NSArray *lxhs = [self lxhEmotions];
    for (JHEmotion *emotion in lxhs) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    
    return nil;
}

+ (void)addRecentEmotion:(JHEmotion *)emotion
{
    // 加载沙盒中的表情数据
//    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
//    if (emotions == nil) {
//        emotions = [NSMutableArray array];
//    }
//    
//    // 将表情放到数组的最前面
//    [emotions insertObject:emotion atIndex:0];
//    
//    // 将所有的表情数据写入沙盒
//    [NSKeyedArchiver archiveRootObject:emotions toFile:JHRecentEmotionsPath];
    
    
    // 删除重复的表情
    [_recentEmotions removeObject:emotion];
    
    // 将表情放到数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:JHRecentEmotionsPath];

}
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}

+ (NSArray *)defaultEmotions
{
    if (_defaultEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/defaultinfo.plist" ofType:nil];
        //        _defaultListView.emotions = [JHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = obj;
            JHEmotion *model = [JHEmotion emotionDictWith:dict];
            model.pngPath = [NSString stringWithFormat:@"EmotionIcons/default/%@",model.png];
            [arrM addObject:model];
        }];
        _defaultEmotions = arrM;
    }
    
    return _defaultEmotions;
    
}
+ (NSArray *)lxhEmotions
{
    if (_lxhEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/lxhinfo.plist" ofType:nil];
        //        _lxhListView.emotions = [JHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = obj;
            JHEmotion *model = [JHEmotion emotionDictWith:dict];
            model.pngPath = [NSString stringWithFormat:@"EmotionIcons/lxh/%@",model.png];
            [arrM addObject:model];
        }];
        _lxhEmotions = arrM;

    }
    
    return _lxhEmotions;
}
+ (NSArray *)emojiEmotions
{
    if (_emojiEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/emojiinfo.plist" ofType:nil];
        //        _emojiListView.emotions = [JHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = obj;
            JHEmotion *model = [JHEmotion emotionDictWith:dict];
            model.pngPath = [NSString stringWithFormat:@"EmotionIcons/emoji/%@",model.png];
            [arrM addObject:model];
        }];
        _emojiEmotions = arrM;
    }
    
    return _emojiEmotions;
}


// 加载沙盒中的表情数据
//    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
//    if (emotions == nil) {
//        emotions = [NSMutableArray array];
//    }

//    [emotions removeObject:emotion];
//    for (int i = 0; i<emotions.count; i++) {
//        JHEmotion *e = emotions[i];
//
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//            break;
//        }
//    }

//    for (JHEmotion *e in emotions) {
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//            break;
//        }
//    }

@end
