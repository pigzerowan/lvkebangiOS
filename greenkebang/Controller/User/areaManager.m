//
//  areaManager.m
//  WheatPlan
//
//  Created by 郑渊文 on 6/23/15.
//  Copyright (c) 2015 IOSTeam. All rights reserved.
//

#import "areaManager.h"

@implementation areaManager

static areaManager *_shareInstance;

+(areaManager *)shareInstance
{
    @synchronized ([areaManager class])
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[areaManager alloc] init];
        }
    }
    return _shareInstance;
}

@end
