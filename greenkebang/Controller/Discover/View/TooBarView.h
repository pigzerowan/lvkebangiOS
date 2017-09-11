//
//  TooBarView.h
//  textView
//
//  Created by 申浩光 on 16/3/7.
//  Copyright © 2016年 申浩光. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTextView.h"
@interface TooBarView : UIView
@property (nonatomic ,strong) UITextView *textViews;
@property (nonatomic ,strong) UIButton *btn;


+ (TooBarView *)CreatView;

@end
