//
//  NewsCommentViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCommentViewController : BaseViewController
@property(nonatomic, strong)UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property(nonatomic,copy)NSString *type;

@end
