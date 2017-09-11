//
//  JHToolBar.m
//  emotions
//
//  Created by zhou on 16/7/5.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "JHToolBar.h"
#import "UIView+Extension.h"

@interface JHToolBar ()

@property (nonatomic, strong) UIButton *emotionButton;

@end

@implementation JHToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        //初始化按钮
//        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:0];
//        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:1];
//        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:2];
//        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:3];
       
        self.emotionButton = [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:4];
    }
    
    return self;
}

/**
 *  创建btn
 *
 *  @param image     正常状态下的图片
 *  @param highImage 高亮状态下的图片
 *  @param type      btn的tag
 *
 *  @return btn
 */
- (UIButton *)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(NSUInteger)type
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
    return btn;
}
/**
 *  btn的点击事件
 *
 *  @param sender btn
 */
- (void)btnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(toolBar:ButtonTag:)]) {
        [self.delegate toolBar:self ButtonTag:sender.tag];
    }
}

/**
 *  showKeyboardButton的set方法，判断键盘是自定义的键盘 还是 系统的键盘，来分别显示不同的图片样式
 *
 *  @param showKeyboardButton showKeyboardButton
 */
- (void)setShowKeyboardButton:(BOOL)showKeyboardButton
{
    _showKeyboardButton = showKeyboardButton;
    
    // 默认的图片名
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    
    // 显示键盘图标
    if (showKeyboardButton) {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }

    // 设置图片
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}
/**
 *  布局
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat btnW = kDeviceWidth/count;
    CGFloat btnH = self.emojiheight;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.emojiy = 0;
        btn.emojiwidth = 30;
        btn.emojiheight = btnH;
        btn.emojix = 30;
    }
}

@end
