//
//  JHEmotionListView.h
//  emotions
//
//  Created by zhou on 16/7/5.
//  Copyright © 2016年 zhou. All rights reserved.
//  表情键盘顶部的表情内容（显示所有表情的）

#import <UIKit/UIKit.h>

@interface JHEmotionListView : UIView
/** 表情(里面存放的JHEmotion模型) */
@property (nonatomic, strong) NSArray *emotions;

@end
