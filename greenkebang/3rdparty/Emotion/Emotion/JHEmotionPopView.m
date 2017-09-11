//
//  JHEmotionPopView.m
//  emotions
//
//  Created by zhou on 16/7/8.
//  Copyright © 2016年 zhou. All rights reserved.

//这个是放大镜，使用xib做的

#import "JHEmotionPopView.h"
#import "JHEmotion.h"
#import "JHEmotionButton.h"
#import "UIView+Extension.h"

@interface JHEmotionPopView ()

@property (weak, nonatomic) IBOutlet JHEmotionButton *emotionButton;


@end

@implementation JHEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"JHEmotionPopView" owner:nil options:nil] lastObject];
}
- (void)showFrom:(JHEmotionButton *)button
{
    if (button == nil) return;
    self.emotionButton.emotion = button.emotion;
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.emojiy = CGRectGetMidY(btnFrame) - self.emojiheight;
    self.emojicenterX = CGRectGetMidX(btnFrame);
}
//- (void)setEmotion:(JHEmotion *)emotion
//{
//    _emotion = emotion;
//    
//    self.emotionButton.emotion = emotion;
//}

@end
