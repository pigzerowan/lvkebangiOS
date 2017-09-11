//
//  SetUpColumnManager.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SetUpColumnManager.h"

@implementation SetUpColumnManager
static SetUpColumnManager *_shareInstance;

+(SetUpColumnManager *)shareInstance
{
    @synchronized ([SetUpColumnManager class])
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[SetUpColumnManager alloc] init];
        }
    }
    return _shareInstance;
}

@end
