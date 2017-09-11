//
//  TabbarManager.m
//  greenkebang
//
//  Created by 郑渊文 on 9/10/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "TabbarManager.h"

@implementation TabbarManager

static TabbarManager *_shareInstance;

+(TabbarManager *)shareInstance
{
    @synchronized ([TabbarManager class])
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[TabbarManager alloc] init];
        }
    }
    return _shareInstance;
}
@end
