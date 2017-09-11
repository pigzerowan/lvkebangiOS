//
//  DiscoveryDetailViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "DiscoveryDetailViewController.h"
#import "SVPullToRefresh.h"
#import "PeopleTableViewCell.h"
#import "FindPeopleModel.h"
#import "FindPeoleTableViewCell.h"
#import "ToUserManager.h"
#import "MyUserInfoManager.h"
static NSString* CellIdentifier = @"FindPepleTableViewCellIdentifier";

@interface DiscoveryDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@end

@implementation DiscoveryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
    self.dataArray = [[NSMutableArray alloc] init];
//    [self initializeData];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    [self initializePageSubviews];
    // Do any additional setup after loading the view.
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithDiscoveryOtherControllerType:(DiscoveryOtherControllerType)controllerType
{
    self = [super init];
    if (self) {
        _controllerType = controllerType;
    }
    return self;
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
    
        self.requestURL = _therquestUrl;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!isLoadingMore) {
//            [self.tableView.pullToRefreshView stopAnimating];
//        }
//        else {
////            [self.dataArray addObject:[NSNull null]];
//            [self.tableView.infiniteScrollingView stopAnimating];
//        }
//        [self.tableView reloadData];
//    });
//    
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
  
    if ([request.url isEqualToString:LKB_FIND_PEOPLE_URL]) {
        FindPeopleModel *findpeopleModel = (FindPeopleModel *)parserObject;
        if (!request.isLoadingMore) {
            
            _dataArray = [NSMutableArray arrayWithArray:findpeopleModel.data];
        } else {
            if (_dataArray.count<findpeopleModel.num) {
                [_dataArray addObjectsFromArray:findpeopleModel.data];
            }
        }
        [self.tableView reloadData];
        if (findpeopleModel.data.count == 0) {
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
    FindPeoleTableViewCell* simplescell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.row < self.dataArray.count) {
         FpeopeleModel *findPeoleModel = (FpeopeleModel *)_dataArray[indexPath.row];
        
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (findPeoleModel.contactName==nil) {
            findPeoleModel.contactName = @"未取名";
        }
        if (findPeoleModel.avatar==nil) {
            findPeoleModel.avatar = @"";
        }
        NSDictionary *mydic = @{@"userName":findPeoleModel.contactName,
                                @"userAvatar":findPeoleModel.avatar
                                };
        NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
        [userDefaults setObject:dic  forKey:findPeoleModel.userId];
        [simplescell configFindPeopleCellWithModel:findPeoleModel];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return simplescell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArray.count) {
        FpeopeleModel *findPeoleModel = (FpeopeleModel *)_dataArray[indexPath.row];
        [ToUserManager shareInstance].userId = findPeoleModel.userId;
        [ToUserManager shareInstance].userName = findPeoleModel.contactName;
    }
    self.hidesBottomBarWhenPushed = YES;
    self . navigationController . navigationBarHidden = YES ;
    LKBUserBaseTabbarController*sss = [[LKBUserBaseTabbarController alloc]init];
    [self.navigationController pushViewController:sss animated:YES];

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
        [_tableView registerClass:[FindPeoleTableViewCell class] forCellReuseIdentifier:CellIdentifier];
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
        case DiscoveryOtherControllerTypeBige:
            return @"推荐";
        case DiscoveryOtherControllerTypeFood:
            return @"农业";
        case DiscoveryOtherControllerTypeDigital:
            return @"环保";
        case DiscoveryOtherControllerTypeHouse:
            return @"健康";
        case DiscoveryOtherControllerTypeCity:
            return @"食品";
        case DiscoveryOtherControllerTypeScrape:
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
