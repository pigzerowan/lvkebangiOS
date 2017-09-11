//
//  BaseTimeViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 4/28/16.
//  Copyright © 2016 transfar. All rights reserved.
//
#define kColor(r , g ,b) [UIColor colorWithRed:(r)  green:(g)  blue:(b) alpha:1]
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#import "BaseTimeViewController.h"
#import "NewTimeViewController.h"
#import "GeTuiSdk.h"
#import "DiscoverPublishQuestionViewController.h"
#import "NewTimeAttentionViewController.h"
#import "PushGoodNewsViewController.h"
#import "SelectedRecommendViewController.h"
#import "AttentionDefaultViewController.h"
#import "WBDropdownMenuView.h"
#import "WBTitleMenuViewController.h"
#import "CreatNewCircleViewController.h"
#import "TabbarManager.h"



@interface BaseTimeViewController ()<UIScrollViewDelegate,WBDropdownMenuViewDelegate,WBTitleMenuDelegate>

@property (nonatomic, weak) UIScrollView *contentScroll;

@property (nonatomic, weak) UIScrollView *titleScroll;

@property (nonatomic, weak) UIButton *selectBtn;

@property (nonatomic, strong) NSMutableArray *titleButton;
@property (strong, nonatomic) UIButton *publishButton;


@end
@implementation BaseTimeViewController


- (NSMutableArray *)titleButton
{
    if (_titleButton == nil) {
        _titleButton = [NSMutableArray array];
    }
    return _titleButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [GeTuiSdk clientId];
    NSLog(@"===========%@===",[GeTuiSdk clientId]);
    
    _publishButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     [_publishButton setFrame:CGRectMake(0, 0, 15, 15)];
    
//    [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
//    [_publishButton setTitleColor:CCCUIColorFromHex(0x69c21b) forState:UIControlStateNormal];
    
    // 右上角更多按钮
    [_publishButton setImage:[UIImage imageNamed:@"More"] forState:UIControlStateNormal];
    [_publishButton addTarget:self action:@selector(publishQuestion:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_publishButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
    
    
    

    [self setUpChildController];
    [self setUpContaintScrollView];
    
    [self setUpTitleScroll];
    
    self.contentScroll.contentSize = CGSizeMake(self.childViewControllers.count *kScreenW, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;

    

    
  
}





- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    
    
    
    [self.navigationController.navigationBar setClipsToBounds:NO];
    [self.navigationController.navigationBar setBarTintColor:CCCUIColorFromHex(0x323436)];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
    
    [TabbarManager shareInstance].vcType = @"0";

    [MobClick beginLogPageView:@"BaseTimeViewController"];
    //    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];

}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"BaseTimeViewController"];
    

}



// 发布
- (void)publishQuestion:(UIButton *)sender {
    
    
    [MobClick event:@"publishQuestionButtonEvent"];
    
    
    WBDropdownMenuView *dropdownMenuView = [[WBDropdownMenuView alloc]init];
    dropdownMenuView.delegate = self;
    
    WBTitleMenuViewController *titleMenuVC = [[WBTitleMenuViewController alloc]init];
    //    titleMenuVC.view.frame = CGRectMake(titleMenuVC.view.frame.origin.x, titleMenuVC.view.frame.origin.y, self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    
    [dropdownMenuView showFrom:sender];
    
    titleMenuVC.dropdownMenuView = dropdownMenuView;
    titleMenuVC.delegate = self;
    dropdownMenuView.contentController = titleMenuVC;


    
    
    
    
    
//    DiscoverPublishQuestionViewController  *publishVC = [DiscoverPublishQuestionViewController new];
//    publishVC.VCType = @"1";
//    publishVC.flag =1;
//    publishVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:publishVC animated:YES];
    
    
    
    
    
//    SelectedRecommendViewController *attentionVC = [[SelectedRecommendViewController alloc]init];
//    attentionVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:attentionVC animated:YES];

    
    
    
}

#pragma mark - 3.WBDropdownMenuViewDelegate
- (void)dropdownMenuDidDismiss:(WBDropdownMenuView *)menu {
    // 让指示箭头向上
//    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
//    titleButton.selected = YES;
    
    
    // 修改导航栏的标题
    
}

#pragma mark - 4.TitleMenuDelegate
-(void)selectAtIndexPath:(NSIndexPath *)indexPath title:(NSString *)title
{
    NSLog(@"indexPath = %ld", (long)indexPath.row);
    NSLog(@"当前选择了%@", title);
    
    
    if (indexPath.row == 0) {
        
        DiscoverPublishQuestionViewController  *publishVC = [DiscoverPublishQuestionViewController new];
        publishVC.VCType = @"1";
        publishVC.flag =1;
        publishVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:publishVC animated:YES];

        
    }
    
    else {
        
        
        CreatNewCircleViewController *creatCircleVc = [[CreatNewCircleViewController alloc]init];
        [TabbarManager shareInstance].createCirleVcType = @"1";
        creatCircleVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:creatCircleVc animated:YES];

    }
    
//    // 修改导航栏的标题
//    [(UIButton *)self.navigationItem.titleView setTitle:title forState:UIControlStateNormal];
//    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
//    titleButton.selected = NO;
    // 调用根据搜索条件返回相应的微博数据
    
    
    
    // ...
}



- (void)setUpTitleScroll
{
    UIScrollView *view = [[UIScrollView alloc] init];
    view.frame = CGRectMake(kDeviceWidth-100, 0, 130, 44);
    view.showsHorizontalScrollIndicator = NO;
    view.scrollEnabled = NO;
    self.titleScroll = view;
    CGFloat btnW = 65;
    CGFloat btnH = view.frame.size.height;
    
    for (int i = 0; i < self.childViewControllers.count; ++i) {
        
        UIViewController *vc = self.childViewControllers[i];
        
        UIButton *btn = [[UIButton alloc] init];;
        btn.frame = CGRectMake(btnW * i , 0, btnW, btnH);
        [btn setTitle:vc.title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        if (i==0) {
            
            btn.alpha=1;
        }else if (i==1)
        {
            btn.alpha=0.6;
        }
        
        
        [btn addTarget:self action:@selector(topTitleBtnClick:) forControlEvents:UIControlEventTouchDown];
        
        btn.tag = i;
        
        [view addSubview:btn];
        
        
        
        if (btn.tag == 0) {
            [self topTitleBtnClick:btn];
        }
        
        [self.titleButton addObject:btn];
        
    }
    self.navigationItem.titleView = view;
    self.titleScroll.contentSize = CGSizeMake(btnW *self.childViewControllers.count, 200);
    
}


- (void)topTitleBtnClick:(UIButton *)btn
{
    
    [self selctedBtn:btn];
    
    
    [self setUpOnechildController:btn];
    
    
}

- (void)setUpOnechildController:(UIButton *)btn
{
    UIViewController *vc = self.childViewControllers[btn.tag];
    //    if (vc.view.superview) return;
    vc.view.frame = CGRectMake(btn.tag * kScreenW, 0, kScreenW, kScreenH );
    
    [self.contentScroll addSubview:vc.view];
    
    self.contentScroll.contentOffset = CGPointMake(btn.tag *kScreenW, 0);
}
//让标题居中
- (void)setupTitleButtonCenter:(UIButton *)button
{
    //     修改偏移量
    //        CGFloat offsetX = button.center.x - kDeviceWidth * 0.5;
    //
    //        // 处理最小滚动偏移量
    //        if (offsetX < 0) {
    //            offsetX = 0;
    //        }
    //
    //        // 处理最大滚动偏移量
    //        CGFloat maxOffsetX = self.titleScroll.contentSize.width - 200;
    //        if (offsetX > maxOffsetX) {
    //            offsetX = maxOffsetX;
    //        }
    //        [self.titleScroll setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
- (void)selctedBtn:(UIButton *)btn
{
    
    _selectBtn.alpha=0.6;
    //    [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self setupTitleButtonCenter:btn];
    
    _selectBtn.transform = CGAffineTransformIdentity;
    btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    _selectBtn = btn;
    [btn setAlpha:1];

    //    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

//下面的滚动容器视图
- (void)setUpContaintScrollView
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,kScreenW , kScreenH)];
    scroll.backgroundColor = [UIColor whiteColor];
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.delegate = self;
    
    [self.view addSubview:scroll];
    self.contentScroll = scroll;
    
}

//添加子控制器
- (void)setUpChildController
{
    //推荐
    NewTimeViewController *message = [[NewTimeViewController alloc] init];
    message.toRequestURL = LKB_ALL_allDynamics;
    message.title = @"全部";
    
    [self addChildViewController:message];
    
    //关注
    //    NewTimeViewController *comp = [[NewTimeViewController  alloc] init];
    //    comp.toRequestURL = LKB_ALL_DYNAMIC;
    //    comp.title = @"关注";
    NewTimeAttentionViewController *comp = [[NewTimeAttentionViewController  alloc] init];
    comp.toRequestURL = LKB_ALL_DYNAMIC;
    comp.title = @"关注";
    comp.type = @"1";
    
    [self addChildViewController:comp];
    
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger i = scrollView.contentOffset.x / kScreenW;
    
    UIButton *btn = self.titleButton[i];
    
    
    [self selctedBtn:btn];
    
    [self setUpOnechildController:btn];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger leftI = scrollView.contentOffset.x / kScreenW;
    
    NSInteger rightI = leftI + 1;
    
    // 1.获取需要形变的按钮
    
    // left
    // 获取左边按钮
    UIButton *leftButton = self.titleButton[leftI];
    
    // right
    NSUInteger count = self.childViewControllers.count;
    UIButton *rigthButton;
    // 获取右边按钮
    if (rightI < count) {
        rigthButton = self.titleButton[rightI];
    }
    
    // 计算右边按钮偏移量
    CGFloat rightScale = scrollView.contentOffset.x / kScreenW;
    // 只想要 0~1
    rightScale = rightScale - leftI;
    
    CGFloat leftScale = 1 - rightScale;
    
    // 形变按钮
    // scale 0 ~ 1 => 1 ~ 1.3
    //    leftButton.transform = CGAffineTransformMakeScale(leftScale  * 1, leftScale *   1);
    //    rigthButton.transform = CGAffineTransformMakeScale(rightScale  * 1, rightScale   *1);
    
    [rigthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


@end
