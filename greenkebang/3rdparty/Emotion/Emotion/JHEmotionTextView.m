//
//  JHEmotionTextView.m
//  emotions
//
//  Created by zhou on 16/7/8.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "JHEmotionTextView.h"
#import "JHEmotion.h"
#import "NSString+Emoji.h"
#import "JHEmotionAttachment.h"

@implementation JHEmotionTextView

- (void)insertEmotion:(JHEmotion *)emotion
{
    if (emotion.code) {
        // insertText : 将文字插入到光标所在的位置
        [self insertText:emotion.code.emoji];
    } else if (emotion.png) {
        
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
        // 拼接之前的文字
        [attributedText appendAttributedString:self.attributedText];
        
        // 加载图片
        JHEmotionAttachment *attch = [[JHEmotionAttachment alloc] init];
//        attch.image = [UIImage imageNamed:emotion.pngPath];
        attch.emotion = emotion;
        
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
        
        // 根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
       
        // 插入属性文字到光标位置
        NSUInteger loc = self.selectedRange.location;
//        [attributedText insertAttributedString:imageStr atIndex:loc];
        [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:imageStr];
        // 设置字体
        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        self.attributedText = attributedText;
        
        // 移动光标到表情的后面
        self.selectedRange = NSMakeRange(loc + 1, 0);
    }

}

- (NSString *)fullText
{
    NSMutableString *fullStr = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        JHEmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) {
            [fullStr appendString:attch.emotion.chs];
        }else
        {
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullStr appendString:str.string];
        }
    }];
    return fullStr;
}
@end
