//
//  SystemDynamicViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemDynamicViewController : BaseViewController
@property(nonatomic, strong)UILabel *contentLabel;

@property(nonatomic, strong)UILabel *timeLabel;
@property(copy,nonatomic)NSString *contentStr;
@property(copy,nonatomic)NSString *timeStr;

@end
