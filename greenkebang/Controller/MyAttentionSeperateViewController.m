//
//  MyAttentionSeperateViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 4/5/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "MyAttentionSeperateViewController.h"
#import "DisCoverQueastionViewController.h"
#import "DynamicModel.h"
#import "SVPullToRefresh.h"
#import "DiscoverQATabViewCell.h"
#import "TimeQaTableViewCell.h"
#import "QADetailViewController.h"
#import "MyUserInfoManager.h"
#import "AttentionArticTableViewCell.h"
#import "AttentionContentsModel.h"
#import "InsightDetailViewController.h"
#import "ColumnListViewController.h"
#import "OutWebViewController.h"
@interface MyAttentionSeperateViewController ()<UITableViewDataSource,UITableViewDelegate,AttentionCellDelegate>
{
    
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;
    
}

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@end
@implementation MyAttentionSeperateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [[NSMutableArray alloc] init];
//        [self initializeData];
    self.title = @"关注的专栏";
    [self initializePageSubviews];
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
    [MobClick endLogPageView:@"MyAttentionSeperateViewController"];

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
    [MobClick beginLogPageView:@"MyAttentionSeperateViewController"];

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
    self.requestParas = @{@"userId":_userId,
                          @"attentionType":@"1",
                          @"token":[MyUserInfoManager shareInstance].token,
                          @"page":@(currPage),
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          isLoadingMoreKey:@(isLoadingMore)

                          };
    self.requestURL = LKB_Attention_Contents_Url;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!isLoadingMore) {
//            [self.tableView.pullToRefreshView stopAnimating];
//        }
//        else {
////            [self.dataArray addObject:[NSNull null]];
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
        if ([errorMessage isEqualToString:@"没有网络，连接失败"]) {
            
            
            [self.tableView removeFromSuperview];
            
            WithoutInternetImage.hidden = NO;
            tryAgainButton.hidden = NO;
            
            
            
        }

        return;
    }
    
    if ([request.url isEqualToString:LKB_Attention_Contents_Url]) {
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
    if (_dataArray.count == 0) {
        
        return 1;
    }
    else {
        
        return self.dataArray.count;

    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count == 0) {
        
        return KDeviceHeight - 64;
    }
    else {
        
        return 74;
        
    }

    
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString *CELLNONE = @"CELLNONE";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
        [cell setBackgroundColor:[UIColor whiteColor]];
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Focus-on-the-column"]];
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 169, 172 );
        
        [cell addSubview:loadingImage];
        return cell;
    }

    AttentionArticTableViewCell* simplescell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    simplescell.attentionCellDelegate =self;

    if (indexPath.row < self.dataArray.count) {
        

        AttentionContentsListModel *attentionModel = (AttentionContentsListModel *)_dataArray[indexPath.row];
        [simplescell configAttentionArticTableCellWithGoodModel:attentionModel];
        
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
        
        ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
        ColumnListViewVC.featureId = attentionModel.featureId;
        ColumnListViewVC.title = attentionModel.featureName;
        ColumnListViewVC.featureAvatar = attentionModel.featureAvatar;
        ColumnListViewVC.featureDesc = attentionModel.featureDesc;

        [self.navigationController pushViewController:ColumnListViewVC animated:YES];
        
    }
    
   
}



- (void)turnToArtic:(NSString *)sender {
    
//    InsightDetailViewController *insightVC = [[InsightDetailViewController alloc]init];
//    insightVC.topicId = sender;
//    [self.navigationController pushViewController:insightVC animated:YES];
    NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,sender] ;
    
    NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];
    
    
    
    
    
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    outSideWeb.sendMessageType = @"1";
    outSideWeb.rightButtonType = @"2";
    outSideWeb.VcType = @"2";
//    outSideWeb.featureId = insight.featureId;// 专栏id
    outSideWeb.circleDetailId = sender;// 文章Id
    outSideWeb.objectId = sender;// 文章Id
//    outSideWeb.mytitle = insight.title;
//    outSideWeb.replyNum = insight.replyNum;
//    outSideWeb.couAvatar = insight.featureAvatar;
//    outSideWeb.commendVcType = @"1";
//    outSideWeb.isCollect = insight.isCollect;
//    outSideWeb.groupAvatar = insight.cover;
    //        outSideWeb.isAttention = insight.isAttention;
    
    NSLog(@"----------------------------%@",outSideWeb.groupAvatar);
    
    NSLog(@"----------------------------%@",outSideWeb.couAvatar);
    
    
    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];

    
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[AttentionArticTableViewCell class] forCellReuseIdentifier:CellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

//#pragma mark - Page subviews
//- (void)initializeData
//{
//    self.dataArray = [[NSMutableArray alloc] init];
//    for (NSInteger i = 0; i < 10; i++) {
//        [self.dataArray addObject:[NSNull null]];
//    }
//}
@end
