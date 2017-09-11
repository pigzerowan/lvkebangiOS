//
//  PushGoodNewsViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/26.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "PushGoodNewsViewController.h"
#import "SVPullToRefresh.h"
#import "PushGoodNewsCell.h"
#import "LoveTableFooterView.h"
#import "MyUserInfoManager.h"
#import "GoodNoticeCell.h"
#import "NewUserMainPageViewController.h"
#import "OutWebViewController.h"
static NSString* PushGoodNewsCellIdentifier = @"PushGoodNewsCellIdentifier";

@interface PushGoodNewsViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UIImageView *navBarHairlineImageView;
}

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@end

@implementation PushGoodNewsViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
        navBarHairlineImageView.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =@"消息";
    
    // 左键按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    
    
    
    
    NSString * noticeType = [NSString stringWithFormat:@"LoginHomeViewController"];
    
    NSString *str = [userDefaultes objectForKey:noticeType];
    
    if ([str isEqualToString:@"isNewLogin"]) {
        
        _dataArray = [[userDefaultes arrayForKey:@"isNewLoginModel"] mutableCopy];
        [userDefaultes setObject:@"isLogin" forKey:noticeType];

    }
    else {
        
        _dataArray  = [[userDefaultes arrayForKey:@"theGoodArr"] mutableCopy];

    }
    [self.view addSubview:self.tableView];


    
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:nil forKey:@"theGoodArr"];
    
    [userDefault setObject:nil forKey:@"isNewLoginModel"];
    
    
    NSString *KeyStr = [NSString stringWithFormat:@"New%@",[MyUserInfoManager shareInstance].userId];

    [userDefault setObject:@"isRead" forKey:KeyStr];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1 ;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    return 78;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return CGFLOAT_MIN;
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    PushGoodNewsCell* goodsCell = [tableView dequeueReusableCellWithIdentifier:PushGoodNewsCellIdentifier];
    
    NSDictionary *dic = _dataArray[indexPath.row];
    
    NSLog(@"=====================%@",dic);
    
    
    
    [goodsCell configPushGoodNewsCell:dic];
    
    [goodsCell PushGoodNewshandlerButtonAction:^(NSInteger clickIndex) {
        
        if (clickIndex == 1) {
            
            
            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
            peopleVC.type = @"2";
            peopleVC.toUserId =[dic valueForKey:@"userId"];
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
        }
    }];
    
    goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [goodsCell setNeedsUpdateConstraints];
    [goodsCell updateConstraintsIfNeeded];

//    [goodsCell configxinChuangTableCellWithGoodModel:model];
    return goodsCell;
}


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = _dataArray[indexPath.row];

    NSString * _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,[dic valueForKey:@"objId"],[dic valueForKey:@"groupId"]];
    
    NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];
    
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    
    outSideWeb.sendMessageType = @"2";
    outSideWeb.rightButtonType = @"2";
    outSideWeb.VcType = @"1";// 圈子动态
    outSideWeb. urlStr =_linkUrl;
    outSideWeb.htmlStr = _linkUrl;
    outSideWeb.circleId = [dic valueForKey:@"groupId"];// 圈id
    outSideWeb.circleDetailId = [dic valueForKey:@"objId"];// 圈详情id
    outSideWeb.objectId = [dic valueForKey:@"objId"];// 圈详情id
    
    outSideWeb.mytitle = [dic valueForKey:@"noticeContent"];
    outSideWeb.describle = [dic valueForKey:@"groupId"];
    outSideWeb.userAvatar = [dic valueForKey:@"groupId"];
//    outSideWeb.isAttention = insight.isAttention;
    outSideWeb.commendVcType = @"1";// 评论一级页面
//    outSideWeb.groupAvatar = insight.cover;
    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];

    
    
}

- (void)actionFetchRequest:(YQRequestModel*)request result:(LKBBaseModel*)parserObject
              errorMessage:(NSString*)errorMessage
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
}

#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[PushGoodNewsCell class] forCellReuseIdentifier:PushGoodNewsCellIdentifier];
        
    }
    return _tableView;
}



@end
