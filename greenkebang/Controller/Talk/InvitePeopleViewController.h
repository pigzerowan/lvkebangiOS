//
//  InvitePeopleViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitePeopleViewController : BaseViewController
@property(nonatomic, strong)UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (copy, nonatomic) NSString *objId;
@property (copy, nonatomic) NSString *type; // 1上层界面为邀请回答 2上层界面为

@end
