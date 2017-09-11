//
//  JHEmotionTextView.h
//  emotions
//
//  Created by zhou on 16/7/8.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHEmotion;

@interface JHEmotionTextView : UITextView

- (void)insertEmotion:(JHEmotion *)emotion;
- (NSString *)fullText;
@end
