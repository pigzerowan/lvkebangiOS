//
//  IntrduceCircleManager.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/10/21.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "IntrduceCircleManager.h"

@implementation IntrduceCircleManager
static IntrduceCircleManager *_shareInstance;

+(IntrduceCircleManager *)shareInstance {
    
    @synchronized([IntrduceCircleManager class]) {
        
        if (_shareInstance == nil) {
            _shareInstance = [[IntrduceCircleManager alloc]init];
            
        }
        return _shareInstance;
    }
}

@end
