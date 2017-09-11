//
//  OtherUserInforViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/28.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "OtherUserInforViewController.h"
#import "UserInforTableViewCell.h"
#import "ToUserManager.h"
#import "MyUserInfoManager.h"
#import "MBProgressHUD+Add.h"
#import "SVPullToRefresh.h"
#import "MyColumnViewController.h"
#import "UserGroupViewController.h"
#import "MyTopicViewController.h"
#import "MyQuestionViewController.h"
#import "NoImageDetailCell.h"
#import "NoImageButWithDetailCell.h"
#import "NewTimeTableViewCell.h"
#import "PeopleViewController.h"
#import "InsightDetailViewController.h"
#import "ChatViewController.h"
#import "MyAttentionBaseViewController.h"

#import "NewTimeViewController.h"
#import "TimeTableViewCell.h"
#import "NewTimeDynamicModel.h"
#import "InsightDetailViewController.h"
#import "DiscoverTableViewCell.h"
#import "MyUserInfoManager.h"
#import "WBDropdownMenuView.h"
#import "WBTitleMenuViewController.h"
#import "QADetailViewController.h"
#import "NoImageNoDetailCell.h"
#import "MyCollectionViewController.h"
NSString * const OtherUserInforTimeNomorlCellIdentifier = @"TimeNomorlCell";
NSString * const OtherUserInforTimeWithNoImageDetailCellIdentifier = @"TimeWithNoImageDetail";
NSString * const OtherUserInforNoImageButWithDetailCellIdentifier = @"TimeWithNoImageButDetail";
NSString * const OtherUserInforNoImageNoDetailCellIdentifier = @"NoImageNoDetailCellIdentifier";



//static NSString* CellIdentifier = @"UserCellIdentifier";

@interface OtherUserInforViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,ChatViewControllerDelegate>

@property (strong, nonatomic) UITableView * tableView;//
@property (strong, nonatomic) UIView * headerView;// 区头
@property (strong, nonatomic) OtherUserInforHeaderView * otherUserInforHeaderView;// 区头
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *headData;
@property (strong, nonatomic) UIButton *turnToTalkBtn;


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

//    self.title =[ToUserManager shareInstance].userName;
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    self.requestParas = @{@"userId":_toUserId,
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          @"token":[MyUserInfoManager shareInstance].token
                          };
    self.requestURL = LKB_User_Infor_Url;

    _turnToTalkBtn = [[UIButton alloc]initWithFrame:CGRectMake(286, 12, 24, 24)];
    [_turnToTalkBtn setImage:[UIImage imageNamed:@"sender_talk"] forState:UIControlStateNormal];
    [_turnToTalkBtn addTarget:self action:@selector(toGroupTalk:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_turnToTalkBtn];

    [self initializePageSubviews];

//     self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    self.requestParas = @{@"userId":_toUserId,
//                          @"ownerId":[MyUserInfoManager shareInstance].userId,
//                          @"token":[MyUserInfoManager shareInstance].token
//                          };
//    self.requestURL = LKB_User_Infor_Url;

}

-(void)toGroupTalk:(id)sender
{
    
    self.hidesBottomBarWhenPushed=YES;
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:_toUserId isGroup:NO];
    chatVC.title = _otherUserInforHeaderView.nameLabel.text;
    chatVC.delelgate = self;
    [self.navigationController pushViewController:chatVC animated:YES];
    //    self.hidesBottomBarWhenPushed=NO;
    
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
       [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    if ([request.url isEqualToString:LKB_User_Infor_Url]) {
        UserInforModel *userInfor = (UserInforModel *)parserObject;
        self.title = [userInfor.data valueForKey:@"userName"];
        
        NSLog(@"=======%@========",[userInfor.data valueForKey:@"ifAttention"]);
        _ifAttention = [userInfor.data valueForKey:@"ifAttention"];
        //已关注
        if ([_ifAttention isEqualToString:@"0"]) {
            
            _turnToTalkBtn.hidden = NO;
            [_otherUserInforHeaderView.attentionButton setImage:[UIImage imageNamed:@"userInfor_attentioned"] forState:UIControlStateNormal];
        }else
        {
            _turnToTalkBtn.hidden = YES;
            [_otherUserInforHeaderView.attentionButton setImage:[UIImage imageNamed:@"attention"] forState:UIControlStateNormal];
        }

        [_otherUserInforHeaderView configSearchPeopleRecommCellWithModel:userInfor];
        [self.tableView reloadData];
        
        

    }
    
    if ([request.url isEqualToString:LKB_UserInfor_dynamic_Url]) {
        UserInforDynamicModel *useInforModel = (UserInforDynamicModel *)parserObject;
//        [self ShowProgressHUDwithMessage:useInforModel.msg];
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
    if ([request.url isEqualToString:LKB_Attention_User_Url]) {
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        [self ShowProgressHUDwithMessage:Model.msg];
//        [_otherUserInforHeaderView.attentionButton setTitle:@"取消关注" forState:UIControlStateNormal];
        [_otherUserInforHeaderView.attentionButton setImage:[UIImage imageNamed:@"OtherInfor_attentioned"] forState:UIControlStateNormal];
        
        _turnToTalkBtn.hidden = NO;
        self.requestParas = @{@"userId":_toUserId,
                              @"ownerId":[MyUserInfoManager shareInstance].userId,
                              @"token":[MyUserInfoManager shareInstance].token
                              };
//        self.requestURL = LKB_UserInfor_dynamic_Url;
        [self.tableView reloadData];
        NSLog(@"%@",Model);
        
    }
    
    if ([request.url isEqualToString:LKB_UnAttention_User_Url]) {
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        [self ShowProgressHUDwithMessage:Model.msg];
        _turnToTalkBtn.hidden = YES;
//        [_otherUserInforHeaderView.attentionButton setTitle:@"关注" forState:UIControlStateNormal];
        [_otherUserInforHeaderView.attentionButton setImage:[UIImage imageNamed:@"attention"] forState:UIControlStateNormal];

        
        self.requestParas = @{@"userId":_toUserId,
                              @"ownerId":[MyUserInfoManager shareInstance].userId,
                              @"token":[MyUserInfoManager shareInstance].token
                              };
//        self.requestURL = LKB_UserInfor_dynamic_Url;
        [self.tableView reloadData];
        NSLog(@"%@",Model);
        
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
    
    self.requestParas = @{@"userId":_toUserId,
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          @"token":[MyUserInfoManager shareInstance].token,
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    self.requestURL = LKB_UserInfor_dynamic_Url;
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!isLoadingMore) {
//            [self.tableView.pullToRefreshView stopAnimating];
//        }
//        else {
//            //[self.dataArray addObject:[NSNull null]];
//            [self.tableView.infiniteScrollingView stopAnimating];
//        }
//        [self.tableView reloadData];
//    });
    
    
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
//        _otherUserInforHeaderView = [[OtherUserInforHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 315)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = self.otherUserInforHeaderView;
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

- (OtherUserInforHeaderView *)otherUserInforHeaderView
{
    if (!_otherUserInforHeaderView) {
        _otherUserInforHeaderView = [[OtherUserInforHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 330)];
        _otherUserInforHeaderView.backgroundColor = [UIColor whiteColor];
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
            if (clickIndex == 5) {
//                MyColumnViewController *peopleVC = [[MyColumnViewController alloc] init];
//                peopleVC.therquestUrl = _toUserId;
//                peopleVC.title = @"Ta的专栏";
//                peopleVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:peopleVC animated:YES];
                MyAttentionBaseViewController *peopleVC = [[MyAttentionBaseViewController alloc] init];
                peopleVC.hidesBottomBarWhenPushed = YES;
                peopleVC.userId = _toUserId;
                [self.navigationController pushViewController:peopleVC animated:YES];

            }
            if (clickIndex == 6) {
                PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
                peopleVC.requestUrl = LKB_Attention_Users_Url;
                peopleVC.userId = _toUserId;
                peopleVC.VCType = @"1";
                peopleVC.ifshare = @"0";
                peopleVC.hidesBottomBarWhenPushed = YES;
                peopleVC.title = @"关注";
                [self.navigationController pushViewController:peopleVC animated:YES];
            }
            if (clickIndex == 7) {
                PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
                peopleVC.requestUrl = LKB_Attention_All_Fans_Url;
                peopleVC.userId = _toUserId;
                peopleVC.VCType = @"2";

                peopleVC.ifshare = @"0";
                peopleVC.hidesBottomBarWhenPushed = YES;
                peopleVC.title = @"粉丝";
                [self.navigationController pushViewController:peopleVC animated:YES];
                
                
                
                
            }
            if (clickIndex == 8) {
                [self userHeaderView];
            }
            
            // 收藏
            if (clickIndex == 9) {
                MyCollectionViewController *collectionVC = [[MyCollectionViewController alloc] init];
                collectionVC.userId = _toUserId;
                collectionVC.hidesBottomBarWhenPushed = YES;
                collectionVC.title = @"Ta的收藏";
                [self.navigationController pushViewController:collectionVC animated:YES];
                
            }


        }];
    }
    return _otherUserInforHeaderView;
}


-(void)userHeaderView {
    
    NSLog(@"-+++++++*--------------%@",_ifAttention);
    if ([_otherUserInforHeaderView.attentionButton.imageView.image isEqual:[UIImage imageNamed:@"attention"]]) {

        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"attentedUser":_toUserId,
                              @"token":[MyUserInfoManager shareInstance].token
                              };
        self.requestURL = LKB_Attention_User_Url;
    }else
    {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"attentedUser":_toUserId,
                              @"token":[MyUserInfoManager shareInstance].token
                              };
        self.requestURL = LKB_UnAttention_User_Url;
    }
}

// 区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 330)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.otherUserInforHeaderView];

    [_otherUserInforHeaderView handlerButtonAction:^(NSInteger clickIndex) {
        if (clickIndex == 1) {
            MyColumnViewController *peopleVC = [[MyColumnViewController alloc] init];
            peopleVC.therquestUrl = _toUserId;
            peopleVC.title = @"Ta的专栏";
            peopleVC.type = @"2";
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
        if (clickIndex == 5) {
            MyColumnViewController *peopleVC = [[MyColumnViewController alloc] init];
            //peopleVC.therquestUrl = [MyUserInfoManager shareInstance].userId;
            peopleVC.therquestUrl = _toUserId;
            peopleVC.title = @"Ta的专栏";
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
        }
        if (clickIndex == 6) {
            PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
            peopleVC.requestUrl = _toUserId;
            peopleVC.userId = [MyUserInfoManager shareInstance].userId;
            peopleVC.hidesBottomBarWhenPushed = YES;
            peopleVC.title = @"关注";
            [self.navigationController pushViewController:peopleVC animated:YES];
        }
        if (clickIndex == 7) {
            PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
            peopleVC.requestUrl = LKB_Attention_All_Fans_Url;
            peopleVC.userId = _toUserId;
            peopleVC.hidesBottomBarWhenPushed = YES;
            peopleVC.title = @"粉丝";
            [self.navigationController pushViewController:peopleVC animated:YES];
        }

    }];
    return _headerView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row<_dataArray.count) {
        
//        UserDynamicModelIntroduceModel *useInforModel = self.dataArray[indexPath.row];
//        
//        
//        if ([useInforModel.type isEqualToString:@"4"]) {
//            return 159;
//        }
//        
//        
//        
//        else    if ([NSStrUtil isEmptyOrNull:useInforModel.cover])
//        {
//            if ([NSStrUtil isEmptyOrNull:useInforModel.summary]) {
//                return 159;
//            }
//            else
//            {
//                return 189;
//            }
//        }
//        else
//        {
//            return 209;
//        }
//    }
//    else
//    {
//        return 537;
//    }
        
        UserDynamicModelIntroduceModel *useInforModel = self.dataArray[indexPath.row];

        
        if ([useInforModel.type isEqualToString:@"4"]) {
            return 159;
        }
        
        
        
        else    if ([NSStrUtil isEmptyOrNull:useInforModel.cover])
        {
            if ([NSStrUtil isEmptyOrNull:useInforModel.summary]) {
                return 159;
            }
            else
            {
                return 189;
            }
        }
        else
        {
            return 209;
        }
    }
    else
    {
        return 209;
    }


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        //        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    
    
    if (indexPath.row < self.dataArray.count) {
        
//        NewDynamicDetailModel *insight = (NewDynamicDetailModel *)_dataArray[indexPath.row];
        UserDynamicModelIntroduceModel *insight = (UserDynamicModelIntroduceModel *)_dataArray[indexPath.row];

        
        NSLog(@"-------------------------------------%@",insight.type);

        if ([insight.type isEqualToString:@"4"]) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:OtherUserInforNoImageNoDetailCellIdentifier];
            if (!cell) {
                cell = [[NoImageNoDetailCell alloc] initWithHeight:150 reuseIdentifier:OtherUserInforNoImageNoDetailCellIdentifier];
            }
            NoImageNoDetailCell *tbCell = (NoImageNoDetailCell *)cell;
            [tbCell configNoImageNoDetailUserTableCellWithGoodModel:insight];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
        
        
        else{
            
            if ([NSStrUtil isEmptyOrNull:insight.cover]) {
                if ([NSStrUtil isEmptyOrNull:insight.summary]) {
                    cell = [tableView dequeueReusableCellWithIdentifier:OtherUserInforTimeWithNoImageDetailCellIdentifier];
                    if (!cell) {
//                        cell = [[NoImageDetailCell alloc] initWithHeight:150 reuseIdentifier:OtherUserInforTimeWithNoImageDetailCellIdentifier];
                    }
                    NoImageDetailCell *tbCell = (NoImageDetailCell *)cell;
                    [tbCell configNoImageDetailUserTableCellWithModel:insight];
                    [tbCell setNeedsUpdateConstraints];
                    [tbCell updateConstraintsIfNeeded];
                }else
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:OtherUserInforNoImageButWithDetailCellIdentifier];
                    if (!cell) {
                        cell = [[NoImageButWithDetailCell alloc] initWithHeight:180 reuseIdentifier:OtherUserInforNoImageButWithDetailCellIdentifier];
                    }
                    NoImageButWithDetailCell *tbCell = (NoImageButWithDetailCell *)cell;
                    [tbCell configNoImageButDetailUserTableCellWithGoodModel:insight];
                    [tbCell setNeedsUpdateConstraints];
                    [tbCell updateConstraintsIfNeeded];
                }
                
            }
            else
            {
                cell = [tableView dequeueReusableCellWithIdentifier:OtherUserInforTimeNomorlCellIdentifier];
                if (!cell) {
//                    cell = [[NewTimeTableViewCell alloc] initWithHeight:200 reuseIdentifier:OtherUserInforTimeNomorlCellIdentifier];
                }
                NewTimeTableViewCell *tbCell = (NewTimeTableViewCell *)cell;
                [tbCell configUserTableCellWithModel:insight];
                [tbCell setNeedsUpdateConstraints];
                [tbCell updateConstraintsIfNeeded];
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row < self.dataArray.count) {
//        NewDynamicDetailModel *insight = (NewDynamicDetailModel *)_dataArray[indexPath.row];
        UserDynamicModelIntroduceModel *insight = (UserDynamicModelIntroduceModel *)_dataArray[indexPath.row];

        if ([insight.type isEqualToString:@"4"]) {
//            TopicDetaillViewController *TopicVC = [[TopicDetaillViewController alloc] init];
//            TopicVC.hidesBottomBarWhenPushed = YES;
//            TopicVC.topicId = insight.objectId;
//            [self.navigationController pushViewController:TopicVC animated:YES];
        }else if([insight.type isEqualToString:@"1"]) {
            InsightDetailViewController *InsightVC = [[InsightDetailViewController alloc] init];
            InsightVC.hidesBottomBarWhenPushed = YES;
            InsightVC.topicId = insight.objectId;
            [self.navigationController pushViewController:InsightVC animated:YES];
        }else if([insight.type isEqualToString:@"2"]||[insight.type isEqualToString:@"3"]) {
            QADetailViewController *QADetailVC = [[QADetailViewController alloc] init];
            QADetailVC.questionId = insight.objectId;
            QADetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:QADetailVC animated:YES];
        }
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
