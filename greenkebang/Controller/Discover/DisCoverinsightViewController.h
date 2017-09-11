//
//  DisCoverinsightViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 9/21/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, DiscoveryInsightControllerType) {
    /**< 推荐*/
    DiscoveryInsightControllerTypeBige = 1,
    /**< 农业*/
    DiscoveryInsightControllerTypeFood,
    /**< 环保*/
    DiscoveryInsightControllerTypeDigital,
    /**< 健康*/
    DiscoveryInsightControllerTypeHouse,
    /**< 食品*/
    DiscoveryInsightControllerTypeCity,
    /**< 生物*/
    DiscoveryInsightControllerTypeScrape
};

@interface DisCoverinsightViewController : BaseViewController

@property (assign, nonatomic) DiscoveryInsightControllerType controllerType;

@property (copy, nonatomic) NSString * therquestUrl;
- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryInsightControllerType)controllerType;
@end
