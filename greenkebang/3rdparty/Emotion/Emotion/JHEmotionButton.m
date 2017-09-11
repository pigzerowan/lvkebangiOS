//
//  JHEmotionButton.m
//  emotions
//
//  Created by zhou on 16/7/8.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "JHEmotionButton.h"
#import "JHEmotion.h"
#import "NSString+Emoji.h"

@implementation JHEmotionButton
/**
 *  当控件不是从xib、storyboard中创建时，就会调用这个方法
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    //设置emoji表情的大小
    self.titleLabel.font = [UIFont systemFontOfSize:32];
}
/**
 *  当控件是从xib、storyboard中创建时，就会调用这个方法
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
/**
 *  这个方法在initWithCoder:方法后调用
 */
- (void)awakeFromNib
{
    
}
- (void)setEmotion:(JHEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) {//有图片
        
        [self setImage:[[UIImage imageNamed:emotion.pngPath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
    }else if (emotion.code){//是emoji表情（emoji是字符串）
        [self setTitle:[NSString emojiWithStringCode:emotion.code] forState:UIControlStateNormal];
    }
}

@end
