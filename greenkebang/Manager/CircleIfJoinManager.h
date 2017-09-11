//
//  CircleIfJoinManager.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/10/31.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircleIfJoinManager : NSObject
+(CircleIfJoinManager *)shareInstance;
@property(nonatomic, copy)NSString *ifJoin;

@end
