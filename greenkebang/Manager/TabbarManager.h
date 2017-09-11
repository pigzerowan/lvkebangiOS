//
//  TabbarManager.h
//  greenkebang
//
//  Created by 郑渊文 on 9/10/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LKBBaseTabBarController;

@interface TabbarManager : NSObject
+(TabbarManager *)shareInstance;

@property (nonatomic,strong)LKBBaseTabBarController *lkbbaseVc;
@property (nonatomic,strong)NSString *vcType;
@property (nonatomic,strong)NSString *createCirleVcType;




@end
