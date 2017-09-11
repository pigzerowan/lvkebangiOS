//
//  TimeSeperateViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DiscoveryOtherControllerType1) {
    /**< 话题*/
    
    DiscoveryOtherControllerTypeTeclolegel = 1,
    /**< 技术答疑*/
    DiscoveryOtherControllerTypeTopic,
    /**< 行业见解*/
    DiscoveryOtherControllerTypeTrade,
};


@interface TimeSeperateViewController : BaseViewController

@property (assign, nonatomic) DiscoveryOtherControllerType1 controllerType;


- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryOtherControllerType1)controllerType;


@end
