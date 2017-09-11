//
//  SearchPepleGroupViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 10/16/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "SearchPepleGroupViewController.h"
#import "TimeTableViewCell.h"
#import "SVPullToRefresh.h"
#import "ToPicModel.h"
#import "PeopleTableViewCell.h"
#import "InsightDetailViewController.h"
#import "DiscoverTableViewCell.h"
#import "FriendModel.h"
#import "AppDelegate.h"
#import "ToUserManager.h"
#import "SearchTextManger.h"

static NSString* CellIdentifier = @"PeopleTableViewCellCellIdentifier";
@interface SearchPepleGroupViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@end

@implementation SearchPepleGroupViewController
#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithDiscoveryOtherControllerType:(SearchViewControllerType)controllerType
{
    self = [super init];
    if (self) {
        _controllerType = controllerType;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
    self.dataArray = [[NSMutableArray alloc] init];
    //     [self initializeData];
    if ([SearchTextManger shareInstance].searchText!=nil) {
         [self initializePageSubviews];
    }
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self . navigationController . navigationBarHidden = NO ;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    } else {
        ++ currPage;
    }
    
    if (_controllerType==0) {
        self.requestParas = @{@"name":[SearchTextManger shareInstance].searchText,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              };
        self.requestURL = LKB_Search_People_Url;
    }
    else if(_controllerType==1)
    {
        self.requestParas = @{@"name":[SearchTextManger shareInstance].searchText,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              };
        self.requestURL = LKB_Search_Group_Url;
    }    
    
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
    if ([request.url isEqualToString:LKB_Search_People_Url]) {
        FriendModel *topicModel = (FriendModel *)parserObject;
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:topicModel.data];
        } else {
            [_dataArray addObjectsFromArray:topicModel.data];
        }
        [self.tableView reloadData];
        if (topicModel.data.count == 0) {
            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
            
        }
    }else if ([request.url isEqualToString:LKB_Search_Group_Url]) {
        GroupModel *dynamicModel = (GroupModel *)parserObject;
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:dynamicModel.data];
            
        } else {
            [_dataArray addObjectsFromArray:dynamicModel.data];
        }
        [self.tableView reloadData];
        if (dynamicModel.data.count == 0) {
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
    return 80;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    PeopleTableViewCell* simplescell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (indexPath.row < self.dataArray.count) {
        if (_controllerType==0) {
            friendDetailModel *topic = (friendDetailModel *)_dataArray[indexPath.row];
            [simplescell configFriendCellWithModel:topic];
        }
        else if (_controllerType==1)
        {
            GroupDetailModel *insight = (GroupDetailModel *)_dataArray[indexPath.row];
            [simplescell configgroupCellWithModel:insight];
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
        if (_controllerType==0) {
            
            
            friendDetailModel *peopleModel = (friendDetailModel *)_dataArray[indexPath.row];
            [ToUserManager shareInstance].userId = peopleModel.userId;
            [ToUserManager shareInstance].userName = peopleModel.userName;
            self.hidesBottomBarWhenPushed = YES;
            self.tabBarController.tabBar.hidden = YES;
            self . navigationController . navigationBarHidden = YES ;
            LKBUserBaseTabbarController*sss = [[LKBUserBaseTabbarController alloc]init];
            [self.navigationController pushViewController:sss animated:YES];

        }
        
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
    }
}
#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.rowHeight = 140;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[PeopleTableViewCell class] forCellReuseIdentifier:CellIdentifier];
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


- (NSString *)goodType
{
    switch (self.controllerType) {
        case SearchViewControllerTypePeople:
            return @"人";
        case SearchViewControllerTypeTypeGroup:
            return @"话题";
        default:
            break;
    }
    return @"";
}



@end
