//
//  JHEmotionPopView.h
//  emotions
//
//  Created by zhou on 16/7/8.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHEmotion,JHEmotionButton;

@interface JHEmotionPopView : UIView

+ (instancetype)popView;
//@property (nonatomic, strong) JHEmotion *emotion;
- (void)showFrom:(JHEmotionButton *)button;
@end
