//
//  SearchTextManger.m
//  greenkebang
//
//  Created by 郑渊文 on 10/16/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "SearchTextManger.h"

@implementation SearchTextManger
static SearchTextManger *_shareInstance;

+(SearchTextManger *)shareInstance
{
    @synchronized ([SearchTextManger class])
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[SearchTextManger alloc] init];
        }
    }
    return _shareInstance;
}
@end
