//
//  UserInforGroupViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/11/9.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforGroupViewController.h"
#import "GroupTableViewCell.h"
#import "GroupDetaillModel.h"
#import "UserRootViewController.h"
#import "FarmerCircleViewController.h"
#import "MyUserInfoManager.h"
#import "CircleIfJoinManager.h"
#import "SVPullToRefresh.h"
#import "AllGroupCell.h"
NSString * const UserGroupCellIdentifier = @"UserGroupCellIdentifier";

@interface UserInforGroupViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;

}


@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation UserInforGroupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self initializePageSubviews];
    self.dataArray = [[NSMutableArray alloc] init];
    
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
    [MobClick endLogPageView:@"UserInforGroupViewController"];

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
    
    [MobClick beginLogPageView:@"UserInforGroupViewController"];

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
    
    
    self.requestParas =  @{@"userId":_toUserId,
                           @"ownerId":[[MyUserInfoManager shareInstance]userId],
                           @"page":@(currPage),
                           @"token":[[MyUserInfoManager shareInstance]token],
                           isLoadingMoreKey:@(isLoadingMore)};
    self.requestURL = LKB_MyGroup_List_Url;
    

}


- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[GroupTableViewCell class] forCellReuseIdentifier:UserGroupCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}





#pragma mark - UITableViewDataSource
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString *CELLNONE = @"CELLNONE";
    
    
//    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
        [cell setBackgroundColor:[UIColor whiteColor]];
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Join-the-circle"]];
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );
        
        [cell addSubview:loadingImage];
        return cell;
    }

    
    GroupTableViewCell* simplescell = [tableView dequeueReusableCellWithIdentifier:UserGroupCellIdentifier];
    simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < self.dataArray.count) {
        GroupDetailModel *findPeoleModel = (GroupDetailModel *)_dataArray[indexPath.row];
        
        [simplescell configUserInforGroupCellWithModel:findPeoleModel];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return simplescell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_dataArray.count == 0) {
        
        return 1;

    }
    else {
        
        return self.dataArray.count ;

    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
    
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    GroupDetailModel *findPeoleModel = (GroupDetailModel *)_dataArray[indexPath.row ];
    
    if (![findPeoleModel.passStatus isEqualToString:@"0"]) {
        
        FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
        
        farmerVC.circleId = findPeoleModel.groupId;
        farmerVC.toUserId = [[MyUserInfoManager shareInstance]userId];
        farmerVC.mytitle = findPeoleModel.groupName;
        farmerVC.ifJion = findPeoleModel.isJoin;
        farmerVC.type = @"1";
        [CircleIfJoinManager shareInstance].ifJoin = findPeoleModel.isJoin;
        
        
        farmerVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:farmerVC animated:YES];

    }
    
    
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (!request.isLoadingMore) {
        [self.tableView.pullToRefreshView stopAnimating];
    }
    else {
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
    
    if ([request.url isEqualToString:LKB_MyGroup_List_Url]||[request.url isEqualToString:LKB_ALLGroup_List_Url]) {
        
        GroupModel *groupModel = (GroupModel *)parserObject;
        
        NSLog(@"========%@===============",parserObject);
        
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:groupModel.data];
        }else {
            [_dataArray addObjectsFromArray:groupModel.data];
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


@end
