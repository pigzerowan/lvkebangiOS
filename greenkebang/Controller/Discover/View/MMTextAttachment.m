//
//  MMTextAttachment.m
//  textKit
//
//  Created by zhuna on 15/11/26.
//  Copyright © 2015年 monph. All rights reserved.
//

#import "MMTextAttachment.h"

@implementation MMTextAttachment
//I want my emoticon has the same size with line's height
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex NS_AVAILABLE_IOS(7_0)
{
//    return CGRectMake( 0 , 0 , lineFrag.size.height*200 , lineFrag.size.height*200 );
    //调整图片大小
    return CGRectMake( 0 , 0 , lineFrag.size.height*20 , lineFrag.size.height*20);
}
@end
