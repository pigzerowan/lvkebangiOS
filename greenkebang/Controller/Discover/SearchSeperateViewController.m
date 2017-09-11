//
//  SearchSeperateViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/14.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SearchSeperateViewController.h"
#import "SeperateTableViewCell.h"
#import "MyUserInfoManager.h"
#import "SearchTextManger.h"
#import "SVPullToRefresh.h"
#import "ToPicModel.h"
#import "ToUserManager.h"
#import "FindSearchModel.h"
#import "ContentTableViewCell.h"
#import "OtherUserInforViewController.h"
#import "UserInforModel.h"
#import "SearchRootViewController.h"
#import "GroupModel.h"
#import "UserRootViewController.h"
#import "ColumnListViewController.h"
#import "LoveTableFooterView.h"
#import "NewUserMainPageViewController.h"
static NSString* CellIdentifier = @"SearchTableViewCellIdentifier";

@interface SearchSeperateViewController ()
@end

@implementation SearchSeperateViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithSearchOtherControllerType:(SearchOtherControllerType)controllerType {

    self = [super init];
    if (self) {
        _controllerType = controllerType;
    }
    return self;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
    self.tableView.backgroundColor  = [UIColor whiteColor];
    self.dataArray = [[NSMutableArray alloc] init];
    if ([SearchTextManger shareInstance].searchText!=nil) {
        [self initializePageSubviews];
    }

    // Do any additional setup after loading the view.
}

#pragma mark - View life cycle
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillLayoutSubviews {
    
    // Re-layout sub views
//    [self layoutSubviews];
}



- (void)initializePageSubviews {
    
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
        footerVew.backgroundColor = [UIColor clearColor];
        footerVew.textLabel.text=@"没有更多数据了哦..";
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = NO;
        
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
//    return 30;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

//- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
//{
//    return CGFLOAT_MIN;
//}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    SeperateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    FindSearchModelDetailModel *searchDetail = (FindSearchModelDetailModel *)_dataArray[indexPath.row];
//    ContentTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (indexPath.row < self.dataArray.count) {
        
        if (_controllerType==1) {
                // 专栏
                FindSearchModelDetailModel *searchDetail = (FindSearchModelDetailModel *)_dataArray[indexPath.row];
            [cell configSeperateGroupCellWithModel:searchDetail];
            

        }
        else if (_controllerType==2)
        {
                FindSearchModelDetailModel *searchDetail = (FindSearchModelDetailModel *)_dataArray[indexPath.row];
            [cell configSeperatePeopleCellWithModel:searchDetail];
        }
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
    }
    return cell;

    
}


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    SearchRootViewController *searchVC = [[SearchRootViewController alloc]init];
    [searchVC.searchBar resignFirstResponder];
    [searchVC.searchBar removeFromSuperview];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArray.count) {
        // 群
        if (_controllerType==1) {
            
            FindSearchModelDetailModel *searchDetail = (FindSearchModelDetailModel *)_dataArray[indexPath.row];
            
            ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
            ColumnListViewVC.featureId = searchDetail.objectId;
            //    ColumnListViewVC.title = attentionModel.featureName;
            ColumnListViewVC.featureAvatar = searchDetail.groupAvatar;
            //    ColumnListViewVC.featureDesc = attentionModel.featureDesc;
            
            [self.navigationController pushViewController:ColumnListViewVC animated:YES];



            
        }
        // 人
        if (_controllerType==2) {
            
            FindSearchModelDetailModel *searchDetail = (FindSearchModelDetailModel *)_dataArray[indexPath.row];

//            UserRootViewController * otherUserVC = [[UserRootViewController alloc]init];
//            otherUserVC.type = @"2";
//            otherUserVC.toUserId = searchDetail.userId;
//            
//            NSLog(@"~~~~~~~~~~~~~~~~~~~%@",otherUserVC.toUserId);
//
//            [self.navigationController pushViewController:otherUserVC animated:YES];
            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
            peopleVC.type = @"2";
            peopleVC.toUserId = searchDetail.userId;
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];



        }
        
    }

}

- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT ) style:UITableViewStyleGrouped];
        _tableView.rowHeight = 140;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[SeperateTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}



#pragma mark -fetchDataWithIsLoadingMore
- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    if(_controllerType==1)
    {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"searchType":@"2",
                              @"token":[MyUserInfoManager shareInstance].token,
                              @"searchContent":[SearchTextManger shareInstance].searchText

//                              isLoadingMoreKey:@(isLoadingMore)
                              };
        self.requestURL = LKB_Find_Search_Url;
    }else
    {
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"searchType":@"3",
                              @"token":[[MyUserInfoManager shareInstance]token],
                              @"searchContent":[SearchTextManger shareInstance].searchText
                              
                              //                              isLoadingMoreKey:@(isLoadingMore)
                              };
        self.requestURL = LKB_Find_Search_Url;
    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!isLoadingMore) {
//            [self.tableView.pullToRefreshView stopAnimating];
//        }
//        else {
////                        [self.dataArray addObject:[NSNull null]];
//            [self.tableView.infiniteScrollingView stopAnimating];
//        }
//        [self.tableView reloadData];
//    });
    
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
    
    NSLog(@"--------------------------------------%@",findModel.data);
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
    

}

#pragma mark - Page subviews
- (void)initializeData
{
    self.dataArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        [self.dataArray addObject:[NSNull null]];
    }
}


- (NSString *)goodType
{
    switch (self.controllerType) {

        case SearchGroupOtherControllerTypeGroup:
            return @"群组";
        case SearchPeopleOtherControllerTypePeople:
            return @"人物";
        default:
            break;
    }
    return @"";
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
