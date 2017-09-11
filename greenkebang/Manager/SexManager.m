//
//  SexManager.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/17.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SexManager.h"

@implementation SexManager
static SexManager *_shareInstance;

+(SexManager *)shareInstance
{
    @synchronized ([SexManager class])
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[SexManager alloc] init];
        }
    }
    return _shareInstance;
}
@end
