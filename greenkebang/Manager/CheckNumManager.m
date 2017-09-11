//
//  CheckNumManager.m
//  greenkebang
//
//  Created by 郑渊文 on 9/2/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "CheckNumManager.h"

@implementation CheckNumManager
static CheckNumManager *_shareInstance;

+(CheckNumManager *)shareInstance
{
    @synchronized ([CheckNumManager class])
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[CheckNumManager alloc] init];
        }
    }
    return _shareInstance;
}
@end
