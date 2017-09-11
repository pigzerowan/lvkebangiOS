//
//  LocationViewController.h
//  WheatPlan
//
//  Created by 郑渊文 on 6/23/15.
//  Copyright (c) 2015 IOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationAreaViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *areaId;
@property(nonatomic,copy)NSString *areaName;

@end
