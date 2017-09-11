//
//  VPViewController.h
//  VPImageCropperDemo
//
//  Created by Vinson.D.Warm on 1/13/14.
//  Copyright (c) 2014 Vinson.D.Warm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

#define arcWitch [UIScreen mainScreen].bounds.size.width/2
@interface VPViewController : UIViewController
@property(nonatomic,copy)NSString *cirleName;
@end
