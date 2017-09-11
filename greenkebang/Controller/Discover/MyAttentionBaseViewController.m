//
//  MyAttentionBaseViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 4/5/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "MyAttentionBaseViewController.h"
#import "MyAttentionSeperateViewController.h"
#import "MyAttentionSeperateTopicViewController.h"
#import "TYTabButtonPagerController.h"

@interface MyAttentionBaseViewController ()<TYPagerControllerDataSource>

@property (nonatomic, strong) TYTabButtonPagerController *pagerController;


@end
@implementation MyAttentionBaseViewController
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
    self.title = @"关注的内容";
    self.view.backgroundColor =  CCCUIColorFromHex(0xeeeeee);
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self addPagerController];

    


    
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    
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
    
    pagerController.progressWidth = _variable ? 0 : 10;

    [pagerController setCurIndex:0];
    
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
        
        return @"专栏";
    }
    else  {
        
        return @"新农圈";
    }
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    if (index==0) {
        MyAttentionSeperateViewController *timeQAVC =[[MyAttentionSeperateViewController alloc] init];
        timeQAVC.userId = _userId;
        return timeQAVC;
    }else
    {
        MyAttentionSeperateTopicViewController *discoveryRecommVC = [[MyAttentionSeperateTopicViewController alloc] init];
        discoveryRecommVC.userId = _userId;
        return discoveryRecommVC;
        
    }
}

-(void)turnTopage:(NSInteger)index
{
    [_pagerController moveToControllerAtIndex:1 animated:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
    
}

@end
