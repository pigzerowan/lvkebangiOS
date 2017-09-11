//
//  NewSeperateViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 1/16/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DiscoveryNewSeperetControllerType) {
    /**< 精选*/
    
    DiscoverySeperetControllerTypeChoise = 0,
    /**< 农业*/
    DiscoveryOtherControllerTypeFarm,
    /**< 科技*/
    DiscoveryOtherControllerTypeTecholic,
    /**< 土壤*/
    DiscoveryOtherControllerTypeSoil,
    /**< 健康*/
    DiscoveryOtherControllerTypeHeathy,
    /**< 生物*/
    DiscoveryOtherControllerTypeBiology,
    
};

@interface NewSeperateViewController : BaseViewController
@property (assign, nonatomic) DiscoveryNewSeperetControllerType newcontrollerType;


- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryNewSeperetControllerType)controllerType;

@end
