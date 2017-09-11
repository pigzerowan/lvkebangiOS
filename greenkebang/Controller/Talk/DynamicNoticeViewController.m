//
//  DynamicNoticeViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "DynamicNoticeViewController.h"
#import "DynamicNoticeCell.h"
#import "MyUserInfoManager.h"
#import "SVPullToRefresh.h"
#import "LoveTableFooterView.h"
#import "GetNoticeModel.h"
#import "UserRootViewController.h"
#import "CommentViewController.h"
#import "OutWebViewController.h"
#import "NewUserMainPageViewController.h"
static NSString* NewsDynamicNoticeCellIdentifier = @"DynamicNoticeCellIdentifier";

@interface DynamicNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;
    
}


@end

@implementation DynamicNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动态通知";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    //获取tableView滚动通知中心单例对象
    NSNotificationCenter * slidercenter = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [slidercenter addObserver:self selector:@selector(slider:) name:@"DynamicNoticeView" object:nil];
    
    
    WithoutInternetImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Network-error"]];
    
    WithoutInternetImage.frame = CGRectMake((kDeviceWidth - 161.5)/2 , 155,161.5, 172);
    
    tryAgainButton = [[UIButton alloc]init];
    
    tryAgainButton.frame = CGRectMake((kDeviceWidth - 135)/2, 374, 135, 33);
    tryAgainButton.backgroundColor = CCCUIColorFromHex(0x01b654);
    tryAgainButton.layer.cornerRadius = 3.0f;
    [tryAgainButton setTitle:@"刷新" forState:UIControlStateNormal];
    [tryAgainButton setTitleColor:CCCUIColorFromHex(0xffffff) forState:UIControlStateNormal];
    tryAgainButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [tryAgainButton addTarget:self action:@selector(tryAgainButton:) forControlEvents:UIControlEventTouchUpInside];
    WithoutInternetImage.hidden = YES ;
    tryAgainButton.hidden = YES;
    
    [self.view addSubview:WithoutInternetImage];
    [self.view addSubview:tryAgainButton];
    
    
    [self initializePageSubviews];


    // Do any additional setup after loading the view.
}

- (void)tryAgainButton:(id )sender {
    
    [self initializePageSubviews];
    
}



-(void)viewWillAppear:(BOOL)animated {
    
    
    
    [super viewWillAppear:animated];
    
    NSNotificationCenter * slidercenter = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [slidercenter addObserver:self selector:@selector(slider:) name:@"DynamicNoticeView" object:nil];
    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [MobClick beginLogPageView:@"DynamicNoticeViewController"];

    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"DynamicNoticeViewController"];
}



- (void)slider:(NSNotification *)sender {
    
    
    NSLog(@"------------------------------%@",sender.userInfo);
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *objectId =[NSString stringWithFormat:@"tongzhi%@",[sender.userInfo objectForKey:@"replyId"]] ;
    
    [userDefault setObject:@"isUnRead" forKey:objectId];
    
    NSString *str = [userDefault objectForKey:objectId
                     ];
    
    
    NSLog(@"------------------------------%@",str);
    
    [self.tableView reloadData];
    
    
    
    
}


-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    self.tableView.showsInfiniteScrolling = YES;
    [self.tableView triggerPullToRefresh];
    
    if (self.dataArray.count == 0) {
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = YES;
    }
    
}


- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    
    self.requestParas = @{
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"page":@(currPage),
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)};
    
    self.requestURL = LKB_Dynamic_Notice;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            [self.tableView.pullToRefreshView stopAnimating];
        }
        else {
            //            [self.dataArray addObject:[NSNull null]];
            [self.tableView.infiniteScrollingView stopAnimating];
        }
        [self.tableView reloadData];
    });
    
}



- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[DynamicNoticeCell class] forCellReuseIdentifier:NewsDynamicNoticeCellIdentifier];
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
    if (_dataArray.count == 0) {
        return 1;
    }
    else {
        return self.dataArray.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SlideBarCell =@"SlideBarCell";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SlideBarCell];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Without-notice"]];
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );
        
        [cell addSubview:loadingImage];
        
        return cell;
    }
    
    else  if (indexPath.row < self.dataArray.count)  {
        
        GetDetailNoticeModel * model = (GetDetailNoticeModel *)_dataArray[indexPath.row];
        
        cell = [tableView dequeueReusableCellWithIdentifier:NewsDynamicNoticeCellIdentifier];
        if (!cell) {
            cell = [[DynamicNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsDynamicNoticeCellIdentifier];
        }
        
        DynamicNoticeCell * simplescell = (DynamicNoticeCell *)cell;
        simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [simplescell configSingelGetNoticeTableCellWithGoodModel:model];
        
        NSLog(@"-------------------------------------%@",model.replyId);
        
        
        
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        
        NSString *myKey = [NSString stringWithFormat:@"tongzhi%@",model.replyId];
        
        
        NSString * str =[userDefault objectForKey:myKey];
        
        
        if ([str isEqualToString:@"isUnRead"]) {
            
            simplescell.unreadImage.hidden = NO;
        }
        else {
            
            simplescell.unreadImage.hidden = YES;
            
        }
        
        
        
        
        
        
        [simplescell handlerButtonAction:^(NSInteger clickIndex) {
            
            
            if (clickIndex == 1) {
                
                NSLog(@"-----------------%@",model.userId);
                
                // 头像
//                UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                userVC.toUserId = model.userId;
//                userVC.type = @"2";
//                userVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:userVC animated:YES];
                NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                peopleVC.type = @"2";
                peopleVC.toUserId = model.userId;
                peopleVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:peopleVC animated:YES];

            }
            if (clickIndex == 2) {
                // 名字
//                UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                userVC.toUserId = model.userId;
//                userVC.type = @"2";
//                userVC.hidesBottomBarWhenPushed = YES;
//                
//                [self.navigationController pushViewController:userVC animated:YES];
                NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                peopleVC.type = @"2";
                peopleVC.toUserId = model.userId;
                peopleVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:peopleVC animated:YES];

                
            }
            if (clickIndex == 3) {
                
                
                NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,model.objId,model.groupId];
                NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                NSURL *url = [NSURL URLWithString:strmy];
                
                OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                
                outSideWeb.sendMessageType = @"2";
                outSideWeb.rightButtonType = @"2";
                outSideWeb.VcType = @"1";// 圈子动态
                outSideWeb. urlStr =linkUrl;
                outSideWeb.htmlStr = linkUrl;
                outSideWeb.circleId = model.groupId;
                outSideWeb.circleDetailId = model.objId;
                outSideWeb.objectId = model.objId;
                
                outSideWeb.mytitle = model.objTitle;
                //                outSideWeb.describle = insight.summary;
                //                outSideWeb.userAvatar = insight.userAvatar;
                //                outSideWeb.isAttention = insight.isAttention;
                outSideWeb.commendVcType = @"1";
                outSideWeb.groupName = model.groupName;
                
                outSideWeb.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:outSideWeb animated:YES];
                
                
                [userDefault setObject:@"isRead" forKey:myKey];
                NSString *str =[userDefault objectForKey:myKey];
                
                if ([str isEqualToString:@"isRead"]) {
                    
                    simplescell.unreadImage.hidden = YES;
                }
                else {
                    
                    simplescell.unreadImage.hidden = NO;
                    
                }
                
                
                [_tableView reloadData];
                
                
                
            }
            
        }];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
        
        
    }
    
    
    
    
    return cell;
}



#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count == 0) {
        
        return KDeviceHeight;

    }
    else {
        
        return 90;

    }
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
        
        if ([errorMessage isEqualToString:@"没有网络，连接失败"]) {
            
            
            [self.tableView removeFromSuperview];
            WithoutInternetImage.hidden = NO;
            tryAgainButton.hidden = NO;
            
            
            
        }

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









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
