//
//  ToUserManager.h
//  greenkebang
//
//  Created by 郑渊文 on 9/17/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToUserManager : NSObject
+(ToUserManager *)shareInstance;

@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *userName;

@end
