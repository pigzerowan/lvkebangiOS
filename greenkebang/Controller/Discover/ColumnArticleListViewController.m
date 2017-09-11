//
//  ColumnArticleListViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 17/2/8.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import "ColumnArticleListViewController.h"
#import "SVPullToRefresh.h"
#import "MyUserInfoManager.h"
#import "LoveTableFooterView.h"
#import "ColumnListModel.h"
#import "ColumnWithImageCell.h"
#import "ColumnWithOutImageCell.h"
#import "OutWebViewController.h"

NSString * const ColumnArticleWithImageCellIdentifier = @"ColumnArticleWithImageCell";
NSString * const ColumnArticleWithOutImageCellIdentifier = @"ColumnArticleWithOutImageCell";

@interface ColumnArticleListViewController () <UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@end

@implementation ColumnArticleListViewController

- (instancetype)init
{
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.title = @"专栏";
    
    self.view.backgroundColor = CCCUIColorFromHex(0x777777);
    self.dataArray = [[NSMutableArray alloc] init];
    [self initializePageSubviews];
    self.requestParas =  @{@"userId":[[MyUserInfoManager shareInstance]userId],
                           @"ownerId":[[MyUserInfoManager shareInstance]userId],
                           @"token":[[MyUserInfoManager shareInstance]token]};
    NSLog(@"==============zheg===%@=",self.requestParas);
    self.requestURL = LKB_ALLGroup_List_Url;
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    
    
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    // 隐藏导航下的线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    //
    [MobClick beginLogPageView:@"ColumnArticleListViewController"];
    
    
    
    //    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"ColumnArticleListViewController"];
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
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
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
    }
    else {
        ++currPage;
    }
    self.requestParas = @{
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"page":@(currPage),
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    
    self.requestURL = LKB_ColumnInfo_List_Url;}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject errorMessage:(NSString *)errorMessage
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
    
    if ([request.url isEqualToString:LKB_ColumnInfo_List_Url]) {
        ColumnListModel *groupModel = (ColumnListModel *)parserObject;
        
        NSLog(@"========%@===============",parserObject);
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
    

- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KKAttCellIdentifier];
        _tableView.backgroundColor =CCCUIColorFromHex(0xf7f7f7);
    }
    
    return _tableView;
    
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    if (_dataArray.count==0) {
        return 1;
    }else
    {
        return 1;
    }
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
    SingelColumnModel *model =self.dataArray[indexPath.row];
    if ([NSStrUtil isEmptyOrNull:model.cover]) {
        
//        return 100;
        
        return [ColumnWithOutImageCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            ColumnWithOutImageCell *cell = (ColumnWithOutImageCell *)sourceCell;
            // 配置数据
            [cell configColumnArticleListNoImageTableCellWithGoodModel:model];
            
        } cache:^NSDictionary *{
            return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"ColumnArticle%@", model.insightId],kHYBCacheStateKey : @"expanded",
                     // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                     // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                     kHYBRecalculateForStateKey : @(NO) // 标识不重新更新
                     };
        }];
        
        
        
        
    }
    else
    {
//        return 120;
        return [ColumnWithImageCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            ColumnWithImageCell *cell = (ColumnWithImageCell *)sourceCell;
            // 配置数据
            [cell configColumnArticleListTableCellWithGoodModel:model];
            
        } cache:^NSDictionary *{
            return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"ColumnArticle%@", model.insightId],kHYBCacheStateKey : @"expanded",
                     // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                     // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                     kHYBRecalculateForStateKey : @(NO) // 标识重新更新
                     };
        }];
        
    }

}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString *CELLNONE = @"CELLNONE";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.textLabel.text = kNoContentMSG;
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }

    if (indexPath.row < self.dataArray.count) {
        
        SingelColumnModel *insight = (SingelColumnModel *)_dataArray[indexPath.row];
        if ([NSStrUtil isEmptyOrNull:insight.cover]) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:ColumnArticleWithOutImageCellIdentifier];
            if (!cell) {
                cell = [[ColumnWithOutImageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:ColumnArticleWithOutImageCellIdentifier];
                
            }

            ColumnWithOutImageCell *tbCell = (ColumnWithOutImageCell *)cell;
            [tbCell configColumnArticleListNoImageTableCellWithGoodModel:insight];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
            
        }
        else
        {
            cell = [tableView dequeueReusableCellWithIdentifier:ColumnArticleWithImageCellIdentifier];
            if (!cell) {
                cell = [[ColumnWithImageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:ColumnArticleWithImageCellIdentifier];
            }

            ColumnWithImageCell *tbCell = (ColumnWithImageCell *)cell;
            [tbCell configColumnArticleListTableCellWithGoodModel:insight];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

    
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SingelColumnModel *insight = (SingelColumnModel *)_dataArray[indexPath.row];
    
    NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,insight.insightId] ;
    
    NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];
    
    
    
    
    
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    outSideWeb.sendMessageType = @"1";
    outSideWeb.rightButtonType = @"2";
    outSideWeb.VcType = @"2";
    outSideWeb.featureId = insight.featureId;// 专栏id
    outSideWeb.circleDetailId = insight.insightId;// 文章Id
    outSideWeb.objectId = insight.insightId;// 文章Id
    outSideWeb.mytitle = insight.title;
    outSideWeb.replyNum = insight.replyNum;
    outSideWeb.couAvatar = insight.featureAvatar;
    outSideWeb.commendVcType = @"1";
    outSideWeb.isCollect = insight.isCollect;
    outSideWeb.groupAvatar = insight.cover;
    //        outSideWeb.isAttention = insight.isAttention;
    
    NSLog(@"----------------------------%@",outSideWeb.groupAvatar);
    
    NSLog(@"----------------------------%@",outSideWeb.couAvatar);
    
    
    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];
    
    
}









@end
