//
//  MyFeatureIdManager.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/11/24.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFeatureIdManager : NSObject
+(MyFeatureIdManager *)shareInstance;
@property(nonatomic, copy) NSString *featureId;

@end
