//
//  MyCollectionViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/7.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "SVPullToRefresh.h"
#import "MyUserInfoManager.h"
#import "CollectionModel.h"
#import "MyCollectionTableViewCell.h"
#import "InsightDetailViewController.h"
static NSString* CollectionCellIdentifier = @"CollectionTableViewCellIdentifier";

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
    self.dataArray = [[NSMutableArray alloc] init];
    //    [self initializeData];
    [self initializePageSubviews];

    // Do any additional setup after loading the view.
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    self.requestParas = @{@"userId":_userId,
                          @"token":[[MyUserInfoManager shareInstance]token],
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          };
    
    self.requestURL = LKB_ColumnInfo_Collection_Url;
    
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
    
    if ([request.url isEqualToString:LKB_ColumnInfo_Collection_Url]) {
        CollectionModel *collectionModel = (CollectionModel *)parserObject;
        
        NSLog(@"========%@===============",collectionModel.data);
        if (!request.isLoadingMore) {
            if(collectionModel.data)
            {
                _dataArray = [NSMutableArray arrayWithArray:collectionModel.data];
            }
        } else {
            [_dataArray addObjectsFromArray:collectionModel.data];
        }
        [self.tableView reloadData];
        if (collectionModel.data.count == 0) {
            //            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
        }
        
    }
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
        //                LoveTableFooterView *footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        //                footerVew.addFriendBlock = ^(){
        //                    NSLog(@"addFriendClicked");
        //                };
        //                self.tableView.tableFooterView = footerVew;
    }
    
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[MyCollectionTableViewCell class] forCellReuseIdentifier:CollectionCellIdentifier];
    }
    return _tableView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    MyCollectionTableViewCell *simplescell = [tableView dequeueReusableCellWithIdentifier:CollectionCellIdentifier];
    if (indexPath.row < self.dataArray.count) {
        CollectionDetailModel *collection = (CollectionDetailModel *)_dataArray[indexPath.row];
        [simplescell configCollectionCellWithModel:collection];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    //
    return simplescell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < self.dataArray.count) {
        
        CollectionDetailModel *collectionModel = (CollectionDetailModel *)_dataArray[indexPath.row];

        InsightDetailViewController *InsightVC = [[InsightDetailViewController alloc] init];
        InsightVC.topicId =collectionModel.insightId ;
        [self.navigationController pushViewController:InsightVC animated:YES];

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
