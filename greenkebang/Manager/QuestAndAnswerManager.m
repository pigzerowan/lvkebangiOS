//
//  QuestAndAnswerManager.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/1.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "QuestAndAnswerManager.h"

@implementation QuestAndAnswerManager
static QuestAndAnswerManager *_shareInstance;

+(QuestAndAnswerManager *)shareInstance {
    
    @synchronized([QuestAndAnswerManager class]) {
        
        if (_shareInstance == nil) {
            _shareInstance = [[QuestAndAnswerManager alloc]init];
            
        }
        return _shareInstance;
    }
}

@end
