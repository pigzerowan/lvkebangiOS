//
//  LKBBaseNavigationController2.m
//  greenkebang
//
//  Created by 郑渊文 on 10/30/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "LKBBaseNavigationController2.h"
#pragma mark - Life cycle
@interface LKBBaseNavigationController2 ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation LKBBaseNavigationController2

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configAppearance];
    __weak __typeof(self)weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configAppearance
{
    
    //    self.navigationBar.tintColor = [UIColor LkbgreenColor];
    //    [self.navigationBar addSubview:self.leftTitle];
    // 配置导航栏
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    //    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
//    [self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor],
//                                                  
//                                                  NSShadowAttributeName : [NSShadow new] }];
    
    UIButton* friendBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 12, 24, 24)];
    [friendBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    //    [friendBtn addTarget:self action:@selector(toMyFriend) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:friendBtn];
    ;
    
    //    self.navigationItem.titleView = _leftTitle;
    
//    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    //    self.navigationBar.backgroundColor = [UIColor LkbgreenColor];
    //    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"nav_back_tap"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    [[UIBarButtonItem appearance]setImage:[UIImage imageNamed:@"nav_back_tap"] ];
    //        [[UIBarButtonItem appearance]
    //         setBackButtonBackgroundImage:[UIImage imageNamed:@"nav_back_tap"]
    //         forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    [[UINavigationBar appearance] setBackgroundImage:DKNavbackbarImage forBarMetrics:UIBarMetricsDefault];
    //    [[UINavigationBar appearanceWhenContainedIn:[MFMessageComposeViewController class], nil] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    //    [[UITabBar appearance] setSelectedImageTintColor:CCColorFromRGB(21, 174, 237)];
    
    
}


#pragma mark UINavigationControllerDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
    
}
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}


- (UILabel *)leftTitle
{
    if (!_leftTitle) {
        _leftTitle = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 100, 40)];
        _leftTitle.font = [UIFont systemFontOfSize:17];
        _leftTitle.textColor=[UIColor whiteColor];
        self.navigationItem.titleView = _leftTitle;
    }
    return _leftTitle;
}

@end
