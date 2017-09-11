//
//  NewSeperateViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 1/16/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "NewSeperateViewController.h"
#import "SVPullToRefresh.h"
#import "MyUserInfoManager.h"
#import "DiscoverTableViewCell.h"
#import "NewFindModel.h"
#import "NewFindNormolCell.h"
#import "FindArticCell.h"
#import "FindPepoleCell.h"
#import "FindGroupCell.h"
#import "ColumnWithOutImageCell.h"
#import "ColumnWithImageCell.h"
#import "FindTopicCell.h"
#import "SDCycleScrollView.h"
#import "BannerModel.h"
#import "InsightDetailViewController.h"
#import "QADetailViewController.h"
#import "YQWebDetailViewController.h"
#import "ChatViewController.h"
#import "UserProfileManager.h"
#import "GroupModel.h"
#import "OtherUserInforViewController.h"
#import "LoveTableFooterView.h"
#import "UserRootViewController.h"
#import "NewUserMainPageViewController.h"
NSString * const FindArticCellIdentifier = @"FindArticCell";
NSString * const FindNomolCellIdentifier = @"BigADNewsCELLID";
NSString * const FindPepoleCellCellIdentifier = @"FindPepoleCellCellIdentifier";
NSString * const FindGroupCellIdentifier = @"FindGroupCellIdentifier";
NSString * const FindColumnWithOutImageCellCellIdentifier = @"FindColumnWithOutImageCellCellIdentifier";
NSString * const FindColumnWithImageCellCellIdentifier = @"FindColumnWithImageCellCellIdentifier";
NSString * const FindTopicCellCellIdentifier = @"FindTopicCellCellIdentifier";


static NSString* KKCellIdentifier = @"TimeTableViewCellIdentifier";
@interface NewSeperateViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,IChatManagerDelegate,ChatViewControllerDelegate>
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic) SDCycleScrollView* cycleScrollView;
@property(strong,nonatomic)NSMutableArray *bannerArray;

@end
@implementation NewSeperateViewController
#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryNewSeperetControllerType)controllerType
{
    self = [super init];
    if (self) {
        _newcontrollerType = controllerType;
    }
    return self;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor infosBackViewColor];
    return footerView;
}


- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.tableView.backgroundColor =  [UIColor whiteColor];
    self.dataArray = [[NSMutableArray alloc] init];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_share_pre"] style:UIBarButtonItemStylePlain target:self action:@selector(didShareBarButtonItemAction:)];

    
    _bannerArray = [NSMutableArray array];
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token]
                          
                          
                          };
    self.requestURL = LKB_ALL_FIND_COVER;
    
    [self initializePageSubviews];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
        currPage = 0;
    } else {
        ++ currPage;
    }
    NSLog(@"==========%@看看什么鬼====",[self goodType]);
    
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token],
                         @"label":[self goodType],
                         isLoadingMoreKey:@(isLoadingMore)
                         
                          };
    self.requestURL = LKB_ALL_FIND;
    

    
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
    
    if ([request.url isEqualToString:LKB_ALL_FIND_COVER]) {
        BannerModel *groupModel = (BannerModel *)parserObject;
        NSArray *bannerArray = [NSMutableArray arrayWithArray:groupModel.data];
        
        for ( int i=0; i<bannerArray.count; i++) {
            BannerDetailModel *model = (BannerDetailModel *)bannerArray[i];
            [_bannerArray addObject:model];
        }
        _cycleScrollView.imageURLsGroup =_bannerArray;
        [self.tableView reloadData];
        
        
        
    }
    
    
    

    if ([request.url isEqualToString:LKB_ALL_FIND]) {
        NewFindModel *topicModel = (NewFindModel *)parserObject;
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:topicModel.data];
        } else {
            if (_dataArray.count<topicModel.num) {
                [_dataArray addObjectsFromArray:topicModel.data];
            }        }
            
        [self.tableView reloadData];
        if (topicModel.num == 0) {
         
            [self.tableView.infiniteScrollingView endScrollAnimating];
                   self.tableView.tableFooterView.hidden=NO;
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
            
        }
        
    }

    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewFindDetailModel *insight = (NewFindDetailModel *)_dataArray[indexPath.section];
    
    if ([insight.type isEqualToString:@"5"]||[insight.type isEqualToString:@"4"])
    {
        return 80;
    }
    else if([insight.type isEqualToString:@"1"]){
        
        if ([NSStrUtil isEmptyOrNull:insight.cover]) {
            return 100;
        }
        else
        {
            return 120;
        }

    }
    else if([insight.type isEqualToString:@"3"]){
        
        return 60;
        
    }
    
    else
    {
        if ([NSStrUtil isEmptyOrNull:insight.cover]) {
            return 100;
        }
        else
        {
            return 120;
        }

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
        cell.textLabel.text = kNoContentMSG;
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    
    
    
  
    
    if (indexPath.row < self.dataArray.count) {
        
        NewFindDetailModel *insight = (NewFindDetailModel *)_dataArray[indexPath.section];
       
         if ([insight.type isEqualToString:@"5"])
        {
            cell = [tableView dequeueReusableCellWithIdentifier:FindPepoleCellCellIdentifier];
            if (!cell) {
                cell = [[FindPepoleCell alloc] initWithHeight:80 reuseIdentifier:FindPepoleCellCellIdentifier];
            }
            FindPepoleCell *tbCell = (FindPepoleCell *)cell;
            [tbCell configNewFindPepoleTableCellWithGoodModel:insight];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
        else  if ([insight.type isEqualToString:@"4"])
        {
            cell = [tableView dequeueReusableCellWithIdentifier:FindGroupCellIdentifier];
            if (!cell) {
                cell = [[FindGroupCell alloc] initWithHeight:80 reuseIdentifier:FindGroupCellIdentifier];
            }
            FindGroupCell *tbCell = (FindGroupCell *)cell;
            [tbCell configNewFindGroupTableCellWithGoodModel:insight];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
        
        else  if ([insight.type isEqualToString:@"1"])
        {
            if ([NSStrUtil isEmptyOrNull:insight.cover]) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:FindColumnWithOutImageCellCellIdentifier];
                if (!cell) {
                    cell = [[ColumnWithOutImageCell alloc] initWithHeight:150 reuseIdentifier:FindColumnWithOutImageCellCellIdentifier];
                }
                // 专栏没有图片
                ColumnWithOutImageCell *tbCell = (ColumnWithOutImageCell *)cell;
                [tbCell configFindSingelColumnNoImageTableCellWithGoodModel:insight];
                [tbCell setNeedsUpdateConstraints];
                [tbCell updateConstraintsIfNeeded];
                
            }
            else
            {
                cell = [tableView dequeueReusableCellWithIdentifier:FindColumnWithImageCellCellIdentifier];
                if (!cell) {
                    cell = [[ColumnWithImageCell alloc] initWithHeight:200 reuseIdentifier:FindColumnWithImageCellCellIdentifier];
                }
                // 专栏有图片
                ColumnWithImageCell *tbCell = (ColumnWithImageCell *)cell;
                [tbCell configFindSingelColumnTableCellWithGoodModel:insight];
                [tbCell setNeedsUpdateConstraints];
                [tbCell updateConstraintsIfNeeded];
            }

        }
        
        
        else  if ([insight.type isEqualToString:@"3"])
        {
          
                
                cell = [tableView dequeueReusableCellWithIdentifier:FindTopicCellCellIdentifier];
                if (!cell) {
                    cell = [[FindTopicCell alloc] initWithHeight:80 reuseIdentifier:FindTopicCellCellIdentifier];
                }
                FindTopicCell *tbCell = (FindTopicCell *)cell;
                [tbCell configNewFindTopicTableCellWithGoodModel:insight];
                [tbCell setNeedsUpdateConstraints];
                [tbCell updateConstraintsIfNeeded];

        }
        
        
        
         else  {
             if ([NSStrUtil isEmptyOrNull:insight.cover]) {
                 
                 cell = [tableView dequeueReusableCellWithIdentifier:FindColumnWithOutImageCellCellIdentifier];
                 if (!cell) {
                     cell = [[ColumnWithOutImageCell alloc] initWithHeight:150 reuseIdentifier:FindColumnWithOutImageCellCellIdentifier];
                 }
                 ColumnWithOutImageCell *tbCell = (ColumnWithOutImageCell *)cell;
                 [tbCell configFindSingelColumnNoImageTableCellWithGoodModel:insight];
                 [tbCell setNeedsUpdateConstraints];
                 [tbCell updateConstraintsIfNeeded];
                 
             }
             else
             {
                 cell = [tableView dequeueReusableCellWithIdentifier:FindColumnWithImageCellCellIdentifier];
                 if (!cell) {
                     cell = [[ColumnWithImageCell alloc] initWithHeight:200 reuseIdentifier:FindColumnWithImageCellCellIdentifier];
                 }
                 ColumnWithImageCell *tbCell = (ColumnWithImageCell *)cell;
                 [tbCell configFindSingelColumnTableCellWithGoodModel:insight];
                 [tbCell setNeedsUpdateConstraints];
                 [tbCell updateConstraintsIfNeeded];
             }

             
         }
        
        
   }
    
    
    cell.backgroundColor =  UIColorWithRGBA(244, 244, 244, 1);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArray.count) {
        NewFindDetailModel *insight = (NewFindDetailModel *)_dataArray[indexPath.section];
        if ([insight.type isEqualToString:@"3"]) {
//            TopicDetaillViewController *TopicVC = [[TopicDetaillViewController alloc] init];
//            TopicVC.topicId = insight.objectId;
//            TopicVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:TopicVC animated:YES];
        }else if([insight.type isEqualToString:@"1"]) {
            InsightDetailViewController *InsightVC = [[InsightDetailViewController alloc] init];
            InsightVC.hidesBottomBarWhenPushed = YES;
            InsightVC.topicId = insight.objectId;
            [self.navigationController pushViewController:InsightVC animated:YES];
        }else if([insight.type isEqualToString:@"2"]) {
            QADetailViewController *QADetailVC = [[QADetailViewController alloc] init];
            QADetailVC.questionId = insight.objectId;
            QADetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:QADetailVC animated:YES];
        }
        else if([insight.type isEqualToString:@"5"]) {
            
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            if (insight.userAvatar==nil) {
                insight.userAvatar = @"";
            }
            if (insight.userName==nil) {
                insight.userName = insight.userName;
            }
            NSDictionary *mydic = @{@"userName":insight.userName,
                                    @"userAvatar":insight.userAvatar
                                    };
            NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
            [userDefaults setObject:dic  forKey:insight.userId];
            
//            UserRootViewController *chatVC = [[UserRootViewController alloc]init];
//            chatVC.toUserId = insight.userId;
//            chatVC.type = @"2";
//            chatVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:chatVC animated:YES];
            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
            peopleVC.type = @"2";
            peopleVC.toUserId = insight.userId;
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
            
        }
        else if([insight.type isEqualToString:@"4"]) {
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            if (insight.avatar==nil) {
                insight.avatar = @"";
            }
            if (insight.userName==nil) {
                insight.userName = insight.userName;
            }
            

            NSDictionary *mydic = @{@"userName":insight.groupName,
                                    @"groupAvatar":insight.groupAvatar,
                                    @"groupId":insight.objectId
                                    };
            NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
            [userDefaults setObject:dic  forKey:insight.easyMobId];
            
        }
    }
    
}

#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];

    self.tableView.tableHeaderView = ({
        
        if (iPhone5) {
            
            _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth, 100) imageURLsGroup:_bannerArray];

        }else {

        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth, 118) imageURLsGroup:_bannerArray];
        }
        _cycleScrollView.delegate = self;
        _cycleScrollView;
        
    });
    

    
    
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
        LoveTableFooterView *footerVew = [[LoveTableFooterView alloc]init] ;               self.tableView.tableFooterView = footerVew;
                                          self.tableView.tableFooterView.hidden=YES;
                                          
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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KKCellIdentifier];
    }
    return _tableView;
}

#pragma mark -SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView*)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    BannerDetailModel* simpleGood = _bannerArray[index];
    NSString* urlStr = [NSString stringWithFormat:@"%@%@",@"http://www.lvkebang.cn",simpleGood.coverLink];
    

    
    if ([urlStr rangeOfString:@"http://www.lvkebang.cn/jianjie/"].location!=NSNotFound ) {
        //        simpleGood *topic = (NewInsightModel *)_dataArray[indexPath.row];
        NSArray *strarray = [urlStr componentsSeparatedByString:@".h"];
        NSString *str = strarray[0];
        
        NSArray *strarray2 = [str componentsSeparatedByString:@"e/"];
        NSString *idStr = strarray2[1];
        InsightDetailViewController *BlogVC = [[InsightDetailViewController alloc] init];
        BlogVC.hidesBottomBarWhenPushed = YES;
        BlogVC.topicId = idStr;
        
        [self.navigationController pushViewController:BlogVC animated:YES];
    }
    else  if ([urlStr rangeOfString:@"http://www.lvkebang.cn/wenda/"].location!=NSNotFound ) {
        //        simpleGood *topic = (NewInsightModel *)_dataArray[indexPath.row];
        NSArray *strarray = [urlStr componentsSeparatedByString:@".h"];
        NSString *str = strarray[0];
        
        NSArray *strarray2 = [str componentsSeparatedByString:@"a/"];
        NSString *idStr = strarray2[1];
        QADetailViewController *BlogVC = [[QADetailViewController alloc] init];
        BlogVC.hidesBottomBarWhenPushed = YES;
        BlogVC.questionId = idStr;
        
        [self.navigationController pushViewController:BlogVC animated:YES];
    }
    else  if ([urlStr rangeOfString:@"http://www.lvkebang.cn/huati/"].location!=NSNotFound ) {
        //        simpleGood *topic = (NewInsightModel *)_dataArray[indexPath.row];
        NSArray *strarray = [urlStr componentsSeparatedByString:@".h"];
        NSString *str = strarray[0];
        
        NSArray *strarray2 = [str componentsSeparatedByString:@"i/"];
        NSString *idStr = strarray2[1];
//        TopicDetaillViewController *BlogVC = [[TopicDetaillViewController alloc] init];
//        BlogVC.hidesBottomBarWhenPushed = YES;
//        BlogVC.topicId = idStr;
//        
//        [self.navigationController pushViewController:BlogVC animated:YES];
    }
    
    else
    {
        YQWebDetailViewController* webDetailVC = [[YQWebDetailViewController alloc] init];
        webDetailVC.urlStr = urlStr;
        webDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webDetailVC animated:YES];
    }
    
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
    switch (self.newcontrollerType) {
            
        case DiscoverySeperetControllerTypeChoise:
            return @"精选";
        case DiscoveryOtherControllerTypeFarm:
            return @"农业";
        case DiscoveryOtherControllerTypeTecholic:
            return @"科技";
        case DiscoveryOtherControllerTypeSoil:
            return @"土壤";
        case DiscoveryOtherControllerTypeHeathy:
            return @"健康";
        case DiscoveryOtherControllerTypeBiology:
            return @"生物";
        default:
            break;
    }
    return @"";
}


@end
