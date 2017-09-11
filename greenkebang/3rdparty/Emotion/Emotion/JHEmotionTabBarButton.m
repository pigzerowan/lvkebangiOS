//
//  JHEmotionTabBarButton.m
//  emotions
//
//  Created by zhou on 16/7/5.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "JHEmotionTabBarButton.h"

@implementation JHEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        //设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
/**
 *  按钮高亮所做的一切操作都不在了
 *
 *  @param highlighted <#highlighted description#>
 */
- (void)setHighlighted:(BOOL)highlighted
{
    
}
@end
