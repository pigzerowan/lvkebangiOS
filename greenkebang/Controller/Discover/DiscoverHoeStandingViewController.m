//
//  DiscoverHoeStandingViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/19.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "DiscoverHoeStandingViewController.h"
#import "HoeStandingCell.h"
#import "LoveTableFooterView.h"
#import "SVPullToRefresh.h"
#import "MyUserInfoManager.h"
#import "HoeListModel.h"
#import "HoeStandingDetailViewController.h"
#import "OutWebViewController.h"

NSString * const HoeStandingCellIdentifier = @"DiscoverHoeStandingCellIdentifier";

@interface DiscoverHoeStandingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@end

@implementation DiscoverHoeStandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CCCUIColorFromHex(0xf0f1f2);
    self.title = @"锄禾说";
    
    [self initializePageSubviews];


    // 左键按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    // Do any additional setup after loading the view.
}
-(void)initializePageSubviews  {
    
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

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];


    //    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
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
    
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token],
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)};
    self.requestURL = LKB_Discover_Hoe_List_Url;
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!isLoadingMore) {
//            [self.tableView.pullToRefreshView stopAnimating];
//        }
//        else {
//            //[self.dataArray addObject:[NSNull null]];
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
        //        [MBProgressHUD showError:errorMessage toView:self.view];
        return;
    }
    
    
    if ([request.url isEqualToString:LKB_Discover_Hoe_List_Url]) {
        
        HoeListModel *replymodel = (HoeListModel *)parserObject;
        
        NSLog(@"-----------------------%@",replymodel.data);
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:replymodel.data];
        } else {
            
                [_dataArray addObjectsFromArray:replymodel.data];
            
            
        }
        
        [self.tableView reloadData];
        
        if (replymodel.num == 0) {
            
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
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
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
    return  [HoeStandingCell getHeight];
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 14;
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
//    static NSString *CellIdentifier = @"HoeStandingCell";

    HoeStandingCell *cell = [tableView dequeueReusableCellWithIdentifier:HoeStandingCellIdentifier];
    if (!cell) {
        
        cell = [[HoeStandingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HoeStandingCellIdentifier];
    }
    
    if (indexPath.row < self.dataArray.count) {
        HoeListModelDetailModel *attentionModel = (HoeListModelDetailModel *)_dataArray[indexPath.section];
        
        NSLog(@",,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<<<<%@",attentionModel.cover);
        
        [cell configHoeListTableCellWithGoodModel:attentionModel];
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentView.backgroundColor = CCCUIColorFromHex(0xf0f1f2);
    
    return cell;

    
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    HoeListModelDetailModel *attentionModel = (HoeListModelDetailModel *)_dataArray[indexPath.section];

    
    NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/hoeContent/%@",LKB_WSSERVICE_HTTP,attentionModel.hoeId];
    
    NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];
    
    
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
//    outSideWeb.sendMessageType = @"2";
    outSideWeb.rightButtonType = @"1";
    outSideWeb.VcType = @"6";
    outSideWeb.objectId = attentionModel.hoeId;
    outSideWeb.circleDetailId = attentionModel.hoeId;
//    outSideWeb.isAttention = insight.isAttention;
    outSideWeb.mytitle = attentionModel.title;
    outSideWeb.groupAvatar = attentionModel.cover;
    NSLog(@"----------------------------%@",outSideWeb.objectId);
    
    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];
    
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
