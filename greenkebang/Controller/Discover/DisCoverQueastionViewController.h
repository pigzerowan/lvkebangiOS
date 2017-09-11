//
//  DisCoverQueastionViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 9/21/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, DiscoveryQueastionControllerType) {
    /**< 推荐*/
    DiscoveryQueastionControllerTypeBige = 1,
    /**< 农业*/
    DiscoveryQueastionControllerTypeFood,
    /**< 环保*/
    DiscoveryQueastionControllerTypeDigital,
    /**< 健康*/
    DiscoveryQueastionControllerTypeHouse,
    /**< 食品*/
    DiscoveryQueastionControllerTypeCity,
    /**< 生物*/
    DiscoveryQueastionControllerTypeScrape
};

@interface DisCoverQueastionViewController : BaseViewController
@property (assign, nonatomic) DiscoveryQueastionControllerType controllerType;

@property (copy, nonatomic) NSString * therquestUrl;
- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryQueastionControllerType)controllerType;
@end
