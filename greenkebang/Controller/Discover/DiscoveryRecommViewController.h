//
//  DiscoveryRecommViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DiscoveryOtherControllerType) {
    /**< 话题*/
    DiscoveryOtherControllerTypeTopic = 1,
    /**< 技术答疑*/
    DiscoveryOtherControllerTypeTeclolegel,
    /**< 行业见解*/
     DiscoveryOtherControllerTypeTrade,
};

@interface DiscoveryRecommViewController : UIViewController


@property (assign, nonatomic) DiscoveryOtherControllerType controllerType;


- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryOtherControllerType)controllerType;

@end
