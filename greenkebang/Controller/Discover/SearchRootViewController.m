//
//  SearchRootViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/14.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SearchRootViewController.h"
#import "SearchSeperateViewController.h"
#import "SearchContentViewController.h"
#import "SearchTextManger.h"
#import "TYTabButtonPagerController.h"
#import "DiscoverAllArticViewController.h"

@interface SearchRootViewController ()<TYPagerControllerDataSource>

@property (nonatomic, strong) TYTabButtonPagerController *pagerController;

@end

@implementation SearchRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
      [self.navigationController.navigationBar setTintColor:[UIColor LkbgreenColor]];
    self.navigationItem.titleView = self.searchBar;
//    self.navigationItem.title = @"搜搜看你想看的内容";
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth -50, 12, 40, 24)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelButton setTitleColor:[UIColor LkbgreenColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(didRightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];

    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    _classArray = @[@"内容",@"专栏",@"人物"];

    [self addPagerController];

    // Do any additional setup after loading the view.
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
    pagerController.cellWidth = SCREEN_WIDTH / 3 -10;
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
    [_pagerController moveToControllerAtIndex:arc4random()%3 animated:NO];
}


- (NSInteger)numberOfControllersInPagerController
{
    return 3;
}


- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    if (index == 0) {
        
        return @"内容";
    }
    else if (index == 1) {
        
        return @"专栏";
    }
    else {
        return  @"人物";
    }
    
    
}


- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    
    if (index ==0) {
        SearchContentViewController *searchContentVC = [[SearchContentViewController alloc]init];
        return searchContentVC;
    }
    else if (index == 1) {
        
        DiscoverAllArticViewController *timeQAVC =[[DiscoverAllArticViewController alloc] init];
        timeQAVC.VCtype = @"2";
        return timeQAVC;

    }
    else {
        SearchSeperateViewController *searchSeperateVC = [[SearchSeperateViewController alloc]initWithSearchOtherControllerType:index];
        return searchSeperateVC;
    }

}



#pragma mark - Navigation
- (void)didRightBarButtonItemAction:(id)sender
{
    [self.searchBar resignFirstResponder];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getters & Setters
- (UISearchBar*)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.backgroundImage = nil;
        _searchBar.searchBarStyle = UISearchBarStyleProminent;
        _searchBar.showsCancelButton =NO;
        if ([SearchTextManger shareInstance].searchText!=nil) {
            _searchBar.text =[SearchTextManger shareInstance].searchText;
        }
        _searchBar.tintColor=[UIColor blueColor];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜搜看你想看的内容";
        if ([_searchBar respondsToSelector:@selector(barTintColor)]) {
            
            [_searchBar setBarTintColor:[UIColor whiteColor]];
        }
        
        for (UIView *obj in [_searchBar subviews]) {
            for (UIView *objs in [obj subviews]) {
                if ([objs isKindOfClass:NSClassFromString(@"UITextField")]){
                    [objs setBackgroundColor:CCCUIColorFromHex(0xf0f1f2)];
                }
            }
            
            if ([obj isKindOfClass:NSClassFromString(@"UITextField")]){
                [obj setBackgroundColor:CCCUIColorFromHex(0xf0f1f2)];
            }
        }
    }
    return _searchBar;
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

//    [self.searchBar becomeFirstResponder];

}
- (void)viewWillAppear:(BOOL)animated
{
     [self.searchBar resignFirstResponder];
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"SearchRootViewController"];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"SearchRootViewController"];
}



#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText
{
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar*)searchBar
{
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [searchBar resignFirstResponder];
    
    if ([searchBar.text isEqualToString:@""]) {
        
    }
    else{
        
        [SearchTextManger shareInstance].searchText = searchBar.text;
        
        [_pagerController reloadData];
        
    }


}
- (void)searchBarCancelButtonClicked:(UISearchBar*)searchBar
{
    [searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)searchBarButtonItemAction:(id)sender
{
    [_searchBar removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
