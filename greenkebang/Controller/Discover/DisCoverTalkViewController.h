//
//  DisCoverTalkViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 9/21/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, DiscoveryTalkControllerType) {
    /**< 推荐*/
    DiscoveryTalkControllerTypeBige = 1,
    /**< 农业*/
    DiscoveryTalkControllerTypeFood,
    /**< 环保*/
    DiscoveryTalkControllerTypeDigital,
    /**< 健康*/
    DiscoveryTalkControllerTypeHouse,
    /**< 食品*/
    DiscoveryTalkControllerTypeCity,
    /**< 生物*/
    DiscoveryTalkControllerTypeScrape
};

@interface DisCoverTalkViewController : BaseViewController

@property (assign, nonatomic) DiscoveryTalkControllerType controllerType;

@property (copy, nonatomic) NSString * therquestUrl;
- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryTalkControllerType)controllerType;

@end
