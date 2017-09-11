//
//  CircleImageManager.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/11/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "CircleImageManager.h"

@implementation CircleImageManager
static CircleImageManager *_shareInstance;

+(CircleImageManager *)shareInstance {
    
    @synchronized([CircleImageManager class]) {
        
        if (_shareInstance == nil) {
            _shareInstance = [[CircleImageManager alloc]init];
            
        }
        return _shareInstance;
    }
}

@end
