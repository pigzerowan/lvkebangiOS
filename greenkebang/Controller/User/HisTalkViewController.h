//
//  HisTalkViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 9/9/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface HisTalkViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *toUserId;
@end
