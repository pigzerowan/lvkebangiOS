//
//  ShareArticleManager.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/7.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "ShareArticleManager.h"

@implementation ShareArticleManager

static ShareArticleManager *_shareinstance;

//+(ShareArticleManager *)shareInstanc2e
//{
//    @synchronized ([ShareArticleManager class]) {
//        if (!_shareInstance) {
//            _shareInstance = [[ShareArticleManager alloc]init];
//        }
//        
//        return _shareInstance;
//    }
//}









































static ShareArticleManager *_shareInstance;

+(ShareArticleManager *)shareInstance {
    
    @synchronized([ShareArticleManager class]) {
        
        if (_shareInstance == nil) {
            _shareInstance = [[ShareArticleManager alloc]init];
            
        }
        return _shareInstance;
    }
}

@end
