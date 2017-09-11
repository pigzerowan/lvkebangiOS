//
//  AllGroupViewControllrt.m
//  greenkebang
//
//  Created by 郑渊文 on 8/9/16.
//  Copyright © 2016 transfar. All rights reserved.
//
#import "AllGroupViewControllrt.h"
#import "GroupModel.h"
#import "SVPullToRefresh.h"
#import "GroupTableViewCell.h"
#import "ChatViewController.h"
#import "MyUserInfoManager.h"
#import "MBProgressHUD+Add.h"
#import "LoveTableFooterView.h"
#import "FarmerCircleViewController.h"
#import "AllGroupCell.h"
#import "CirclePeopleViewController.h"
#import "CircleIfJoinManager.h"
static NSString* AllGroupTableViewCellIdentifier = @"AllGroupTableViewCellIdentifier";

@interface AllGroupViewControllrt ()<UITableViewDataSource,UITableViewDelegate,ChatViewControllerDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@end


#import "AllGroupViewControllrt.h"

@implementation AllGroupViewControllrt
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor =  [UIColor whiteColor];
    self.dataArray = [[NSMutableArray alloc] init];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    //    [self initializeData];
    [self initializePageSubviews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //
    [MobClick beginLogPageView:@"AllGroupViewControllrt"];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"AllGroupViewControllrt"];
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
    
    
    if ([_ifgrouptype isEqualToString:@"1"]) {
        self.requestParas =  @{@"userId":[MyUserInfoManager shareInstance].userId,
                               @"page":@(currPage),
                               @"token":[[MyUserInfoManager shareInstance]token],
                               isLoadingMoreKey:@(isLoadingMore)};
    }else
    {
        
        self.requestParas =  @{@"userId":_therquestUrl,
                               @"ownerId":[[MyUserInfoManager shareInstance]userId],
                               @"page":@(currPage),
                               @"token":[[MyUserInfoManager shareInstance]token],
                               isLoadingMoreKey:@(isLoadingMore)};
    }
    
    self.requestURL = self.circlerquestUrl;
    
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
    
    if ([request.url isEqualToString:LKB_MyGroup_List_Url]||[request.url isEqualToString:LKB_ALLGroup_List_Url]) {
        GroupModel *groupModel = (GroupModel *)parserObject;
        
        
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:groupModel.data];
        }else {
            [_dataArray addObjectsFromArray:groupModel.data];
        }
        
        [self.tableView reloadData];
        
        if (groupModel.data.count == 0) {
            // self.tableView.showsInfiniteScrolling = NO;
            self.tableView.tableFooterView.hidden = NO;
            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
        }

    }
    
    
    if ([request.url isEqualToString:LKB_ShareColumn_ToGroup_Url]) {
        
        
        LKBBaseModel * base = (LKBBaseModel *)parserObject;
        
        NSLog(@"6666666666666666666666666^^^^^^^^^^^^^^^^^^^^^^^^^^^^%@",base.msg);
    }
    
    if ([request.url isEqualToString:LKB_ShareQuestion_ToGroup_Url]) {
        
        LKBBaseModel * base = (LKBBaseModel *)parserObject;
        
        NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<^^^^^^^^^^^^^^^^^^^^^^^^^^^^%@",base.msg);
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
    return 87;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    AllGroupCell* simplescell = [tableView dequeueReusableCellWithIdentifier:AllGroupTableViewCellIdentifier];
    simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < self.dataArray.count) {
        GroupDetailModel *findPeoleModel = (GroupDetailModel *)_dataArray[indexPath.row];
        
//        NSUserDefaults *userDefault = [[NSUserDefaults alloc]init];
        //        NSDictionary *mydic = @{@"userName":buddy.contactName,
        //                                @"userAvatar":buddy.image
        //                                };
        //        NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
        //        [userDefaults setObject:dic  forKey:buddy.userId];
        
//        if (findPeoleModel.easyMobId==nil) {
//            findPeoleModel.easyMobId = @"100000008888";
//        }
//        
//        NSLog(@"-----------------------------%@",findPeoleModel.groupName);
//        NSLog(@"-----------------------------%@",findPeoleModel.groupAvatar);
//        NSLog(@"-----------------------------%@",findPeoleModel.groupId);
//        
//        
//        NSDictionary *mydic = @{@"userName":findPeoleModel.groupName,
//                                @"groupAvatar":findPeoleModel.groupAvatar,
//                                @"groupId":findPeoleModel.groupId
//                                };
//        NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
//        [userDefault setObject:dic  forKey:findPeoleModel.easyMobId];
        
        [simplescell configUserInforGroupCellWithModel:findPeoleModel];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return simplescell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < self.dataArray.count) {
        self.hidesBottomBarWhenPushed=YES;
        GroupDetailModel *findPeoleModel = (GroupDetailModel *)_dataArray[indexPath.row];
        
        _easyMobId = findPeoleModel.easyMobId;
        _groupName =findPeoleModel.groupName;
        _groupId = findPeoleModel.groupId;
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:findPeoleModel.easyMobId isGroup:YES];
        if ([_ifshare isEqualToString:@"2"]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否分享到这里" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alert show];
            
            
            
            
            
        }
        else {
            //
            
            
           
            
//            CirclePeopleViewController * circlePeopleVC = [[CirclePeopleViewController alloc]init];
            
            
            FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
            
            NSString *str = [NSString stringWithFormat:@"circle%@",findPeoleModel.groupId];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *passWord = [ user objectForKey:str];
            NSLog(@"===========%@======",findPeoleModel.isJoin);
            
            if (!passWord) {
                farmerVC.ifJion = findPeoleModel.isJoin;
                [CircleIfJoinManager shareInstance].ifJoin = findPeoleModel.isJoin;
            }
            else
            {
                farmerVC.ifJion = passWord;
                [CircleIfJoinManager shareInstance].ifJoin = passWord;
            }
            farmerVC.circleId = findPeoleModel.groupId;
            farmerVC.groupAvatar = findPeoleModel.groupAvatar;
            farmerVC.toUserId = [MyUserInfoManager shareInstance].userId;
            farmerVC.mytitle = findPeoleModel.groupName;
            farmerVC.type= @"1";

            farmerVC.hidesBottomBarWhenPushed = YES;

            
//            circlePeopleVC.groupId = findPeoleModel.groupId;
//            circlePeopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:farmerVC animated:YES];
            
        }
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:_easyMobId isGroup:YES];
        [chatVC sendTextMessage:_shareDes];
        chatVC.delelgate  = self;
        chatVC.ifShare = YES;
        chatVC.title = _groupName;
        chatVC.groupId = _groupId;
        [self.navigationController pushViewController:chatVC animated:YES];
        self.hidesBottomBarWhenPushed=YES;
        
        
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
    self.tableView.showsInfiniteScrolling = NO;
    [self.tableView triggerPullToRefresh];
    
    if (self.dataArray.count == 0) {
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        footerVew.textLabel.text=@"没有更多数据了哦..";
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = YES;
        
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
        [_tableView registerClass:[AllGroupCell class] forCellReuseIdentifier:AllGroupTableViewCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *mydic = [userDefaults objectForKey:chatter];
    //    if (mydic) {
    
    NSString *strr = mydic[@"userAvatar"];
    
    //    }
    NSString *strrr = [NSString stringWithFormat:@"%@%@",LKB_USERHEADER_HTTP,strr];
    return strrr;
    //    NSLog(@"======%@==========",chatter);
    ////        return @"http://img0.bdstatic.com/img/image/shouye/jianbihua0525.jpg";
    //    NSString *strr = [NSString stringWithFormat:@"%@%@",LKB_IMAGEBASE_HTTP,[MyUserInfoManager shareInstance].avatar];
    //    return strr;
    
    //    return @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
    //    return nil;
}

// 根据环信id得到要显示用户名，如果返回nil，则默认显示环信id
- (NSString *)nickNameWithChatter:(NSString *)chatter{
    return chatter;
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


@end
