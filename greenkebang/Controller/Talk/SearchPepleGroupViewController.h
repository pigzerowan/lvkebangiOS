//
//  SearchPepleGroupViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 10/16/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SearchViewControllerType) {
    /**< 人*/
    SearchViewControllerTypePeople = 1,
    /**< 群组*/
    SearchViewControllerTypeTypeGroup,
};



@interface SearchPepleGroupViewController : BaseViewController

@property (assign, nonatomic) SearchViewControllerType controllerType;

- (instancetype)initWithDiscoveryOtherControllerType:(SearchViewControllerType)controllerType;

@end
