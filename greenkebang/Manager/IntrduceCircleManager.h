//
//  IntrduceCircleManager.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/10/21.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntrduceCircleManager : NSObject
+(IntrduceCircleManager *)shareInstance;
@property(nonatomic, copy)NSString *IntrduceCircleStr;
@end
