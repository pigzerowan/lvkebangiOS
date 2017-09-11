//
//  QuestAndAnswerManager.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/1.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestAndAnswerManager : NSObject
+(QuestAndAnswerManager *)shareInstance;
@property(nonatomic, copy)NSString *unreadNum;

@end
