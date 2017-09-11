//
//  XinChuangListViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 7/22/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "XinChuangListViewController.h"
#import "LoveTableFooterView.h"
#import "SVPullToRefresh.h"
#import "UIView+BlockGesture.h"
#import "MBProgressHUD+Add.h"
#import "YQWebDetailViewController.h"
#import "XinChuangTableViewCell.h"
#import "MyUserInfoManager.h"
#import "StarSchoolModel.h"
#import "OutWebViewController.h"

static NSString* XinchuangCellIdentifier = @"XinChuangTableViewCell";

@interface XinChuangListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@end

@implementation XinChuangListViewController
#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    
    //    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =@"消息";
//    [self initializeData];
    [self initializePageSubviews];
    
    // 左键按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -fetchDataWithIsLoadingMore
- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    }
    else {
        ++currPage;
    }
    self.requestParas = @{
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token],
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    self.requestURL = LKB_Star_School_Url;
    
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (!isLoadingMore) {
//                [self.tableView.pullToRefreshView stopAnimating];
//            }
//            else {
//                [self.dataArray addObject:[NSNull null]];
//                [self.tableView.infiniteScrollingView stopAnimating];
//            }
//            [self.tableView reloadData];
//        });
    
    
    
}
- (void)actionFetchRequest:(YQRequestModel*)request result:(LKBBaseModel*)parserObject
              errorMessage:(NSString*)errorMessage
{
    if (!request.isLoadingMore) {
        [self.tableView.pullToRefreshView stopAnimating];
    }
    else {
        [self.tableView.infiniteScrollingView stopAnimating];
    }
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    if ([request.url isEqualToString:LKB_Star_School_Url]) {
        StarSchoolModel* friendsCollectionModel = (StarSchoolModel*)parserObject;
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:friendsCollectionModel.data];
        }
        else {
            [_dataArray addObjectsFromArray:friendsCollectionModel.data];
        }
        [self.tableView reloadData];
        if (friendsCollectionModel.data.count == 0) {
            self.tableView.tableFooterView.hidden = NO;
            [self.tableView.infiniteScrollingView endScrollAnimating];
        }
        else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
        }
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1 ;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{

    return 115;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{

    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return CGFLOAT_MIN;
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    XinChuangTableViewCell* goodsCell = [tableView dequeueReusableCellWithIdentifier:XinchuangCellIdentifier];
    StarSchoolModelDetailModel *model = (StarSchoolModelDetailModel *)_dataArray[indexPath.row];
    
    goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [goodsCell configxinChuangTableCellWithGoodModel:model];
    return goodsCell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
       StarSchoolModelDetailModel *model = (StarSchoolModelDetailModel *)_dataArray[indexPath.row];
//    NSString *linkUrl = [NSString stringWithFormat:@"http://192.168.1.199:8082/app/detail/insight/%@",model.couId];
    
//   NSString *linkUrl = @"http://192.168.1.199:8082/app/detail/insight/1";
    
       NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,model.couInsight];
    NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];

//    NSDictionary *dictCookieUId = [NSDictionary dictionaryWithObjectsAndKeys:@"userId", NSHTTPCookieName,[[MyUserInfoManager shareInstance] userId], NSHTTPCookieValue,
//                                   @"/", NSHTTPCookiePath,
//                                   @"test.com", NSHTTPCookieDomain,nil];//生成cookie的方法是先将cookie的各个property作为键值对生成dictionary
//    
//    NSHTTPCookie *cookieUserId = [NSHTTPCookie cookieWithProperties:dictCookieUId];//调用cookieWIthProperties生成cookie
//    NSDictionary *dictCookiePToken = [NSDictionary dictionaryWithObjectsAndKeys:@"token", NSHTTPCookieName,
//                                      [[MyUserInfoManager shareInstance] token], NSHTTPCookieValue,
//                                      @"/", NSHTTPCookiePath,
//                                      @"test.com", NSHTTPCookieDomain,nil];
//    
//    NSHTTPCookie *cookiePassToken = [NSHTTPCookie cookieWithProperties:dictCookiePToken];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSArray *arrCookies = [NSArray arrayWithObjects: cookieUserId, cookiePassToken, nil];
//    NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:arrCookies];//将cookie设置到头中
//    [request setValue: [dictCookies objectForKey:@"Cookie"] forHTTPHeaderField: @"Cookie"];
    
    
    
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    outSideWeb.sendMessageType = @"1";
    outSideWeb.rightButtonType = @"2";
    outSideWeb.VcType = @"3";
    outSideWeb.circleDetailId = model.couInsight;// 专栏详情Id
    outSideWeb.featureId = model.featureId; // 专栏Id
    outSideWeb.objectId = model.couInsight;// 专栏详情Id
    outSideWeb.replyNum = model.replyNum;
    outSideWeb.couAvatar = model.featureAvatar; // 专栏头像
    outSideWeb.mytitle = model.couTitle; // 专栏标题
    outSideWeb.commendVcType = @"1";
    outSideWeb.isCollect = model.isCollect;
    outSideWeb.groupAvatar = model.couAvatar;
    
    NSLog(@"----------------------------%@",outSideWeb.objectId);
    NSLog(@"<<<<<<<<<<<<<<<<<<<<<----------------------------%@",model.couInsight);

    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];

}



#pragma mark - Page subviews
#pragma mark - Page subviews
- (void)initializeData
{
    self.dataArray = [[NSMutableArray alloc] init];
//    for (NSInteger i = 0; i < 10; i++) {
//        [self.dataArray addObject:[NSNull null]];
//    }
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
    if (self.dataArray.count == 0) {
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        footerVew.textLabel.text=@"没有更多数据了哦..";
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = YES;

    }
}
#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        [_tableView registerClass:[XinChuangTableViewCell class] forCellReuseIdentifier:XinchuangCellIdentifier];

    }
    return _tableView;
}


@end
