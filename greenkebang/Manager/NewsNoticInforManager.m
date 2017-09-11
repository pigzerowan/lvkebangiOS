//
//  NewsNoticInforManager.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/29.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "NewsNoticInforManager.h"

@implementation NewsNoticInforManager
static NewsNoticInforManager *_shareInstance;

+(NewsNoticInforManager *)shareInstance {
    
    @synchronized([NewsNoticInforManager class]) {
        
        if (_shareInstance == nil) {
            _shareInstance = [[NewsNoticInforManager alloc]init];
            
        }
        return _shareInstance;
    }
}

@end
