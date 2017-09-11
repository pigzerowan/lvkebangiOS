//
//  TimeSeperateViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "TimeSeperateViewController.h"
#import "TimeTableViewCell.h"
#import "SVPullToRefresh.h"
#import "ToPicModel.h"
#import "InsightDetailViewController.h"
#import "DiscoverTableViewCell.h"
#import "MyUserInfoManager.h"

static NSString* CellIdentifier = @"TimeTableViewCellIdentifier";
@interface TimeSeperateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@end

@implementation TimeSeperateViewController

#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryOtherControllerType1)controllerType
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
    
    if (_controllerType==0) {
       
    }
    else if(_controllerType==1)
    {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              };
        self.requestURL = LKB_TOPIC_ATS;
    }else
    {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                             @"page":@(currPage),
                             isLoadingMoreKey:@(isLoadingMore)
                             };
        self.requestURL = LKB_INSIGHT_DYNAMIC;
    }
    
    
    
    
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
 if ([request.url isEqualToString:LKB_TOPIC_ATS]) {
        ToPicModel *topicModel = (ToPicModel *)parserObject;
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:topicModel.data];
        } else {
            if (_dataArray.count<topicModel.num) {
                [_dataArray addObjectsFromArray:topicModel.data];
            }
            
            
        }
        [self.tableView reloadData];
        if (topicModel.data.count == 0) {
            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];

        }
 }else if ([request.url isEqualToString:LKB_QUESTION_DYNAMIC]) {
     DynamicModel *dynamicModel = (DynamicModel *)parserObject;
     if (!request.isLoadingMore) {
         _dataArray = [NSMutableArray arrayWithArray:dynamicModel.data];
         
     } else {
         if (_dataArray.count<dynamicModel.num) {
             [_dataArray addObjectsFromArray:dynamicModel.data];
         }
     }
     [self.tableView reloadData];
     if (dynamicModel.data.count == 0) {
         [self.tableView.infiniteScrollingView endScrollAnimating];
     } else {
         self.tableView.showsInfiniteScrolling = YES;
         [self.tableView.infiniteScrollingView beginScrollAnimating];
         
     }
 }
 else if ([request.url isEqualToString:LKB_INSIGHT_DYNAMIC]) {
     InsightModel *insightModel = (InsightModel *)parserObject;
     if (!request.isLoadingMore) {
         _dataArray = [NSMutableArray arrayWithArray:insightModel.data];
         
     } else {
         if (_dataArray.count<insightModel.num) {
             [_dataArray addObjectsFromArray:insightModel.data];
         }
     }
     [self.tableView reloadData];
     if (insightModel.data.count == 0) {
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
    DiscoverTableViewCell* simplescell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (indexPath.row < self.dataArray.count) {
            if (_controllerType==1) {
                PeoplestopicModel *topic = (PeoplestopicModel *)_dataArray[indexPath.row];
                [simplescell configTimeTopicCellWithModel:topic];
            }
            else if (_controllerType==2)
            {
                NewInsightModel *insight = (NewInsightModel *)_dataArray[indexPath.row];
                [simplescell configDiscoveryRecommCellWithModel:insight];
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
        if (_controllerType==1) {
            
            PeoplestopicModel *topic = (PeoplestopicModel *)_dataArray[indexPath.row];
//            TopicDetaillViewController *peopleVC = [[TopicDetaillViewController alloc] init];
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//            [formatter setDateStyle:NSDateFormatterMediumStyle];
//            [formatter setTimeStyle:NSDateFormatterShortStyle];
//            [formatter setDateFormat:@"YYYY-MM-dd"];
//            NSString*strrr1=topic.operTime;
//            NSTimeInterval time=[strrr1 doubleValue]/1000;
//            NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//            
//            NSString *confromTimespStr = [formatter stringFromDate:detaildate];
//            
//            peopleVC.timeStr = confromTimespStr;
//            peopleVC.topicDesc = topic.topicDesc;
//            peopleVC.autherName = topic.ownerName;
//            peopleVC.topicId = topic.topicId;
//            peopleVC.topicUserId = topic.operUser;
//            peopleVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:peopleVC animated:YES];
        }
        if (_controllerType==2) {
            
            NewInsightModel *topic = (NewInsightModel *)_dataArray[indexPath.row];
            InsightDetailViewController *BlogVC = [[InsightDetailViewController alloc] init];
           BlogVC.hidesBottomBarWhenPushed = YES;

            BlogVC.topicId = topic.blogId;
            [self.navigationController pushViewController:BlogVC animated:YES];
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
        //        LoveTableFooterView *footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        //        footerVew.addFriendBlock = ^(){
        //            NSLog(@"addFriendClicked");
        //        };
        //        self.tableView.tableFooterView = footerVew;
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
        [_tableView registerClass:[DiscoverTableViewCell class] forCellReuseIdentifier:CellIdentifier];
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
            
        case DiscoveryOtherControllerTypeTeclolegel:
            return @"技术答疑";
        case DiscoveryOtherControllerTypeTopic:
            return @"话题";
        case DiscoveryOtherControllerTypeTrade:
            return @"行业见解";
        default:
            break;
    }
    return @"";
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
