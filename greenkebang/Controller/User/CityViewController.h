//
//  CityViewController.h
//  youqu
//
//  Created by chun.chen on 15/8/24.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityViewController : UITableViewController

/**
 *  选择后回调
 */
@property (copy, nonatomic) void (^finishedSelectBlock)(NSString *city);

@end
