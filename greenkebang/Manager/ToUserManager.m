//
//  ToUserManager.m
//  greenkebang
//
//  Created by 郑渊文 on 9/17/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "ToUserManager.h"

@implementation ToUserManager
static ToUserManager *_shareInstance;

+(ToUserManager *)shareInstance
{
    @synchronized ([ToUserManager class])
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[ToUserManager alloc] init];
        }
    }
    return _shareInstance;
}
@end
