//
//  OtherUserInforViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/28.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "OtherUserInforViewController.h"
#import "OtherUserInforHeaderView.h"
#import "UserInforTableViewCell.h"
#import "ToUserManager.h"
#import "MyUserInfoManager.h"
#import "MBProgressHUD+Add.h"
#import "SVPullToRefresh.h"
#import "MyColumnViewController.h"
#import "UserGroupViewController.h"
#import "MyTopicViewController.h"
#import "MyQuestionViewController.h"

static NSString* CellIdentifier = @"UserCellIdentifier";

@interface OtherUserInforViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,OtherUserHeaderViewDelegate>

@property (strong, nonatomic) UITableView * tableView;//
//@property (strong, nonatomic) UIView * headerView;// 区头
@property (strong, nonatomic) OtherUserInforHeaderView * otherUserInforHeaderView;// 区头
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *headData;


@end

@implementation OtherUserInforViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"用户信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor LkbgreenColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self initializePageSubviews];

//     self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.requestParas = @{@"userId":_toUserId,
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          @"token":[MyUserInfoManager shareInstance].token
                          };
    self.requestURL = LKB_User_Infor_Url;
    self.tabBarController.tabBar.hidden = NO;

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
        
        //        LoveTableFooterView *footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        //        footerVew.addFriendBlock = ^(){
        //            NSLog(@"addFriendClicked");
        //        };
        //        self.tableView.tableFooterView = footerVew;
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
        [MBProgressHUD showError:errorMessage toView:self.view];
        return;
    }
    if ([request.url isEqualToString:LKB_User_Infor_Url]) {
        UserInforModel *userInfor = (UserInforModel *)parserObject;
        if ([[userInfor.data valueForKey:@"ifAttention"] isEqualToString:@"0"]) {
            
            [_otherUserInforHeaderView.attentionButton setImage:[UIImage imageNamed:@"hadattention"] forState:UIControlStateNormal];
        }else
        {
            [_otherUserInforHeaderView.attentionButton setImage:[UIImage imageNamed:@"attention"] forState:UIControlStateNormal];
        }

        [_otherUserInforHeaderView configSearchPeopleRecommCellWithModel:userInfor];
        [self.tableView reloadData];

    }
    
    if ([request.url isEqualToString:LKB_UserInfor_dynamic_Url]) {
        UserInforDynamicModel *useInforModel = (UserInforDynamicModel *)parserObject;
        NSLog(@"~~~~~~~~~%@",useInforModel.data);
        NSLog(@"========%@===============",parserObject);
        
        NSLog(@"------------------------------------------------------------------------------------------------%@",useInforModel.msg);
        
        [self ShowProgressHUDwithMessage:useInforModel.msg];
        if (!request.isLoadingMore) {
            if(useInforModel.data)
            {
                _dataArray = [NSMutableArray arrayWithArray:useInforModel.data];
            }
        }
//            else {
//            if (_dataArray.count<useInforModel.num) {
//                [_dataArray addObjectsFromArray:useInforModel.data];
//            }
//            
//        }
        [self.tableView reloadData];
        if (useInforModel.data.count == 0) {
            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
        }
    }

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
    
//    self.requestParas = @{@"userId":_toUserId,
//                          @"ownerId":[MyUserInfoManager shareInstance].userId,
//                          @"token":[MyUserInfoManager shareInstance].token,
//                          @"page":@(currPage),
//                          isLoadingMoreKey:@(isLoadingMore)
//                          };
//    self.requestURL = LKB_UserInfor_dynamic_Url;
    
    self.requestParas = @{@"userId":@"13",//[MyUserInfoManager shareInstance].userId,
                          @"ownerId":@"13",//[MyUserInfoManager shareInstance].userId,
                          @"token":@"da2b67af8dc14d22a3a9383b50580d57",//[MyUserInfoManager shareInstance].token,
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    self.requestURL = LKB_UserInfor_dynamic_Url;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            [self.tableView.pullToRefreshView stopAnimating];
        }
        else {
            //                        [self.dataArray addObject:[NSNull null]];
            [self.tableView.infiniteScrollingView stopAnimating];
        }
        [self.tableView reloadData];
    });
    
    
}

- (void)ShowProgressHUDwithMessage:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.dimBackground = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _otherUserInforHeaderView = [[OtherUserInforHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 315)];
        _otherUserInforHeaderView.delegate =self;
        _tableView.tableHeaderView = _otherUserInforHeaderView;
        _tableView.delegate = self;
        [_tableView registerClass:[UserInforTableViewCell class] forCellReuseIdentifier:CellIdentifier];
        self.automaticallyAdjustsScrollViewInsets = NO;

    }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

// 区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
//    _otherUserInforHeaderView = [[OtherUserInforHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 309)];
//    _otherUserInforHeaderView.backgroundColor = [UIColor whiteColor];
//    _tableView.tableHeaderView = _otherUserInforHeaderView;


    [_otherUserInforHeaderView handlerButtonAction:^(NSInteger clickIndex) {
        if (clickIndex == 1) {
            MyColumnViewController *peopleVC = [[MyColumnViewController alloc] init];
            peopleVC.therquestUrl = _toUserId;
            peopleVC.title = @"Ta的专栏";
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
        }
        if (clickIndex == 2) {
            UserGroupViewController *groupVC = [[UserGroupViewController alloc]init];
            groupVC.therquestUrl = _toUserId;
            groupVC.title = @"Ta的群组";
            groupVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:groupVC animated:YES];
        }
        if (clickIndex == 3) {
            MyTopicViewController *topicVC = [[MyTopicViewController alloc] init];
            topicVC.therquestUrl = _toUserId;
            topicVC.title = @"Ta的话题";
            topicVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:topicVC animated:YES];
        }
        if (clickIndex == 4) {
            MyQuestionViewController *questionVC = [[MyQuestionViewController alloc] init];
            questionVC.therquestUrl = _toUserId;
            questionVC.title = @"Ta的答疑";
            questionVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:questionVC animated:YES];
        }
    }];
    return _otherUserInforHeaderView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    self.automaticallyAdjustsScrollViewInsets =NO;
    
    return 0;
}

// headerView随着屏幕滑动一起移动至消失
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 310;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserInforTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.row < self.dataArray.count) {
        
        UserDynamicModelIntroduceModel *userDetail = (UserDynamicModelIntroduceModel *)_dataArray[indexPath.row];
        
        [cell configUserInforCellWithModel:userDetail];
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
    }

    return cell;
}

- (void)otherUserHeaderView:(OtherUserInforHeaderView *)UserHeaderView didatterntion:(NSString *)userId {
    
    if ([_otherUserInforHeaderView.attentionButton.imageView.image isEqual:[UIImage imageNamed:@"attention"]]) {
        
        [_otherUserInforHeaderView.attentionButton setImage:[UIImage imageNamed:@"hasattention"] forState:UIControlStateNormal];
//        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
//                              @"toUser":[ToUserManager shareInstance].userId,
//                              };
//        self.requestURL = LKB_Attention_New_Url;
    }else
    {
        [_otherUserInforHeaderView.attentionButton setImage:[UIImage imageNamed:@"attention"] forState:UIControlStateNormal];
//        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
//                              @"unId":[ToUserManager shareInstance].userId,
//                              };
//        self.requestURL = LKB_Attention_Un_Url;
    }

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
