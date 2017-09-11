//
//  NewsNoticeViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/31.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "NewsNoticeViewController.h"
#import "NewsNoticeCell.h"
#import "SVPullToRefresh.h"
#import "MyUserInfoManager.h"
#import "LoveTableFooterView.h"
#import "GetNoticeModel.h"
#import "QuesAndAnsViewController.h"
#import "DynamicNoticeViewController.h"
#import "InvitePeopleViewController.h"
#import "SystemDynamicListViewController.h"
#import "ContactsViewController.h"
#import "PeopleViewController.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"
#import "NewsNoticInforManager.h"
#import "QuestAndAnswerManager.h"
#import "SystemDynamicViewController.h"
NSString * const NewsNoticeCellIdentifier = @"NewsNoticeCellIdentifier";

@interface NewsNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSMutableArray *mystr;
}


@end

@implementation NewsNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    mystr = [[NSMutableArray alloc]init];

    //获取NewsNotice通知中心单例对象
    NSNotificationCenter * NewsNotice = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [NewsNotice addObserver:self selector:@selector(newsNotice:) name:@"NewsNoticeVC" object:nil];
    // 左键返回
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];

    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *myKey = [NSString stringWithFormat:@"NewsNoticeVC%@",[MyUserInfoManager shareInstance].userId];
    
    
    NSDictionary *userDefaultDic = [userDefault objectForKey:myKey];
    
    _noticeType = [NSString stringWithFormat:@"%@",[userDefaultDic objectForKey:@"noticeType"]];
    NSDictionary *dic = [userDefaultDic objectForKey:@"object"];
    
    _inviteAnswerNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"inviteAnswerNum"]];
    _userName = [dic objectForKey:@"userName"];
    _objType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"objType"]];
    _objTitle = [dic objectForKey:@"objTitle"];
    _noticeDate =[dic objectForKey:@"noticeDate"];
    _msg = [userDefaultDic objectForKey:@"msg"];

    
    


}

-(void)backToMain
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    

//    [self.navigationController.navigationBar setClipsToBounds:NO];
//    [self.navigationController.navigationBar setBarTintColor:CCCUIColorFromHex(0x323436)];
//    
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    [self initializePageSubviews];

    
    [MobClick beginLogPageView:@"NewsNoticeCellIdentifier"];

    [self setEdgesForExtendedLayout:UIRectEdgeNone];

}




-(void)newsNotice:(NSNotification *)sender{
    
    NSLog(@"!!!!!!!!!~!《《《》》》》》》》》》》》》》》》》》%@",sender.userInfo);
    
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *objectId =[NSString stringWithFormat:@"NewsNoticeVC%@",[MyUserInfoManager shareInstance].userId] ;
    
    [userDefaults setObject:sender.userInfo forKey:objectId];

    NSDictionary *userDefaultDic = [userDefaults objectForKey:objectId];
    
    
    NSLog(@"------------------------------%@",userDefaultDic);
    
    
    
    
    _noticeType = [NSString stringWithFormat:@"%@",[sender.userInfo objectForKey:@"noticeType"]];
    NSDictionary *dic = [sender.userInfo objectForKey:@"object"];
    
    _inviteAnswerNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"inviteAnswerNum"]];
    _userName = [dic objectForKey:@"userName"];
    _objType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"objType"]];
    _objTitle = [dic objectForKey:@"objTitle"];
    _noticeDate =[dic objectForKey:@"noticeDate"];
    _msg = [sender.userInfo objectForKey:@"msg"];
    
    NSLog(@"-------------------%@",_msg);



    
    
    if ([_noticeType isEqualToString:@"1"]) {
        
//        //创建一个消息对象
//        NSNotification *questionslider = [NSNotification notificationWithName:@"QuesAndAnsView" object:nil userInfo:dic];
//        //发送消息
//        [[NSNotificationCenter defaultCenter]postNotification:questionslider];
        
        NSString * noticeType = [NSString stringWithFormat:@"wenda%@",_noticeType];
        [userDefaults setObject:@"isUnRead" forKey:noticeType];
        


        
        NSString *str = [userDefaults objectForKey:noticeType];
        
        NSLog(@"------------------------------%@",str);
        
        [mystr addObject:str];
        
        [QuestAndAnswerManager shareInstance].unreadNum = [NSString stringWithFormat:@"%lu",(unsigned long)[mystr count]];
        
        NSLog(@"————————————————————%@",[QuestAndAnswerManager shareInstance].unreadNum);

    }
    if ([_noticeType isEqualToString:@"2"]) {
        
        //创建一个消息对象
        NSNotification *slider = [NSNotification notificationWithName:@"DynamicNoticeView" object:nil userInfo:dic];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:slider];
        
//        //创建一个消息对象
//        NSNotification *slider = [NSNotification notificationWithName:@"DynamicNoticeView" object:nil];
//        //发送消息
//        [[NSNotificationCenter defaultCenter]postNotification:slider];
        
        NSString * noticeType = [NSString stringWithFormat:@"dongtai%@",_noticeType];
        [userDefaults setObject:@"isUnRead" forKey:noticeType];
        
        NSString *str = [userDefaults objectForKey:noticeType];
        
        NSLog(@"------------------------------%@",str);

        
    }

    if ([_noticeType isEqualToString:@"3"]) {
        
        //创建一个消息对象
        NSNotification *Inviteslider = [NSNotification notificationWithName:@"InvitePeopleViewController" object:nil userInfo:dic];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:Inviteslider];
        
        NSString * noticeType = [NSString stringWithFormat:@"guanzhu%@",_noticeType];
        [userDefaults setObject:@"isUnRead" forKey:noticeType];
        
        NSString *str = [userDefaults objectForKey:noticeType];
        
        NSLog(@"------------------------------%@",str);

    }
    
    if ([_noticeType isEqualToString:@"4"]) {
        
        
        NSString * noticeType = [NSString stringWithFormat:@"xitong%@",_noticeType];
        [userDefaults setObject:@"isUnRead" forKey:noticeType];
        
        
        
        
        NSString *str = [userDefaults objectForKey:noticeType];
        
        NSLog(@"------------------------------%@",str);
        
        [mystr addObject:str];
        
        
        
    }


    
//    [self initializePageSubviews];
    
    [self.tableView reloadData];

    
    

}


-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:YES];
    
//    _noticeType = @"4";
    
//    _attentionUnreadImage.hidden = YES;
//    _noticeUnreadImage.hidden =YES;
//    
//    [_noticeUnreadImage removeFromSuperview];
//    [_attentionUnreadImage removeFromSuperview];

}

- (void)viewWillDisappear:(BOOL)animated {
    
    
    [super viewWillDisappear:YES];
    
//    _noticeType = @"4";

//    _attentionUnreadImage.hidden = YES;
//    _noticeUnreadImage.hidden =YES;
//
//    [_noticeUnreadImage removeFromSuperview];
//    [_attentionUnreadImage removeFromSuperview];
    [MobClick endLogPageView:@"NewsNoticeCellIdentifier"];


    
}



- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
    
//    __weak __typeof(self) weakSelf = self;
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        
//        [weakSelf fetchDataWithIsLoadingMore:NO];
//        
//    }];
//    [self.tableView addInfiniteScrollingWithActionHandler:^{
//        [weakSelf fetchDataWithIsLoadingMore:YES];
//    }];
//    self.tableView.showsInfiniteScrolling = YES;
//    [self.tableView triggerPullToRefresh];
//    if (self.dataArray.count == 0) {
//        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
//        self.tableView.tableFooterView = footerVew;
//        self.tableView.tableFooterView.hidden = YES;
//    }
    
}


- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    
//    self.requestParas = @{
//                          @"userId":[[MyUserInfoManager shareInstance]userId],
//                          @"page":@(currPage),
//                          @"token":[[MyUserInfoManager shareInstance]token],
//                          isLoadingMoreKey:@(isLoadingMore)};
//    
//    self.requestURL = LKB_Get_Comment;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!isLoadingMore) {
//            [self.tableView.pullToRefreshView stopAnimating];
//        }
//        else {
//            //            [self.dataArray addObject:[NSNull null]];
//            [self.tableView.infiniteScrollingView stopAnimating];
//        }
//        [self.tableView reloadData];
//    });
    
}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
    if (!request.isLoadingMore) {
        [self.tableView.pullToRefreshView stopAnimating];
    } else {
        [self.tableView.infiniteScrollingView stopAnimating];
    }
    
    if (errorMessage) {
      [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    
    if ([request.url isEqualToString:LKB_Dynamic_Notice]) {
        GetNoticeModel *getDetailModel = (GetNoticeModel *)parserObject;
        
        NSLog(@"-----------------------%@",getDetailModel.data);
        
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:getDetailModel.data];
        }else {
            [_dataArray addObjectsFromArray:getDetailModel.data];
        }
        
        
        [self.tableView reloadData];
        
        if (getDetailModel.num == 0) {
            
            _tableView.tableFooterView.hidden = NO;
            [_tableView.infiniteScrollingView endScrollAnimating];
        } else {
            //            _tableView.showsInfiniteScrolling = YES;
            _tableView.tableFooterView.hidden = YES;
            
            [_tableView.infiniteScrollingView beginScrollAnimating];
            
        }
        
    }
    
    
}





- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[NewsNoticeCell class] forCellReuseIdentifier:NewsNoticeCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    
    return _tableView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SlideBarCell =@"SlideBarCell";
    
    UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:NewsNoticeCellIdentifier];
        if (cell == nil) {
            cell = [[NewsNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsNoticeCellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
        NewsNoticeCell * simplescell = (NewsNoticeCell *)cell;
        simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    
    
    NSUserDefaults  *userDefault = [NSUserDefaults standardUserDefaults];
    
    ;
    
    if (indexPath.row == 0) {
        // 问答邀请
        simplescell.headerImage.image = [UIImage imageNamed:@"Question_Notice"];
        simplescell.nameLabel.text = @"参与邀请";
        
        NSString *KeyStr = [NSString stringWithFormat:@"QuestionAndAnswer%@",[MyUserInfoManager shareInstance].userId];
        
        NSMutableArray *updateInviteArr = [[userDefault objectForKey:KeyStr]mutableCopy];
        
        
        NSLog(@"=======================%@",updateInviteArr);
        
        
        NSLog(@"=======================%lu",(unsigned long)updateInviteArr.count);
        if ([_noticeType isEqualToString:@"1"]) {
            // 时间设置
            NSTimeInterval time=[_noticeDate doubleValue];
            
            NSDate *createDate = [NSDate dateFormJavaTimestamp:time];
            
            simplescell.timeLabel.text = [NSString stringWithFormat:@"%@",[createDate timeAgo]];
            simplescell.detailLabel.text = [NSString stringWithFormat:@"%@ 邀请你回答: %@",_userName,_objTitle];
            
            [NewsNoticInforManager shareInstance].wenDaDetail = [NSString stringWithFormat:@"%@ 邀请你回答: %@",_userName,_objTitle];
            
            if (updateInviteArr.count > 0) {
                
                simplescell.unreadLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)updateInviteArr.count];
                simplescell.detailLabel.text = [NSString stringWithFormat:@"%@",[NewsNoticInforManager shareInstance].wenDaDetail];
                //                simplescell.timeLabel.hidden = YES;
                simplescell.noticeUnreadImage.hidden = YES;
                
                
            }
            else {
                
                simplescell.detailLabel.text = @"暂无新的通知";
                simplescell.noticeUnreadImage.hidden = YES;
                simplescell.unreadLabel.hidden = YES;
                simplescell.timeLabel.hidden = YES;
                
                
            }

        }
        else {
            
            if (updateInviteArr.count > 0) {
                
                simplescell.unreadLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)updateInviteArr.count];
                simplescell.detailLabel.text = [NSString stringWithFormat:@"%@",[NewsNoticInforManager shareInstance].wenDaDetail];
                //                simplescell.timeLabel.hidden = YES;
                simplescell.noticeUnreadImage.hidden = YES;
                
                
            }
            else {
                
                simplescell.detailLabel.text = @"暂无新的通知";
                simplescell.noticeUnreadImage.hidden = YES;
                simplescell.unreadLabel.hidden = YES;
                simplescell.timeLabel.hidden = YES;
                
                
            }

        }
        
        
        



    }
    if (indexPath.row == 1) {
        // 动态通知
        simplescell.headerImage.image = [UIImage imageNamed:@"Dynamic_Notice"];
        simplescell.nameLabel.text = @"动态通知";
        
        simplescell.unreadLabel.hidden = YES;
        if ([_noticeType isEqualToString:@"2"]) {
            
            // 时间设置
            NSTimeInterval time=[_noticeDate doubleValue];
            
            NSDate *createDate = [NSDate dateFormJavaTimestamp:time];
            
            simplescell.timeLabel.text = [NSString stringWithFormat:@"%@",[createDate timeAgo]];
            
            NSString *myKey = [NSString stringWithFormat:@"dongtai%@",_noticeType];

            NSString * str =[userDefault objectForKey:myKey];
            
            NSLog(@"-------------------%@",str);

            
            if ([str isEqualToString:@"isUnRead"]) {
                
                simplescell.noticeUnreadImage.hidden = NO;
                
                simplescell.timeLabel.text = [NSString stringWithFormat:@"%@",[createDate timeAgo]];

                if ([_objType isEqualToString:@"0"]) {
                    // 问答
                    simplescell.detailLabel.text = [NSString stringWithFormat:@"%@ 评论了你关注的问答: %@",_userName,_objTitle];
                    [NewsNoticInforManager shareInstance].dongTaiDetail = [NSString stringWithFormat:@"%@ 评论了你关注的问答: %@",_userName,_objTitle];

                    
                    [NewsNoticInforManager shareInstance].dongTaiType = @"1";
                    
                    simplescell.timeLabel.hidden = NO;

                    
                }
                else {
                    // 话题
                    simplescell.detailLabel.text = [NSString stringWithFormat:@"%@ 评论了你关注的动态: %@",_userName,_objTitle];
                    [NewsNoticInforManager shareInstance].dongTaiDetail = [NSString stringWithFormat:@"%@ 评论了你关注的话题: %@",_userName,_objTitle];
                    [NewsNoticInforManager shareInstance].dongTaiType = @"2";
                    simplescell.timeLabel.hidden = NO;

                }

            }
            else {
                
                
                simplescell.detailLabel.text = @"暂无新的通知";
                simplescell.noticeUnreadImage.hidden = YES;
                simplescell.unreadLabel.hidden = YES;
                simplescell.timeLabel.hidden = YES;

            }
            
        
        }
        else {
            
            if ([[NewsNoticInforManager shareInstance].dongTaiType isEqualToString:@"1"]) {
                
                simplescell.detailLabel.text = [NewsNoticInforManager shareInstance].dongTaiDetail = [NSString stringWithFormat:@"%@",[NewsNoticInforManager shareInstance].dongTaiDetail];
                
                simplescell.timeLabel.hidden = YES;
                
            }
            else if ([[NewsNoticInforManager shareInstance].dongTaiType isEqualToString:@"2"]) {
                
                simplescell.detailLabel.text = [NSString stringWithFormat:@"%@",[NewsNoticInforManager shareInstance].dongTaiDetail];
                
                simplescell.timeLabel.hidden = YES;

                
            }
            else {
                simplescell.detailLabel.text = @"暂无新的通知";
                simplescell.noticeUnreadImage .hidden = YES;
                simplescell.timeLabel.hidden = YES;
                
            }

        }


    }
    if (indexPath.row == 2) {
        // 关注我的人
        simplescell.headerImage.image = [UIImage imageNamed:@"Fans_Notice"];
        simplescell.nameLabel.text = @"关注我的人";
        simplescell.unreadLabel.hidden = YES;
        if ([_noticeType isEqualToString:@"3"]) {
            
            simplescell.detailLabel.text = [NSString stringWithFormat:@"%@ 关注了你",_userName];
            
            [NewsNoticInforManager shareInstance].guanZhuDetail = [NSString stringWithFormat:@"%@ 关注了你",_userName];
            // 时间设置
            NSTimeInterval time=[_noticeDate doubleValue];
            
            NSDate *createDate = [NSDate dateFormJavaTimestamp:time];
            
            simplescell.timeLabel.text = [NSString stringWithFormat:@"%@",[createDate timeAgo]];
            
            
            NSString *myKey = [NSString stringWithFormat:@"guanzhu%@",_noticeType];

            NSString * str =[userDefault objectForKey:myKey];
            
            NSLog(@"-------------------%@",str);
            
            if ([str isEqualToString:@"isUnRead"]) {
                
                simplescell.noticeUnreadImage.hidden = NO;
                simplescell.timeLabel.hidden = NO;
            }
            else {
                
                simplescell.noticeUnreadImage.hidden = YES;

            }

            
        }
        else {
            
            if ([[NewsNoticInforManager shareInstance].guanZhuDetail isEqualToString:@""]||[NewsNoticInforManager shareInstance].guanZhuDetail == nil) {
                
                simplescell.detailLabel.text = @"暂无新的通知";
                simplescell.noticeUnreadImage .hidden = YES;
                simplescell.timeLabel.hidden = YES;

            }
            else {
                simplescell.noticeUnreadImage .hidden = YES;
//                simplescell.timeLabel.hidden = YES;
                simplescell.detailLabel.text = [NSString stringWithFormat:@"%@",[NewsNoticInforManager shareInstance].guanZhuDetail];
                simplescell.timeLabel.hidden = YES;

                
            }
            


        }
    }
    
    if (indexPath.row ==3) {
        
        simplescell.headerImage.image = [UIImage imageNamed:@"System_Notice"];
        simplescell.nameLabel.text = @"系统通知";
        simplescell.unreadLabel.hidden = YES;
        simplescell.noticeUnreadImage .hidden = YES;
        NSString *myKey = [NSString stringWithFormat:@"xitong%@",_noticeType];
        
        NSString * str =[userDefault objectForKey:myKey];
        
        NSLog(@"-------------------%@",str);
        NSLog(@"-------------------%@",_msg);

        
        if ([str isEqualToString:@"isUnRead"]) {
            
            simplescell.noticeUnreadImage.hidden = NO;
                // 系统
            simplescell.detailLabel.text = [NSString stringWithFormat:@"%@",_msg];
            
            // 时间设置
            NSTimeInterval time=[_noticeDate doubleValue];
            
            NSDate *createDate = [NSDate dateFormJavaTimestamp:time];
            
            simplescell.timeLabel.text = [NSString stringWithFormat:@"%@",[createDate timeAgo]];

            
        }
        else {
            
            simplescell.detailLabel.text = @"暂无新的通知";
            simplescell.noticeUnreadImage.hidden = YES;
            simplescell.timeLabel.hidden = YES;

            
        }


    }
    
    
    
    return cell;
}



#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsNoticeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];


    if (indexPath.row == 0) {
        
        _noticeType = @"1";
        // 问答邀请
        QuesAndAnsViewController * questionVC = [[QuesAndAnsViewController alloc]init];
        questionVC.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:questionVC animated:YES];
        

        [_tableView reloadData];
        
    }
    
    if (indexPath.row == 1) {
        
        [_noticeType isEqualToString:@"2"];
        NSString *myKey = [NSString stringWithFormat:@"dongtai%@",_noticeType];

        [userDefault setObject:@"isRead" forKey:myKey];
        
        // 动态通知
        DynamicNoticeViewController *dynamicNoticeVC = [[DynamicNoticeViewController alloc]init];
        dynamicNoticeVC.hidesBottomBarWhenPushed = YES ;

        [self.navigationController pushViewController:dynamicNoticeVC animated:YES];
        
        NSString *str =[userDefault objectForKey:myKey];
        
        if ([str isEqualToString:@"isRead"]) {
            
            cell.noticeUnreadImage.hidden = YES;
//            cell.timeLabel.hidden = YES;
        }
        else {
            
            cell.noticeUnreadImage.hidden = NO;
//            cell.timeLabel.hidden = NO;
        }

        [_tableView reloadData];

        
    }
    
    if (indexPath.row == 2) {
        
        [_noticeType isEqualToString:@"3"];
        NSString *myKey = [NSString stringWithFormat:@"guanzhu%@",_noticeType];

        [userDefault setObject:@"isRead" forKey:myKey];
        // 关注我的人
        InvitePeopleViewController *invitePeopleVC = [[InvitePeopleViewController alloc]init];
        invitePeopleVC.type = @"2";
        invitePeopleVC.title = @"关注我的人";
        invitePeopleVC.hidesBottomBarWhenPushed = YES ;

        [self.navigationController pushViewController:invitePeopleVC animated:YES];
        
        NSString *str =[userDefault objectForKey:myKey];
        
        if ([str isEqualToString:@"isRead"]) {
            
            cell.noticeUnreadImage.hidden = YES;
            cell.timeLabel.hidden =YES;
        }
        else {
            
            cell.noticeUnreadImage.hidden = NO;
            cell.timeLabel.hidden = NO;
        }

        [_tableView reloadData];
    }
    
    if (indexPath.row == 3) {
        
        
        [_noticeType isEqualToString:@"4"];
        NSString *myKey = [NSString stringWithFormat:@"xitong%@",_noticeType];
        
        [userDefault setObject:@"isRead" forKey:myKey];

        
        // 系统消息
        SystemDynamicViewController *systemVC = [[SystemDynamicViewController alloc]init];
        systemVC.hidesBottomBarWhenPushed = YES;
        systemVC.contentStr = _msg;
        cell.noticeUnreadImage.hidden =YES;
        [self.navigationController pushViewController:systemVC animated:YES];
        NSString *str =[userDefault objectForKey:myKey];

        if ([str isEqualToString:@"isRead"]) {
            
            cell.noticeUnreadImage.hidden = YES;
            cell.timeLabel.hidden =YES;
        }
        else {
            
            cell.noticeUnreadImage.hidden = NO;
            cell.timeLabel.hidden = NO;
        }



        [_tableView reloadData];

        
    }



    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
