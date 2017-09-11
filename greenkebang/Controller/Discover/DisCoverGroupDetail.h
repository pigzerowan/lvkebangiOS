//
//  DisCoverGroupDetail.h
//  greenkebang
//
//  Created by 郑渊文 on 9/18/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DiscoveryGroupControllerType) {
    /**< 推荐*/
    DiscoveryGroupControllerTypeBige = 1,
    /**< 农业*/
    DiscoveryGroupControllerTypeFood,
    /**< 环保*/
    DiscoveryGroupControllerTypeDigital,
    /**< 健康*/
    DiscoveryGroupControllerTypeHouse,
    /**< 食品*/
    DiscoveryGroupControllerTypeCity,
    /**< 生物*/
    DiscoveryGroupControllerTypeScrape
};

@interface DisCoverGroupDetail : BaseViewController
@property (assign, nonatomic) DiscoveryGroupControllerType controllerType;

@property (copy, nonatomic) NSString * therquestUrl;
- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryGroupControllerType)controllerType;
@end
