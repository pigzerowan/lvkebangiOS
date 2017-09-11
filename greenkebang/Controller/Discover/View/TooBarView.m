//
//  TooBarView.m
//  textView
//
//  Created by 申浩光 on 16/3/7.
//  Copyright © 2016年 申浩光. All rights reserved.
//


#import "UIView+SDAutoLayout.h"
#import "TooBarView.h"

@interface TooBarView ()

    

@end

@implementation TooBarView



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (TooBarView *)CreatView{
    

    TooBarView *toolBar = [[TooBarView alloc] init];
    toolBar.backgroundColor = [UIColor lightGrayColor];
    
    
    SSTextView *views = [[SSTextView alloc] init];
    views.backgroundColor = [UIColor whiteColor];
    views.tag = 10;
    views.placeholder =@"123334";
    [toolBar addSubview:views];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"发送" forState:(UIControlStateNormal)];
    [toolBar addSubview:btn];
    btn.tag = 11;
    
//    UILabel *lab = [UILabel new];
//    lab.textColor = [UIColor lightGrayColor];
//    lab.tag = 12;
//    [views addSubview:lab];
    
    
    views.sd_layout.leftSpaceToView(toolBar,10).widthIs(kDeviceWidth-80).topSpaceToView(toolBar,5).bottomSpaceToView(toolBar,5);
    
    
    btn.sd_layout.leftSpaceToView(views,20).rightSpaceToView(toolBar,20).topSpaceToView(toolBar,5).bottomSpaceToView(toolBar,5);
    
//    lab.sd_layout.leftSpaceToView(views,8).widthIs(120).topSpaceToView(views,8).heightIs(20);
    
    
    
    return toolBar;
    
}


@end
