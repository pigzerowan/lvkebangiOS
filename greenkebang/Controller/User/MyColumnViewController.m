//
//  MyColumnViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 1/20/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "MyColumnViewController.h"
#import "ColumnModel.h"
#import "SVPullToRefresh.h"
#import "DiscoverTableViewCell.h"
#import "InsightDetailViewController.h"
#import "MyUserInfoManager.h"
#import "MyColumnIntroduceCell.h"
#import "ColumnListViewController.h"
#import "ColumnInfoMation.h"
#import "CreateColumnViewController.h"
static NSString* CellIdentifier = @"FindPepleTableViewCellIdentifier";
@interface MyColumnViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic) UIButton *creatButton;

@end
@implementation MyColumnViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
    self.dataArray = [[NSMutableArray alloc] init];
    
    _creatButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-10, 12, 50, 24)];
    [_creatButton setTitle:@"创建" forState:UIControlStateNormal];
    [_creatButton addTarget:self action:@selector(setColumnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([_type isEqualToString:@"1"]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_creatButton];
        
    }

    
    //    [self initializeData];
    [self initializePageSubviews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    //    self.hidesBottomBarWhenPushed = YES;
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}


// 创建专栏
- (void)setColumnButton:(id)sender {
    
    CreateColumnViewController *createColumnVC = [[CreateColumnViewController alloc]init];
    
    [self.navigationController pushViewController:createColumnVC animated:YES];
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
    
    self.requestParas = @{@"userId":_therquestUrl,
                          @"ownerId":[[MyUserInfoManager shareInstance]userId],
                          @"page":@(currPage),
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)};
    
    self.requestURL = LKB_Insight_features_Url;
    
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
    
    if ([request.url isEqualToString:LKB_Insight_features_Url]) {
        ColumnModel *groupModel = (ColumnModel *)parserObject;
        
        NSLog(@"========%@===============",groupModel.data);
        if (!request.isLoadingMore) {
            if(groupModel.data)
            {
                _dataArray = [NSMutableArray arrayWithArray:groupModel.data];
            }
        } else {
            if (_dataArray.count<groupModel.num) {
                [_dataArray addObjectsFromArray:groupModel.data];
            }
            
        }
        [self.tableView reloadData];
        if (groupModel.data.count == 0) {
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
    return 1;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    MyColumnIntroduceCell* simplescell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.row < self.dataArray.count) {
        ColumnIntroduceModel *MyColumnIntroduceModel = (ColumnIntroduceModel *)_dataArray[indexPath.row];
        [simplescell configColumnIntroduceCellWithModel:MyColumnIntroduceModel];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return simplescell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < self.dataArray.count) {
        ColumnIntroduceModel *topic = (ColumnIntroduceModel *)_dataArray[indexPath.row];
        // 专栏详情
        ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
        ColumnListViewVC.featureId = topic.featureId;
        ColumnListViewVC.title = topic.featureName;
        ColumnListViewVC.featureAvatar = topic.featureAvatar;
        ColumnListViewVC.featureDesc = topic.featureDesc;
        ColumnListViewVC.themUrl = topic.userId;
        [self.navigationController pushViewController:ColumnListViewVC animated:YES];
    }
    
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
        //                LoveTableFooterView *footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        //                footerVew.addFriendBlock = ^(){
        //                    NSLog(@"addFriendClicked");
        //                };
        //                self.tableView.tableFooterView = footerVew;
    }
}

#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[MyColumnIntroduceCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}

#pragma mark - Page subviews
- (void)initializeData
{
    self.dataArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        [self.dataArray addObject:[NSNull null]];
    }
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
@end
