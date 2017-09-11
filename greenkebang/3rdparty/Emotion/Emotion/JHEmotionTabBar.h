//
//  JHEmotionTabBar.h
//  emotions
//
//  Created by zhou on 16/7/5.
//  Copyright © 2016年 zhou. All rights reserved.
//  表情键盘底部的选项卡

#import <UIKit/UIKit.h>
@class JHEmotionTabBar;

@protocol JHEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(JHEmotionTabBar *)emotionTabBar didSelectButton:(NSUInteger)buttontype;

@end

@interface JHEmotionTabBar : UIView

@property (nonatomic,weak) id<JHEmotionTabBarDelegate> delegate;

@end
