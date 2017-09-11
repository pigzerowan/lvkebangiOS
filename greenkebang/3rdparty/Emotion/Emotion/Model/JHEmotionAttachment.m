//
//  JHEmotionAttachment.m
//  emotions
//
//  Created by zhou on 16/7/11.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "JHEmotionAttachment.h"
#import "JHEmotion.h"

@implementation JHEmotionAttachment
- (void)setEmotion:(JHEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.pngPath];
}
@end
