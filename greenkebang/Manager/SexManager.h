//
//  SexManager.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/17.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SexManager : NSObject
+(SexManager *)shareInstance;

@property (nonatomic,copy)NSString *DirectionStr;
@property (nonatomic,copy)NSString * directionId;

@end
