//
//  LKBUserBaseTabbarController.m
//  greenkebang
//
//  Created by 郑渊文 on 9/9/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "LKBUserBaseTabbarController.h"
#import "DiscoveryRootViewController.h"
#import "TalkRootViewController.h"
#import "TimeRootViewController.h"
#import "UserRootViewController.h"
#import "LKBBaseNavigationController2.h"
#import "HisGroupViewController.h"
#import "HisQAViewController.h"
#import "HisTalkViewController.h"
#import "HisThinkViewController.h"
@interface LKBUserBaseTabbarController ()

@end

@implementation LKBUserBaseTabbarController
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
    
    HisTalkViewController *talkRootVC = [[HisTalkViewController alloc] init];
    talkRootVC.navigationItem.title = @"个人中心";
    HisThinkViewController *thinkRootVC = [[HisThinkViewController alloc] init];
    thinkRootVC.navigationItem.title = @"个人中心";
    HisGroupViewController *groupRootVC = [[HisGroupViewController alloc] init];
    groupRootVC.navigationItem.title = @"个人中心";
    HisQAViewController *QARootVC = [[HisQAViewController alloc] init];
    QARootVC.navigationItem.title = @"个人中心";
    
    LKBBaseNavigationController2 *talkNav = [[LKBBaseNavigationController2 alloc] initWithRootViewController:talkRootVC];
    LKBBaseNavigationController2 *thinkNav = [[LKBBaseNavigationController2 alloc] initWithRootViewController:thinkRootVC];
    LKBBaseNavigationController2 *groupNav = [[LKBBaseNavigationController2 alloc] initWithRootViewController:groupRootVC];
    LKBBaseNavigationController2 *QANav = [[LKBBaseNavigationController2 alloc] initWithRootViewController:QARootVC];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor blackColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       UIColorWithRGBA(192 , 138, 82, 1), NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    

    talkNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"TA话题" image:[UIImage imageNamed:@"his_talk_tabbar"] selectedImage:[[UIImage imageNamed:@"his_talk_tabbar_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    thinkNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"TA见解" image:[UIImage imageNamed:@"his_think_tabbar"] selectedImage:[[UIImage imageNamed:@"his_think_tabbar_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    groupNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"TA群组" image:[UIImage imageNamed:@"his_group_tabbar"] selectedImage:[[UIImage imageNamed:@"his_goup_tabbar_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    QANav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"TA问答" image:[UIImage imageNamed:@"his_qa_tabbar"] selectedImage:[[UIImage imageNamed:@"his_qa_tabbar_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.viewControllers = @[talkNav,thinkNav,groupNav,QANav];
    self.selectedIndex = 0;
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
