//
//  SystemDynamicListViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SystemDynamicListViewController.h"
#import "SystemDynamicViewController.h"
#import "SVPullToRefresh.h"
#import "LoveTableFooterView.h"
#import "SystemDynamicListCell.h"
NSString * const NewsSystemDynamicCellIdentifier = @"NewsSystemDynamicCellIdentifier";

@interface SystemDynamicListViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation SystemDynamicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"系统消息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10,22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    [self initializePageSubviews];
    // Do any additional setup after loading the view.
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

}

- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
    
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
//    
//    if (self.dataArray.count == 0) {
//        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
//        self.tableView.tableFooterView = footerVew;
//        self.tableView.tableFooterView.hidden = YES;
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
    
    self.requestParas = @{
                          @"userId":@"110",//[[MyUserInfoManager shareInstance]userId],
                          @"page":@(currPage),
                          @"token":@"7e8a82028a804612bb688fbcf45f3d3e",//[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)};
    
    self.requestURL = LKB_Notice_Question;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            [self.tableView.pullToRefreshView stopAnimating];
        }
        else {
            //            [self.dataArray addObject:[NSNull null]];
            [self.tableView.infiniteScrollingView stopAnimating];
        }
        [self.tableView reloadData];
    });
    
}



- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[SystemDynamicListCell class] forCellReuseIdentifier:NewsSystemDynamicCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _tableView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //    return [self.dataSource count];
    return 10;
    
    //    if (_dataArray.count == 0) {
    //        return 1;
    //    }
    //    else {
    //        return self.dataArray.count;
    //    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SlideBarCell =@"SlideBarCell";
    
    UITableViewCell *cell;
    //    if (_dataArray.count == 0) {
    //        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SlideBarCell];
    //        [cell setBackgroundColor:[UIColor whiteColor]];
    //        cell.textLabel.text = @"暂时没有新的通知";
    //        cell.textLabel.textColor = [UIColor lightGrayColor];
    //        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    //        cell.textLabel.font = [UIFont systemFontOfSize:14];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        cell.backgroundColor =[UIColor whiteColor];
    //
    //        return cell;
    //    }
    //
    //    else  if (indexPath.row < self.dataArray.count)  {
    
    //    GetDetailNoticeModel * model = (GetDetailNoticeModel *)_dataArray[indexPath.row];
    
    cell = [tableView dequeueReusableCellWithIdentifier:NewsSystemDynamicCellIdentifier];
    if (!cell) {
        cell = [[SystemDynamicListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsSystemDynamicCellIdentifier];
    }
    SystemDynamicListCell * simplescell = (SystemDynamicListCell *)cell;

    simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
    [simplescell setNeedsUpdateConstraints];
    [simplescell updateConstraintsIfNeeded];

    
    
    
    return cell;
}



#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    // 系统消息
    SystemDynamicViewController *systemVC = [[SystemDynamicViewController alloc]init];
    
    [self.navigationController pushViewController:systemVC animated:YES];
    
    
    
    
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
