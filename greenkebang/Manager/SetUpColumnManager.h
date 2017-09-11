//
//  SetUpColumnManager.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetUpColumnManager : NSObject

+(SetUpColumnManager *)shareInstance;

@property (nonatomic,copy)NSString *featureAvatar;
@end
