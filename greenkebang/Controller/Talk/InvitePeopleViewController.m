//
//  InvitePeopleViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "InvitePeopleViewController.h"
#import "GroupTableViewCell.h"
#import "SVPullToRefresh.h"
#import "LoveTableFooterView.h"
#import "MyUserInfoManager.h"
#import "InvitePeopleModel.h"
#import "UserRootViewController.h"
#import "FansModel.h"
#import "PeopleTableViewCell.h"
#import "NewUserMainPageViewController.h"
NSString * const NewNoticeInviteCellIdentifier = @"NewNoticeInviteCellIdentifier";
static NSString* UserCellIdentifier = @"PepleTableViewCellIdentifier";

@interface InvitePeopleViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;
    
}


@end

@implementation InvitePeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];

    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    //获取NewsNotice通知中心单例对象
    NSNotificationCenter * NewsNotice = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [NewsNotice addObserver:self selector:@selector(InviteNewsNotice:) name:@"InvitePeopleViewController" object:nil];
    
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



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];

    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [MobClick beginLogPageView:@"InvitePeopleViewController"];

}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // 设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor navbarColor]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [MobClick endLogPageView:@"InvitePeopleViewController"];

}





-(void)InviteNewsNotice:(NSNotification *)sender {
    
    NSLog(@"-----------------------------%@",sender.userInfo);
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
    
    if ([_type isEqualToString:@"1"]) {
        self.requestParas = @{
                              @"userId":[[MyUserInfoManager shareInstance]userId],
                              @"topicId":_objId,
                              @"token":[[MyUserInfoManager shareInstance]token],
                              isLoadingMoreKey:@(isLoadingMore)};
        
        self.requestURL = LKB_Invite_User;
    }
    else {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"ownerId":[MyUserInfoManager shareInstance].userId,
                              @"token":[MyUserInfoManager shareInstance].token,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              };
        
        self.requestURL = LKB_Attention_All_Fans_Url;
    }
    
    
    
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
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //        [_tableView registerClass:[NewsCommentCell class] forCellReuseIdentifier:NewsCommentIdentifier];
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
        
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"No-fans"]];
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );
        
        [cell addSubview:loadingImage];
        
        return cell;
    }
    
    else  if (indexPath.row < self.dataArray.count)  {
        
        if ([_type isEqualToString:@"1"]) {
            
            InvitePeopleDetailModel * model = (InvitePeopleDetailModel *)_dataArray[indexPath.row];
            
        
        
            cell = [tableView dequeueReusableCellWithIdentifier:NewNoticeInviteCellIdentifier];
            if (!cell) {
                cell = [[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewNoticeInviteCellIdentifier];
            }
            
            
            GroupTableViewCell * simplescell = (GroupTableViewCell *)cell;
            simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [simplescell configNewsInvitePeopleCellWithModel:model];
            [simplescell setNeedsUpdateConstraints];
            [simplescell updateConstraintsIfNeeded];
        }
        
        else {
            
            peopeleModel *model = (peopeleModel *)_dataArray[indexPath.row];
            
           cell = [tableView dequeueReusableCellWithIdentifier:UserCellIdentifier];
            
            if (!cell) {
                cell = [[PeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserCellIdentifier];
            }

            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            if (model.avatar==nil) {
                model.avatar = @"";
            }
            if (model.userName==nil) {
                model.userName = model.userName;
            }
            NSDictionary *mydic = @{@"userName":model.userName,
                                    @"userAvatar":model.avatar
                                    };
            NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
            [userDefaults setObject:dic  forKey:model.userId];
            PeopleTableViewCell * simplescell = (PeopleTableViewCell *)cell;

            simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [simplescell configPeopleCellWithModel:model];
            [simplescell setNeedsUpdateConstraints];
            [simplescell updateConstraintsIfNeeded];


        }
        
    }
    
    
    
    
    return cell;
}



#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    InvitePeopleDetailModel *model = (InvitePeopleDetailModel *)_dataArray[indexPath.row];
    
//    UserRootViewController *userVC = [[UserRootViewController alloc]init];
//    userVC.toUserId = model.userId;
//    userVC.type = @"2";
//    [self.navigationController pushViewController:userVC animated:YES];
    NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
    peopleVC.type = @"2";
    peopleVC.toUserId = model.userId;
    peopleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:peopleVC animated:YES];

    
    
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
    
    
    
    if ([request.url isEqualToString:LKB_Invite_User]) {
        InvitePeopleModel *Model = (InvitePeopleModel *)parserObject;
        
        NSLog(@"-----------------------%@",Model.data);
        
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:Model.data];
        }
//        else {
//            [_dataArray addObjectsFromArray:Model.data];
//        }
        
        
        [self.tableView reloadData];
        
        
    }
    if ([request.url isEqualToString:LKB_Attention_All_Fans_Url]) {
        FansModel *fansmodel = (FansModel *)parserObject;
        if (!request.isLoadingMore) {
            
            
            _dataArray = [NSMutableArray arrayWithArray:fansmodel.data];
        } else {
            
            
            if (_dataArray.count<fansmodel.num) {
                [_dataArray addObjectsFromArray:fansmodel.data];
            }
        }
        
        [self.tableView reloadData];
        if (fansmodel.data.count == 0) {
            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
            
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
