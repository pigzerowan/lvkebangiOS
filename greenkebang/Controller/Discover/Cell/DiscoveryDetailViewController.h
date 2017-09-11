//
//  DiscoveryDetailViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DiscoveryOtherControllerType) {
    /**< 推荐*/
    DiscoveryOtherControllerTypeBige = 1,
    /**< 农业*/
    DiscoveryOtherControllerTypeFood,
    /**< 环保*/
    DiscoveryOtherControllerTypeDigital,
    /**< 健康*/
    DiscoveryOtherControllerTypeHouse,
    /**< 食品*/
    DiscoveryOtherControllerTypeCity,
    /**< 生物*/
    DiscoveryOtherControllerTypeScrape
};

@interface DiscoveryDetailViewController : BaseViewController

@property (assign, nonatomic) DiscoveryOtherControllerType controllerType;

@property (copy, nonatomic) NSString * therquestUrl;
- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryOtherControllerType)controllerType;

@end
