//
//  ColumnListViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 1/25/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColumnListViewController : BaseViewController
@property (copy, nonatomic) NSString * featureId;
@property (copy, nonatomic) NSString * featureAvatar;
@property (copy, nonatomic) NSString * featureDesc;
@property (copy, nonatomic) NSString * featureName;
@property (copy, nonatomic) NSString * status;
@property (copy, nonatomic) NSString * userId;
@property (copy, nonatomic) NSString * themUrl;
@property (nonatomic, copy) NSString *ifAttention;

@property (nonatomic, copy) NSString *ifHaveData;


@end
