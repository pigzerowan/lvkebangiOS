//
//  QuesAndAnsViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuesAndAnsViewController : BaseViewController

@property(nonatomic, strong)UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;


@property(copy,nonatomic)NSString *objectTitle;

@end
