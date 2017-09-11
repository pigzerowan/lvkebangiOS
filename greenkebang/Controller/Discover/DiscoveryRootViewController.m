//
//  DiscoveryRootViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 8/26/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "DiscoveryRootViewController.h"
#import "DiscoverIntoViewController.h"
#import "SDCycleScrollView.h"
#import "BannerModel.h"
#import "InsightDetailViewController.h"
#import "QADetailViewController.h"
#import "YQWebDetailViewController.h"
#import "NSStrUtil.h"
#import "SearchRootViewController.h"
#import "DiscoverHoeStandingViewController.h"
#import "DiscoverActivityViewController.h"
#import "FarmerCircleViewController.h"
#import "OutWebViewController.h"
#import "WFDetailController.h"
#import "DiscoverCircleRootViewController.h"
#import "MyAttentionSeperateViewController.h"
#import "XinChuangListViewController.h"
#import "DiscoverAllArticViewController.h"
#import "SelectedRecommendViewController.h"
#import "PaySystemViewController.h"
#import "CreatNewCircleViewController.h"
#import "TranceApplyViewController.h"
#import "YanzhengModel.h"
#import "ShareArticleManager.h"
#import "MemberApplyVC.h"
#import "ColumnArticleListViewController.h"
#import "TabbarManager.h"
#import "TYTabButtonPagerController.h"
#import "DiscoverFeaturedViewController.h"

static NSString* eeCellIdentifier = @"DisCoverCellIdentifier";
@interface DiscoveryRootViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,UIGestureRecognizerDelegate,TYPagerControllerDataSource>
{
    UIImageView *leadImg;
    UIImageView *nextImg;
}

@property (strong, nonatomic) NSArray *classArray;
@property (strong, nonatomic) UIView *rootView;
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) UIView* showMyImgeView;
@property (strong, nonatomic) UIView* nextView;
@property (strong, nonatomic) SDCycleScrollView* cycleScrollView;
@property (strong, nonatomic) UIImageView* imageView;
@property(strong,nonatomic)NSMutableArray *bannerArray;
@property(strong,nonatomic)UILabel *chuheLabel;
@property (nonatomic, strong) TYTabButtonPagerController *pagerController;


@end

@implementation DiscoveryRootViewController


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
    
//    _classArray = @[@"新农圈",@"绿科秀",@"专栏",@"锄禾说",@"星创学堂"];
    
    
    _bannerArray = [NSMutableArray array];
    
    [self judgeShowIntroView2];
    self.tableView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
//    _classArray = @[@"新农圈",@"绿科秀",@"专栏",@"交易系统"];
    
    _classArray = @[@"精选",@"活动"];

    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(-10, 10, 20, 20)];
    [searchButton setImage:[UIImage imageNamed:@"Discover_search_nor"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    
    
//    __block DiscoveryRootViewController/*主控制器*/ *weakSelf = self;
//    
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
//    
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//        [weakSelf refreshtablview];
//    });
    
    
    
    
    
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token]
                          
                          
                          };
    self.requestURL = LKB_ALL_FIND_COVER;
    
//    [self initializePageSubviews];
    
    [self addPagerController];


}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _pagerController.view.frame = self.view.bounds;
}


- (void)addPagerController
{
    TYTabButtonPagerController *pagerController = [[TYTabButtonPagerController alloc]init];
    pagerController.dataSource = self;
    pagerController.adjustStatusBarHeight = YES;
    pagerController.cellWidth = SCREEN_WIDTH / 2 -10;
    pagerController.cellSpacing = 8;
    pagerController.barStyle = _variable ? TYPagerBarStyleProgressBounceView: TYPagerBarStyleProgressView;
    [pagerController setCurIndex:0];
    pagerController.progressWidth = _variable ? 0 : 10;
    pagerController.view.frame = self.view.bounds;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    _pagerController = pagerController;
    
    
}

- (void)scrollToRamdomIndex
{
    [_pagerController moveToControllerAtIndex:arc4random()%2 animated:NO];
}


- (NSInteger)numberOfControllersInPagerController
{
    return 2;
}


- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    if (index == 0) {
        
        return @"精选";
    }
    else {
        return  @"活动";
    }
    
    
}


- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    
    if (index ==0) {
        
        
        DiscoverFeaturedViewController *featuredVC =[[DiscoverFeaturedViewController alloc] init];
        return featuredVC;
    }
    else {
        DiscoverActivityViewController *activityVC = [[DiscoverActivityViewController alloc] init];
        return activityVC;
    }
    
}










-(void)refreshtablview

{
    [_tableView reloadData];
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



#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = ({
        
        if (iPhone5) {
            
            _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth, 143) imageURLsGroup:_bannerArray];
            
            
        }
        else if (iPhone6p) {
            
            _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth, 185) imageURLsGroup:_bannerArray];
            
        }
        else {
            
            _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth, 168) imageURLsGroup:_bannerArray];
        }
        _cycleScrollView.delegate = self;
        _cycleScrollView;
        
    });
    
}



//- (void)search:(id)sender {
//
//
//    SelectedRecommendViewController * selectVC = [[SelectedRecommendViewController alloc]init];
//
//    selectVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:selectVC animated:YES];
//}



- (void)searchAction:(id)sender {
    
    
    SearchRootViewController * searchVC = [[SearchRootViewController alloc]init];
    
    searchVC.hidesBottomBarWhenPushed =YES;
    
    //    [self.navigationController.navigationBar setBarTintColor:[UIColor LkbBtnColor]];
    //    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    
    [self.navigationController pushViewController:searchVC animated:YES];
    
}




- (void)judgeShowIntroView2
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if ([userInfo floatForKey:iYQUserVersionKey] < iYQUserVersion) {
        _rootView = self.navigationController.view;
        [self showIntroWithCustomView2];
    }
    [userInfo setFloat:iYQUserVersion forKey:iYQUserVersionKey];
    [userInfo synchronize];
}

-(void)showIntroWithCustomView2
{
    leadImg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    leadImg.image = [UIImage imageNamed:@"ios-2"];
    [[UIApplication sharedApplication].keyWindow addSubview:leadImg];
    UITapGestureRecognizer *tapReconginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPress:)];
    leadImg.userInteractionEnabled = YES;
    [leadImg addGestureRecognizer:tapReconginzer];
}



- (void)tapPress:(UITapGestureRecognizer *)sender {
    
    [leadImg removeFromSuperview];
    
    nextImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, KDeviceHeight)];
    nextImg.image = [UIImage imageNamed:@"ios-4"];
    [[UIApplication sharedApplication].keyWindow addSubview:nextImg];
    UITapGestureRecognizer *tapReconginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextPress:)];
    nextImg.userInteractionEnabled = YES;
    [nextImg addGestureRecognizer:tapReconginzer];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    
    if ([request.url isEqualToString:LKB_ALL_FIND_COVER]) {
        BannerModel *groupModel = (BannerModel *)parserObject;
        
        
        NSLog(@"----------------------------------------------%@",groupModel.data);
        
        NSArray *bannerArray = [NSMutableArray arrayWithArray:groupModel.data];
        
        for ( int i=0; i<bannerArray.count; i++) {
            BannerDetailModel *model = (BannerDetailModel *)bannerArray[i];
            [_bannerArray addObject:model];
        }
        _cycleScrollView.imageURLsGroup =_bannerArray;
        //        [self.tableView reloadData];
    }
    
    if ([request.url isEqualToString:LKB_jiaoyiValidate_Url]){
        
        YanzhengModel *Model = (YanzhengModel *)parserObject;
         YanzhengDetailModel *yanzhengmodel = Model.data;
        NSLog(@"！！！！！！========%@===============",Model.msg);
        
        
        if ([Model.msg isEqualToString:@"需要进行绿科邦交易系统会员申请！"]) {
            
            
            
            if ([MyUserInfoManager shareInstance].mobile&&[MyUserInfoManager shareInstance].mobile.length!=0) {
                TranceApplyViewController * applyVC = [[TranceApplyViewController alloc]init];
                applyVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:applyVC animated:YES];
            }
            else
            {
                NSString *userkey = [NSString stringWithFormat:@"updatemall%@",[MyUserInfoManager shareInstance].userId];
                
                NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
                
                NSString *telephone =[Defaults objectForKey:userkey];
                
                
                if (telephone&&telephone.length!=0) {
                    TranceApplyViewController * applyVC = [[TranceApplyViewController alloc]init];
                    applyVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:applyVC animated:YES];
                    
//                    [self ShowProgressHUDwithMessage:[[MyUserInfoManager shareInstance]mobile]];                    
                }else
                {
                    MemberApplyVC * applyVC = [[MemberApplyVC alloc]init];
                    applyVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:applyVC animated:YES];
                    
                }
            }
            
            
            
            
//            TranceApplyViewController *outSideWeb = [[TranceApplyViewController alloc]init];
//            
//            outSideWeb.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:outSideWeb animated:YES];
  
        }
        
        else
        {
        if ([yanzhengmodel.status isEqualToString:@"2"]) {
            

            if ([MyUserInfoManager shareInstance].mobile&&[MyUserInfoManager shareInstance].mobile.length!=0) {
                TranceApplyViewController * applyVC = [[TranceApplyViewController alloc]init];
                applyVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:applyVC animated:YES];
            }
            else
            {
                NSString *userkey = [NSString stringWithFormat:@"updatemall%@",[MyUserInfoManager shareInstance].userId];
                
                NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
                
                NSString *telephone =[Defaults objectForKey:userkey];
                
                
                if (telephone&&telephone.length!=0) {
                    TranceApplyViewController * applyVC = [[TranceApplyViewController alloc]init];
                    applyVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:applyVC animated:YES];
                    
                    [self ShowProgressHUDwithMessage:[[MyUserInfoManager shareInstance]mobile]];
                    
                }else
                {
                    MemberApplyVC * applyVC = [[MemberApplyVC alloc]init];
                    applyVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:applyVC animated:YES];
                    
                }
            }
            

            
        }else if ([yanzhengmodel.status isEqualToString:@"0"])
        {
            
            [self ShowProgressHUDwithMessage:Model.msg];
            
        }else
        {
//            if ([yanzhengmodel.lkbId isEqualToString:@"0"]) {
//                [self ShowProgressHUDwithMessage:Model.msg];
//
//            }else
//            {
//                [MyUserInfoManager shareInstance].lkbId=yanzhengmodel.lkbId;
//                
//                NSString *userNameStr;
//                
//                if ([NSStrUtil isEmptyOrNull:[[MyUserInfoManager shareInstance]mobile]]) {
//                    userNameStr = [[MyUserInfoManager shareInstance]email];
//                }else
//                {
//                    userNameStr = [[MyUserInfoManager shareInstance]mobile];
//                }
//                
//                
            
                
//                NSDictionary *jiaoyiDic = @{@"token":yanzhengmodel.mallToken,
//                                            };

                
//                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Mall_lOGIN_Url parameters:jiaoyiDic success:^(id parserObject) {
//                    
//                    NSLog(@"******%@",parserObject);
            
             
                        
                        PaySystemViewController * payVC = [[PaySystemViewController alloc]init];
                        payVC.mallUrl = [NSString stringWithFormat:@"http://mall.lvkebang.cn/login/app/login.jhtml?token=%@",yanzhengmodel.mallToken];
            
            // f340e87fe9964cf7bcd41507603d7a33
                        
                        payVC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:payVC animated:YES];
         
         
                    
//                    
//                } failure:^(NSString *errorMessage) {
//                    
//                    [self ShowProgressHUDwithMessage:errorMessage];
//                }];
//                

            }
            
        }
            
        }
//    }

    
    
    
}

#pragma mark -SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView*)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    BannerDetailModel* simpleGood = _bannerArray[index];
    
    NSLog(@"=========================%@",simpleGood);
    
    
    NSString* urlStr = [NSString stringWithFormat:@"%@%@",@"http://www.lvkebang.cn",simpleGood.coverLink];
    
    
    
    if ([urlStr rangeOfString:@"jianjie"].location!=NSNotFound ) {
        //        simpleGood *topic = (NewInsightModel *)_dataArray[indexPath.row];
        NSArray *strarray = [urlStr componentsSeparatedByString:@".h"];
        NSString *str = strarray[0];
        
        NSArray *strarray2 = [str componentsSeparatedByString:@"e/"];
        NSString *idStr = strarray2[1];
        
        NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,idStr] ;
        
        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        outSideWeb.sendMessageType = @"1";
        outSideWeb.rightButtonType = @"2";
        outSideWeb.VcType = @"2";// 专栏
        outSideWeb.circleDetailId = idStr;// 文章Id
        outSideWeb.replyNum = simpleGood.replyNum;
        outSideWeb.featureId = simpleGood.featureId;
        outSideWeb.couAvatar = simpleGood.featureAvatar;
        outSideWeb.mytitle = simpleGood.title;
        outSideWeb.groupAvatar = simpleGood.cover;
        
        [ShareArticleManager shareInstance].shareType = @"1";
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];
        
    }
    else  if ([urlStr rangeOfString:@"wenda"].location!=NSNotFound ) {
        
        
        
    }
    else  if ([urlStr rangeOfString:@"huati"].location!=NSNotFound ) {
        
    }
    else  if ([urlStr rangeOfString:@"huodong"].location!=NSNotFound ) {
        // 活动
        // 活动
//        NSArray *strarray = [urlStr componentsSeparatedByString:@".h"];
//        NSString *str = strarray[0];
//        
//        NSArray *strarray2 = [str componentsSeparatedByString:@"a/"];
//        NSString *idStr = strarray2[1];
        
        NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/"];
        NSString * idStr = [urlStr substringFromIndex: jianjie.length];
        NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/activity/%@",LKB_WSSERVICE_HTTP,idStr];
        
        
        
        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        //    outSideWeb.sendMessageType = @"2";
        outSideWeb.rightButtonType = @"1";
        //    outSideWeb.objectId = attentionModel.myId;
        //    outSideWeb.isAttention = insight.isAttention;
        outSideWeb.VcType = @"7";
        outSideWeb.circleDetailId = idStr;
        outSideWeb.mytitle = @"活动详情";
        //        outSideWeb.columnAvatar = attentionModel.img;
        [ShareArticleManager shareInstance].shareType = @"1";
        
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];
        
    }
    
    
    else
    {
        YQWebDetailViewController* webDetailVC = [[YQWebDetailViewController alloc] init];
        webDetailVC.urlStr = urlStr;
        webDetailVC.mytitle = simpleGood.title;
        webDetailVC.coverUrl = simpleGood.coverUrl;
        webDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webDetailVC animated:YES];
    }
    
}
#pragma mark - Private methods
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"DiscoveryRootViewController"];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setClipsToBounds:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBarTintColor:CCCUIColorFromHex(0x323436)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [ShareArticleManager shareInstance].shareType = nil;
    
    [TabbarManager shareInstance].vcType = @"2";

    [MobClick beginLogPageView:@"DiscoveryRootViewController"];

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    if (_classArray.count==4) {
        return 4;
    }else
    {
        return 3;
    }
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        return 1;
    }else if(section==1)
    {
        return 1;
    }
    else if(section==2)
    {
        return 1;
    }
    
    else
        return 1;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (iPhone5) {
        return 10;
    }
    else {
        
        
        return 15;
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:eeCellIdentifier];
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eeCellIdentifier];
    }
    else{
        // 避免cell重叠
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    UIImageView *rightImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27,19,6, 10.5)];
    rightImage.image = [UIImage imageNamed:@"icon_arrow_r"];
    
    [cell.contentView addSubview:rightImage];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(42, 17, kDeviceWidth - 22, 15)];
    
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = CCCUIColorFromHex(0x333333);
    [cell.contentView addSubview:titleLabel];
    
    
    UIImageView * headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(14, 16, 18, 18)];
    
    [cell.contentView addSubview:headerImage];


    
    if (indexPath.section==0) {
        // 新农圈
        titleLabel.text = _classArray[indexPath.row];
        headerImage.image = [UIImage imageNamed:@"Discover_newFarmer"];
    }else if(indexPath.section==1)
    {
        // 活动
        titleLabel.text = _classArray[indexPath.row+1];
        headerImage.image = [UIImage imageNamed:@"discover_Event"];
        
    }
    else if(indexPath.section==2)
    {
        // 专栏
        titleLabel.text = _classArray[indexPath.row+2];
        headerImage.image = [UIImage imageNamed:@"Discover_column"];
        
    }
//        else if(indexPath.section==3)
//    {
//        
//        titleLabel.text = _classArray[indexPath.row+3];
//        _chuheLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth -  150, 11, 120, 25)];
//        _chuheLabel.textAlignment = NSTextAlignmentRight;
//        _chuheLabel.textColor = CCCUIColorFromHex(0x999999);
//        _chuheLabel.font = [UIFont systemFontOfSize:12];
//        if (indexPath.row == 0) {
//            // 锄禾说
//            _chuheLabel.text = @"为你精心定制好文";
//            [cell.contentView addSubview:_chuheLabel];
//            headerImage.image = [UIImage imageNamed:@"Discover_chuhe"];
//            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 46, SCREEN_WIDTH, 0.5)];
//            lineView.backgroundColor =UIColorWithRGBA(237, 238, 239, 1);
//            [cell.contentView addSubview:lineView];
//        }
//        if (indexPath.row == 1) {
//            _chuheLabel.text = @"趣味课堂学本领";
//            headerImage.image = [UIImage imageNamed:@"Discover_school"];
//        }
//        [cell.contentView addSubview:_chuheLabel];
//    }
    
    
    
    
    else
    {
        
        titleLabel.text = @"交易系统";
        headerImage.image = [UIImage imageNamed:@"pay_system"];
        
    }
    // cell 点击时候的颜色
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = CCCUIColorFromHex(0xf0f1f2);
    cell.textLabel.font =  [UIFont systemFontOfSize:13];
    
    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        // 新农圈
        DiscoverCircleRootViewController * activityVC = [[DiscoverCircleRootViewController alloc]init];
        activityVC.showNavBar = YES;
        
        activityVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:activityVC animated:YES];
        
    }
    
    if (indexPath.section==1) {
        // 活动
        DiscoverActivityViewController * activityVC = [[DiscoverActivityViewController alloc]init];
        activityVC.showNavBar = YES;
        
        activityVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:activityVC animated:YES];
        
    }
    if (indexPath.section == 2) {
        
        // 专栏
//        DiscoverAllArticViewController *timeQAVC =[[DiscoverAllArticViewController alloc] init];
//        timeQAVC.VCtype = @"1";
//        timeQAVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:timeQAVC animated:YES];
        
        ColumnArticleListViewController * columnVC = [[ColumnArticleListViewController alloc]init];
        columnVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:columnVC animated:YES];

        
    }
    
    
    if (indexPath.section == 3) {
        
        
//        if ([MyUserInfoManager shareInstance].mobile&&[MyUserInfoManager shareInstance].mobile.length!=0) {
//            MemberApplyVC * applyVC = [[MemberApplyVC alloc]init];
//            applyVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:applyVC animated:YES];
//        }
//        else
//        {
//        NSString *userkey = [NSString stringWithFormat:@"updatemall%@",[MyUserInfoManager shareInstance].userId];
//        
//        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
//
//        NSString *telephone =[Defaults objectForKey:userkey];
//        
//        
//        if (telephone&&telephone.length!=0) {
//            MemberApplyVC * applyVC = [[MemberApplyVC alloc]init];
//            applyVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:applyVC animated:YES];
//            
//            [self ShowProgressHUDwithMessage:[[MyUserInfoManager shareInstance]mobile]];
//            
//        }else
//        {
//            MemberApplyVC * applyVC = [[MemberApplyVC alloc]init];
//            applyVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:applyVC animated:YES];
//
//        }
//        }
        
//        if ([[[MyUserInfoManager shareInstance]lkbId] isEqualToString:@"0"]) {
        
            self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                  
                                  @"token":[[MyUserInfoManager shareInstance]token]
                                  
                                  };
            self.requestURL = LKB_jiaoyiValidate_Url;

//        }
//        
//        
//        else{
        
        
//        NSString *userNameStr;
//        
//        if ([NSStrUtil isEmptyOrNull:[[MyUserInfoManager shareInstance]mobile]]) {
//            userNameStr = [[MyUserInfoManager shareInstance]email];
//        }else
//        {
//            userNameStr = [[MyUserInfoManager shareInstance]mobile];
//        }
            
            
//            if (!userNameStr) {
//                self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
//                                      
//                                      @"token":[[MyUserInfoManager shareInstance]token]
//                                      
//                                      };
//                self.requestURL = LKB_jiaoyiValidate_Url;
//            }
            
//else
//{
//    
//        NSDictionary *jiaoyiDic = @{@"userName":userNameStr,
//                                    };
//        
//        
//        
//        [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_jiaoyi_Url parameters:jiaoyiDic success:^(id parserObject) {
//            
//            NSLog(@"******%@",parserObject);
//            
//            LKBBaseModel *mydic = (LKBBaseModel *)parserObject;
//            NSString *jiaoyiType = mydic.type;
//            
//            if ([jiaoyiType isEqualToString:@"3"]) {
//
//                PaySystemViewController * payVC = [[PaySystemViewController alloc]init];
//                
//                payVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:payVC animated:YES];
//                
//            }else
//            {
//                
//                if ([jiaoyiType isEqualToString:@"0"]) {
//                    
//                    [XHToast showTopWithText:@"非常抱歉,交易系统无此用户,请联系系统管理员." topOffset:60.0];
//                }else
//                {
//                     [XHToast showTopWithText:@"非常抱歉，目前交易系统只对买家会员开放，您现在是绿科邦管理员/卖家会员/经纪人会员." topOffset:60.0];
//                }
//                
//                
//
//              
//            }
//            
//
//            
//        } failure:^(NSString *errorMessage) {
//            
//            [self ShowProgressHUDwithMessage:errorMessage];
//        }];
//        
//
//        }
//        }
//    }
//    
    
    
//    if (indexPath.section==3){
//        
//        if (indexPath.row == 0) {
//            // 锄禾说
//            DiscoverHoeStandingViewController *HoeStandingVC = [[DiscoverHoeStandingViewController alloc]init];
//            HoeStandingVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:HoeStandingVC animated:YES];
//            
//        }
//        else {
//            
//            // 星创学堂
//            XinChuangListViewController *HoeStandingVC = [[XinChuangListViewController alloc]init];
//            HoeStandingVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:HoeStandingVC animated:YES];
//            
//            
//        }
//        
//    }
}
}


- (void)nextPress:(UITapGestureRecognizer *)sender {
    
    [nextImg removeFromSuperview];
}
- (void)didTouchView {
    _showMyImgeView.hidden = YES;
    _nextView.hidden = YES;
    _imageView.hidden = YES;
}



#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.rowHeight = 140;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:eeCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    return _tableView;
}
- (UIView*)showMyImgeView
{
    if (!_showMyImgeView) {
        _showMyImgeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _showMyImgeView.backgroundColor = [UIColor whiteColor];
        _showMyImgeView.alpha = 0.5;
    }
    return _showMyImgeView;
}

- (UIView*)nextView
{
    if (!_nextView) {
        _nextView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-150, SCREEN_HEIGHT/2-150, 300, 300)];
        _nextView.backgroundColor = [UIColor whiteColor];
    }
    return _nextView;
}

- (UIImageView*)imageView
{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-130, SCREEN_HEIGHT/2-130, 260, 260)];
        _imageView.image = [UIImage imageNamed:@"qc_app_link"];
    }
    return _imageView;
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
