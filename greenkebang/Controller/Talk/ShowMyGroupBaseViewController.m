//
//  ShowGroupBaseViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 10/14/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "ShowMyGroupBaseViewController.h"
#import "SearchPepleGroupViewController.h"
#import "SearchTextManger.h"
@interface ShowMyGroupBaseViewController ()<ViewPagerDataSource,ViewPagerDelegate,UISearchBarDelegate>
@property (strong, nonatomic) NSArray *classArray;
@property (nonatomic,strong) UIButton * searchButton;
@property (nonatomic,strong) UISearchBar     * searchBar;
@end
@implementation ShowMyGroupBaseViewController
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
    self.title = @"搜索";

    
    _searchButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    [_searchButton addTarget:self action:@selector(jumpToSearch) forControlEvents:UIControlEventTouchUpInside];
    [_searchButton setImage:[UIImage imageNamed:@"searchButton"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_searchButton];
    ;

    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;

    self.view.backgroundColor =  CCCUIColorFromHex(0xeeeeee);
    _classArray = @[@"人",@"群组"];
    self.dataSource = self;
    self.delegate = self;
    [self reloadData];
}


- (void)jumpToSearch
{
    self.navigationItem.rightBarButtonItem=nil;
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.center = CGPointMake(SCREEN_WIDTH/2, 84);
    _searchBar.frame = CGRectMake(10, 20,SCREEN_WIDTH-20, 0);
    [_searchBar setContentMode:UIViewContentModeBottomLeft];
    _searchBar.delegate = self;
    _searchBar.backgroundColor=[UIColor clearColor];
    _searchBar.searchBarStyle=UISearchBarStyleDefault;
    _searchBar.showsCancelButton =YES;
    _searchBar.tag=1000;
    [self.navigationController.navigationBar addSubview:_searchBar];
    _searchBar.placeholder = @"关键字搜索";
    //-------------------------------------------------------------------
    [_searchBar becomeFirstResponder];
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
        SearchPepleGroupViewController *timeQAVC = [[SearchPepleGroupViewController alloc] initWithDiscoveryOtherControllerType:index];
        return timeQAVC;
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


#pragma -mark searchBarDelegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_searchButton];
    [_searchBar resignFirstResponder];
    [_searchBar removeFromSuperview];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([searchBar.text isEqualToString:@""]) {
        
    }
    else{
        
        [SearchTextManger shareInstance].searchText = searchBar.text;
        
        [self reloadData];

    }
   
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_searchButton];
    [_searchBar resignFirstResponder];
    [_searchBar removeFromSuperview];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
       
    }
    else{

    }
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //取消按钮 重置
    UITextField *tf;
    for (UIView *view in [[_searchBar.subviews objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            tf=(UITextField *)view;
        }
    }
    [_searchBar setShowsCancelButton:YES animated:YES];
    _searchBar.showsCancelButton=YES;
    for(UIView *subView in searchBar.subviews){
        if([subView isKindOfClass:UIButton.class]){
            [(UIButton*)subView setTitle:@"取消" forState:UIControlStateNormal];
            UIButton *button=(UIButton*)subView;
            button.titleLabel.textColor=[UIColor whiteColor];
        }
    }
    //取消字体变白
    UIButton *cancelButton;
    UIView *topView = _searchBar.subviews[0];
    for (UIView *subView in topView.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            cancelButton = (UIButton*)subView;
        }
    }
    if (cancelButton) {
        NSLog(@"%@",NSStringFromCGRect(cancelButton.frame));
        //Set the new title of the cancel button
        [cancelButton setTitle:@"       " forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.textColor=[UIColor whiteColor];
        cancelButton.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:20];
        [cancelButton removeFromSuperview];
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(-5, -5,40,40)];
        lable.textAlignment=NSTextAlignmentLeft;
        lable.text=@"取消";
        lable.textColor=[UIColor whiteColor];
        [cancelButton addSubview:lable];
        lable.font = [UIFont fontWithName:@"Heiti SC" size:16];
        [cancelButton addSubview:lable];
        
    }
    
}




- (void)viewPagerDidStartSearch:(ViewPagerController *)viewPager
{
   
}


#pragma mark - Navigation
- (void)didLeftBarButtonItemAction:(id)sender
{
    
}
- (void)searchBarButtonItemAction:(id)sender
{
    //    DiscoverSearchViewController* discoverSearchVC = [[DiscoverSearchViewController alloc] init];
    //    [self.navigationController pushViewController:discoverSearchVC animated:YES];
}


- (void)backToMain
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
