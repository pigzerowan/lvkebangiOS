//
//  NewsRootViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPagerController.h"

@interface NewsRootViewController : ViewPagerController
@property(nonatomic,strong) UIImageView *chatVCImage;

@property(nonatomic,strong) UIImageView *commentVCImage;
    
@property(nonatomic,strong) UIImageView *noticeVCImage;
@property(nonatomic,strong) NSDictionary * DicOfNsnotification;
    

@end
