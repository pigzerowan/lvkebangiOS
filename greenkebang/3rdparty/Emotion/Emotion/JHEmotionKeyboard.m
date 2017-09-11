//
//  JHEmotionKeyboard.m
//  emotions
//
//  Created by zhou on 16/7/5.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "JHEmotionKeyboard.h"
#import "JHEmotionTabBar.h"
#import "JHEmotionListView.h"
#import "UIView+Extension.h"
#import "JHEmotion.h"
#import "JHEmotionTool.h"
//#import "NSObject+MJKeyValue.h"

@interface JHEmotionKeyboard ()<JHEmotionTabBarDelegate>
/** tabbar */
@property (nonatomic, strong) JHEmotionTabBar *tabBar;

/** 容纳表情内容的控件 */
@property (nonatomic, strong) UIView *contentView;

/** 表情内容 */
@property (nonatomic, strong) JHEmotionListView *rencentListView;
@property (nonatomic, strong) JHEmotionListView *defaultListView;
@property (nonatomic, strong) JHEmotionListView *emojiListView;
@property (nonatomic, strong) JHEmotionListView *lxhListView;

@end

@implementation JHEmotionKeyboard

#pragma mark 懒加载
- (JHEmotionListView *)rencentListView
{
    if (_rencentListView == nil) {
        _rencentListView = [[JHEmotionListView alloc]init];
//        _rencentListView.backgroundColor = [self randomColor];
        // 加载沙盒中的数据
        _rencentListView.emotions = [JHEmotionTool recentEmotions];
    }
    return _rencentListView;
}
- (JHEmotionListView *)defaultListView
{
    if (_defaultListView == nil) {
        
        _defaultListView = [[JHEmotionListView alloc]init];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
////        _defaultListView.emotions = [JHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
//        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
//        
//        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
//        
//        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSDictionary *dict = obj;
//            JHEmotion *model = [JHEmotion emotionDictWith:dict];
//            model.pngPath = [NSString stringWithFormat:@"EmotionIcons/default/%@",model.png];
//            [arrM addObject:model];
//        }];
//        _defaultListView.emotions = arrM;
        
        _defaultListView.emotions = [JHEmotionTool defaultEmotions];
    }
    return _defaultListView;
}
- (JHEmotionListView *)emojiListView
{
    if (_emojiListView == nil) {
        _emojiListView = [[JHEmotionListView alloc]init];
//        _emojiListView.backgroundColor = [self randomColor];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
////        _emojiListView.emotions = [JHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
//        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
//        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
//        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSDictionary *dict = obj;
//            JHEmotion *model = [JHEmotion emotionDictWith:dict];
//            model.pngPath = [NSString stringWithFormat:@"EmotionIcons/emoji/%@",model.png];
//            [arrM addObject:model];
//        }];
//        _emojiListView.emotions = arrM;
        _emojiListView.emotions = [JHEmotionTool emojiEmotions];
    }
    return _emojiListView;
}
- (JHEmotionListView *)lxhListView
{
    if (_lxhListView == nil) {
        _lxhListView = [[JHEmotionListView alloc]init];
//        _lxhListView.backgroundColor = [self randomColor];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
////        _lxhListView.emotions = [JHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
//        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
//        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
//        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSDictionary *dict = obj;
//            JHEmotion *model = [JHEmotion emotionDictWith:dict];
//            model.pngPath = [NSString stringWithFormat:@"EmotionIcons/lxh/%@",model.png];
//            [arrM addObject:model];
//        }];
//        _lxhListView.emotions = arrM;
        _lxhListView.emotions = [JHEmotionTool lxhEmotions];
    }
    return _lxhListView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //1.表情内容
        UIView *contentView = [[UIView alloc]init];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        //2.tabBar
        JHEmotionTabBar *tabBar = [[JHEmotionTabBar alloc]init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        
        // 表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect) name:@"JHEmotionDidSelectNotification" object:nil];
    }
    
    return self;
}
- (void)emotionDidSelect
{
    self.rencentListView.emotions = [JHEmotionTool recentEmotions];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1.tabBar
    self.tabBar.emojiwidth = self.emojiwidth;
    self.tabBar.emojiheight = 37;
    self.tabBar.emojix = 0;
    self.tabBar.emojiy = self.emojiheight - self.tabBar.emojiheight;
    
    //2.表情内容
    self.contentView.emojix = self.contentView.emojiy = 0;
    self.contentView.emojiwidth = self.emojiwidth;
    self.contentView.emojiheight = self.tabBar.emojiy;
    
    //3.设置frame
    UIView *child = [self.contentView.subviews lastObject];
    child.frame = self.contentView.bounds;
    
    
}


#pragma mark - JHEmotionTabBarDelegate
- (void)emotionTabBar:(JHEmotionTabBar *)emotionTabBar didSelectButton:(NSUInteger)buttontype
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (buttontype) {
        case 0:
            [self.contentView addSubview:self.rencentListView];
            
            break;
        case 1:{//默认
            
//            [self.contentView addSubview:self.defaultListView];
        [self.contentView addSubview:self.emojiListView];
            break;
        }
        case 2:{//emoji
            
            [self.contentView addSubview:self.emojiListView];
            break;
        }
        case 3:{//浪小花
            
            [self.contentView addSubview:self.lxhListView];
            break;
        }
            
        default:
            break;
    }
    
    [self setNeedsLayout];
}

// 随机颜色
- (UIColor*)randomColor
{
    
    CGFloat r = arc4random() % 256 / 255.0;
    CGFloat g = arc4random() % 256 / 255.0;
    CGFloat b = arc4random() % 256 / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


@end
