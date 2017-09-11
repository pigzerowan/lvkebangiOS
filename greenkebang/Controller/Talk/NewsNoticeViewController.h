//
//  NewsNoticeViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/31.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsNoticeViewController : BaseViewController
@property(nonatomic, strong)UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property(copy,nonatomic)NSString *noticeType;
@property(copy,nonatomic)NSString *inviteAnswerNum;
@property(copy,nonatomic)NSString *objTitle;
@property(copy,nonatomic)NSString *objType;
@property(copy,nonatomic)NSString *userName;
@property(copy,nonatomic)NSString *noticeDate;
@property(copy,nonatomic)NSString *groupId;
@property(copy,nonatomic)NSString *msg;
@property(copy,nonatomic)NSString *date;

@property(nonatomic,strong) NSDictionary * DicOfNsnotification;


@end
