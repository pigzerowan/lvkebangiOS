//
//  UserInforCollectionViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/11/11.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforCollectionViewController.h"
#import "OutWebViewController.h"
#import "MyUserInfoManager.h"
#import "SVPullToRefresh.h"
#import "UserGroupViewController.h"
#import "UserCollectionImageButNoDetailCell.h"
#import "UserCollectionNoImageNoDetailCell.h"
#import "CollectionModel.h"
#import "InsightDetailViewController.h"
#import "ColumnListViewController.h"
#import "OutWebViewController.h"

NSString * const UserInforCollectionCellIdentifier =@"UserInforCollectionCellIdentifier";

NSString * const UserCollectionImageButNoDetailCellIdentifier = @"UserImageButNoDetailCellIdentifier";
NSString * const UserCollectionNoImageNoDetailCellIdentifier = @"UserNoImageNoDetailCellIdentifier";

@interface UserInforCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;
    
}


@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation UserInforCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"我的收藏";
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
    [MobClick endLogPageView:@"UserInforCollectionViewController"];

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
    [MobClick beginLogPageView:@"UserInforCollectionViewController"];

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
    
    
    self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                          @"token":[[MyUserInfoManager shareInstance]token],
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)
                          
                          };
    
    self.requestURL = LKB_ColumnInfo_Collection_Url;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            
            [_tableView.pullToRefreshView stopAnimating];
            
        }
        else {
            
            [_tableView.infiniteScrollingView stopAnimating];
            
        }
        
        [_tableView reloadData];
        
        
    });
    
    
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UserInforCollectionCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}





#pragma mark - UITableViewDataSource
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
        
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserInforCollectionCellIdentifier];
        [cell setBackgroundColor:[UIColor whiteColor]];
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Collection-articles"]];
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );
        
        [cell addSubview:loadingImage];
        return cell;
    }
    
    
    if (indexPath.row < self.dataArray.count) {
        
        CollectionDetailModel *collectionModel = (CollectionDetailModel *)_dataArray[indexPath.row];;
        
        if ([NSStrUtil isEmptyOrNull:collectionModel.cover])
        {
            // 没图没见解
            cell = [tableView dequeueReusableCellWithIdentifier:UserCollectionNoImageNoDetailCellIdentifier];
            if (!cell) {
                // 1
                cell = [[UserCollectionNoImageNoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:UserCollectionNoImageNoDetailCellIdentifier];
                
            }
            UserCollectionNoImageNoDetailCell *tbCell = (UserCollectionNoImageNoDetailCell *)cell;
            
            [tbCell handlerButtonAction:^(NSInteger clickIndex) {
                if (clickIndex == 1) {
                    
                    // 我的专栏
                    ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
                    ColumnListViewVC.featureId = collectionModel.featureId;
                    ColumnListViewVC.title = collectionModel.featureName;
                    ColumnListViewVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:ColumnListViewVC animated:YES];

                }
            }];

            tbCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [tbCell configCollectionNoImageNoDetailCellWithModel:collectionModel];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
        
        
        else
        {
            //  有图片没有见解
            cell = [tableView dequeueReusableCellWithIdentifier:UserCollectionImageButNoDetailCellIdentifier];
            if (!cell) {
                // 2
                cell = [[UserCollectionImageButNoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                 reuseIdentifier:UserCollectionImageButNoDetailCellIdentifier];
            }
            UserCollectionImageButNoDetailCell *tbCell = (UserCollectionImageButNoDetailCell *)cell;
            
            [tbCell handlerButtonAction:^(NSInteger clickIndex) {
                if (clickIndex == 1) {
                    
                    // 我的专栏
                    ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
                    ColumnListViewVC.featureId = collectionModel.featureId;
                    ColumnListViewVC.title =collectionModel.featureName;
                    ColumnListViewVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:ColumnListViewVC animated:YES];

                }
            }];
            
            tbCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [tbCell configCollectionImageButNoDetailCellCellWithModel:collectionModel];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
        
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_dataArray.count ==0 ) {
        return 1;
    }
    else {
        return _dataArray.count;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_dataArray.count!=0&&indexPath.row < _dataArray.count) {
        
        CollectionDetailModel *collectionModel =(CollectionDetailModel *)_dataArray[indexPath.row];
        if ([NSStrUtil isEmptyOrNull:collectionModel.cover]) {
            // 1
            return [UserCollectionNoImageNoDetailCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                UserCollectionNoImageNoDetailCell *cell = (UserCollectionNoImageNoDetailCell *)sourceCell;
                // 配置数据
                [cell configCollectionNoImageNoDetailCellWithModel:collectionModel];
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"userCollection%@",collectionModel.featureId],
                         kHYBCacheStateKey : @"expanded",
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                         };
            }];
            
        }
        else
        {
            
            // 2
            return [UserCollectionImageButNoDetailCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                UserCollectionImageButNoDetailCell *cell = (UserCollectionImageButNoDetailCell *)sourceCell;
                // 配置数据
                [cell configCollectionImageButNoDetailCellCellWithModel:collectionModel];
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"userCollection%@",collectionModel.featureId],
                         kHYBCacheStateKey : @"expanded",
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                         };
            }];
            
            
            
        }
        
    }
    else {
        return 258;
    }
    
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    CollectionDetailModel *collectionModel = (CollectionDetailModel *)_dataArray[indexPath.row];
    
    NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,collectionModel.insightId] ;
    NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];
    
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    
    outSideWeb.sendMessageType = @"1";
    outSideWeb.rightButtonType = @"2";
    outSideWeb.VcType = @"2";
    outSideWeb.objectId = collectionModel.insightId;
    outSideWeb.circleDetailId = collectionModel.insightId;
    outSideWeb.mytitle = collectionModel.title;
    outSideWeb.featureId = collectionModel.featureId; // 专栏Id
    outSideWeb.couAvatar = collectionModel.avatar;
    outSideWeb.replyNum = collectionModel.replyNum;

    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];
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
    
    if ([request.url isEqualToString:LKB_ColumnInfo_Collection_Url]) {
        
        CollectionModel *collectionModel = (CollectionModel *)parserObject;
        
        NSLog(@"！！！！！！========%@===============",collectionModel.data);
        if (!request.isLoadingMore) {
            if(collectionModel.data)
            {
                _dataArray = [NSMutableArray arrayWithArray:collectionModel.data];
            }
        } else {
            [_dataArray addObjectsFromArray:collectionModel.data];
        }
        [_tableView reloadData];
        if (collectionModel.data.count == 0) {
            _tableView.tableFooterView.hidden = NO;
            
            [_tableView.infiniteScrollingView endScrollAnimating];
        } else {
            _tableView.showsInfiniteScrolling = YES;
            [_tableView.infiniteScrollingView beginScrollAnimating];
        }
        
    }
    
}

@end
