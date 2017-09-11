//
//  MyCollectionViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/7.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (nonatomic, copy) NSString *userId;
@end
