//
//  CircleIfJoinManager.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/10/31.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "CircleIfJoinManager.h"

@implementation CircleIfJoinManager
static CircleIfJoinManager *_shareInstance;

+(CircleIfJoinManager *)shareInstance {
    
    @synchronized([CircleIfJoinManager class]) {
        
        if (_shareInstance == nil) {
            _shareInstance = [[CircleIfJoinManager alloc]init];
            
        }
        return _shareInstance;
    }
}

@end
