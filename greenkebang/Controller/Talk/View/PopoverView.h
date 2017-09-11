//
//  PopoverView.h
//  youqu
//
//  Created by 郑渊文 on 8/14/15.
//  Copyright (c) 2015 youqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopoverView : UIView

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images;
-(void)show;
-(void)dismiss;
-(void)dismiss:(BOOL)animated;

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);

@end
