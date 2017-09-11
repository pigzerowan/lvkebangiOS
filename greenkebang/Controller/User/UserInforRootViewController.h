//
//  UserInforRootViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/6.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInforRootViewController : BaseViewController

@property (strong, nonatomic) UIImage *headImg;
@property (nonatomic, copy) NSURL *photoUrl;

@property (strong, nonatomic) NSString *headerImg;// 上层页面的头像
@property (strong, nonatomic) NSString * genderStr;
@property (strong, nonatomic) NSString * goodFiledStr;
@property (strong, nonatomic) NSString * addressStr;
@property (strong, nonatomic) NSString * identityStr;
@property (strong, nonatomic) NSString * remarkStr;
@property (strong, nonatomic) UIImageView *dotImage;


@end
