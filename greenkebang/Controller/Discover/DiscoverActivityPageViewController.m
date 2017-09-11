//
//  DiscoverActivityPageViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/19.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "DiscoverActivityPageViewController.h"
#import "HoeStandingCell.h"
#import "HoeStandingDetailViewController.h"
#import "SVPullToRefresh.h"
#import "LoveTableFooterView.h"
#import "MyUserInfoManager.h"
#import "ActivityListModel.h"
#import "OutWebViewController.h"
#import "ShareArticleManager.h"
#import "LvKeXiuActivityCell.h"
@interface DiscoverActivityPageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@end

@implementation DiscoverActivityPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    [self initializePageSubviews];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [ShareArticleManager shareInstance].shareType = nil;
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
                          @"status":_status,
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
    
//    HoeStandingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
