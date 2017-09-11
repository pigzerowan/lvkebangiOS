//
//  ChangeChooseViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 11/2/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeChooseViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *chooseName;
@property(nonatomic,copy)NSString *chooseId;

@end
