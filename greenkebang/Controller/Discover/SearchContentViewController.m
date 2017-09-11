//
//  SearchContentViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/14.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SearchContentViewController.h"
#import "ContentTableViewCell.h"
#import "FindSearchModel.h"
#import "SearchTextManger.h"
#import "SVPullToRefresh.h"
#import "MyUserInfoManager.h"
#import "InsightDetailViewController.h"
#import "QADetailViewController.h"
#import "OutWebViewController.h"
#import "LoveTableFooterView.h"
static NSString* KDCellIdentifier = @"SearchTableViewCellIdentifier";

@interface SearchContentViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SearchContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.dataArray = [[NSMutableArray alloc] init];
    //    [self initializeData];
    if ([SearchTextManger shareInstance].searchText!=nil) {
        
        [self initializePageSubviews];
    }
    

    // Do any additional setup after loading the view.
}


//- (instancetype)initWithDiscoveryOtherControllerType:(SearchViewControllerType)controllerType
//{
//    self = [super init];
//    if (self) {
//        _controllerType = controllerType;
//    }
//    return self;
//}


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
//    ContentTableViewCell *cell =(ContentTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
    return 90;
}

//- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
//{
//    return CGFLOAT_MIN;
//}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    ContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.row < self.dataArray.count) {
        FindSearchModelDetailModel *searchDetail = (FindSearchModelDetailModel *)_dataArray[indexPath.row];
        [cell configSeperateContentCellWithModel:searchDetail];        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        
    }
    
    
    return cell;
    
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArray.count) {
//
        FindSearchModelDetailModel *searchDetail = (FindSearchModelDetailModel *)_dataArray[indexPath.row];
        
        // 1 专栏文章 2 技术答疑 3 群组话题 4 群组 5 人 6 锄禾说 7专栏

        if ([searchDetail.type isEqualToString:@"1"]) {
            
            // 专栏文章
//            InsightDetailViewController *InsightVC = [[InsightDetailViewController alloc] init];
//            InsightVC.topicId = searchDetail.objectId;
//            [self.navigationController pushViewController:InsightVC animated:YES];
            NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,searchDetail.objectId] ;
            
            NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSURL *url = [NSURL URLWithString:strmy];

            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
            outSideWeb.sendMessageType = @"1";
            outSideWeb.rightButtonType = @"2";
            outSideWeb.VcType = @"2";
            outSideWeb.featureId = searchDetail.featureId;// 专栏id
            outSideWeb.circleDetailId = searchDetail.objectId;// 文章Id
            outSideWeb.objectId = searchDetail.objectId;// 文章Id
            outSideWeb.mytitle = searchDetail.title;
            outSideWeb.replyNum = searchDetail.replyNum;
            outSideWeb.couAvatar = searchDetail.featureAvatar;
            outSideWeb.commendVcType = @"1";
            
            NSLog(@"----------------------------%@",outSideWeb.objectId);
            
            outSideWeb.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:outSideWeb animated:YES];

            
        }
        
        if ([searchDetail.type isEqualToString:@"2"] || [searchDetail.type isEqualToString:@"3"]|| [searchDetail.type isEqualToString:@"4"] || [searchDetail.type isEqualToString:@"5"]) {
            
            //  2 技术答疑 3 群组话题 4 群组 5 人
//            QADetailViewController *QADetailVC = [[QADetailViewController alloc] init];
//            QADetailVC.questionId = searchDetail.objectId;
//            [self.navigationController pushViewController:QADetailVC animated:YES];
            
            NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@",LKB_WSSERVICE_HTTP,searchDetail.objectId] ;
            NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSURL *url = [NSURL URLWithString:strmy];
            
            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
            
            outSideWeb.sendMessageType = @"2";
            outSideWeb.rightButtonType = @"2";
            outSideWeb.VcType = @"1";// 圈子动态
            outSideWeb. urlStr =linkUrl;
            outSideWeb.htmlStr = linkUrl;
//            outSideWeb.circleId = insight.groupId;// 圈id
            outSideWeb.circleDetailId = searchDetail.objectId;// 圈详情id
            outSideWeb.objectId = searchDetail.objectId;// 圈详情id
            
            outSideWeb.mytitle = searchDetail.title;
            outSideWeb.describle = searchDetail.summary;
//            outSideWeb.userAvatar = insight.userAvatar;
//            outSideWeb.isAttention = insight.isAttention;
            outSideWeb.commendVcType = @"1";// 评论一级页面
            
            outSideWeb.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:outSideWeb animated:YES];


        }
        if ([searchDetail.type isEqualToString:@"6"]) {
            
            // 锄禾说
//            InsightDetailViewController *InsightVC = [[InsightDetailViewController alloc] init];
//            InsightVC.topicId = searchDetail.objectId;
//            [self.navigationController pushViewController:InsightVC animated:YES];
            NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/hoeContent/%@",LKB_WSSERVICE_HTTP,searchDetail.objectId];
            NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSURL *url = [NSURL URLWithString:strmy];
            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
            //    outSideWeb.sendMessageType = @"2";
            outSideWeb.rightButtonType = @"1";
            outSideWeb.VcType = @"6";
            outSideWeb.objectId =searchDetail.objectId;
            outSideWeb.circleDetailId = searchDetail.objectId;
            NSLog(@"----------------------------%@",outSideWeb.objectId);
            
            outSideWeb.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:outSideWeb animated:YES];



        }
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[ContentTableViewCell class] forCellReuseIdentifier:CellIdentifier];
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


#pragma mark -fetchDataWithIsLoadingMore
- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
//    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
//    if (!isLoadingMore) {
//        currPage = 1;
//    } else {
//        ++ currPage;
//    }
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"searchType":@"1",
                          @"token":[MyUserInfoManager shareInstance].token,
                          @"searchContent":[SearchTextManger shareInstance].searchText
                          
                          //                              isLoadingMoreKey:@(isLoadingMore)
                          };
    self.requestURL = LKB_Find_Search_Url;
    
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
//    if ([request.url isEqualToString:LKB_Find_Search_Url]) {
    
    FindSearchModel * findModel = (FindSearchModel *)parserObject;
    NSLog(@"-------------------%@",findModel.data);
    NSLog(@"-------------------%@",findModel.msg);

        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:findModel.data];
            
        } else {
            [_dataArray addObjectsFromArray:findModel.data];
        }
        [self.tableView reloadData];
        if (findModel.data.count == 0) {
            _tableView.tableFooterView.hidden = NO;

            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
//            self.tableView.showsInfiniteScrolling = YES;
            _tableView.tableFooterView.hidden = NO;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
            
        }
//    }
    
    NSLog(@"22222222222222222222222222222");
    
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
