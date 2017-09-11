//
//  OtherRootViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/8.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "OtherRootViewController.h"
#import "Masonry.h"
#import "MASConstraintMaker.h"
#import "MyUserInfoManager.h"
#import "MyAttentionBaseViewController.h"
#import "PeopleViewController.h"
#import "UILabel+StringFrame.h"
#import "UserInforDynamicModel.h"
#import "SVPullToRefresh.h"
#import "QuestionModel.h"
#import "ColumnModel.h"
#import "GroupModel.h"
#import "ToPicModel.h"
#import "QADetailViewController.h"
#import "InsightDetailViewController.h"
#import "NewGroupInfoDetailViewController.h"
#import "ColumnListViewController.h"
#import "TopicDetaillViewController.h"
#import "CreatNewGroupViewController.h"
#import "UserInforSettingViewController.h"

#import "UserSettingViewController.h"
#import "CollectionModel.h"
#import "HHHorizontalPagingView.h"
#import "UserInforAllTableView.h"
#import "UserInforQueTableView.h"
#import "UserInforColumnTableView.h"
#import "UserInforGroupTableView.h"
#import "UserInforTopicTableView.h"
#import "UserInforCollectionTableView.h"
#import "ToUserManager.h"
@interface OtherRootViewController ()
//<PushTopicController,InforAllTableView,PushQuestionController,PushColumnController,PushGroupController,PushCollectionController>
@property (nonatomic, strong) UserInforAllTableView *allTableView;
@property (nonatomic, strong)UserInforQueTableView *questionTableView;
@property (nonatomic, strong)UserInforColumnTableView *columnTableView;
@property (nonatomic, strong)UserInforGroupTableView *groupTableView;
@property (nonatomic, strong)UserInforTopicTableView *topicTableView;
@property (nonatomic, strong)UserInforCollectionTableView *collectionTableView;

@property (nonatomic, strong)NSMutableArray *buttonArray;
@property (nonatomic, strong)HHHorizontalPagingView *pagingView ;

@property (nonatomic, assign) CGFloat            headerViewHeight;

@end

@implementation OtherRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _headerView = [[HeaderView alloc]init];

    [_headerView.beAttentionedButton setTitle:@"关注ta的人" forState:UIControlStateNormal];
    
    [_headerView.hadAttentionButton setTitle:@"ta关注的人" forState:UIControlStateNormal];
    
    self.requestParas = @{@"userId":_toUserId,
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          @"token":[MyUserInfoManager shareInstance].token
                          };
    self.requestURL = LKB_User_Infor_Url;

    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, kDeviceWidth , 44)];
    
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    titleText.textAlignment = NSTextAlignmentCenter;
    [titleText setFont:[UIFont systemFontOfSize:17.0]];
    [titleText setText:[ToUserManager shareInstance].userName];
    self.navigationItem.titleView=titleText;
    
    
    //分享按钮
    _shareButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 30, 10, 20, 20)];
    [_shareButton setImage:[UIImage imageNamed:@"nav_share_nor"] forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationController.navigationBar addSubview:_setUpButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_shareButton];
    ;


    // Do any additional setup after loading the view.
}


- (void)shareButton:(id)sender {
    
}


- (void)initializePageSubviews {
    
    _allTableView = [UserInforAllTableView allTableView];
    _questionTableView = [UserInforQueTableView qusetionTableView];
    _columnTableView = [UserInforColumnTableView columnTableView];
    _groupTableView = [UserInforGroupTableView groupTableView];
    _topicTableView = [UserInforTopicTableView topicTableView];
    _collectionTableView = [UserInforCollectionTableView collectionTableView];
    
//    _allTableView.AllpushNextDelegate = self;
//    _questionTableView.pushNextQuestionDelegate = self;
//    _columnTableView.pushNextColumnDelegate=self;
//    _groupTableView.pushNextGroupDelegate=self;
//    _topicTableView.pushNextDelegate = self;
//    _collectionTableView.pushNextCollectionDelegate =self;
    
    
    _buttonArray = [NSMutableArray array];
    _classArray = @[@"动态",@"问答",@"专栏",@"群组",@"话题",@"收藏"];
    for(int i = 0; i < 6; i++) {
        UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [segmentButton setBackgroundColor:[UIColor whiteColor]];
        [segmentButton setTitleColor:[UIColor grayColor]  forState:UIControlStateNormal];
        [segmentButton setTitleColor:[UIColor LkbBtnColor] forState:UIControlStateSelected];
        [segmentButton setTitle:[NSString stringWithFormat:@"%@",_classArray[i]] forState:UIControlStateNormal];
        //        [segmentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_buttonArray addObject:segmentButton];
    }
    
    
    
    _headerView.frame = CGRectMake(0, 0, kDeviceWidth, _headerViewHeight );
    _headerView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    _pagingView = [HHHorizontalPagingView pagingViewWithHeaderView:_headerView headerHeight:_headerView.frame.size.height segmentButtons:_buttonArray segmentHeight:60 contentViews:@[_allTableView, _questionTableView, _columnTableView,_groupTableView,_topicTableView,_collectionTableView]];
    _pagingView.magnifyTopConstraint = _headerView.headerTopConstraint;
    NSLog(@"*----------------------------------------%f",_pagingView.headerViewHeight);
    
    
    
    [self.view addSubview:_pagingView];
    
    
    
    
    __weak __typeof(self) weakSelf = self;
    // 1
    [_allTableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [_allTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    
    _allTableView.showsInfiniteScrolling = YES;
    [_allTableView triggerPullToRefresh];
    
    // 2
    [_questionTableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [_questionTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    
    _questionTableView.showsInfiniteScrolling = YES;
    [_questionTableView triggerPullToRefresh];
    
    // 3
    [_columnTableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [_columnTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    
    _columnTableView.showsInfiniteScrolling = YES;
    [_columnTableView triggerPullToRefresh];
    
    // 4
    [_groupTableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [_groupTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    
    _groupTableView.showsInfiniteScrolling = YES;
    [_groupTableView triggerPullToRefresh];
    
    // 5
    [_topicTableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [_topicTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    
    _topicTableView.showsInfiniteScrolling = YES;
    [_topicTableView triggerPullToRefresh];
    
    // 6
    [_collectionTableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [_collectionTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    
    _collectionTableView.showsInfiniteScrolling = YES;
    [_collectionTableView triggerPullToRefresh];
    
    self.requestParas = @{@"userId":_toUserId,
                          @"token":[[MyUserInfoManager shareInstance]token],
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          };
    
    self.requestURL = LKB_ColumnInfo_Collection_Url;
    
    
    
    
    
}

- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    
    self.requestParas = @{@"userId":_toUserId,
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          @"token":[MyUserInfoManager shareInstance].token,
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    self.requestURL = LKB_UserInfor_dynamic_Url;
    
    
    self.requestParas = @{@"userId":_toUserId,
                          @"ownerId":[[MyUserInfoManager shareInstance]userId],
                          @"page":@(currPage),
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)};
    
    self.requestURL = LKB_Question_Url;
    
    self.requestParas = @{@"userId":_toUserId,
                          @"ownerId":[[MyUserInfoManager shareInstance]userId],
                          @"page":@(currPage),
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)};
    
    self.requestURL = LKB_Insight_features_Url;
    
    self.requestParas =  @{@"userId":_toUserId,
                           @"ownerId":[[MyUserInfoManager shareInstance]userId],
                           @"page":@(currPage),
                           @"token":[[MyUserInfoManager shareInstance]token],
                           isLoadingMoreKey:@(isLoadingMore)};
    
    self.requestURL = LKB_Group_List_Url;
    
    self.requestParas = @{@"userId":_toUserId,
                          @"ownerId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token],
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    
    self.requestURL = LKB_Topic_Url;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            [_allTableView.pullToRefreshView stopAnimating];
            [_columnTableView.pullToRefreshView stopAnimating];
            [_questionTableView.pullToRefreshView stopAnimating];
            [_groupTableView.pullToRefreshView stopAnimating];
            [_collectionTableView.pullToRefreshView stopAnimating];
            [_topicTableView.pullToRefreshView stopAnimating];
            
            
        }
        else {
            //            [self.dataArray addObject:[NSNull null]];
            [_allTableView.infiniteScrollingView stopAnimating];
            [_columnTableView.infiniteScrollingView stopAnimating];
            [_questionTableView.infiniteScrollingView stopAnimating];
            [_groupTableView.infiniteScrollingView stopAnimating];
            [_collectionTableView.infiniteScrollingView stopAnimating];
            [_topicTableView.infiniteScrollingView stopAnimating];
            
        }
        [_allTableView reloadData];
        [_columnTableView reloadData];
        [_questionTableView reloadData];
        [_collectionTableView reloadData];
        [_groupTableView reloadData];
        [_topicTableView reloadData];
        
    });
}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    //    if (!request.isLoadingMore) {
    //        [t.pullToRefreshView stopAnimating];
    //    }
    //    else {
    //        [_allTableView.infiniteScrollingView stopAnimating];
    //    }
    
    if (errorMessage) {
        [MBProgressHUD showError:errorMessage toView:self.view];
        return;
    }
    if ([request.url isEqualToString:LKB_User_Infor_Url]) {
        UserInforModel *userInfor = (UserInforModel *)parserObject;
        
        
        UserInforModellIntroduceModel *userInfor22 =userInfor.data;
        
        NSLog(@"~~~~~~~~~%@",userInfor22.remark);
        
        
        //        _headerView.describeLabel.text = userInfor22.remark;
        
        
        _headerView.describeLabel.text = @"66666666666666669999999999999999999999999999999999999966222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222229666666666444455555555";
        //        _describeLabel= _headerView.describeLabel.text;
        //        [_headerView addSubview:_describeLabel];
        //        _describeLabel.text = userInfor22.remark;
        CGRect rect = [_headerView.describeLabel.text boundingRectWithSize:CGSizeMake(kDeviceWidth, KDeviceHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
        
        NSLog(@"********************************%f",rect.size.height);
        
        //        CGFloat labelHeight = [self.testLabel sizeThatFits:CGSizeMake(self.testLabel.frame.size.width, MAXFLOAT)].height;
        NSNumber *count =@( rect.size.height / _headerView.describeLabel.font.lineHeight);
        NSLog(@"共 %td 行", [count integerValue]);
        
        
        NSLog(@"++++++++++++%f",_headerView.describeLabel.font.lineHeight * 6);
        
        if([count integerValue] <6) {
            _headerView.OpenButton.hidden = YES;
            _headerViewHeight = 35 +90  +10  ;
            
        }
        else{
            _headerView.OpenButton.hidden = NO;
            
            _headerViewHeight = _headerView.describeLabel.font.lineHeight * 6  +90 +10 +45 +10;
            
        }
        
        
        [self initializePageSubviews];
        [self headerViewAction];
        
        [_headerView configMyInforRecommCellWithModel:userInfor];
        
    }
    
    if ([request.url isEqualToString:LKB_UserInfor_dynamic_Url]) {
        
        UserInforDynamicModel *useInforModel = (UserInforDynamicModel *)parserObject;
        if (!request.isLoadingMore) {
            _allTableView.dataArray = [NSMutableArray arrayWithArray:useInforModel.data];
        }else {
            [_allTableView.dataArray addObjectsFromArray:useInforModel.data];
        }
        
        NSLog(@"0---------------------%@",_allTableView.dataArray);
        
        
        [_allTableView  reloadData];
        
        if (useInforModel.data.count == 0) {
            //            [_allTableView.infiniteScrollingView endScrollAnimating];
        } else {
            _allTableView.showsInfiniteScrolling = YES;
            [_allTableView.infiniteScrollingView beginScrollAnimating];
            
        }
        
        
    }
    
    if ([request.url isEqualToString:LKB_Question_Url]) {
        QuestionModel *questionModel = (QuestionModel *)parserObject;
        NSLog(@"========%@===============",questionModel.data);
        if (!request.isLoadingMore) {
            if(questionModel.data)
            {
                _questionTableView.dataArray = [NSMutableArray arrayWithArray:questionModel.data];
            }
        } else {
            [_questionTableView.dataArray addObjectsFromArray:questionModel.data];
        }
        
        [_questionTableView reloadData];
        
        if (questionModel.data.count == 0) {
            //[self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            _questionTableView.showsInfiniteScrolling = YES;
            [_questionTableView.infiniteScrollingView beginScrollAnimating];
        }
    }
    
    if ([request.url isEqualToString:LKB_Insight_features_Url]) {
        ColumnModel *columnModel = (ColumnModel *)parserObject;
        
        NSLog(@"========%@===============",columnModel.data);
        if (!request.isLoadingMore) {
            if(columnModel.data)
            {
                _columnTableView.dataArray = [NSMutableArray arrayWithArray:columnModel.data];
            }
        } else {
            if (_columnTableView.dataArray.count<columnModel.num) {
                [_columnTableView.dataArray addObjectsFromArray:columnModel.data];
            }
            
        }
        [_columnTableView reloadData];
        
        if (columnModel.data.count == 0) {
            //            [_columnTableView.infiniteScrollingView endScrollAnimating];
        } else {
            _columnTableView.showsInfiniteScrolling = YES;
            [_columnTableView.infiniteScrollingView beginScrollAnimating];
        }
        
    }
    if ([request.url isEqualToString:LKB_Group_List_Url]) {
        GroupModel *groupModel = (GroupModel *)parserObject;
        
        NSLog(@"========%@===============",parserObject);
        NSLog(@"=========%@=======",groupModel.data);
        
        if (!request.isLoadingMore) {
            if(groupModel.data)
            {
                _groupTableView.dataArray = [NSMutableArray arrayWithArray:groupModel.data];
            }
        } else {
            if (_groupTableView.dataArray.count<groupModel.num) {
                [_groupTableView.dataArray addObjectsFromArray:groupModel.data];
            }
            
        }
        [_groupTableView reloadData];
        
        if (groupModel.data.count == 0) {
            //            [_columnTableView.infiniteScrollingView endScrollAnimating];
        } else {
            _groupTableView.showsInfiniteScrolling = YES;
            [_groupTableView.infiniteScrollingView beginScrollAnimating];
        }
        
    }
    
    if ([request.url isEqualToString:LKB_Topic_Url]) {
        ToPicModel *topicModel = (ToPicModel *)parserObject;
        NSLog(@"========%@===============",topicModel.data);
        if (!request.isLoadingMore) {
            if(topicModel.data)
            {
                _topicTableView.dataArray = [NSMutableArray arrayWithArray:topicModel.data];
            }
        } else {
            [_topicTableView.dataArray addObjectsFromArray:topicModel.data];
        }
        [_topicTableView reloadData];
        if (topicModel.data.count == 0) {
            //            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            _topicTableView.showsInfiniteScrolling = YES;
            [_topicTableView.infiniteScrollingView beginScrollAnimating];
        }
        
    }
    
    if ([request.url isEqualToString:LKB_ColumnInfo_Collection_Url]) {
        CollectionModel *collectionModel = (CollectionModel *)parserObject;
        
        NSLog(@"！！！！！！========%@===============",collectionModel.data);
        if (!request.isLoadingMore) {
            if(collectionModel.data)
            {
                _collectionTableView.dataArray = [NSMutableArray arrayWithArray:collectionModel.data];
            }
        } else {
            [_collectionTableView.dataArray addObjectsFromArray:collectionModel.data];
        }
        [_collectionTableView reloadData];
        if (collectionModel.data.count == 0) {
            //            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            _collectionTableView.showsInfiniteScrolling = YES;
            [_collectionTableView.infiniteScrollingView beginScrollAnimating];
        }
        
    }
    
    
    
}

- (void)pushAllObject:(NSString *)object type:(NSString *)type {
    
    
    if ([type isEqualToString:@"4"]) {
        TopicDetaillViewController *TopicVC = [[TopicDetaillViewController alloc] init];
        TopicVC.hidesBottomBarWhenPushed = YES;
        TopicVC.topicId = object;
        
        
    }else if([type isEqualToString:@"1"]) {
        InsightDetailViewController *InsightVC = [[InsightDetailViewController alloc] init];
        InsightVC.hidesBottomBarWhenPushed = YES;
        InsightVC.topicId = object;
        [self.navigationController pushViewController:InsightVC animated:YES];
    }else if([type isEqualToString:@"2"]||[type isEqualToString:@"3"]) {
        QADetailViewController *QADetailVC = [[QADetailViewController alloc] init];
        QADetailVC.questionId = object;
        QADetailVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:QADetailVC animated:YES];
    }
    else if([type isEqualToString:@"5"]) {
        
        NewGroupInfoDetailViewController *InsightVC = [[NewGroupInfoDetailViewController alloc]init];
        InsightVC.hidesBottomBarWhenPushed = YES;
        InsightVC.groupIdStr =object;
        [self.navigationController pushViewController:InsightVC animated:YES];
    }
}




-(void)pushNextQuestionViewController:(NSString *)objectId {
    
    QADetailViewController *QADetailVC = [[QADetailViewController alloc] init];
    QADetailVC.questionId = objectId;
    QADetailVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:QADetailVC animated:YES];
    
}


- (void)pushNextColumnViewController:(NSString *)objectId {
    
    ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
    ColumnListViewVC.featureId = objectId;
    //    ColumnListViewVC.title = topic.featureName;
    //    ColumnListViewVC.featureAvatar = topic.featureAvatar;
    //    ColumnListViewVC.featureDesc = topic.featureDesc;
    //    ColumnListViewVC.themUrl = topic.userId;
    [self.navigationController pushViewController:ColumnListViewVC animated:YES];
    
    
}

- (void)pushNextGroupViewController:(NSString *)objectId {
    
    if ([objectId isEqualToString:@"创建群组"]) {
        CreatNewGroupViewController * creatGroup  =[[CreatNewGroupViewController alloc]init];
        creatGroup.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:creatGroup animated:YES];
    }
    
    else {
        
        NewGroupInfoDetailViewController *InsightVC = [[NewGroupInfoDetailViewController alloc]init];
        InsightVC.hidesBottomBarWhenPushed = YES;
        InsightVC.groupIdStr =objectId;
        [self.navigationController pushViewController:InsightVC animated:YES];
    }
}

- (void)pushNextViewController:(NSString *)object {
    
    TopicDetaillViewController *TopicVC = [[TopicDetaillViewController alloc] init];
    TopicVC.hidesBottomBarWhenPushed = YES;
    TopicVC.topicId = object;
    
    [self.navigationController pushViewController:TopicVC animated:YES];
}

- (void)pushNextCollectionViewController:(NSString *)objectId {
    
    InsightDetailViewController *InsightVC = [[InsightDetailViewController alloc] init];
    InsightVC.hidesBottomBarWhenPushed = YES;
    InsightVC.topicId = objectId;
    [self.navigationController pushViewController:InsightVC animated:YES];
    
}


- (void)headerViewAction {
    
    _pagingView.clickEventViewsBlock = ^(UIView *eventView){
        
        if (eventView == _headerView.headerImageButton) {
            UserInforSettingViewController* userInforVC = [[UserInforSettingViewController alloc]init];
            userInforVC.hidesBottomBarWhenPushed = YES;
            
            userInforVC.headerImg = [MyUserInfoManager shareInstance].avatar;
            [self.navigationController pushViewController:userInforVC animated:YES];
            
        }
        
        if (eventView == _headerView.hadAttentionButton) {
            
            PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
            peopleVC.requestUrl = LKB_Attention_Users_Url;
            peopleVC.userId = _toUserId;
            peopleVC.hidesBottomBarWhenPushed = YES;
            peopleVC.title = @"Ta关注的人";
            [self.navigationController pushViewController:peopleVC animated:YES];
            
            
        }
        if (eventView == _headerView.beAttentionedButton) {
            
            PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
            peopleVC.requestUrl = LKB_Attention_All_Fans_Url;
            peopleVC.userId = _toUserId;
            peopleVC.hidesBottomBarWhenPushed = YES;
            peopleVC.title = @"关注Ta的人";
            [self.navigationController pushViewController:peopleVC animated:YES];
        }
        
        
        if (eventView == _headerView.attentionContentButton) {
            
            // 我关注的内容
            MyAttentionBaseViewController *peopleVC = [[MyAttentionBaseViewController alloc] init];
            peopleVC.userId = _toUserId;
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
        }
        if (eventView == _headerView.OpenButton) {
            
            
            
            
        }
        if (eventView == _headerView.describeLabel) {
            
            _headerView. isExpandedNow =!_headerView.isExpandedNow;
            [_pagingView reloadInputViews];
            
        }

        
    };
    
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
