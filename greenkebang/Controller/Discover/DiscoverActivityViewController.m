//
//  DiscoverActivityViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/19.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "DiscoverActivityViewController.h"
#import "TYTabButtonPagerController.h"
#import "DiscoverActivityPageViewController.h"

#import "HoeStandingDetailViewController.h"
#import "SVPullToRefresh.h"
#import "LoveTableFooterView.h"
#import "MyUserInfoManager.h"
#import "ActivityListModel.h"
#import "OutWebViewController.h"
#import "ShareArticleManager.h"
#import "LvKeXiuActivityCell.h"
@interface DiscoverActivityViewController ()<TYPagerControllerDataSource,UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;
    
}


@property(nonatomic, strong)UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;



@property (nonatomic, strong) TYTabButtonPagerController *pagerController;

@end

@implementation DiscoverActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"活动";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 左键按钮
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


    [self initializePageSubviews];



    // Do any additional setup after loading the view.
}

- (void)tryAgainButton:(id )sender {
    
    [self initializePageSubviews];
    
}


-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
//    if (!_showNavBar) {
//        self.navigationController.navigationBarHidden = YES;
//    }
//    
//    // 隐藏导航下的线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//     self.navigationController.navigationBar.translucent = NO;
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
//    
//    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    // DiscoverActivityViewController
    [MobClick beginLogPageView:@"DiscoverActivityViewController"];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    if (!_showNavBar) {
//        self.navigationController.navigationBarHidden = NO;
//    }
//    
//
//        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setShadowImage:nil];
//        self.navigationController.navigationBar.translucent = YES;
    [MobClick endLogPageView:@"DiscoverActivityViewController"];


}


- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _pagerController.view.frame = self.view.bounds;
}



#pragma mark - Page subviews
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
        footerVew.backgroundColor = [UIColor clearColor];
        footerVew.textLabel.text=@"没有更多数据了哦..";
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = YES;
    }
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
    self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                          @"token":[MyUserInfoManager shareInstance].token,
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    self.requestURL = LKB_Discover_Activity_List_Url;
    
    
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage {
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
    if ([request.url isEqualToString:LKB_Discover_Activity_List_Url]) {
        
        ActivityListModel * activityModel = (ActivityListModel *)parserObject;
        
        NSLog(@"*--------------------%@",activityModel.data);
        
        if (!request.isLoadingMore) {
            
            _dataArray = [NSMutableArray arrayWithArray:activityModel.data];
        } else {
            
            if (_dataArray.count<activityModel.num) {
                [_dataArray addObjectsFromArray:activityModel.data];
            }
            
        }
        
        [self.tableView reloadData];
        
        if (activityModel.num == 0) {
            
            _tableView.tableFooterView.hidden = NO;
            [_tableView.infiniteScrollingView endScrollAnimating];
        } else {
            //            _tableView.showsInfiniteScrolling = YES;
            _tableView.tableFooterView.hidden = NO;
            
            [_tableView.infiniteScrollingView beginScrollAnimating];
            
        }
        
    }
    
    
}



- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    return  [HoeStandingCell getHeight] ;
    return 179;

}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 14;
    }
    else {
        return 1;
    }
    
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"GroupCell";

    LvKeXiuActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[LvKeXiuActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.contentView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (indexPath.row < self.dataArray.count) {
        ActivityListDetailModel *attentionModel = (ActivityListDetailModel *)_dataArray[indexPath.section];
        
        //        [cell configActivityListTableCellWithGoodModel:attentionModel];
        [cell configLvKeXiuActivityCellWithGoodModel:attentionModel];
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    HoeStandingDetailViewController * hoeStandingVC = [[HoeStandingDetailViewController alloc]init];
    //
    //    [self.navigationController pushViewController:hoeStandingVC animated:YES];
    ActivityListDetailModel *attentionModel = (ActivityListDetailModel *)_dataArray[indexPath.section];
    
    
    NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/activity/%@",LKB_WSSERVICE_HTTP,attentionModel.myId];
    
    NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];
    
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    //    outSideWeb.sendMessageType = @"2";
    outSideWeb.rightButtonType = @"1";
    //    outSideWeb.objectId = attentionModel.myId;
    //    outSideWeb.isAttention = insight.isAttention;
    outSideWeb.VcType = @"7";
    outSideWeb.circleDetailId = attentionModel.myId;
    outSideWeb.mytitle = attentionModel.name;
    outSideWeb.groupAvatar = attentionModel.img;
    outSideWeb.couAvatar = attentionModel.img;
    
    [ShareArticleManager shareInstance].shareType = @"1";
    
    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];
    
    
}



- (void)addPagerController
{
    TYTabButtonPagerController *pagerController = [[TYTabButtonPagerController alloc]init];
    pagerController.dataSource = self;
    pagerController.adjustStatusBarHeight = YES;
    pagerController.cellWidth = SCREEN_WIDTH / 3 -10 ;
    pagerController.cellSpacing = 8;
    pagerController.barStyle = _variable ? TYPagerBarStyleProgressBounceView: TYPagerBarStyleProgressView;
    [pagerController setCurIndex:1];
    if (_showNavBar) {
        pagerController.progressWidth = _variable ? 0 : 10;
    }
    
    pagerController.view.frame = self.view.bounds;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    _pagerController = pagerController;
}

- (void)scrollToRamdomIndex
{
    [_pagerController moveToControllerAtIndex:arc4random()%3 animated:NO];
}

#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController
{
    return 3;
}


- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    if (index == 0) {
        
        return @"即将开始";
    }
    else if (index == 1) {
        
        return @"进行中";
    }
    else {
        
        return  @"往期活动";
    }
    
    
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{

    DiscoverActivityPageViewController *pageVC = [[DiscoverActivityPageViewController alloc]init];
    
    if (index == 0) {
        pageVC.status = @"0";
    }
    if (index == 1) {
        pageVC.status = @"1";
    }
    if (index == 2) {
        pageVC.status = @"2";
    }

    return pageVC;
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
