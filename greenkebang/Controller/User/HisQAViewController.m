//
//  HisQAViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 9/9/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "HisQAViewController.h"
#import "UserHeaderView.h"
#import "GroupTableViewCell.h"
#import "SVPullToRefresh.h"
#import "GroupModel.h"
#import "TabbarManager.h"
#import "ToUserManager.h"
#import "TimeQaTableViewCell.h"
#import "ToUserManager.h"
#import "MyUserInfoManager.h"
#import "ChatViewController.h"
#import "QADetailViewController.h"
//static NSString* CellIdentifier = @"UserCellddIdentifier";
@interface HisQAViewController ()<UserHeaderViewDelegate>

@property(nonatomic,copy)UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UserHeaderView *headView;
@property (strong, nonatomic) UIButton *turnToTalkBtn;

@end

@implementation HisQAViewController

#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _turnToTalkBtn = [[UIButton alloc]initWithFrame:CGRectMake(286, 12, 24, 24)];
    [_turnToTalkBtn setImage:[UIImage imageNamed:@"sender_talk"] forState:UIControlStateNormal];
    [_turnToTalkBtn addTarget:self action:@selector(toGroupTalk:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_turnToTalkBtn];
    
//    self.requestParas = @{@"userId":[ToUserManager shareInstance].userId,
//                          @"fromUser":[MyUserInfoManager shareInstance].userId
//                          };
//    self.requestURL = LKB_User_Center_Url;

    
    UIImageView *backgroundImg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backgroundImg.image = [UIImage imageNamed:@"owener_bg"];
    [self.view addSubview:backgroundImg];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    
    [self initializePageSubviews];
    
    // Do any additional setup after loading the view.
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.requestParas = @{@"userId":[ToUserManager shareInstance].userId,
                          @"fromUser":[MyUserInfoManager shareInstance].userId
                          };
    self.requestURL = LKB_User_Center_Url;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initSubViews
{
    
    [self.view addSubview:_tableView];
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
        return;
    }
    if ([request.url isEqualToString:LKB_His_Question_Url]) {
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
    
    
    if ([request.url isEqualToString:LKB_User_Center_Url]) {
        UserCenterModel *userCenterModel = (UserCenterModel *)parserObject;
        
        NSLog(@"=======%@========",userCenterModel.ifAttention);
        if ([userCenterModel.ifAttention isEqualToString:@"0"]) {
            _turnToTalkBtn.hidden = NO;
            [_headView.attentionBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        }else
        {
            _turnToTalkBtn.hidden = YES;
            [_headView.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
            
        }
        [_headView configDiscoveryRecommCellWithModel:userCenterModel];
        [ToUserManager shareInstance].userName = userCenterModel.contactName;
        [self.tableView reloadData];
    }
    
    if ([request.url isEqualToString:LKB_Attention_New_Url]) {
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        [self ShowProgressHUDwithMessage:Model.msg];
        _turnToTalkBtn.hidden = NO;
        [_headView.attentionBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        
        self.requestParas = @{@"userId":[ToUserManager shareInstance].userId,
                              @"fromUser":[MyUserInfoManager shareInstance].userId
                              };
        self.requestURL = LKB_User_Center_Url;
        [self.tableView reloadData];
        NSLog(@"%@",Model);
        
    }
    
    if ([request.url isEqualToString:LKB_Attention_Un_Url]) {
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        [self ShowProgressHUDwithMessage:Model.msg];
        _turnToTalkBtn.hidden = NO;
        [_headView.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        
        self.requestParas = @{@"userId":[ToUserManager shareInstance].userId,
                              @"fromUser":[MyUserInfoManager shareInstance].userId
                              };
        self.requestURL = LKB_User_Center_Url;
        [self.tableView reloadData];
        NSLog(@"%@",Model);
        
    }

    
}


-(void)userHeaderView:(UserHeaderView *)UserHeaderView didatterntion:(NSString *)userId
{
    if ([UserHeaderView.attentionBtn.titleLabel.text isEqualToString:@"关注"]) {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"toUser":[ToUserManager shareInstance].userId,
                              };
        self.requestURL = LKB_Attention_New_Url;
    }else
    {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"unId":[ToUserManager shareInstance].userId,
                              };
        self.requestURL = LKB_Attention_Un_Url;
    }
    
}
-(void)toGroupTalk:(id)sender
{

    self.hidesBottomBarWhenPushed=YES;
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:[ToUserManager shareInstance].userId isGroup:NO];
    chatVC.title = [ToUserManager shareInstance].userName;
    [self.navigationController pushViewController:chatVC animated:YES];
    //    self.hidesBottomBarWhenPushed=NO;
    
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


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38;
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
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[newDynamicModel.addTime integerValue]];
        
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        
        qadetailVC.timeStr = confromTimespStr;
        
        
//        qadetailVC.questionDesc = newDynamicModel.questionDesc;
        qadetailVC.autherName = newDynamicModel.userName;
        qadetailVC.questionId = newDynamicModel.questionId;
        qadetailVC.questionUserId = newDynamicModel.userId;
        [self.navigationController pushViewController:qadetailVC animated:YES];
        
        
    }

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 38)];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 37, kDeviceWidth, 1)];
    lineView.backgroundColor = UIColorWithRGBA(246, 246, 246, 1);
    UILabel *myLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 38)];
    headerView.backgroundColor =[UIColor whiteColor];
    [headerView addSubview:myLable];
    [headerView addSubview:lineView];
    myLable.textAlignment = NSTextAlignmentCenter;
    myLable.text = [NSString stringWithFormat:@"%@的问答",[ToUserManager shareInstance].userName];
    return headerView;
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
    
    
    self.requestParas = @{@"userId":[ToUserManager shareInstance].userId,
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    self.requestURL = LKB_His_Question_Url;
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!isLoadingMore) {
//            [self.tableView.pullToRefreshView stopAnimating];
//        }
//        else {
//            //                        [self.dataArray addObject:[NSNull null]];
//            [self.tableView.infiniteScrollingView stopAnimating];
//        }
//        [self.tableView reloadData];
//    });
//    
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, kDeviceWidth-20, KDeviceHeight) style:UITableViewStylePlain];
        _tableView.rowHeight = 140;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _headView =   [[UserHeaderView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 200)];
        _headView.delegate = self;
        _tableView.tableHeaderView =_headView;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[GroupTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}

-(void)backToMain
{
     [self.tabBarController.navigationController popViewControllerAnimated:YES];
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
