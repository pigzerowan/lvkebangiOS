//
//  UIView+Extension.m
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setEmojix:(CGFloat)emojix {
    
    CGRect frame = self.frame;
    frame.origin.x = emojix;
    self.frame = frame;

}

- (void)setEmojiy:(CGFloat)emojiy {
    
    CGRect frame = self.frame;
    frame.origin.y = emojiy;
    self.frame = frame;
}



- (CGFloat)emojix
{
    return self.frame.origin.x;
}

- (CGFloat)emojiy
{
    return self.frame.origin.y;
}


- (void)setEmojicenterX:(CGFloat)emojicenterX {
    
    CGPoint center = self.center;
    center.x = emojicenterX;
    self.center = center;

    
}

- (CGFloat)emojicenterX {
    
    return self.center.x;

}

- (void)setEmojicenterY:(CGFloat)emojicenterY {
    
    CGPoint center = self.center;
    center.y = emojicenterY;
    self.center = center;

}

- (CGFloat)emojicenterY {
    
    return self.center.y;

}


- (void)setEmojiwidth:(CGFloat)emojiwidth {
    
    CGRect frame = self.frame;
    frame.size.width = emojiwidth;
    self.frame = frame;

    
}


- (void)setEmojiheight:(CGFloat)emojiheight {
    
    CGRect frame = self.frame;
    frame.size.height = emojiheight;
    self.frame = frame;

    
}


- (CGFloat)emojiheight {
    
    return self.frame.size.height;
    
}

- (CGFloat)emojiwidth {
    
    return self.frame.size.width;

}

- (void)setEmojisize:(CGSize)emojisize {
    
    CGRect frame = self.frame;
    frame.size = emojisize;
    self.frame = frame;

}


- (CGSize)emojisize {
    
    return self.frame.size;

}


- (void)setEmojiorigin:(CGPoint)emojiorigin {
    
    CGRect frame = self.frame;
    frame.origin = emojiorigin;
    self.frame = frame;

}

- (CGPoint)emojiorigin {
    
    return self.frame.origin;

}

@end
