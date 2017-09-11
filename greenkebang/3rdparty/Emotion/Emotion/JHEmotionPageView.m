//
//  JHEmotionPageView.m
//  emotions
//
//  Created by zhou on 16/7/8.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "JHEmotionPageView.h"
#import "UIView+Extension.h"
#import "JHEmotion.h"
#import "JHEmotionPopView.h"
#import "JHEmotionButton.h"
#import "JHEmotionTool.h"

@interface JHEmotionPageView ()
/** 点击表情后弹出的放大镜 */
@property (nonatomic, strong) JHEmotionPopView *popView;
/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation JHEmotionPageView

- (JHEmotionPopView *)popView
{
    if (_popView == nil) {
        _popView = [JHEmotionPopView popView];
    }
    return _popView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //删除按钮
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton = deleteButton;
        [self addSubview:deleteButton];
        //添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}
/**
 *  根据手指位置所在的表情按钮
 */
- (JHEmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        JHEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            
            return btn;
        }
    }
    return nil;
}
/**
 *  在这个方法中处理长按手势
 */
- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    JHEmotionButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            // 移除popView
            [self.popView removeFromSuperview];
            // 如果手指还在表情按钮上
            if (btn) {
                // 发出通知
                [self selectEmotion:btn.emotion];
            }

            
            break;
        }
        case UIGestureRecognizerStateBegan: // 手势开始（刚检测到长按）
        case UIGestureRecognizerStateChanged:{
            [self.popView showFrom:btn];
            
            break;
        }
            
        default:
            break;
    }
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        JHEmotionButton *btn = [[JHEmotionButton alloc]init];
       // 设置表情数据
        btn.emotion = emotions[i];
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat inset = 10;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.emojiwidth - 2 * inset)/7;
    CGFloat btnH = (self.emojiheight - inset)/3;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i+1];//因为在创建这个表情页面的时候，先加上的是删除按钮，所以第一个子控件是删除按钮；如果 i ＝＝ 1开始，那么下面的x和y要变
        btn.emojiwidth = btnW;
        btn.emojiheight = btnH;
        btn.emojix = inset + (i % 7) * btnW;
        btn.emojiy = inset + (i / 7) * btnH;
    }
    
    self.deleteButton.emojiwidth = btnW;
    self.deleteButton.emojiheight = btnH;
    self.deleteButton.emojix = self.emojiwidth - inset - btnW;
    self.deleteButton.emojiy = self.emojiheight - btnH;
}
/**
 *  监听删除按钮的点击
 *
 *  @param sender <#sender description#>
 */
- (void)deleteClick:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"JHEmotionDidDeleteNotification" object:nil];
}

/**
 *  监听表情按钮点击
 *
 *  @param btn 被点击的表情按钮
 */
- (void)btnClick:(JHEmotionButton *)sender
{
    // 给popView传递数据
//    self.popView.emotion = sender.emotion;
    
    [self.popView showFrom:sender];
    
    // 等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    //发出通知
    [self selectEmotion:sender.emotion];
}

/**
 *  选中某个表情，发出通知
 *
 *  @param emotion 被选中的表情
 */
- (void)selectEmotion:(JHEmotion *)emotion
{
    // 将这个表情存进沙盒
    [JHEmotionTool addRecentEmotion:emotion];
    
    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"JHSelectEmotionKey"] = emotion;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"JHEmotionDidSelectNotification" object:nil userInfo:userInfo];
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
