//
//  UserInforActivityViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/11/9.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforActivityViewController.h"
#import "ActivityTableViewCell.h"
#import "ActivityModel.h"
#import "OutWebViewController.h"
#import "MyUserInfoManager.h"
#import "SVPullToRefresh.h"
#import "LvKeXiuActivityCell.h"
NSString * const activityCellIdentifier = @"activityTableViewCellIdentifier";

@interface UserInforActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;

}
@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation UserInforActivityViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"我的动态";
    
    [self initializePageSubviews];
    self.dataArray = [[NSMutableArray alloc] init];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
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

    
}

- (void)tryAgainButton:(id )sender {
    
    
    [self initializePageSubviews];
    
    
    
    
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;
    [MobClick endLogPageView:@"UserInforActivityViewController"];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
    // 隐藏导航下的线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [MobClick beginLogPageView:@"UserInforActivityViewController"];

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
    self.tableView.showsInfiniteScrolling = NO;
    [self.tableView triggerPullToRefresh];
    
}

#pragma mark -fetchDataWithIsLoadingMore
- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    
    
    self.requestParas =  @{@"userId":[MyUserInfoManager shareInstance].userId,
                           @"ownerId":[MyUserInfoManager shareInstance].userId,
                           @"page":@(currPage),
                           @"token":[[MyUserInfoManager shareInstance]token],
                           isLoadingMoreKey:@(isLoadingMore)};
    
    self.requestURL = LKB_Activity_Url;
    
    
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [_tableView registerClass:[LvKeXiuActivityCell class] forCellReuseIdentifier:activityCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}





#pragma mark - UITableViewDataSource
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    
    static NSString *CELLNONE = @"UserInforCELLNONE";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"no-content-yet"]];
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );
        
        [cell addSubview:loadingImage];
        
        return cell;
    }

    
    if (indexPath.row < self.dataArray.count) {
        ActivityIntroduceModel *MyactivityIntroduceModel = (ActivityIntroduceModel *)_dataArray[indexPath.row];
        
        cell = [tableView dequeueReusableCellWithIdentifier:activityCellIdentifier];
        if (!cell) {
            cell = [[LvKeXiuActivityCell alloc] initWithStyle:UITableViewCellStyleDefault                                                                               reuseIdentifier:activityCellIdentifier];
            
        }
        
        LvKeXiuActivityCell *simplescell = (LvKeXiuActivityCell *)cell;
        [simplescell configMyActivityCellWithGoodModel:MyactivityIntroduceModel];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_dataArray.count == 0) {
        return 1;
    }else {
        
        return self.dataArray.count ;

    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 179;
    
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    ActivityIntroduceModel *MyactivityIntroduceModel = (ActivityIntroduceModel *)_dataArray[indexPath.row];
    
    NSLog(@"--------------------------%@",MyactivityIntroduceModel.myId);
    
    NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/activity/%@",LKB_WSSERVICE_HTTP,MyactivityIntroduceModel.myId];
    NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];
    
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    
    outSideWeb.rightButtonType = @"1";
    outSideWeb.VcType = @"7";// 活动详情
    outSideWeb. urlStr =linkUrl;
    outSideWeb.htmlStr = linkUrl;
    outSideWeb.circleDetailId = MyactivityIntroduceModel.myId;
    outSideWeb.objectId = MyactivityIntroduceModel.myId;
    
    outSideWeb.mytitle = MyactivityIntroduceModel.name;
    outSideWeb.commendVcType = @"1";
    
    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];
    


}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (!request.isLoadingMore) {
        [self.tableView.pullToRefreshView stopAnimating];
    }
    else {
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
    
    if ([request.url isEqualToString:LKB_Activity_Url]) {
        
        ActivityModel *activityModel = (ActivityModel *)parserObject;
        if (!request.isLoadingMore) {
            
            if(activityModel.data)
            {
                _dataArray= [NSMutableArray arrayWithArray:activityModel.data];
            }
            
        }else {
            [_dataArray addObjectsFromArray:activityModel.data];
        }
        
        
        
        [_tableView  reloadData];
        
        if (activityModel.data.count == 0) {
            
            _tableView.tableFooterView.hidden = NO;
            [_tableView.infiniteScrollingView endScrollAnimating];
        } else {
            _tableView.showsInfiniteScrolling = YES;
            [_tableView.infiniteScrollingView beginScrollAnimating];
            //               [_allTableView.pullToRefreshView stopAnimating];
            
        }
    }
    
}

@end
