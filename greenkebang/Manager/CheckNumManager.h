//
//  CheckNumManager.h
//  greenkebang
//
//  Created by 郑渊文 on 9/2/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckNumManager : NSObject
+(CheckNumManager *)shareInstance;

@property (nonatomic,copy)NSString *checkNum;
@end
