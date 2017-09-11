//
//  DiscoverCircleRootViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 7/21/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#define kColor(r , g ,b) [UIColor colorWithRed:(r)  green:(g)  blue:(b) alpha:1]
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#import "DiscoverCircleRootViewController.h"
#import "TYTabButtonPagerController.h"
#import "DiscoverActivityPageViewController.h"
#import "UserGroupViewController.h"
#import "MyUserInfoManager.h"
#import "AllGroupViewControllrt.h"
#import "CreatNewCircleViewController.h"


@interface DiscoverCircleRootViewController ()<TYPagerControllerDataSource,UserGroupViewControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) TYTabButtonPagerController *pagerController;
@property (strong, nonatomic) UIButton *creatCircleButton;

@property (nonatomic, weak) UIScrollView *contentScroll;
@property (nonatomic, weak) UIScrollView *titleScroll;
@property (nonatomic, weak) UIButton *selectBtn;
@property (nonatomic, strong) NSMutableArray *titleButton;
@property (strong, nonatomic) UIButton *publishButton;

@end
@implementation DiscoverCircleRootViewController

- (NSMutableArray *)titleButton
{
    if (_titleButton == nil) {
        _titleButton = [NSMutableArray array];
    }
    return _titleButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新农圈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self addPagerController];
    

    _creatCircleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_creatCircleButton setFrame:CGRectMake(0, 0, 60, 30)];
//    [_creatCircleButton sizeToFit];
    [_creatCircleButton setTitle:@"创建" forState:UIControlStateNormal];
    [_creatCircleButton setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
    
    //        [_publishButton setImage:[UIImage imageNamed:@"publish_Question"] forState:UIControlStateNormal];
    [_creatCircleButton addTarget:self action:@selector(creatCircle:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_creatCircleButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
    
    
    // 左键按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.contentScroll.contentSize = CGSizeMake(self.childViewControllers.count *kScreenW, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    // Do any additional setup after loading the view.
}




-(void)creatCircle:(id)sender
{
    CreatNewCircleViewController *creatCircleVc = [[CreatNewCircleViewController alloc]init];
    [self.navigationController pushViewController:creatCircleVc animated:YES];
}


-(void)backToMain
{
    [self.navigationController.navigationBar setClipsToBounds:NO];
    [self.navigationController popViewControllerAnimated:YES];
}







- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!_showNavBar) {
        self.navigationController.navigationBarHidden = YES;
    }
    
//    [self.navigationController setNavigationBarHidden:NO animated:animated];

    
    // 隐藏导航下的线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [MobClick beginLogPageView:@"DiscoverCircleRootViewController"];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (!_showNavBar) {
        self.navigationController.navigationBarHidden = NO;
    }
    

        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:nil];
        self.navigationController.navigationBar.translucent = YES;
    [MobClick endLogPageView:@"DiscoverCircleRootViewController"];

  
}


- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
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
    
    if (_showNavBar) {
        pagerController.progressWidth = _variable ? 0 : 10;
    }
    
    if ([_type isEqualToString:@"2"]) {
        [pagerController setCurIndex:1];

    }
    else {
        [pagerController setCurIndex:0];

    }
    
    pagerController.view.frame = self.view.bounds;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    _pagerController = pagerController;
}

- (void)scrollToRamdomIndex
{
    [_pagerController moveToControllerAtIndex:arc4random()%2 animated:NO];
}

#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController
{
    return 2;
}


- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    if (index == 0) {
        
        return @"我的圈";
    }
    else  {
        
        return @"圈推荐";
    }
    
    
    
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    if (index==0) {
        UserGroupViewController *pageVC = [[UserGroupViewController alloc]init];
        pageVC.therquestUrl =[[MyUserInfoManager shareInstance]userId];
        pageVC.circlerquestUrl =  LKB_MyGroup_List_Url;
        pageVC.topageDelegate = self;
        return pageVC;
    }else
    {
        AllGroupViewControllrt *pageVC = [[AllGroupViewControllrt alloc]init];
        pageVC.therquestUrl =[[MyUserInfoManager shareInstance]userId];
        pageVC.circlerquestUrl = LKB_ALLGroup_List_Url;
        pageVC.ifgrouptype  = @"1";
        return pageVC;
    }
    
    
}

-(void)turnTopage:(NSInteger)index
{
    [_pagerController moveToControllerAtIndex:1 animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
