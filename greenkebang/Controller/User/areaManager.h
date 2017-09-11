//
//  areaManager.h
//  WheatPlan
//
//  Created by 郑渊文 on 6/23/15.
//  Copyright (c) 2015 IOSTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface areaManager : NSObject
+(areaManager *)shareInstance;

@property (nonatomic,copy)NSString *areaName;
@property (nonatomic,copy) NSString *areaId;
@end
