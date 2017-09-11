//
//  MyAttentionSeperateTopicViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/6.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MyAttentionSeperateTopicViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *token;
@property (assign, nonatomic)CGFloat oneImageWidth;
@property (assign, nonatomic)CGFloat oneImageHeight;




@end
