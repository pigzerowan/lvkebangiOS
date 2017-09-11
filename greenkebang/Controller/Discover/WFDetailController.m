//
//  WFDetailController.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/5.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFDetailController.h"
#import "WFDetailHeaderView.h"
#import "WFWebView.h"
#import "WFBottomBarView.h"
#import "WFLoadingView.h"
#import "WFWebImageShowView.h"

#import "OutWebViewController.h"

@interface WFDetailController ()<WFBottomBarDelegate,WFWebViewDelegate>
{
    WFWebView           *_detailWeb;
    WFDetailHeaderView  *_detailHeaderView;
    WFBottomBarView     *_detailBottomView;
    UIView              *_containerView;

}
@property (nonatomic,strong) WFLoadingView *loadingView;//加载视图

@end

@implementation WFDetailController


#pragma mark - View Load
- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    [self refreshUI];
    [self configUI];
    [self configBottomUI];

        [_loadingView dismissLoadingView];
        _loadingView = nil;


}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
 [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    if (_detailWeb.scrollView.contentOffset.y >= 80) {
//        
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//        
//    }else{
//        
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    }
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


#pragma mark - View factory
- (void)configUI{

    if (!_containerView) {
        
        _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_containerView];
        _containerView.backgroundColor = [UIColor whiteColor];

    }
    
    if (!_detailWeb) {
        
        _detailWeb = [[WFWebView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight  - 44)];
//
        NSString *strrr = @"http://192.168.1.45/app/template/chuhe/chuhe_detail_temp.html";
        
        NSString *str = [strrr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [_detailWeb loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:str]]];
//        _detailWeb.scalesPageToFit = YES;
        
        _detailWeb.scrollView.delegate = self;
        _detailWeb.webDelegate = self;
        
        
        
        [_containerView addSubview:_detailWeb];

    }
    
    [_containerView addSubview:self.loadingView];
    
}


- (NSString *)loadWebViewHtml{
    
    
    
    
    return [NSString stringWithFormat:@"http://192.168.1.45/app/template/chuhe/chuhe_detail.html"];
  
    
}

- (void)configBottomUI{


    
    _detailBottomView = [[WFBottomBarView alloc] initWithFrame:CGRectMake(0, KDeviceHeight - 50.f, kDeviceWidth, 50.f)];
    _detailBottomView.delegate = self;
    [self.view addSubview:_detailBottomView];
}

- (void)refreshUI{
    
    NSString *strrr = [self loadWebViewHtml];
    
   NSString *str = [strrr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
   [_detailWeb loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:str]]];
    

}

- (void)refreshBottomUI{



}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offSetY = scrollView.contentOffset.y;

    if (-offSetY <= 80 && -offSetY >= 0) {
        
        [_detailHeaderView wf_parallaxHeaderViewWithOffset:offSetY];
        
     
       
        if (-offSetY > 40 && !_detailWeb.scrollView.isDragging){
            
            [self getPreviousNews];
        }
    }else if (-offSetY > 80) {//到－80 让webview不再能被拉动
        
        _detailWeb.scrollView.contentOffset = CGPointMake(0, -80);
        
    }else if (offSetY <= 300 ){
        
        
        _detailHeaderView.frame = CGRectMake(0, -40 - offSetY, kDeviceWidth, 260);
    }
    
    if (offSetY + KDeviceHeight > scrollView.contentSize.height + 160 && !_detailWeb.scrollView.isDragging) {
        
         [self getNextNews];
    }

    if (offSetY >= 120) {
    
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];

        
        
        
    }else{
  
          [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}


#pragma mark - 获得上一条
- (void)getPreviousNews{


//    
//    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        _containerView.frame = CGRectMake(0, kScreenHeight + 40, kScreenWidth, kScreenHeight);
//    } completion:^(BOOL finished) {
//        
//        [self.view insertSubview:self.loadingView belowSubview:_detailBottomView];
//        DELAYEXECUTE(0.25, _containerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//                     
//                            [_viewModel getPreviousData:^{
//            
//                                    _detailBottomView.nextArrowsEnable = YES;//肯定有下一条
//                                    [weakSelf refreshUI];
//                                    [self.loadingView dismissLoadingView];
//                                    self.loadingView = nil;
//                                    _viewModel.isLoading = NO;
//            
//                            }];
//                     
//                            [_viewModel getPreviousExtraData:^{
//                                    [weakSelf refreshBottomUI];
//                            }];);
//            }];
}


#pragma mark - 获得下一条
- (void)getNextNews{
    
//    WS(weakSelf);
//    
//    if (_viewModel.isHasNext == NO) {
//        return;
//    }
//    if (_viewModel.isLoading) {
//        return;
//    }
//    _viewModel.isLoading = YES;
//    
//    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        _containerView.frame = CGRectMake(0, -kScreenHeight, kScreenWidth, kScreenHeight);
//    } completion:^(BOOL finished) {
//        
//        [self.view insertSubview:self.loadingView belowSubview:_detailBottomView];
//        DELAYEXECUTE(0.25, _containerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//                     
//                     [_viewModel getNextData:^{
//            
//                            _detailBottomView.nextArrowsEnable = _viewModel.isHasNext;
//                            [weakSelf refreshUI];
//                            [self.loadingView dismissLoadingView];
//                            self.loadingView = nil;
//                            _viewModel.isLoading = NO;
//                    }];
//                     
//                    [_viewModel getNextExtraData:^{
//            
//                            [weakSelf refreshBottomUI];
//                    }];);
//        
//        }];
}

#pragma mark - WFWebViewDelegate -
- (void)clickActionOnHyperlink:(NSString *)linkUrl{

    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:linkUrl];
    [self.navigationController pushViewController:outSideWeb animated:YES];

}


- (void)clickActionOnImage:(NSString *)imageUrl{

    __block WFWebImageShowView *showImageView = [[WFWebImageShowView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight ) imageUrl:imageUrl];
    
    [showImageView show:[[UIApplication sharedApplication] keyWindow] didFinish:^{
        [showImageView removeFromSuperview];
        showImageView = nil;
        
    }];


}


#pragma mark - WFBottomBarDelegate -
- (void)selectBtn:(UIButton *)button{
    
//    switch (button.tag - kBottomTag){
//        case 0:
//        {
//            [self.navigationController popViewControllerAnimated:YES];
//            break;
//        }
//        case 1:
//        {
//            [self getNextNews];
//            break;
//        }
//        case 2:
//        {
//            break;
//        }
//        case 3:
//        {
//            
//            [[WFSharePanelView sharedManager] showSharePanelHasStore:YES byClick:^(SharePlatform plat) {
//                DLog(@"plat == %zi",plat);
//                
//            } withPlatform:WFSharePlatformWeChat,WFSharePlatformWeChatFriends,WFSharePlatformQQ,WFSharePlatformSinaWeibo,WFSharePlatformCopyLink,WFSharePlatformMail,WFSharePlatformYouDao,WFSharePlatformYinXiang,WFSharePlatformTencentWeibo,WFSharePlatformMessage,WFSharePlatformInstapaper,WFSharePlatformTwitter,WFSharePlatformRenRen, nil];
//      
//            break;
//        }
//            
//        case 4:
//        {
//           
//            break;
//        }
//        default:
//            break;
//    }
}


#pragma mark - Getter
- (WFLoadingView *)loadingView{
    
    if (!_loadingView) {
        _loadingView = [[WFLoadingView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    }
    
    return _loadingView;
}
@end
