//
//  SocialRigistManager.m
//  greenkebang
//
//  Created by 郑渊文 on 9/14/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "SocialRigistManager.h"

@implementation SocialRigistManager
static SocialRigistManager *_shareInstance;

+(SocialRigistManager *)shareInstance
{
    @synchronized ([SocialRigistManager class])
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[SocialRigistManager alloc] init];
        }
    }
    return _shareInstance;
}
@end
