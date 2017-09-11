//
//  DisCoverQueastionViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 9/21/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "DisCoverQueastionViewController.h"
#import "DynamicModel.h"
#import "SVPullToRefresh.h"
#import "DiscoverQATabViewCell.h"
#import "TimeQaTableViewCell.h"
#import "QADetailViewController.h"
#import "MyUserInfoManager.h"
//static NSString* CellIdentifier = @"FindPepleTableViewCellIdentifier";


@interface DisCoverQueastionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;


@end

@implementation DisCoverQueastionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title =@"发现问题";
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;

    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
    self.dataArray = [[NSMutableArray alloc] init];
    //    [self initializeData];
    [self initializePageSubviews];
    // Do any additional setup after loading the view.
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryQueastionControllerType)controllerType
{
    self = [super init];
    if (self) {
        _controllerType = controllerType;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    //    self.hidesBottomBarWhenPushed = YES;
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
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"recommend":@(1),
                              //                              @"trade":@(_controllerType),
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)};
    }
    else{
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              //                              @"recommend":@(1),
                              @"trade":@(_controllerType),
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)};
    }
    
    self.requestURL = LKB_FIND_Question_List_Url;
    
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
    
    if ([request.url isEqualToString:LKB_FIND_Question_List_Url]) {
        DynamicModel *groupModel = (DynamicModel *)parserObject;
        
        NSLog(@"========%@===============",parserObject);
        if (!request.isLoadingMore) {
            if(groupModel.data)
            {
                _dataArray = [NSMutableArray arrayWithArray:groupModel.data];
            }
        } else {
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
    TimeQaTableViewCell *cell =(TimeQaTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;

}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    TimeQaTableViewCell* simplescell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.row < self.dataArray.count) {
        NewDynamicModel *findPeoleModel = (NewDynamicModel *)_dataArray[indexPath.row];
        [simplescell configDynamicCellWithModel:findPeoleModel];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return simplescell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row < self.dataArray.count) {
            NewDynamicModel *newDynamicModel = (NewDynamicModel *)_dataArray[indexPath.row];
            QADetailViewController *qadetailVC = [[QADetailViewController alloc] init];
//            qadetailVC.questionDesc = newDynamicModel.questionDesc;
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSString*strrr1=newDynamicModel.addTime;
            NSTimeInterval time=[strrr1 doubleValue]/1000;
            NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
            
            NSString *confromTimespStr = [formatter stringFromDate:detaildate];
            
            qadetailVC.timeStr = confromTimespStr;
            qadetailVC.autherName = newDynamicModel.userName;
            qadetailVC.questionId = newDynamicModel.questionId;
            qadetailVC.questionUserId = newDynamicModel.userId;
            [self.navigationController pushViewController:qadetailVC animated:YES];

    
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[TimeQaTableViewCell class] forCellReuseIdentifier:CellIdentifier];
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
        case DiscoveryQueastionControllerTypeBige:
            return @"推荐";
        case DiscoveryQueastionControllerTypeFood:
            return @"农业";
        case DiscoveryQueastionControllerTypeDigital:
            return @"环保";
        case DiscoveryQueastionControllerTypeHouse:
            return @"健康";
        case DiscoveryQueastionControllerTypeCity:
            return @"食品";
        case DiscoveryQueastionControllerTypeScrape:
            return @"生物";
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
