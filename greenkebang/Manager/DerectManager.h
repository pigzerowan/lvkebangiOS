//
//  DerectManager.h
//  greenkebang
//
//  Created by 郑渊文 on 8/28/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DerectManager : NSObject
+(DerectManager *)shareInstance;

@property (nonatomic,copy)NSString *DirectionStr;
@property (nonatomic,copy)NSString * directionId;

@end
