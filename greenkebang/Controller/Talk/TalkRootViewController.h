//
//  TalkRootViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 8/26/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface TalkRootViewController :BaseViewController

@property (strong, nonatomic) UITableView           *tableView;

- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;
@end
