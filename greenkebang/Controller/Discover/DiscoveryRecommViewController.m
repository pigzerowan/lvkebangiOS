//
//  DiscoveryRecommViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import "SVPullToRefresh.h"
#import "DiscoveryRecommViewController.h"

static NSString* CellIdentifier = @"DiscoveryRecommCellIdentifier";
@interface DiscoveryRecommViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@end

@implementation DiscoveryRecommViewController

#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryOtherControllerType)controllerType
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
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    self.dataArray = [[NSMutableArray alloc] init];
    [self initializePageSubviews];
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
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
//    NSInteger currPage = [[self.requestParas objectForKey:@"pn"] integerValue];
//    if (!isLoadingMore) {
//        currPage = 0;
//    } else {
//        ++ currPage;
//    }
//    self.requestParas = @{@"size":@(5),
//                          @"pn":@(currPage),
//                          isLoadingMoreKey:@(isLoadingMore)};
//    self.requestURL = YQ_TopicList_Url;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            [self.tableView.pullToRefreshView stopAnimating];
        }
        else {
            [self.dataArray addObject:[NSNull null]];
            [self.tableView.infiniteScrollingView stopAnimating];
        }
        [self.tableView reloadData];
    });

}

//- (void)actionFetchRequest:(YQRequestModel *)request result:(YQBaseModel *)parserObject
//              errorMessage:(NSString *)errorMessage
//{
//    if (!request.isLoadingMore) {
//        [self.tableView.pullToRefreshView stopAnimating];
//    } else {
//        [self.tableView.infiniteScrollingView stopAnimating];
//    }
//    
//    if (errorMessage) {
//        [MBProgressHUD showError:errorMessage toView:self.view];
//        return;
//    }
//    if ([request.url isEqualToString:YQ_GoodCarousel_Url]) {
//        _goodCarouse = (YQGoodCarouselModel *)parserObject;
//        _cycleScrollView.imageURLsGroup = _goodCarouse.carList;
//    }else if ([request.url isEqualToString:YQ_TopicList_Url]) {
//        YQTopicModel *topicModel = (YQTopicModel *)parserObject;
//        if (!request.isLoadingMore) {
//            _dataArray = [NSMutableArray arrayWithArray:topicModel.typeList];
//        } else {
//            [_dataArray addObjectsFromArray:topicModel.typeList];
//        }
//        [self.tableView reloadData];
//        if (topicModel.typeList.count == 0) {
//            [self.tableView.infiniteScrollingView endScrollAnimating];
//        } else {
//            self.tableView.showsInfiniteScrolling = YES;
//            [self.tableView.infiniteScrollingView beginScrollAnimating];
//            
//        }
//    }
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
    return 8;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    DiscoverTableViewCell* simplescell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < self.dataArray.count) {
//        SimpleTopic *topic = (SimpleTopic *)_dataArray[indexPath.section];
        [simplescell configDiscoveryRecommCellWithModel:nil];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return simplescell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArray.count) {
        
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

//- (NSString *)goodType
//{
//    /**< 话题*/
//    DiscoveryOtherControllerTypeTopic = 1,
//    /**< 技术答疑*/
//    DiscoveryOtherControllerTypeTeclolegel,
//    /**< 行业见解*/
//    DiscoveryOtherControllerTypeTrade,
//    
//    
//    switch (self.controllerType) {
//        case DiscoveryOtherControllerTypeTopic:
//            return @"逼格";
//        case DiscoveryOtherControllerTypeFood:
//            return @"美食";
//        case DiscoveryOtherControllerTypeDigital:
//            return @"数码";
//        case DiscoveryOtherControllerTypeHouse:
//            return @"家居";
//        case DiscoveryOtherControllerTypeCity:
//            return @"城市";
//        case DiscoveryOtherControllerTypeScrape:
//            return @"限抢";
//        default:
//            break;
//    }
//    return @"";
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
