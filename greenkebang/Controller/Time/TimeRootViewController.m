//
//  TimeRootViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 8/26/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "TimeRootViewController.h"
#import "TimeSeperateViewController.h"
#import "TimeQATableViewController.h"

@interface TimeRootViewController ()<ViewPagerDataSource,ViewPagerDelegate>
{
    UIImageView *leadImg;
}
@property (strong, nonatomic) NSArray *classArray;
@property (strong, nonatomic) UIView *rootView;
@end

@implementation TimeRootViewController

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
    _classArray = @[@"技术答疑",@"话题",@"行业见解"];
    self.dataSource = self;
    self.delegate = self;
   
    [self reloadData];
    
    [self judgeShowIntroView2];
}



- (void)judgeShowIntroView2
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if ([userInfo floatForKey:iYQUserVersionKey] < iYQUserVersion) {
        _rootView = self.navigationController.view;
        [self showIntroWithCustomView2];
    }
    else
    {
//    [userInfo setFloat:iYQUserVersion forKey:iYQUserVersionKey];
    [userInfo synchronize];
    }
}

-(void)showIntroWithCustomView2
{
    leadImg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    leadImg.image = [UIImage imageNamed:@"ios-1"];
    [[UIApplication sharedApplication].keyWindow addSubview:leadImg];
    UITapGestureRecognizer *tapReconginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPress:)];
    leadImg.userInteractionEnabled = YES;
    [leadImg addGestureRecognizer:tapReconginzer];
    
}

- (void)tapPress:(UITapGestureRecognizer *)sender {
    
    [leadImg removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
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
    
    if (index ==0) {
        TimeQATableViewController *timeQAVC = [[TimeQATableViewController alloc] init];
        return timeQAVC;
    }
    TimeSeperateViewController *discoveryRecommVC = [[TimeSeperateViewController alloc] initWithDiscoveryOtherControllerType:index];
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
            return 320 / _classArray.count;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
