//
//  UserRootViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/19.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserRootViewController.h"
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
#import "ColumnListViewController.h"
#import "UserInforSettingViewController.h"
#import "ToUserManager.h"
#import "UserInforOtherGroupTableView.h"
#import "UserSettingViewController.h"
#import "CollectionModel.h"
#import "HHHorizontalPagingView.h"
//#import "UserInforAllTableView.h"
#import "UserInforQueTableView.h"
#import "UserInforColumnTableView.h"
#import "UserInforTopicTableView.h"
#import "ChatViewController.h"
#import "OtherUserInforSettingViewController.h"
#import "LoveTableFooterView.h"
#import "NewShareActionView.h"
#import "TYAlertController.h"
#import "UserGroupViewController.h"
#import "PeopleViewController.h"
#import "ContactsViewController.h"
//#import "UserInforActivityTableView.h"
#import "ActivityModel.h"
#import "UMSocial.h"
#import "NewUserMainPageViewController.h"
#define OpenTag 4001
#define CloseTag 4002
@interface UserRootViewController () <ChatViewControllerDelegate,UIScrollViewDelegate,NewShareActionViewDelegete>
{
    
    UserInforModel *userInforDic;
    HeaderView *headerView2;
    NSString *jsonStr;


}
//@property (nonatomic, strong)UserInforAllTableView *allTableView;
@property (nonatomic, strong)UserInforQueTableView *questionTableView;
@property (nonatomic, strong)UserInforColumnTableView *columnTableView;
//@property (nonatomic, strong)UserInforGroupTableView *groupTableView;
@property (nonatomic, strong)UserInforOtherGroupTableView *groupOtherTableView;

@property (nonatomic, strong)UserInforTopicTableView *topicTableView;
//@property (nonatomic, strong)UserInforCollectionTableView *collectionTableView;
//@property (nonatomic, strong)UserInforActivityTableView *activityTableView;


@property (nonatomic, strong)NSMutableArray *buttonArray;
@property (nonatomic, strong)HHHorizontalPagingView *pagingView ;

@property (nonatomic, assign) CGFloat            headerViewHeight;
@property (nonatomic, assign) NSInteger            pagingheight;

@property(nonatomic,strong)TYAlertController *alertController;

@end

@implementation UserRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _headerView = [[HeaderView alloc]init];
    _titleText = [[UILabel alloc] initWithFrame: CGRectMake(70, 0, kDeviceWidth , 44)];
    
    _titleText.backgroundColor = [UIColor clearColor];
    if ([_type isEqualToString:@"2"]) {
        _titleText.textColor=[UIColor blackColor];

    }
    else {
        _titleText.textColor=[UIColor whiteColor];

    }
    _titleText.textAlignment = NSTextAlignmentCenter;
    [_titleText setFont:[UIFont systemFontOfSize:17.0]];
    
    self.navigationItem.titleView=_titleText;
    
    
    if ([_type isEqualToString:@"2"]) {
        
        self.requestParas = @{@"userId":_toUserId,
                              @"ownerId":[MyUserInfoManager shareInstance].userId,
                              @"token":[MyUserInfoManager shareInstance].token
                              };
        self.requestURL = LKB_User_Infor_Url;

        
        [_headerView.hadAttentionButton setTitle:@"ta关注的人" forState:UIControlStateNormal];
        [_headerView.beAttentionedButton setTitle:@"关注ta的人" forState:UIControlStateNormal];
        
        //        [_titleText setText:[ToUserManager shareInstance].userName];
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
        //    [self.navigationController.navigationBar addSubview:backBtn];
        [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        //分享按钮
        _shareButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 30, 10, 22, 22)];
        [_shareButton setImage:[UIImage imageNamed:@"bottom_icon_share_nor"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
        //    [self.navigationController.navigationBar addSubview:_setUpButton];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_shareButton];
        
        //        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake( 30, 10, 20, 20)];
        //        leftBtn.backgroundColor = [UIColor clearColor];
        //        [leftBtn addTarget:self action:@selector(doNothing:) forControlEvents:UIControlEventTouchUpInside];
        //
        //        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        //        ;
        
    }
    else {
        
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"ownerId":[MyUserInfoManager shareInstance].userId,
                              @"token":[MyUserInfoManager shareInstance].token
                              };
        self.requestURL = LKB_User_Infor_Url;

        // 设置按钮
        _setUpButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 30, 10, 20, 20)];
        [_setUpButton setImage:[UIImage imageNamed:@"setUp"] forState:UIControlStateNormal];
        [_setUpButton addTarget:self action:@selector(setUpButton:) forControlEvents:UIControlEventTouchUpInside];
        //    [self.navigationController.navigationBar addSubview:_setUpButton];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_setUpButton];
        ;
        
        
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake( 30, 10, 20, 20)];
        
        [leftBtn addTarget:self action:@selector(doNothing:) forControlEvents:UIControlEventTouchUpInside];
        //    [self.navigationController.navigationBar addSubview:_setUpButton];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        ;
        
        
        
    }

    

}

-(void)doNothing:(id)sender
{
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
     [self.navigationController.navigationBar setClipsToBounds:NO];
    if ([_type isEqualToString:@"2"]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
        [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    }
    else {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self.navigationController.navigationBar setBarTintColor:CCCUIColorFromHex(0x323436)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"发送" object:nil];

    


    
}

- (void)receive:(NSNotification *)notification
{
    
     _titleText.text = [notification.userInfo objectForKey:@"名字"];
    _headerView.describeLabel.text = [notification.userInfo objectForKey:@"简介"];

    headerView2.describeLabel.text = [notification.userInfo objectForKey:@"简介"];

    UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[[notification.userInfo objectForKey:@"头像"] lkbImageUrl4]]];
    
    if ([[notification.userInfo objectForKey:@"头像"] isEqualToString:@"" ] || [MyUserInfoManager shareInstance].avatar == nil) {
        [_headerView.headerImageButton setImage:YQNormalPlaceImage forState:UIControlStateNormal];
    }
    else {
        [_headerView.headerImageButton setImage:image forState:UIControlStateNormal];
    }

}


-(void)backToMain
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 分享
- (void)shareButton:(id)sender {
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该功能暂未开放，点其他的试试~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
    
    [self shareView];
    
}

- (void)shareView {
    
    
    
    _urlStr = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@", _toUserId];
    _shareCover = [NSString stringWithFormat:@"http://imagetest.lvkebang.cn/static/user_header/%@",_userAvatar];
    
    if (_userInforRemark == nil) {
        _userInforRemark = @"";
    }
    
    
    NSDictionary *shaDic = @{@"cover":_shareCover,
                             @"userId":[[MyUserInfoManager shareInstance]userId],
                             @"description":_userInforRemark,
                             @"title":_toUserName,
                             @"toUserId":_toUserId,
                             @"linkUrl":_urlStr,
                             @"shareType":@"7",
                             //                             @"featureId":_circleDetailId
                             @"fromLable":@"来自个人名片",                             };
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shaDic options:NSJSONWritingPrettyPrinted error:nil];
    
    jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NewShareActionView *newshare = [[NewShareActionView alloc]init];
    newshare.delegate = self;
    newshare.layer.cornerRadius = 10;

    _alertController = [TYAlertController alertControllerWithAlertView:newshare preferredStyle:TYAlertControllerStyleAlert];
    _alertController.backgoundTapDismissEnable = YES;
    [self presentViewController:_alertController animated:YES completion:nil];
    
}



- (void)newShareActionView:(NewShareActionView *)UserHeaderView didatterntion:(NSInteger)index
{
    NSLog(@"点击了群组");
    
//    if (index==0) {
//        [_alertController dismissViewControllerAnimated:YES];
//        UserGroupViewController *shareTogroupView = [[UserGroupViewController alloc]init];
//        shareTogroupView.title = @"我的群组";
//        shareTogroupView.ifshare = @"2";
//        
//        shareTogroupView.shareDes =[NSString stringWithFormat: @"分享名片：<a href='http://www.lvkebang.cn/mingpian/%@'>【%@】</a>",_toUserId,_toUserName];
//        //        NSDictionary *shareDic = @{@"userId":[[MyUserInfoManager shareInstance]userId],
//        //                                   @"title":_questionTitle,
//        //                                   @"questionId":_questionId,
//        //                                   @"summary":_questionDesc,
//        //                                   @"cover":@"",
//        //                                   @"token":[[MyUserInfoManager shareInstance]token],
//        //                                   };
//        //
//        //        NSMutableDictionary* mydic = [NSMutableDictionary dictionaryWithDictionary:shareDic];
//        //
//        //        NSLog(@"-----------------------------%@",mydic);
//        //        shareTogroupView.shareDic = mydic;
//        //
//        shareTogroupView.therquestUrl = [[MyUserInfoManager shareInstance]userId];
//        [self.navigationController pushViewController:shareTogroupView animated:YES];
//    }
//    else if (index == 1) {
//        [_alertController dismissViewControllerAnimated:YES];
//        
//        PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
//        peopleVC.requestUrl = LKB_Attention_Users_Url;
//        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
//        
//        peopleVC.hidesBottomBarWhenPushed = YES;
//        peopleVC.title = @"我的好友";
//        
//        peopleVC.shareDes =[NSString stringWithFormat: @"分享名片：<a href='http://www.lvkebang.cn/mingpian/%@'>【%@】</a>",_toUserId,_toUserName];
//        peopleVC.ifshare = @"2";
//        [self.navigationController pushViewController:peopleVC animated:YES];
//        
//        
//    }
    
    if (index == 1) {
        [_alertController dismissViewControllerAnimated:YES];
        
        PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
        peopleVC.shareDes = jsonStr;
        peopleVC.requestUrl = LKB_Attention_Users_Url;
        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
        peopleVC.VCType = @"1";
        peopleVC.shareType = @"7";
        peopleVC.hidesBottomBarWhenPushed = YES;
        peopleVC.title = @"我的好友";
        peopleVC.ifshare = @"3";
        [self.navigationController pushViewController:peopleVC animated:YES];
        
        
    }
    
    // 微信好友
    if (index == 2) {
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _toUserName;
        
 
        NSLog(@"---------------------------------%@",_toUserId);
        
        extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@",_toUserId];;
    
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_userInforRemark shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
    // 微信朋友圈
    if (index==3) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _toUserName;
        
        NSLog(@"---------------------------------%@",_toUserId);

        extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@",_toUserId];;
        [[UMSocialControllerService defaultControllerService] setShareText:_userInforRemark shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // 新浪
    if (index==4) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _toUserName;
        
        extConfig.sinaData.shareText =_userInforRemark;
        
        //        extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_topicId];
        
 
        extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@",_toUserId];;
        [[UMSocialControllerService defaultControllerService] setShareText:_userInforRemark shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
    }
    // 空间
    if (index==5) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _toUserName;
        
        extConfig.tencentData.shareText = _userInforRemark;
        
        //        extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huati/%@",_objectId];
        
        extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@",_toUserId];;
        [[UMSocialControllerService defaultControllerService] setShareText:_userInforRemark shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // QQ
    if (index==6) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        
        extConfig.title = _toUserName;
        extConfig.qqData.shareText = _userInforRemark;
        
        //        extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huati/%@",_objectId];
        

            extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@",_toUserId];;
    
        [[UMSocialControllerService defaultControllerService] setShareText:_userInforRemark shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }


    
}




- (void)setUpButton:(id)sender {
    
    
    UserSettingViewController *userVC = [[UserSettingViewController alloc]init];
    userVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userVC animated:YES];
}


- (void)initializePageSubviews {
    
//    _allTableView = [UserInforAllTableView allTableView];
    _questionTableView = [UserInforQueTableView qusetionTableView];
    _columnTableView = [UserInforColumnTableView columnTableView];
//    _groupTableView = [UserInforGroupTableView groupTableView];
    _topicTableView = [UserInforTopicTableView topicTableView];
//    _collectionTableView = [UserInforCollectionTableView collectionTableView];
    
    _groupOtherTableView = [UserInforOtherGroupTableView otherGroupTableView];
    
//    _activityTableView = [UserInforActivityTableView activityTableView];
    
//    _allTableView.AllpushNextDelegate= self;
    _buttonArray = [NSMutableArray array];
    _classArray = @[@"动态",@"新农圈",@"活动",@"专栏",@"收藏"];
    for(int i = 0; i < 5; i++) {
        
        UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [segmentButton setBackgroundColor:[UIColor whiteColor]];
        [segmentButton setTitleColor:[UIColor grayColor]  forState:UIControlStateNormal];
        [segmentButton setTitleColor:[UIColor LkbBtnColor] forState:UIControlStateSelected];
        [segmentButton setTitle:[NSString stringWithFormat:@"%@",_classArray[i]] forState:UIControlStateNormal];
        segmentButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_buttonArray addObject:segmentButton];
    }
    
    
    
    _headerView.frame = CGRectMake(0, 0, kDeviceWidth, _headerViewHeight );
    _headerView.backgroundColor = [UIColor whiteColor];
    
    
    // 他人页面
    if ([_type isEqualToString:@"2"]) {
        
        NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<%ld",(long)_pagingheight);
        
        
        
//        _pagingView = [HHHorizontalPagingView pagingViewWithHeaderView:_headerView headerHeight:_pagingheight segmentButtons:_buttonArray segmentHeight:50 contentViews:@[_allTableView, _questionTableView, _columnTableView,_groupOtherTableView,_topicTableView,_collectionTableView]];
//        _pagingView = [HHHorizontalPagingView pagingViewWithHeaderView:_headerView headerHeight:_pagingheight segmentButtons:_buttonArray segmentHeight:50 contentViews:@[_allTableView,_groupOtherTableView,_activityTableView, _columnTableView,_collectionTableView]];
        
        [self.view addSubview:_pagingView];
        
        
        UIView * View = [[UIView alloc]initWithFrame:CGRectMake(0, KDeviceHeight -104, kDeviceWidth, 49)];
        
        View.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        View.alpha = 0.95;
        
        
        _chatButton = [[UIButton alloc]initWithFrame:CGRectMake(0, KDeviceHeight -109, kDeviceWidth /2 -0.5 , 49)];
        _chatButton.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        _chatButton.alpha = 0.95;
        [_chatButton setTitle:@"私信" forState:UIControlStateNormal];
        _chatButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_chatButton setTitleColor:CCCUIColorFromHex(0x888888) forState:UIControlStateNormal];
        [_chatButton addTarget:self action:@selector(chatButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth /2 -0.5, KDeviceHeight -94, 1, 19)];
        line.image =[UIImage imageNamed:@"foot_line"];
        
        
        _attentionButton = [[UIButton alloc]initWithFrame:CGRectMake( kDeviceWidth /2 +0.5 , KDeviceHeight-109 , kDeviceWidth /2, 49)];
        _attentionButton.alpha = 0.95;
        _attentionButton.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        _attentionButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        
        // 未关注
        if ([_ifAttention isEqualToString:@"1"]) {
            
            [_attentionButton setTitle:@"未关注" forState:UIControlStateNormal];
            [_attentionButton setTitleColor:CCCUIColorFromHex(0xf58e23) forState:UIControlStateNormal];
            _attentionButton.titleEdgeInsets = UIEdgeInsetsMake(0, _attentionButton.titleLabel.bounds.size.width -19, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
            
            [_attentionButton setImage:[UIImage imageNamed:@"tade_tab_icon_add"] forState:UIControlStateNormal];
            _attentionButton.imageEdgeInsets = UIEdgeInsetsMake(10,_attentionButton.titleLabel.bounds.size.width -25,10,_attentionButton.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
            
            
        }
        else {
            
            
            [_attentionButton setTitle:@"已关注" forState:UIControlStateNormal];
            [_attentionButton setTitleColor:CCCUIColorFromHex(0x888888) forState:UIControlStateNormal];
            _attentionButton.titleEdgeInsets = UIEdgeInsetsMake(0, _attentionButton.titleLabel.bounds.size.width -19, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
            
            [_attentionButton setImage:[UIImage imageNamed:@"tade_tab_icon_added"] forState:UIControlStateNormal];
            _attentionButton.imageEdgeInsets = UIEdgeInsetsMake(10,_attentionButton.titleLabel.bounds.size.width -25,10,_attentionButton.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
        }
        
        [_attentionButton addTarget:self action:@selector(attentionButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [_pagingView addSubview:View];
        [_pagingView addSubview:_chatButton];
        
        [_pagingView addSubview:line];
        
        [_pagingView addSubview:_attentionButton];
        
        
    }
    else {
        
        
        // 我的页面
        
//        _pagingView = [HHHorizontalPagingView pagingViewWithHeaderView:_headerView headerHeight:_pagingheight segmentButtons:_buttonArray segmentHeight:50 contentViews:@[_allTableView, _questionTableView, _columnTableView,_groupTableView,_topicTableView,_collectionTableView]];
//        _pagingView = [HHHorizontalPagingView pagingViewWithHeaderView:_headerView headerHeight:_pagingheight segmentButtons:_buttonArray segmentHeight:50 contentViews:@[_allTableView,_groupTableView,_activityTableView, _columnTableView,_collectionTableView]];

        [self.view addSubview:_pagingView];
        
        
    }
    
    
    
    __weak __typeof(self) weakSelf = self;
//    // 全部动态
//    [_allTableView addPullToRefreshWithActionHandler:^{
//        
//        [weakSelf fetchAllDataWithIsLoadingMore:NO];
//        
//    }];
//    [_allTableView addInfiniteScrollingWithActionHandler:^{
//        [weakSelf fetchAllDataWithIsLoadingMore:YES];
//    }];
//    
//    _allTableView.showsInfiniteScrolling = YES;
//    [_allTableView triggerPullToRefresh];
    
    
//    if (_allTableView.dataArray.count == 0) {
//        
//        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
//        self.allTableView.tableFooterView = footerVew;
//        self.allTableView.tableFooterView.hidden = YES;
//    }
    
    // 疑难解答
    [_questionTableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchQuestionDataWithIsLoadingMore:NO];
        
    }];
    [_questionTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchQuestionDataWithIsLoadingMore:YES];
    }];
    
    _questionTableView.showsInfiniteScrolling = YES;
    [_questionTableView triggerPullToRefresh];
    if (_questionTableView.dataArray.count == 0) {
        
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        self.questionTableView.tableFooterView = footerVew;
        self.questionTableView.tableFooterView.hidden = YES;
    }
    
    // 专栏
    [_columnTableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchInsightDataWithIsLoadingMore:NO];
        
    }];
    [_columnTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchInsightDataWithIsLoadingMore:YES];
    }];
    
//    if ([_type isEqualToString:@"2"])  {
//        self.requestParas = @{@"userId":_toUserId,
//                              @"ownerId":[[MyUserInfoManager shareInstance]userId],
//                              @"token":[[MyUserInfoManager shareInstance]token],
//                              };
//        
//        self.requestURL = LKB_Insight_features_Url;
//        
//    }
//    else {
//        
//        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
//                              @"ownerId":[[MyUserInfoManager shareInstance]userId],
//                              @"token":[[MyUserInfoManager shareInstance]token],
//                              };
//        
//        self.requestURL = LKB_Insight_features_Url;
//    }

    
    _columnTableView.showsInfiniteScrolling = YES;
    [_columnTableView triggerPullToRefresh];
    if (_columnTableView.dataArray.count == 0) {
        
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        self.columnTableView.tableFooterView = footerVew;
        self.columnTableView.tableFooterView.hidden = YES;
    }
    
//    // 新农圈（群组）我的
//    [_groupTableView addPullToRefreshWithActionHandler:^{
//        
//        [weakSelf fetchGroupDataWithIsLoadingMore:NO];
//        
//    }];
//    [_groupTableView addInfiniteScrollingWithActionHandler:^{
//        [weakSelf fetchGroupDataWithIsLoadingMore:YES];
//    }];
//    
//    _groupTableView.showsInfiniteScrolling = YES;
//    [_groupTableView triggerPullToRefresh];
//    if (_groupTableView.dataArray.count == 0) {
//        
//        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
//        self.groupTableView.tableFooterView = footerVew;
//        self.groupTableView.tableFooterView.hidden = YES;
//    }
    
    // 话题
    [_topicTableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [_topicTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    
    _topicTableView.showsInfiniteScrolling = YES;
    [_topicTableView triggerPullToRefresh];
    if (_topicTableView.dataArray.count == 0) {
        
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        self.topicTableView.tableFooterView = footerVew;
        self.topicTableView.tableFooterView.hidden = YES;
    }
    
//    // 收藏
//    [_collectionTableView addPullToRefreshWithActionHandler:^{
//        
//        [weakSelf fetchCollectionDataWithIsLoadingMore:NO];
//        
//    }];
//    [_collectionTableView addInfiniteScrollingWithActionHandler:^{
//        [weakSelf fetchCollectionDataWithIsLoadingMore:YES];
//    }];
//    
//    _collectionTableView.showsInfiniteScrolling = YES;
//    [_collectionTableView triggerPullToRefresh];
//    if (_collectionTableView.dataArray.count == 0) {
//        
//        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
//        self.collectionTableView.tableFooterView = footerVew;
//        self.collectionTableView.tableFooterView.hidden = YES;
//    }
//    
    // 新农圈 (群组)他的
    [_groupOtherTableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchGroupDataWithIsLoadingMore:NO];
        
    }];
    [_groupOtherTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchGroupDataWithIsLoadingMore:YES];
    }];
    
    _groupOtherTableView.showsInfiniteScrolling = YES;
    [_groupOtherTableView triggerPullToRefresh];
    if (_groupOtherTableView.dataArray.count == 0) {
        
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
//        self.groupTableView.tableFooterView = footerVew;
//        self.groupTableView.tableFooterView.hidden = YES;
    }
    
    // 活动列表
//    [_activityTableView addPullToRefreshWithActionHandler:^{
//        
//        [weakSelf fetchActivityDataWithIsLoadingMore:NO];
//        
//    }];
//    [_activityTableView addInfiniteScrollingWithActionHandler:^{
//        [weakSelf fetchActivityDataWithIsLoadingMore:YES];
//    }];
//    
//    _activityTableView.showsInfiniteScrolling = YES;
//    [_activityTableView triggerPullToRefresh];
//    if (_activityTableView.dataArray.count == 0) {
//        
//        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
//        self.activityTableView.tableFooterView = footerVew;
//        self.activityTableView.tableFooterView.hidden = YES;
//    }

    
    
}



- (void)chatButton:(id)sender {
    

    if ([_ifAttention isEqualToString:@"1"]) {
        // 未关注
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请先关注哦~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else {
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:_toUserId isGroup:NO];
        chatVC.title = [ToUserManager shareInstance].userName;
        
        chatVC.delelgate = self;
        [self.navigationController pushViewController:chatVC animated:YES];

    }
    
    
    
    
    
}


// 加入群组
- (void)pushAllObject:(NSString *)object type:(NSString *)type {
    
    
    NSLog(@"----------------------------%@",object);
    self.requestParas = @{@"groupId":object,
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token]
                          };
    self.requestURL = LKB_Group_Join_Url;
    
}


// 关注
- (void)attentionButton:(id)sender {
    
    
    if ([_attentionButton.titleLabel.text isEqualToString:@"未关注"]) {
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"attentedUser":_toUserId,
                              @"token":[MyUserInfoManager shareInstance].token
                              };
        self.requestURL = LKB_Attention_User_Url;
        
    }
    else {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"attentedUser":_toUserId,
                              @"token":[MyUserInfoManager shareInstance].token
                              };
        self.requestURL = LKB_UnAttention_User_Url;
        
    }
}

// 收藏
- (void)fetchCollectionDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    if ([_type isEqualToString:@"2"]) {
        self.requestParas = @{@"userId":_toUserId,
                              @"token":[[MyUserInfoManager shareInstance]token],
                              @"ownerId":[MyUserInfoManager shareInstance].userId,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              
                              };
        
        self.requestURL = LKB_ColumnInfo_Collection_Url;
        
    }
    else {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"token":[[MyUserInfoManager shareInstance]token],
                              @"ownerId":[MyUserInfoManager shareInstance].userId,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              
                              };
        
        self.requestURL = LKB_ColumnInfo_Collection_Url;
    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!isLoadingMore) {
//            
//            [_collectionTableView.pullToRefreshView stopAnimating];
//            
//        }
//        else {
//            
//            [_collectionTableView.infiniteScrollingView stopAnimating];
//            
//        }
//        
//        [_collectionTableView reloadData];
//        
//        
//    });
    
}


// 全部动态
- (void)fetchAllDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    if ([_type isEqualToString:@"2"]) {
        self.requestParas = @{@"userId":_toUserId,
                              @"ownerId":[MyUserInfoManager shareInstance].userId,
                              @"token":[MyUserInfoManager shareInstance].token,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              };
        self.requestURL = LKB_UserInfor_dynamic_Url;
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (!isLoadingMore) {
//                
//                [_allTableView.pullToRefreshView stopAnimating];
//            }
//            else {
//                
//                [_allTableView.infiniteScrollingView stopAnimating];
//            }
//            
//            [_allTableView reloadData];
//            
//            
//        });
        
        
    }
    else {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"ownerId":[MyUserInfoManager shareInstance].userId,
                              @"token":[MyUserInfoManager shareInstance].token,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              };
        self.requestURL = LKB_UserInfor_dynamic_Url;
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (!isLoadingMore) {
//                
//                [_allTableView.pullToRefreshView stopAnimating];
//            }
//            else {
//                
//                [_allTableView.infiniteScrollingView stopAnimating];
//            }
//            
//            [_allTableView reloadData];
//            
//            
//        });
        
        
    }
    
    
}

// 答疑
- (void)fetchQuestionDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    if ([_type isEqualToString:@"2"])  {
        self.requestParas = @{@"userId":_toUserId,
                              @"ownerId":[[MyUserInfoManager shareInstance]userId],
                              @"page":@(currPage),
                              @"token":[[MyUserInfoManager shareInstance]token],
                              isLoadingMoreKey:@(isLoadingMore)};
        
        self.requestURL = LKB_Question_Url;
        
        
    }
    else {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"ownerId":[[MyUserInfoManager shareInstance]userId],
                              @"page":@(currPage),
                              @"token":[[MyUserInfoManager shareInstance]token],
                              isLoadingMoreKey:@(isLoadingMore)};
        
        self.requestURL = LKB_Question_Url;
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            
            [_questionTableView.pullToRefreshView stopAnimating];
        }
        else {
            
            [_questionTableView.infiniteScrollingView stopAnimating];
        }
        
        [_questionTableView reloadData];
        
        
    });
    
    
    
    
    
}

// 专栏
- (void)fetchInsightDataWithIsLoadingMore:(BOOL)isLoadingMore
{
//    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
//    if (!isLoadingMore) {
//        currPage = 1;
//    } else {
//        ++ currPage;
//    }
    
    if ([_type isEqualToString:@"2"])  {
        self.requestParas = @{@"userId":_toUserId,
                              @"ownerId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token],
                              };
        
        self.requestURL = LKB_Insight_features_Url;
        
    }
    else {
        
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"ownerId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token],
                              };
        
        self.requestURL = LKB_Insight_features_Url;
        
        
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            
            [_columnTableView.pullToRefreshView stopAnimating];
            
        }
        else {
            
            [_columnTableView.infiniteScrollingView stopAnimating];
            
        }
        
        [_columnTableView reloadData];
        
        
    });
    
    
}


// 新农圈（群组）
- (void)fetchGroupDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    
    
    if ([_type isEqualToString:@"2"])  {
        
        self.requestParas =  @{@"userId":_toUserId,
                               @"ownerId":[[MyUserInfoManager shareInstance]userId],
                               @"page":@(currPage),
                               @"token":[[MyUserInfoManager shareInstance]token],
                               isLoadingMoreKey:@(isLoadingMore)};
        
        self.requestURL = LKB_MyGroup_List_Url;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!isLoadingMore) {
                
                [_groupOtherTableView.pullToRefreshView stopAnimating];
                
                
                
            }
            else {
                
                [_groupOtherTableView.infiniteScrollingView stopAnimating];
                
                
            }
            
            [_groupOtherTableView reloadData];
            
            
        });
        
        
    }
    else {
//        self.requestParas =  @{@"userId":[MyUserInfoManager shareInstance].userId,
//                               @"ownerId":[[MyUserInfoManager shareInstance]userId],
//                               @"page":@(currPage),
//                               @"token":[[MyUserInfoManager shareInstance]token],
//                               isLoadingMoreKey:@(isLoadingMore)};
//        
//        self.requestURL = LKB_MyGroup_List_Url;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (!isLoadingMore) {
//                
//                [_groupTableView.pullToRefreshView stopAnimating];
//                
//                
//                
//            }
//            else {
//                
//                [_groupTableView.infiniteScrollingView stopAnimating];
//                
//                
//            }
//            
//            [_groupTableView reloadData];
//            
//            
//        });
        
    }
}

//// 活动
//- (void)fetchActivityDataWithIsLoadingMore:(BOOL)isLoadingMore
//{
//    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
//    if (!isLoadingMore) {
//        currPage = 1;
//    } else {
//        ++ currPage;
//    }
//    
//    
//    
//    if ([_type isEqualToString:@"2"])  {
//        
//        self.requestParas =  @{@"userId":_toUserId,
//                               @"ownerId":[[MyUserInfoManager shareInstance]userId],
//                               @"page":@(currPage),
//                               @"token":[[MyUserInfoManager shareInstance]token],
//                               isLoadingMoreKey:@(isLoadingMore)};
//        
//        self.requestURL = LKB_Activity_Url;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (!isLoadingMore) {
//                
//                [_activityTableView.pullToRefreshView stopAnimating];
//            }
//            else {
//                
//                [_activityTableView.infiniteScrollingView stopAnimating];
//                
//                
//            }
//            
//            [_activityTableView reloadData];
//        });
//        
//        
//    }
//    else {
//        self.requestParas =  @{@"userId":[MyUserInfoManager shareInstance].userId,
//                               @"ownerId":[MyUserInfoManager shareInstance].userId,
//                               @"page":@(currPage),
//                               @"token":[[MyUserInfoManager shareInstance]token],
//                               isLoadingMoreKey:@(isLoadingMore)};
//        
//        self.requestURL = LKB_Activity_Url;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (!isLoadingMore) {
//                
//                [_activityTableView.pullToRefreshView stopAnimating];
//                
//                
//                
//            }
//            else {
//                
//                [_activityTableView.infiniteScrollingView stopAnimating];
//                
//                
//            }
//            
//            [_activityTableView reloadData];
//            
//            
//        });
//        
//    }
//    
//        
//}





- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    if ([_type isEqualToString:@"2"])  {
        self.requestParas = @{@"userId":_toUserId,
                              @"ownerId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token],
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              };
        
        self.requestURL = LKB_Topic_Url;
    }
    else {
        
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"ownerId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token],
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              };
        
        self.requestURL = LKB_Topic_Url;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            
            [_topicTableView.pullToRefreshView stopAnimating];
            
            
        }
        else {
            
            [_topicTableView.infiniteScrollingView stopAnimating];
            
        }
        [_topicTableView reloadData];
        
    });
}





- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
//    if (!request.isLoadingMore) {
//        [_allTableView.pullToRefreshView stopAnimating];
//    }
//    else {
//        [_allTableView.infiniteScrollingView stopAnimating];
//    }
    
    if (errorMessage) {
        //        [MBProgressHUD showError:errorMessage toView:self.view];
        return;
    }
    if ([request.url isEqualToString:LKB_User_Infor_Url]) {
        UserInforModel *userInfor = (UserInforModel *)parserObject;
        
        
        UserInforModellIntroduceModel *userInfor22 =userInfor.data;
        
        NSLog(@"~~~~~~~~~%@",userInfor22.remark);
        
        userInforDic = userInfor;
        _headerView.describeLabel.text = userInfor22.remark;
        
        _userAvatar = userInfor22.avatar;
        [_titleText setText:[NSString stringWithFormat:@"%@",userInfor22.userName]];
        
        _toUserName = userInfor22.userName;
        UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[userInfor22.avatar lkbImageUrl4]]];
        
        if ([userInfor22.avatar isEqualToString:@"" ] || userInfor22.avatar == nil) {
            [_headerView.headerImageButton setImage:YQNormalPlaceImage forState:UIControlStateNormal];
        }
        else {
            [_headerView.headerImageButton setImage:image forState:UIControlStateNormal];
        }
        if ([_type isEqualToString:@"2"]) {
            
            
            NSString *avtar =   [userInfor.data valueForKey:@"avatar"];
            
            
            if (avtar ==nil) {
                avtar = @"";
            }
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            [ToUserManager shareInstance].userName = [userInfor.data valueForKey:@"userName"];
            _toUserId = [userInfor.data valueForKey:@"userId"];
            
            NSDictionary *mydic = @{@"userName":[ToUserManager shareInstance].userName,
                                    @"userAvatar":avtar
                                    };
            NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
            [userDefaults setObject:dic  forKey:_toUserId];
            
        }
        
        _userInforRemark = userInfor22.remark;
        //       _headerView.describeLabel.text =@"99999999999999999999999999999999999999999966555555555555555%%%%%%%%%%%%$$$#@@@@@@@@@@@@@@@@@jjjjsjsjsjsjsjjjjfdksklfkfkkfjkdfgklgjesgjksdjglkdjgdfbghbrtbnrtbrtbrtbrtbrtbrtbsbdsbb@99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111";
        
        if (_headerView.describeLabel.text == nil) {
            _headerView.describeLabel.text = @"";
        }
        CGRect rect = [_headerView.describeLabel.text boundingRectWithSize:CGSizeMake(kDeviceWidth -20, KDeviceHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
        
        NSLog(@"********************************%f",rect.size.height);
        // 计算行数
        NSNumber *count =@( rect.size.height / _headerView.describeLabel.font.lineHeight);
        NSLog(@"共 %td 行", [count integerValue]);
        
        
        
        if(rect.size.height <120) {
            _headerView.OpenButton.hidden = YES;
            _headerViewHeight = rect.size.height +90  +10+35  ;
            
            if (rect.size.height < 20) {
                
                _pagingheight = 90+ 10 +rect.size.height;
            }
            else {
                _pagingheight = 90  +10+rect.size.height +60;
                
            }
            
        }
        else{
            _headerView.OpenButton.hidden = NO;
            
            _headerViewHeight = 130+90 +20;
            _pagingheight = 130+90 +40;
        }
        
        
        _ifAttention = userInfor22.ifAttention;
        
        
        [self initializePageSubviews];
//        [self headerViewAction];
        
        [_headerView configMyInforRecommCellWithModel:userInfor];

    }
    
    if ([request.url isEqualToString:LKB_UserInfor_dynamic_Url]) {
        
        UserInforDynamicModel *useInforModel = (UserInforDynamicModel *)parserObject;
//        if (!request.isLoadingMore) {
//            _allTableView.dataArray = [NSMutableArray arrayWithArray:useInforModel.data];
//        }else {
//            [_allTableView.dataArray addObjectsFromArray:useInforModel.data];
//        }
//        
//        NSLog(@"0---------------------%@",_allTableView.dataArray);
//        
//        
//        [_allTableView  reloadData];
//        
//        if (useInforModel.data.count == 0) {
//            
//            _allTableView.tableFooterView.hidden = NO;
//            [_allTableView.infiniteScrollingView endScrollAnimating];
//        } else {
//            _allTableView.showsInfiniteScrolling = YES;
//            [_allTableView.infiniteScrollingView beginScrollAnimating];
//            //               [_allTableView.pullToRefreshView stopAnimating];
//            
//        }
        
        
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
            
            _questionTableView.tableFooterView.hidden = NO;
            [_questionTableView.infiniteScrollingView endScrollAnimating];
        } else {
            _questionTableView.showsInfiniteScrolling = YES;
            [_questionTableView.infiniteScrollingView beginScrollAnimating];
        }
    }
    
    if ([request.url isEqualToString:LKB_Insight_features_Url]) {
        ColumnModel *columnModel = (ColumnModel *)parserObject;
        NSLog(@"《《《《《========%@===============",columnModel.data);
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        [arr addObject:columnModel.data];
    
        if (!request.isLoadingMore) {
            if(columnModel.data.count!=0&&columnModel!=nil)
            {
                _columnTableView.dataArray = [NSMutableArray arrayWithArray:arr];
            }
        }

        
        [_columnTableView reloadData];
    
}
    
    
    if ([request.url isEqualToString:LKB_MyGroup_List_Url]) {
        GroupModel *groupModel = (GroupModel *)parserObject;
        
        NSLog(@"---------------------%@",groupModel.data);
        
        if ([_type isEqualToString:@"2"]) {
            if (!request.isLoadingMore) {
                if(groupModel.data)
                {
                    _groupOtherTableView.dataArray = [NSMutableArray arrayWithArray:groupModel.data];
                    
                    GroupDetailModel * detailModel;
                    for (GroupDetailModel *model  in groupModel.data) {
                        
                        
                        if ([model.passStatus isEqualToString:@"0"]) {
                            
                            detailModel = model;
                            
                            [_groupOtherTableView.dataArray removeObject:detailModel];
                            
                        }
                        
                    }

                }
            } else {
                [_groupOtherTableView.dataArray addObjectsFromArray:groupModel.data];
                
                GroupDetailModel * detailModel;
                for (GroupDetailModel *model  in groupModel.data) {
                    
                    
                    if ([model.passStatus isEqualToString:@"0"]) {
                        
                        detailModel = model;
                        
                        [_groupOtherTableView.dataArray removeObject:detailModel];
                        
                    }
                    
                }
                
            }
            [_groupOtherTableView reloadData];
            
            if (groupModel.data.count == 0) {
                _groupOtherTableView.tableFooterView.hidden = NO;
                
                [_groupOtherTableView.infiniteScrollingView endScrollAnimating];
            } else {
                _groupOtherTableView.showsInfiniteScrolling = YES;
                [_groupOtherTableView.infiniteScrollingView beginScrollAnimating];
                [_groupOtherTableView.pullToRefreshView stopAnimating];
            }
            
            
        }
        else {
//            if (!request.isLoadingMore) {
//                if(groupModel.data)
//                {
//                    _groupTableView.dataArray = [NSMutableArray arrayWithArray:groupModel.data];
//                    
//                    GroupDetailModel * detailModel;
//                    for (GroupDetailModel *model  in groupModel.data) {
//                        
//                        
//                        if ([model.passStatus isEqualToString:@"0"]) {
//                            
//                            detailModel = model;
//                            
//                            [_groupTableView.dataArray removeObject:detailModel];
//                            
//                        }
//                        
//                    }
//                    
//
//                }
//            } else {
//                [_groupTableView.dataArray addObjectsFromArray:groupModel.data];
//                
//                GroupDetailModel * detailModel;
//                for (GroupDetailModel *model  in groupModel.data) {
//                    
//                    
//                    if ([model.passStatus isEqualToString:@"0"]) {
//                        
//                        detailModel = model;
//                        
//                        [_groupTableView.dataArray removeObject:detailModel];
//                        
//                    }
//                    
//                }
//                
//                
//            }
//            [_groupTableView reloadData];
//            
//            if (groupModel.data.count == 0) {
//                _groupTableView.tableFooterView.hidden = NO;
//                
//                [_groupTableView.infiniteScrollingView endScrollAnimating];
//            } else {
//                _groupTableView.showsInfiniteScrolling = YES;
//                [_groupTableView.infiniteScrollingView beginScrollAnimating];
//            }
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
            _topicTableView.tableFooterView.hidden = NO;
            
            [_topicTableView.infiniteScrollingView endScrollAnimating];
        } else {
            _topicTableView.showsInfiniteScrolling = YES;
            [_topicTableView.infiniteScrollingView beginScrollAnimating];
        }
        
    }
    
    if ([request.url isEqualToString:LKB_ColumnInfo_Collection_Url]) {
        
        CollectionModel *collectionModel = (CollectionModel *)parserObject;
        
//        NSLog(@"！！！！！！========%@===============",collectionModel.data);
//        if (!request.isLoadingMore) {
//            if(collectionModel.data)
//            {
//                _collectionTableView.dataArray = [NSMutableArray arrayWithArray:collectionModel.data];
//            }
//        } else {
//            [_collectionTableView.dataArray addObjectsFromArray:collectionModel.data];
//        }
//        [_collectionTableView reloadData];
//        if (collectionModel.data.count == 0) {
//            _collectionTableView.tableFooterView.hidden = NO;
//            
//            [_collectionTableView.infiniteScrollingView endScrollAnimating];
//        } else {
//            _collectionTableView.showsInfiniteScrolling = YES;
//            [_collectionTableView.infiniteScrollingView beginScrollAnimating];
//        }
        
    }
    
    if ([request.url isEqualToString:LKB_Attention_User_Url]) {
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        //        [self ShowProgressHUDwithMessage:Model.msg];
        
        [_attentionButton setTitle:@"已关注" forState:UIControlStateNormal];
        [_attentionButton setTitleColor:CCCUIColorFromHex(0x888888) forState:UIControlStateNormal];
        _attentionButton.titleEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
        
        [_attentionButton setImage:[UIImage imageNamed:@"tade_tab_icon_added"] forState:UIControlStateNormal];
        _attentionButton.imageEdgeInsets = UIEdgeInsetsMake(10,-30,10,0);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
        
        _ifAttention = @"0";
        

    }
    
    if ([request.url isEqualToString:LKB_UnAttention_User_Url]) {
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        //        [self ShowProgressHUDwithMessage:Model.msg];
        
        [_attentionButton setTitle:@"未关注" forState:UIControlStateNormal];
        [_attentionButton setTitleColor:CCCUIColorFromHex(0xf58e23) forState:UIControlStateNormal];
        _attentionButton.titleEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 6);//设置title在button上的位置（上top，左left，下bottom，右right）
        
        [_attentionButton setImage:[UIImage imageNamed:@"tade_tab_icon_add"] forState:UIControlStateNormal];
        _attentionButton.imageEdgeInsets = UIEdgeInsetsMake(10,- 30,10,0);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
        _ifAttention = @"1";
        
    }
    
    if ([request.url isEqualToString:LKB_Group_Join_Url]) {
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        
        NSLog(@"！！！！！！========%@===============",Model.msg);

        
        if ([Model.success isEqualToString:@"1"]) {
            
            [self ShowProgressHUDwithMessage:@"加群成功"];

        }
        
        
    }
    
//    if ([request.url isEqualToString:LKB_Activity_Url]) {
//        
//        ActivityModel *activityModel = (ActivityModel *)parserObject;
//        if (!request.isLoadingMore) {
//            
//            if(activityModel.data)
//            {
//                _activityTableView.dataArray = [NSMutableArray arrayWithArray:activityModel.data];
//            }
//
//        }else {
//            [_activityTableView.dataArray addObjectsFromArray:activityModel.data];
//        }
//        
//        NSLog(@"0---------------------%@",_activityTableView.dataArray);
//        
//        
//        [_activityTableView  reloadData];
//        
//        if (activityModel.data.count == 0) {
//            
//            _activityTableView.tableFooterView.hidden = NO;
//            [_activityTableView.infiniteScrollingView endScrollAnimating];
//        } else {
//            _activityTableView.showsInfiniteScrolling = YES;
//            [_activityTableView.infiniteScrollingView beginScrollAnimating];
//            //               [_allTableView.pullToRefreshView stopAnimating];
//            
//        }
//    }
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







- (void)headerViewAction {
    
    _pagingView.clickEventViewsBlock = ^(UIView *eventView){
        
        if (eventView == _headerView.headerImageButton ) {
            
            if ([_type isEqualToString:@"2"]) {
                
                OtherUserInforSettingViewController *otherVC = [[OtherUserInforSettingViewController alloc]init];
                
                otherVC.userId = _toUserId;
                
                [self.navigationController pushViewController:otherVC animated:YES];
                
            }
            else {
                
                UserInforSettingViewController* userInforVC = [[UserInforSettingViewController alloc]init];
                userInforVC.hidesBottomBarWhenPushed = YES;
                
                userInforVC.headerImg = [MyUserInfoManager shareInstance].avatar;
                userInforVC.attentionNum = @"1";
                [self.navigationController pushViewController:userInforVC animated:YES];
                
            }
            
            
            
        }
        
        if (eventView == _headerView.hadAttentionButton ) {
            
            PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
            peopleVC.requestUrl = LKB_Attention_Users_Url;
            peopleVC.VCType = @"1";
            peopleVC.hidesBottomBarWhenPushed = YES;
            if ([_type isEqualToString:@"2"]) {
                peopleVC.title = @"ta关注的人";
                peopleVC.userId = _toUserId;
                
            }
            else {
                peopleVC.title = @"我的关注";
                peopleVC.userId = [MyUserInfoManager shareInstance].userId;
                
            }
            [self.navigationController pushViewController:peopleVC animated:YES];
            
            
        }
        if (eventView == _headerView.beAttentionedButton ) {
            
            PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
            peopleVC.requestUrl = LKB_Attention_All_Fans_Url;
            peopleVC.VCType = @"2";

            peopleVC.hidesBottomBarWhenPushed = YES;
            if ([_type isEqualToString:@"2"]) {
                peopleVC.title = @"关注ta的人";
                peopleVC.userId = _toUserId;
                
            }
            else {
                peopleVC.title = @"我的粉丝";
                peopleVC.userId = [MyUserInfoManager shareInstance].userId;
                
            }
            [self.navigationController pushViewController:peopleVC animated:YES];
            
        }
        
        
        if (eventView == _headerView.attentionContentButton ) {
            
            // 我关注的内容
//            MyAttentionBaseViewController *peopleVC = [[MyAttentionBaseViewController alloc] init];
            
            
            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
            
        
//            if ([_type isEqualToString:@"2"]) {
//                peopleVC.userId = _toUserId;
//            }
//            else {
//                peopleVC.userId = [MyUserInfoManager shareInstance].userId;
//                
//            }
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
        }
        if (eventView == _headerView.describeLabel  || eventView == _headerView.OpenButton) {
            _headerView.describeLabel.text = _userInforRemark;
            
            
            
            CGRect rect = [_headerView.describeLabel.text boundingRectWithSize:CGSizeMake(kDeviceWidth, KDeviceHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
            
            if (rect.size.height > 130) {
                
                
                _headerView.isExpandedNow = !_headerView.isExpandedNow;
                
                if (!_headerView.isExpandedNow) {
                    _headerView.OpenButton .hidden = NO;
                    
                    [headerView2 removeFromSuperview];
                }
                else {
                    _headerView.OpenButton.hidden = NO;
                    
                    
                    _headerView.describeLabel.text = _userInforRemark;
                    
                    
                    CGRect rect = [_headerView.describeLabel.text boundingRectWithSize:CGSizeMake(kDeviceWidth, KDeviceHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
                    
                    
                    
                    NSLog(@"!!!!----------------------%f",rect.size.height);
                    _headerViewHeight = rect.size.height +66 + 90 +10;
                    
                    NSLog(@"~~~!!!!----------------------%f",_headerViewHeight);
                    
                    headerView2 = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, _headerViewHeight +10)];
                    headerView2.isExpandedNow = YES;
                    headerView2.backgroundColor = [UIColor whiteColor];
                    headerView2.alpha = 1;
                    [headerView2 configMyInforRecommCellWithModel:userInforDic];
                    
                    
                    
                    
                    
                    
                    
                    headerView2.describeLabel.text = _userInforRemark;
                    
                    
                    
                    headerView2.expandBlock = ^(BOOL isExpand) {
                        
                        [ headerView2 removeFromSuperview];
                        _headerView.isExpandedNow = NO;
                    };
                    
                    [self.view addSubview:headerView2];
                    headerView2.type = @"2";
                    if ([_type isEqualToString:@"2"]) {
                        [headerView2.hadAttentionButton setTitle:@"ta关注的人" forState:UIControlStateNormal];
                        [headerView2.beAttentionedButton setTitle:@"关注ta的人" forState:UIControlStateNormal];
               
                        
                    }
                    
                }
            }
            
            
        }
    };
    
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
