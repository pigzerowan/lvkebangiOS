//
//  JHToolBar.h
//  emotions
//
//  Created by zhou on 16/7/5.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHToolBar;

@protocol JHToolBarDelegate <NSObject>

@optional
- (void)toolBar:(JHToolBar *)toolBar ButtonTag:(NSUInteger)tag;

@end

@interface JHToolBar : UIView

@property (nonatomic,weak) id<JHToolBarDelegate> delegate;

@property (nonatomic,assign) BOOL showKeyboardButton;

@end
