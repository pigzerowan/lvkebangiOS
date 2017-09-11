//
//  DerectManager.m
//  greenkebang
//
//  Created by 郑渊文 on 8/28/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "DerectManager.h"

@implementation DerectManager
static DerectManager *_shareInstance;

+(DerectManager *)shareInstance
{
    @synchronized ([DerectManager class])
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[DerectManager alloc] init];
        }
    }
    return _shareInstance;
}

@end
