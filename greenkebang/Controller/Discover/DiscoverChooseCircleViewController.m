//
//  DiscoverChooseCircleViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/22.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "DiscoverChooseCircleViewController.h"
#import "SVPullToRefresh.h"
#import "MyUserInfoManager.h"
#import "GroupModel.h"
#import "DerectManager.h"
@interface DiscoverChooseCircleViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIImageView *chooseimage;
@property (nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation DiscoverChooseCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择圈子";

    // 左键返回
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    [self initializePageSubviews];
    
    
    NSLog(@"===============--------------------------------%@",[DerectManager shareInstance].DirectionStr);


    // Do any additional setup after loading the view.
}



- (void)initializePageSubviews {
    [self.view addSubview:self.tableView];
    
    self.requestParas =  @{@"userId":[MyUserInfoManager shareInstance].userId,
                           @"ownerId":[[MyUserInfoManager shareInstance]userId],
//                           @"page":@(currPage),
                           @"token":[[MyUserInfoManager shareInstance]token],
//                           isLoadingMoreKey:@(isLoadingMore)
                           };
    
    self.requestURL = LKB_Group_List_Url;


//    __weak __typeof(self) weakSelf = self;
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        
//        [weakSelf fetchDataWithIsLoadingMore:NO];
//        
//    }];
//    [self.tableView addInfiniteScrollingWithActionHandler:^{
//        [weakSelf fetchDataWithIsLoadingMore:YES];
//    }];
//    self.tableView.showsInfiniteScrolling = YES;
//    [self.tableView triggerPullToRefresh];
    
//    if (self.dataArray.count == 0) {
//        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
//        self.tableView.tableFooterView = footerVew;
//        self.tableView.tableFooterView.hidden = NO;
//    }

    
}

- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    
    self.requestParas =  @{@"userId":[MyUserInfoManager shareInstance].userId,
                           @"ownerId":[[MyUserInfoManager shareInstance]userId],
                           @"page":@(currPage),
                           @"token":[[MyUserInfoManager shareInstance]token],
                           isLoadingMoreKey:@(isLoadingMore)};
    
    self.requestURL = LKB_MyGroup_List_Url;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            [self.tableView.pullToRefreshView stopAnimating];
        }
        else {
            //[self.dataArray addObject:[NSNull null]];
            [self.tableView.infiniteScrollingView stopAnimating];
        }
        [self.tableView reloadData];
    });
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    
    //    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 1;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return 10;
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  46;
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"HoeStandingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row < self.dataArray.count) {
        
        
        GroupDetailModel *findPeoleModel = (GroupDetailModel *)_dataArray[indexPath.row];
        
//        if ([findPeoleModel.passStatus isEqualToString:@"1"]) {
        
            cell.textLabel.text = findPeoleModel.groupName;
            //        cell.textLabel.text = @"农业";
            cell.textLabel.textColor = CCCUIColorFromHex(0x333333);
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 46, SCREEN_WIDTH, 0.5)];
            lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
            
            [cell.contentView addSubview:lineView];
            
            _chooseimage= [[UIImageView alloc]init];
            
            UIImage *image = [UIImage imageNamed:@"Discover_ChooseCircle"];
            CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
            
            _chooseimage.frame = frame;
            _chooseimage.image = image;
            
            cell.accessoryView= _chooseimage;
            
            
            NSLog(@"================================%@",cell.textLabel.text);
            NSLog(@"================================%@",[DerectManager shareInstance].DirectionStr);
            
            if ([cell.textLabel.text isEqual:[DerectManager shareInstance].DirectionStr] ) {
                
                cell.accessoryView.hidden = NO;
            }
            else {
                
                cell.accessoryView.hidden = YES;
                
            }

//        }
        
        
        
        
    }
    return cell;
    
    
}



- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (errorMessage) {
        //        [MBProgressHUD showError:errorMessage toView:self.view];
        return;
    }
    
    if ([request.url isEqualToString:LKB_Group_List_Url]) {
        GroupModel *groupModel = (GroupModel *)parserObject;
        
        _dataArray = [NSMutableArray arrayWithArray:groupModel.data];
        
        NSLog(@"===========================%@",_dataArray);
        
        GroupDetailModel * detailModel;
        for (GroupDetailModel *model  in groupModel.data) {
            
            
            if ([model.passStatus isEqualToString:@"0"]) {
                
                detailModel = model;
                
                [_dataArray removeObject:detailModel];
                
            }
            
        }

        
        
        [self.tableView reloadData];
        
        
    }
    
}



- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    GroupDetailModel *areaDetail = (GroupDetailModel *)_dataArray[indexPath.row];

    [DerectManager shareInstance].DirectionStr = areaDetail.groupName;
    [DerectManager shareInstance].directionId = areaDetail.groupId  ;
    
    NSLog(@"******************%@",[DerectManager shareInstance].DirectionStr);
    [self.navigationController popViewControllerAnimated:YES];



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
