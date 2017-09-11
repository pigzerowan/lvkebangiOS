//
//  JHEmotionTabBar.m
//  emotions
//
//  Created by zhou on 16/7/5.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "JHEmotionTabBar.h"
#import "UIView+Extension.h"
#import "JHEmotionTabBarButton.h"

@interface JHEmotionTabBar ()

@property (nonatomic, strong) JHEmotionTabBarButton *selectedBtn;//选中的按钮

@end

@implementation JHEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupBtn:@"最近" buttonType:0];
        
//        self.selectedBtn = [self setupBtn:@"默认" buttonType:1];
        
        [self setupBtn:@"emoji" buttonType:1];
//        [self setupBtn:@"浪小花" buttonType:3];
    }
    
    return self;
}

/**
 *  创建一个按钮
 *
 *  @param title 按钮文字
 *  @param type  tag
 *
 *  @return JHEmotionTabBarButton
 */
- (JHEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(NSUInteger)type
{
    JHEmotionTabBarButton *btn = [[JHEmotionTabBarButton alloc]init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = type;
    [btn setTitle:title forState:UIControlStateNormal];
    
    [self addSubview:btn];
    
    // 设置背景图片
    NSString *image = nil;
    NSString *selectImage = nil;
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }else if (self.subviews.count == 4){
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }else
    {
        image = @"compose_emotion_table_mid_normal";
        selectImage = @"compose_emotion_table_mid_selected";

    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    
    return btn;
}

/**
 *  重写这个方法，在切换成表情键盘的时候，选中  默认  选项，但是要给代理赋值，不然开始的时候，代理是空的，只有点击选项的时候，代理才有值
 *
 *  @param delegate <#delegate description#>
 */
- (void)setDelegate:(id<JHEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    [self btnClick:self.selectedBtn];
}
/**
 *  JHEmotionTabBarButton点击事件
 *
 *  @param sender
 */
- (void)btnClick:(JHEmotionTabBarButton *)sender
{
    self.selectedBtn.enabled = YES;
    sender.enabled = NO;
    self.selectedBtn = sender;
    
    //如果没有重写上面的delegate的set方法，在切换成表情键盘的时候，这个  delegate 是nil
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:sender.tag];
    }
}
/**
 *  布局
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger btnCount = self.subviews.count;
    
    CGFloat btnW = self.emojiwidth/btnCount;
    CGFloat btnH = self.emojiheight;
    
    for (NSUInteger i = 0; i < btnCount; i++) {
        JHEmotionTabBarButton *btn = self.subviews[i];
        btn.emojiy = 0;
        btn.emojiwidth = btnW;
        btn.emojiheight = btnH;
        btn.emojix = i * btnW;
    }
    
}

@end
