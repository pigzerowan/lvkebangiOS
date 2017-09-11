//
//  MyFeatureIdManager.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/11/24.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "MyFeatureIdManager.h"

@implementation MyFeatureIdManager
static MyFeatureIdManager *_shareInstance;

+(MyFeatureIdManager *)shareInstance {
    
    @synchronized([MyFeatureIdManager class]) {
        
        if (_shareInstance == nil) {
            _shareInstance = [[MyFeatureIdManager alloc]init];
            
        }
        return _shareInstance;
    }
}

@end
