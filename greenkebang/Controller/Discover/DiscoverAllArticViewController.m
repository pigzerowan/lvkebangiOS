//
//  DiscoverAllArticViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 7/25/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "DiscoverAllArticViewController.h"
#import "DisCoverQueastionViewController.h"
#import "DynamicModel.h"
#import "SVPullToRefresh.h"
#import "DiscoverQATabViewCell.h"
#import "TimeQaTableViewCell.h"
#import "QADetailViewController.h"
#import "MyUserInfoManager.h"
#import "AllArticTableViewCell.h"
#import "AttentionContentsModel.h"
#import "InsightDetailViewController.h"
#import "ColumnListViewController.h"
#import "OutWebViewController.h"
#import "SearchTextManger.h"
#import "FindSearchModel.h"
#import "LoveTableFooterView.h"
@interface DiscoverAllArticViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@end
@implementation DiscoverAllArticViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [[NSMutableArray alloc] init];
    //        [self initializeData];
    self.title = @"专栏";
    
    if ([SearchTextManger shareInstance].searchText!=nil) {
        
        [self initializePageSubviews];
    }
    if ([_VCtype isEqualToString:@"1"]) {
        [self initializePageSubviews];

    }

    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    //
    [MobClick beginLogPageView:@"DiscoverAllArticViewController"];

    
    
    //    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"DiscoverAllArticViewController"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
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
    if ([_VCtype isEqualToString:@"2"]) {
        
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"searchType":@"2",
                              @"token":[MyUserInfoManager shareInstance].token,
                              @"searchContent":[SearchTextManger shareInstance].searchText
                              
                              //                              isLoadingMoreKey:@(isLoadingMore)
                              };
        self.requestURL = LKB_Find_Search_Url;

    }
    else {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              
                              @"token":[MyUserInfoManager shareInstance].token,
                              @"page":@(currPage),
                              
                              isLoadingMoreKey:@(isLoadingMore)
                              
                              };
        self.requestURL = LKB_All_Artic_Contents_Url;

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
    
    if ([request.url isEqualToString:LKB_All_Artic_Contents_Url]) {
        AttentionContentsModel *groupModel = (AttentionContentsModel *)parserObject;
        
        NSLog(@"========%@===============",groupModel.data);
        if (!request.isLoadingMore) {
            if(groupModel.data)
            {
                _dataArray = [NSMutableArray arrayWithArray:groupModel.data];
            }
        } else {
            if (_dataArray.count< groupModel.num) {
                [_dataArray addObjectsFromArray:groupModel.data];
            }
            
        }
        [self.tableView reloadData];
        if (groupModel.data.count == 0) {
            _tableView.tableFooterView.hidden = NO;

            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
//            self.tableView.showsInfiniteScrolling = YES;
            _tableView.tableFooterView.hidden = NO;

            [self.tableView.infiniteScrollingView beginScrollAnimating];
        }
        
    }
    
    if ([request.url isEqualToString:LKB_Find_Search_Url]) {
    
    FindSearchModel * findModel = (FindSearchModel *)parserObject;
    
    NSLog(@"--------------------------------------%@",findModel.data);
    if (!request.isLoadingMore) {
        _dataArray = [NSMutableArray arrayWithArray:findModel.data];
    } else {
        [_dataArray addObjectsFromArray:findModel.data];
    }
    [self.tableView reloadData];
    if (findModel.data.count == 0) {
        
        [self.tableView.infiniteScrollingView endScrollAnimating];
    } else {
        
        self.tableView.showsInfiniteScrolling = YES;
        [self.tableView.infiniteScrollingView beginScrollAnimating];
        
    }
        }

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    AllArticTableViewCell* simplescell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.row < self.dataArray.count) {
        
        if ([_VCtype isEqualToString:@"2"]) {
            
            FindSearchModelDetailModel *searchDetail = (FindSearchModelDetailModel *)_dataArray[indexPath.row];
            
            [simplescell configSeperateGroupCellWithModel:searchDetail];


        }
        else {
            
            AttentionContentsListModel *attentionModel = (AttentionContentsListModel *)_dataArray[indexPath.row];
            [simplescell configAllArticTableCellWithGoodModel:attentionModel];

            
        }
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return simplescell;
    
    
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArray.count) {
        
        
        AttentionContentsListModel *attentionModel = (AttentionContentsListModel *)_dataArray[indexPath.row];
        
        FindSearchModelDetailModel *searchDetail = (FindSearchModelDetailModel *)_dataArray[indexPath.row];

        
        ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
        if ([_VCtype isEqualToString:@"2"]) {
            
            ColumnListViewVC.featureId = searchDetail.objectId;
            //    ColumnListViewVC.title = attentionModel.featureName;
            ColumnListViewVC.featureAvatar = searchDetail.cover;
            //    ColumnListViewVC.featureDesc = attentionModel.featureDesc;
        }
        else {
            ColumnListViewVC.featureId = attentionModel.featureId;
            //    ColumnListViewVC.title = attentionModel.featureName;
            ColumnListViewVC.featureAvatar = attentionModel.featureAvatar;
            //    ColumnListViewVC.featureDesc = attentionModel.featureDesc;

        }
        
        [self.navigationController pushViewController:ColumnListViewVC animated:YES];


    }
    
    
}



- (void)turnToArtic:(NSString *)sender {
    
    InsightDetailViewController *insightVC = [[InsightDetailViewController alloc]init];
    insightVC.topicId = sender;
    [self.navigationController pushViewController:insightVC animated:YES];
    
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
        self.tableView.tableFooterView.hidden = NO;
    }
}

#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-64) style:UITableViewStyleGrouped];
         _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        //        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[AllArticTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}

@end
