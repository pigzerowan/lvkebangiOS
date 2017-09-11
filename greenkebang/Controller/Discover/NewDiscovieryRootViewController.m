//
//  NewDiscovieryRootViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 1/16/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "NewDiscovieryRootViewController.h"
#import "TimeSeperateViewController.h"
#import "TimeQATableViewController.h"
#import "NewSeperateViewController.h"
#import "SearchRootViewController.h"

@interface NewDiscovieryRootViewController ()<ViewPagerDataSource,ViewPagerDelegate>

@property (strong, nonatomic) NSArray *classArray;
@property (strong, nonatomic) UIView *rootView;
@end

@implementation NewDiscovieryRootViewController
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
    self.view.backgroundColor =  CCCUIColorFromHex(0xeeeeee);
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    _classArray = @[@"精选",@"农业",@"科技",@"土壤",@"健康",@"生物"];
    self.dataSource = self;
    self.delegate = self;
    
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(-10, 10, 20, 20)];
    [searchButton setImage:[UIImage imageNamed:@"new_search"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];


    
//    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"发布技术答疑" style:UIBarButtonItemStyleDone target:self action:@selector(publishQuestion:)];
//    self.navigationItem.leftBarButtonItem = left;

    
    [self reloadData];
}

- (void)searchAction:(id)sender {

    
    SearchRootViewController * searchVC = [[SearchRootViewController alloc]init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
    
}
#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return _classArray.count;
}
- (NSString *)viewPager:(ViewPagerController *)viewPager titleForTabAtIndex:(NSUInteger)index
{
    return _classArray[index];
}
-(UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index{
    
//    if (index ==0) {
//        TimeQATableViewController *timeQAVC = [[TimeQATableViewController alloc] init];
//        return timeQAVC;
//    }
    NewSeperateViewController *discoveryRecommVC = [[NewSeperateViewController alloc] initWithDiscoveryOtherControllerType:index];
    return discoveryRecommVC;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
            break;
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        case ViewPagerOptionTabWidth:
            return kDeviceWidth / _classArray.count;
        default:
            break;
    }
    return value;
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            //            return CCColorFromRGB(21, 174, 237);
            //            return CCCUIColorFromHex(0x32D6FF);
            return [UIColor colorWithHex:0x22ac38];
        case ViewPagerTabsView:
            return [UIColor whiteColor];
        case ViewPagerContent:
            return [UIColor clearColor];
        default:
            return color;
    }
}

//- (void)viewPagerDidStartSearch:(ViewPagerController *)viewPager
//{
//    DiscoverSearchViewController* discoverSearchVC = [[DiscoverSearchViewController alloc] init];
//    [self.navigationController pushViewController:discoverSearchVC animated:YES];
//}
#pragma mark - Navigation
- (void)didLeftBarButtonItemAction:(id)sender
{
    
}
- (void)searchBarButtonItemAction:(id)sender
{
    //    DiscoverSearchViewController* discoverSearchVC = [[DiscoverSearchViewController alloc] init];
    //    [self.navigationController pushViewController:discoverSearchVC animated:YES];
}

@end
