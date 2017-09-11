#import "YQWebDetailViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "ShareActionView.h"
#import "MBProgressHUD+Add.h"
#import "OutWebViewController.h"
#import "MBProgressHUD+Add.h"
#import "MyUserInfoManager.h"
#import "NewShareActionView.h"
#import "TYAlertController.h"
#import "UserGroupViewController.h"
#import "PeopleViewController.h"
#import "NewShareToViewController.h"
#import "NewCircleShareActionView.h"
#import "UMSocial.h"
#import "ShareArticleManager.h"

@interface YQWebDetailViewController () <NJKWebViewProgressDelegate,NewShareActionViewDelegete,NewCircleShareActionViewDelegete>
{
    
    NSString *jsonStr;

}
@property (strong, nonatomic) NJKWebViewProgressView* progressView;
@property (strong, nonatomic) NJKWebViewProgress* progressProxy;
@property(nonatomic,strong)TYAlertController *alertController;

@end

@implementation YQWebDetailViewController

#pragma mark - Life cycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _webView.delegate = nil;
    [_webView removeFromSuperview];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_share_pre"] style:UIBarButtonItemStylePlain target:self action:@selector(didShareBarButtonItemAction:)];
    
    
    NSURLRequest* req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlStr]];
    [self.webView loadRequest:req];
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setClipsToBounds:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    [self.navigationController.navigationBar addSubview:_progressView];
    [self initializePageSubviews];
    
    [MobClick beginLogPageView:@"YQWebDetailViewController"];

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [_progressView removeFromSuperview];
    [MobClick endLogPageView:@"YQWebDetailViewController"];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)didShareBarButtonItemAction:(id)sender
{
//    [MyUserInfoManager shareInstance].shaImage = @"";
//    [MyUserInfoManager shareInstance].shaTitle = self.title;
//    [MyUserInfoManager shareInstance].shaDes = _urlStr;;
//    
//    [MyUserInfoManager shareInstance].shaUrl = _urlStr;
//    
//    [MyUserInfoManager shareInstance].shareType = @"1";
    
    _shareCover = [NSString stringWithFormat:@"http://imagetest.lvkebang.cn/static/powerpoint_cover/%@",_coverUrl];
    
    
    if ([_shareCover isEqualToString:@"http://www.lvkebang.cn "]) {
        
        _shareCover = [NSString stringWithFormat:@"http://image.lvkebang.cn/static/group_topic/link_default_graph.png"];
        
    }
    
    if (_mytitle == nil) {
        _mytitle = @"活动";
    }
    
    [ShareArticleManager shareInstance].shareImage = _shareCover;
    [ShareArticleManager shareInstance].shareTitle = _mytitle;
    [ShareArticleManager shareInstance].shareUrl = _urlStr;
    
    [ShareArticleManager shareInstance].shareType = @"1";


    NSDictionary *shaDic = @{@"cover":_shareCover,
                             @"userId":[[MyUserInfoManager shareInstance]userId],
                             @"title":_mytitle,
                             @"linkUrl":_urlStr,
                             @"shareType":@"8",
                             
                             };
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shaDic options:NSJSONWritingPrettyPrinted error:nil];
    
    
    
    jsonStr=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    
    NewCircleShareActionView *newshare =[[NewCircleShareActionView alloc]init];
    
    newshare.delegate = self;
    newshare.layer.cornerRadius = 10;
    _alertController = [TYAlertController alertControllerWithAlertView:newshare preferredStyle:TYAlertControllerStyleAlert];
    
    
    _alertController.backgoundTapDismissEnable = YES;
    [self presentViewController:_alertController animated:YES completion:nil];
}


- (void)rebackToRootViewAction {
    
    //将标示条件置空，以防通过正常情况下导航栏进入该页面时无法返回上一级页面
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@"" forKey:@"push"];
    [pushJudge synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)newCircleShareActionView:(NewCircleShareActionView *)UserHeaderView didatterntion:(NSInteger)index {
    
    
    NSLog(@"点击了群组");
    
    if (index == 1) {
        [_alertController dismissViewControllerAnimated:YES];
        
        NewShareToViewController *peopleVC = [[NewShareToViewController alloc] init];
        peopleVC.showNavBar = YES;
        peopleVC.shareDes = jsonStr;
        peopleVC.requestUrl = LKB_Attention_Users_Url;
        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
//        peopleVC.questionId = _circleDetailId;
        peopleVC.shareType = @"3";
        peopleVC.hidesBottomBarWhenPushed = YES;
        peopleVC.ifshare = @"3";
        
        [self.navigationController pushViewController:peopleVC animated:YES];
        
        
    }
    // 微信好友
    if (index == 2) {
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
            extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"%@",_urlStr];;
        [[UMSocialControllerService defaultControllerService] setShareText:_mytitle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
    // 微信朋友圈
    if (index==3) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"%@",_urlStr];;
        [[UMSocialControllerService defaultControllerService] setShareText:_mytitle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // 新浪
    if (index==4) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        extConfig.sinaData.shareText =_mytitle;
        
        extConfig.sinaData.shareText  = [NSString stringWithFormat:@"h%@",_urlStr];;
        [[UMSocialControllerService defaultControllerService] setShareText:_mytitle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
    }
    // 空间
    if (index==5) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        extConfig.tencentData.shareText = _mytitle;
        
        extConfig.qzoneData.url  = [NSString stringWithFormat:@"%@",_urlStr];;
        [[UMSocialControllerService defaultControllerService] setShareText:_mytitle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // QQ
    if (index==6) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        
        extConfig.title = _mytitle;
        extConfig.qqData.shareText = _mytitle;
        
        extConfig.qqData.url  = [NSString stringWithFormat:@"%@",_urlStr];;
        [[UMSocialControllerService defaultControllerService] setShareText:_mytitle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }

}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    if ([[pushJudge objectForKey:@"push"] isEqualToString:@"push"]) {
        
        [self.tabBarController.tabBar setHidden:YES];
        
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
        //    [self.navigationController.navigationBar addSubview:backBtn];
        [backBtn addTarget:self action:@selector(rebackToRootViewAction) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        
    }

}






#pragma mark - NJKWebViewProgress Delegate
- (void)webViewProgress:(NJKWebViewProgress*)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    _mytitle = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    
    
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString * requestURL = request.URL.absoluteString ;
    
    
    if ([requestURL rangeOfString:@"huodong"].location != NSNotFound) {
        
        [ShareArticleManager shareInstance].shareType = nil;
        
        NSString *huodong = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/"];
        
        NSString * str = [requestURL substringFromIndex: huodong.length];
        
        NSString * _linkUrl = [NSString stringWithFormat:@"%@/detail/activity/%@",LKB_WSSERVICE_HTTP,str];
        
        NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:strmy];
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        
        outSideWeb.VcType = @"7";
        outSideWeb.rightButtonType = @"1";
        outSideWeb.circleDetailId = str;
        outSideWeb.urlStr = _linkUrl;
        outSideWeb.shareType = @"2";
        outSideWeb.commendVcType = @"1";
        [ShareArticleManager shareInstance].shareType = @"1";
        NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
        outSideWeb.squareType = @"1";
        
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];
        
        
        return NO;
        
        
        
    }
    else if ([requestURL rangeOfString:@"jianjie"].location != NSNotFound) {
        
        [ShareArticleManager shareInstance].shareType = nil;
        
        
        NSString *huodong = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/"];
        
        NSString * str = [requestURL substringFromIndex: huodong.length];
        
        NSString * _linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,str] ;
        
        NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:strmy];
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        
        outSideWeb.VcType = @"2";
        outSideWeb.rightButtonType = @"1";
        outSideWeb.sendMessageType = @"1";
        outSideWeb.circleDetailId = str;
        outSideWeb.urlStr = _linkUrl;
        outSideWeb.shareType = @"2";
        outSideWeb.commendVcType = @"1";
        
        outSideWeb.circleDetailId = str;
        
        [ShareArticleManager shareInstance].shareType = @"1";
        NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
        outSideWeb.squareType = @"1";
        
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];
        
        
        return NO;
        
    }
//        else if ([requestURL rangeOfString:@".html"].location != NSNotFound) {
//        YQWebDetailViewController* webDetailVC = [[YQWebDetailViewController alloc] init];
//        webDetailVC.urlStr = requestURL;
//        //        webDetailVC.mytitle = insight.shareTitle;
//        //        webDetailVC.coverUrl = insight.shareImage;
//        webDetailVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:webDetailVC animated:YES];
//        
//        return NO;
//        
//    }
    else {
        
        return YES;
    }
}


// 禁止双击放大或缩小
- (UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView
{
    return nil;
}



#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.view addSubview:self.webView];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}
#pragma mark - Getters & Setters
- (UIWebView*)webView
{
    if (!_webView) {
        CGRect frame = self.view.bounds;
        
        _webView = [[UIWebView alloc] initWithFrame:frame];
        _webView.scalesPageToFit = YES;
        _webView.scrollView.bounces = NO;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _webView;
}

@end
