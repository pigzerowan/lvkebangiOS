//
//  DiscoverIntoViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "DiscoverIntoViewController.h"
#import "DiscoveryDetailViewController.h"
#import "DisCoverGroupDetail.h"
#import "DisCoverTalkViewController.h"
#import "DisCoverinsightViewController.h"
#import "DisCoverQueastionViewController.h"

@interface DiscoverIntoViewController ()<ViewPagerDataSource,ViewPagerDelegate>
@property (strong, nonatomic) NSArray *classArray;

@end

@implementation DiscoverIntoViewController

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
    _classArray = @[@"推荐",@"农业",@"环保",@"健康",@"食品",@"生物"];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;

    self.dataSource = self;
    self.delegate = self;
    [self reloadData];
    //    NSString *city = [[UserMationMange sharedInstance] userDefaultCity];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:city style:UIBarButtonItemStylePlain target:self action:@selector(didLeftBarButtonItemAction:)];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarButtonItemAction:)];
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (_requestURL == LKB_FIND_PEOPLE_URL) {
        DiscoveryDetailViewController *discoveryDetailVC = [[DiscoveryDetailViewController alloc]
                                                            initWithDiscoveryOtherControllerType:index];
        self.title = @"发现人";
        discoveryDetailVC.therquestUrl =_requestURL;
        return discoveryDetailVC;
    }else if (_requestURL == LKB_FIND_Topic_List_Url)
    {
        DisCoverTalkViewController *discoveryTalklVC = [[DisCoverTalkViewController alloc]
                                                            initWithDiscoveryOtherControllerType:index];
        discoveryTalklVC.therquestUrl =_requestURL;
        self.title = @"发现话题";
        return discoveryTalklVC;

    }else if (_requestURL == LKB_FIND_Insight_List_Url)
    {
        DisCoverinsightViewController *discoveryInsightVC = [[DisCoverinsightViewController alloc]
                                                        initWithDiscoveryOtherControllerType:index];
        discoveryInsightVC.therquestUrl =_requestURL;
        self.title = @"发现见解";
        return discoveryInsightVC;
        
    }else if (_requestURL == LKB_FIND_Question_List_Url)
    {
        DisCoverQueastionViewController *discoveryQAVC = [[DisCoverQueastionViewController alloc]
                                                             initWithDiscoveryOtherControllerType:index];
        self.title = @"发现问答";
        discoveryQAVC.therquestUrl =_requestURL;
        return discoveryQAVC;
        
    }
    
    else {
        
        DisCoverGroupDetail *discoveryGrouplVC = [[DisCoverGroupDetail alloc]
                                                            initWithDiscoveryOtherControllerType:index];
    self.title = @"发现群组";
        return discoveryGrouplVC;
    }
   
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
            return [UIColor LkbgreenColor];
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
