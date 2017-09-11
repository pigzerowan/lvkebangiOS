#import "OutWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "GTMNSString+HTML.h"
#import "WFWebImageShowView.h"
#import "UserRootViewController.h"
#import "FarmerCircleViewController.h"
#import "PeopleViewController.h"
#import "MyUserInfoManager.h"
#import "ColumnListViewController.h"
#import "ZFActionSheet.h"
#import "NewShareActionView.h"
#import "TYAlertController.h"
#import "UserGroupViewController.h"
#import "UMSocial.h"
#import "ReportViewController.h"
#import "WFLoadingView.h"
#import "CircleIfJoinManager.h"
#import "NewUserMainPageViewController.h"
#import "NewTimeViewController.h"
#import "NewShareToViewController.h"
#import "ShareArticleManager.h"
#import "NewCircleShareActionView.h"
#import "YQWebDetailViewController.h"
#define ATTENTION_TOPIC 10001
#define UNATTENTION_TOPIC 10002

@interface OutWebViewController ()<NSXMLParserDelegate,UIGestureRecognizerDelegate,UITextViewDelegate,UIScrollViewDelegate,ZFActionSheetDelegate,NewShareActionViewDelegete,NewCircleShareActionViewDelegete>
{
    UIWebView *_detailWeb;
    NSURL  *_reqString;
    UIActivityIndicatorView *_indicatorView;
    UIView *backGroundView;
    UIView *commentsView;
    UITextView *commentText;
    UIButton * senderButton;
    UIToolbar *topView;
    UITapGestureRecognizer * tapGestureRecognizer;
    UILabel * label;
    UIButton *collection;
    NSString *jsonStr;
    UIButton *rightBtn ;
    UIButton *sendButton;
    
    UIImageView*navBarHairlineImageView;
    UIImageView *noNetImg;
        UILabel *nonetLable;
    UIButton *tryAgainBtn;
    UILabel * commendLabel;
    UIImageView *columnAvatar;
    //    UIView * bottomView;
    
    
}
@property (strong, nonatomic) NJKWebViewProgressView *progressView;
@property (strong, nonatomic) NJKWebViewProgress *progressProxy;
@property (copy, nonatomic) NSString *htmlss;
@property (strong, nonatomic)ZFActionSheet *actionshare;
@property(nonatomic,strong)TYAlertController *alertController;
@property(nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong) WFLoadingView *loadingView;//加载视图


@property (strong, nonatomic) NSURLConnection *connection;
//@property (strong, nonatomic) CustomURLCache *urlCache;
@property (strong, nonatomic) NSURLCache *urlCache;
@end

@implementation OutWebViewController


- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return (UIImageView*)view;
    }
    for(UIView*subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}




#pragma mark  请求前统一处理：如果是没有网络，则不论是GET请求还是POST请求，均无需继续处理
- (BOOL)requestBeforeCheckNetWork {
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isNetworkEnable  =(isReachable && !needsConnection) ? YES : NO;
    dispatch_async(dispatch_get_main_queue(), ^{
//        [UIApplication sharedApplication].networkActivityIndicatorVisible =isNetworkEnable;
        /*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
    });
    return isNetworkEnable;
}


- (id)initWithReqUrl:(NSURL *)reqUrlString{
    
    if (self = [super init]) {
        
        NSLog(@"================%@",reqUrlString);
        
        _reqString = reqUrlString;
        
        
//        self.urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
//                                                                     diskCapacity:200 * 1024 * 1024
//                                                                         diskPath:nil
//                                                                        cacheTime:0];
//        [CustomURLCache setSharedURLCache:_urlCache];
//        

        [self setUIWebviewcookie];
        
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
    
}


-(void)setNoNetUIWebview
{
    
    
    self.webView.scrollView.scrollEnabled = NO;
    noNetImg = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-100, KDeviceHeight/2-180, 200, 200)];
    noNetImg.image = [UIImage imageNamed:@"Network-error"];
    
    
    
    nonetLable = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2-100, KDeviceHeight/2-180+220, 200, 24)];
    nonetLable.text = @"无法连接到网络";
    nonetLable.textAlignment = NSTextAlignmentCenter;
    nonetLable.font = [UIFont systemFontOfSize:14];
    nonetLable.textColor = CCCUIColorFromHex(0x999999);
    

    tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth/2-50, KDeviceHeight/2-180+260, 100, 24)];
    tryAgainBtn.backgroundColor = CCCUIColorFromHex(0x01b654);
    tryAgainBtn.layer.cornerRadius = 3.0f;
    
    [tryAgainBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [tryAgainBtn setTitleColor:CCCUIColorFromHex(0xffffff) forState:UIControlStateNormal];
    tryAgainBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [tryAgainBtn addTarget:self action:@selector(tyrAgaintoNet:) forControlEvents:UIControlEventTouchUpInside];


    [self.view addSubview:noNetImg];
//    [self.view addSubview:nonetLable];
    [self.view addSubview:tryAgainBtn];
 
}

-(void)tyrAgaintoNet:(id)sender
{
    [noNetImg removeFromSuperview];
    [tryAgainBtn removeFromSuperview];
    [nonetLable removeFromSuperview];
    
    [self.view addSubview:self.scrollView];
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_reqString cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:60];
    [_detailWeb loadRequest:request];
    
    

}



-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error

{
    [_loadingView dismissLoadingView];
    _loadingView = nil;
    [self setNoNetUIWebview];
    [self.scrollView removeFromSuperview];
    _detailWeb.scrollView.scrollEnabled = NO;
    
}


#pragma mark - 兼容其他手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    return NO;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configUI];
    
    

    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_reqString];
    
    
  NSMutableURLRequest *request =   [NSMutableURLRequest requestWithURL:_reqString cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:500];
//
//
//    
//    //从请求中获取缓存输出
    NSCachedURLResponse *response =[self.urlCache cachedResponseForRequest:request];
    //判断是否有缓存
    if (response != nil){
        NSLog(@"如果有缓存输出，从缓存中获取数据");
        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
//
    
    [_detailWeb loadRequest:request];
    
    
    _detailWeb.scrollView.delegate = self;
    
    
}


- (void)rebackToRootViewAction {
    
    //将标示条件置空，以防通过正常情况下导航栏进入该页面时无法返回上一级页面
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@"" forKey:@"push"];
    [pushJudge synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}






#pragma mark - Getter
- (WFLoadingView *)loadingView{
    
    if (!_loadingView) {
        
        _loadingView = [[WFLoadingView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    }
    
    return _loadingView;
}



-(void)setUIWebviewcookie{
    //    NSString * strID = [NSString stringWithFormat:@"%@",[[UserInfoManager shareUserInfoManagerWithDic:nil] id]];LKB_WSSERVICE_HTTP http://192.168.1.199:8082 http://112.124.96.181:8099
    
 
    
    // 正式环境
        NSURL *cookieHost = [NSURL URLWithString:LKB_WSSERVICE_HTTP];
    
    // 测试环境
//    NSURL *cookieHost = [NSURL URLWithString:@"http://192.168.1.199:8082/app"];
    // 设定 cookie
    NSHTTPCookie *cookie1 = [NSHTTPCookie cookieWithProperties:
                             [NSDictionary dictionaryWithObjectsAndKeys:
                              [cookieHost host], NSHTTPCookieDomain,
                              [cookieHost path], NSHTTPCookiePath,
                              @"userId",  NSHTTPCookieName,
                              [[MyUserInfoManager shareInstance] userId], NSHTTPCookieValue,
                              nil]];
    
    // 设定 cookie
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie1];
    //    NSString * mdStr = [UserInfoManager md5:[UserInfoManager md5:str]];
    // 定义 cookie 要设定的 host
    // 设定 cookie
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             [cookieHost host], NSHTTPCookieDomain,
                             [cookieHost path], NSHTTPCookiePath,
                             @"token",  NSHTTPCookieName,
                             [[MyUserInfoManager shareInstance] token], NSHTTPCookieValue,
                             nil]];
    // 设定 cookie
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
}

-(void)backToMain
{
    
    if ([_detailWeb canGoBack]) {
        [_detailWeb goBack];
    }
    else
    {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }
    
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;
    
    if ([_VcType isEqualToString:@"1"]) {
        
        [MobClick endLogPageView:@"CircleOutWebViewController"];

    }
    if ([_VcType isEqualToString:@"2"]) {
        [MobClick endLogPageView:@"ColumnOutWebViewController"];

    }
    if ([_VcType isEqualToString:@"4"]) {
        [MobClick endLogPageView:@"CommentOutWebViewController"];
        
    }
    if ([_VcType isEqualToString:@"7"]) {
        [MobClick endLogPageView:@"ActivityOutWebViewController"];
        
    }
    if ([_VcType isEqualToString:@"8"]) {
        [MobClick endLogPageView:@"TradingSystemOutWebViewController"];
        
    }



}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 隐藏导航下的线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    
    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 30, 10, 20, 20)];
    
    [self.navigationController.navigationBar setClipsToBounds:NO];
    
    
    
    
    if ([_rightButtonType isEqualToString:@"1"]) {
        
        
        //分享
        [rightBtn setImage:[UIImage imageNamed:@"bottom_icon_share_nor"] forState:UIControlStateNormal];
        //    [self.navigationController.navigationBar addSubview:_setUpButton];
        [rightBtn addTarget:self action:@selector(shareRightButton:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        
    }
    
    if ([_rightButtonType isEqualToString:@"2"]) {
        
        // 三个点
        [rightBtn setImage:[UIImage imageNamed:@"nav_spot_nor"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(setUpRightButton:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        
    }
    [self configCommendUI];
    
    
    if ([_VcType isEqualToString:@"1"]) {
        [MobClick beginLogPageView:@"CircleOutWebViewController"];

    }
    if ([_VcType isEqualToString:@"2"]) {
        [MobClick beginLogPageView:@"ColumnOutWebViewController"];
        
    }
    if ([_VcType isEqualToString:@"4"]) {
        [MobClick beginLogPageView:@"CommentOutWebViewController"];
        
    }
    if ([_VcType isEqualToString:@"7"]) {
        [MobClick beginLogPageView:@"ActivityOutWebViewController"];
        
    }
    if ([_VcType isEqualToString:@"8"]) {
        [MobClick beginLogPageView:@"TradingSystemOutWebViewController"];
        
    }
    
}


-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT -50 - 64, SCREEN_WIDTH, 50)];
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_bottomView.bounds];
        _bottomView.layer.masksToBounds = NO;
        //        _bottomView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _bottomView.layer.shadowColor = CCColorFromRGBA(0, 0, 0, 0.1).CGColor;
        _bottomView.layer.shadowOffset = CGSizeMake(0.0f, -0.5f);
        _bottomView.layer.shadowOpacity = 0.5f;
        _bottomView.layer.shadowPath = shadowPath.CGPath;
        
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    
    return _bottomView;
}




// 右上角分享
-(void)shareRightButton:(id)sender {
    

    [self shareView];
    
}


// 右下角分享
- (void)shareButton:(id)sender {
    
    [self shareView];
    
}



// 分享
- (void)shareView {
    
    if (_mytitle==nil) {
        _mytitle= @"圈子详情";
    }
    if (_describle==nil) {
        _describle= @"点击查看详情";
    }
    if (_groupAvatar==nil) {
        _groupAvatar= @" ";
    }
    
    if (_featureId == nil) {
        _featureId= @" ";
        
    }
    // 专栏头像
    if (_couAvatar == nil) {
        _couAvatar= @" ";
        
    }
    if (_replyNum == nil) {
        _replyNum =@" ";
    }
    
    
    
    
    NSLog(@"---------------------------%@",_featureId);
    NSLog(@"---------------------------%@",_couAvatar);
    if ([_VcType isEqualToString:@"1"]) {
        // 圈子详情
        _shareUrlStr = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_circleDetailId];;
        _shareType = @"2";
        _fromLable = @"绿科邦新农圈";
    }
    if ([_VcType isEqualToString:@"2"]) {
        // 专栏详情
        _shareUrlStr = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];
        _shareType = @"4";
        _fromLable = @"绿科邦专栏";
    }
    if ([_VcType isEqualToString:@"3"]) {
        // 星创学堂
        _shareUrlStr = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];
        _shareType = @"6";
        _fromLable = @"绿科邦专栏";

        
    }
    if ([_VcType isEqualToString:@"6"]) {
        // 锄禾说 /chuhe/
        _shareUrlStr = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/%@",_circleDetailId];
        _shareType = @"5";
        _fromLable = @"绿科邦专栏";

        
    }
    if ([_VcType isEqualToString:@"7"]) {
        // 活动
        _shareUrlStr = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/%@",_circleDetailId];
        _shareType = @"3";
        _fromLable = @"绿科邦专栏";

        
    }
    
    
    if ([_VcType isEqualToString:@"3"]) {
        _shareCover = [NSString stringWithFormat:@"%@%@",LKB_STAR_HEADER_HTTP,_groupAvatar];
        
    }
    else if ([_VcType isEqualToString:@"6"]) {
        _shareCover = [NSString stringWithFormat:@"%@%@",LKB_ChuHeShuo_HTTP,_groupAvatar];

        
    }
    else if ([_VcType isEqualToString:@"7"]) {
        _shareCover = [NSString stringWithFormat:@"%@%@",LKB_Activity_HTTP,_groupAvatar];
        
        
    }

    else {
        
        if (_groupAvatar == nil || [_groupAvatar isEqualToString:@" "]) {
            
            _shareCover = [NSString stringWithFormat:@"http://image.lvkebang.cn/static/group_topic/link_default_graph.png"];

        }
        else {
            
            _shareCover = [NSString stringWithFormat:@"http://www.lvkebang.cn%@",_groupAvatar];

        }
        
        
    }
    _shareColumnAvatar = [NSString stringWithFormat:@"http://imagetest.lvkebang.cn/static/insight_feature/%@",_couAvatar];
    
    NSLog(@"》》》》》》》》》》》》》》》》》》》》》》---------------------------%@",_shareUrlStr);
    
    if ([_VcType isEqualToString:@"1"]) {
        NSDictionary *shaDic = @{@"cover":_shareCover,
                                 @"userId":[[MyUserInfoManager shareInstance]userId],
                                 @"description":_describle,
                                 @"title":_mytitle,
                                 @"circleId":_circleId,
                                 @"linkUrl":_shareUrlStr,
                                 @"featureId":_circleDetailId,
                                 @"shareType":_shareType,
                                 @"fromLable":_fromLable,
                                 
                                 };
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shaDic options:NSJSONWritingPrettyPrinted error:nil];
        
        
        
        jsonStr=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    else {
        NSDictionary *shaDic = @{@"cover":_shareCover,
                                 @"userId":[[MyUserInfoManager shareInstance]userId],
                                 @"description":_describle,
                                 @"title":_mytitle,
                                 @"linkUrl":_shareUrlStr,
                                 @"featureId":_circleDetailId,
                                 @"shareType":_shareType,
                                 @"fromLable":_fromLable,
                                 @"columnId":_featureId,
                                 @"columnAvatar":_shareColumnAvatar,
                                 @"replyNum":_replyNum,
                                 
                                 };
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shaDic options:NSJSONWritingPrettyPrinted error:nil];
        
        
        
        jsonStr=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    
    [ShareArticleManager shareInstance].shareObjId = _circleDetailId;
    
    if (_shareImage == nil) {
        
        [ShareArticleManager shareInstance].shareImage = _shareCover;

    }else {
        
        if ([_shareImage isEqualToString:@"http://www.lvkebang.cn "]) {
            
            _shareImage = [NSString stringWithFormat:@"http://image.lvkebang.cn/static/group_topic/link_default_graph.png"];
            
        }
        [ShareArticleManager shareInstance].shareImage = _shareImage;

        
        

        
    }
    [ShareArticleManager shareInstance].shareTitle = _mytitle;
    [ShareArticleManager shareInstance].shareUrl = _shareUrlStr;

    
    
    // @property (strong, nonatomic) NSString *VcType; // 1 圈子 2 专栏 3 星创学堂 4 评论 5 圈子列表 6 锄禾说  7 活动 8交易系统
    
    
    NSLog(@"====================%@",_VcType);

    if ([_VcType isEqualToString:@"1"]) {
        
        NewShareActionView *newshare = [[NewShareActionView alloc]init];
        newshare.delegate = self;
        newshare.layer.cornerRadius = 10;
        
        _alertController = [TYAlertController alertControllerWithAlertView:newshare preferredStyle:TYAlertControllerStyleAlert];
        _alertController.backgoundTapDismissEnable = YES;
        [self presentViewController:_alertController animated:YES completion:nil];


    }
    else {
        
        NewCircleShareActionView *newshare = [[NewCircleShareActionView alloc]init];
        newshare.delegate = self;
        newshare.layer.cornerRadius = 10;
        
        _alertController = [TYAlertController alertControllerWithAlertView:newshare preferredStyle:TYAlertControllerStyleAlert];
        _alertController.backgoundTapDismissEnable = YES;
        [self presentViewController:_alertController animated:YES completion:nil];

    }
    
}

- (void)newShareActionView:(NewShareActionView *)UserHeaderView didatterntion:(NSInteger)index
{
    NSLog(@"点击了群组");
    
    if (index == 1) {
        [_alertController dismissViewControllerAnimated:YES];
        
        PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
        peopleVC.shareDes = jsonStr;
        peopleVC.requestUrl = LKB_Attention_Users_Url;
        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
        peopleVC.VCType = @"1";

        
        
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            peopleVC.questionId = _circleDetailId;
            peopleVC.shareType = @"2";
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            peopleVC.questionId = _circleDetailId;
            peopleVC.shareType = @"4";
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            peopleVC.questionId = _circleDetailId;
            peopleVC.shareType = @"6";
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说
            peopleVC.questionId = _circleDetailId;
            peopleVC.shareType = @"5";
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 活动
            peopleVC.questionId = _circleDetailId;
            peopleVC.shareType = @"3";
        }
        peopleVC.hidesBottomBarWhenPushed = YES;
        peopleVC.ifshare = @"3";
        

        
        [self.navigationController pushViewController:peopleVC animated:YES];
        
        
    }
    // 微信好友
    if (index == 2) {
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说 /chuhe/
            extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 锄禾说 /chuhe/
            extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/%@",_circleDetailId];;
        }
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
    // 微信朋友圈
    if (index==3) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说 /chuhe/
            extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 锄禾说 /chuhe/
            extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/%@",_circleDetailId];;
        }
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // 新浪
    if (index==4) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        extConfig.sinaData.shareText =_describle;
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说 /chuhe/
            extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 锄禾说 /chuhe/
            extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/%@",_circleDetailId];;
        }
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
    }
    // 空间
    if (index==5) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        extConfig.tencentData.shareText = _describle;
        
        //        extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huati/%@",_objectId];
        
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说 /chuhe/
            extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 锄禾说 /chuhe/
            extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/%@",_circleDetailId];;
        }
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // QQ
    if (index==6) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        extConfig.qqData.shareText = _describle;
        
        //        extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huati/%@",_objectId];
        
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            extConfig.qqData.url = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说 /chuhe/
            extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 锄禾说 /chuhe/
            extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/%@",_circleDetailId];;
        }
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
    
    
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
        
        
        
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            peopleVC.questionId = _circleDetailId;
            peopleVC.shareType = @"2";
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            peopleVC.questionId = _circleDetailId;
            peopleVC.shareType = @"4";
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            peopleVC.questionId = _circleDetailId;
            peopleVC.shareType = @"6";
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说
            peopleVC.questionId = _circleDetailId;
            peopleVC.shareType = @"5";
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 活动
            peopleVC.questionId = _circleDetailId;
            peopleVC.shareType = @"3";
        }
        peopleVC.hidesBottomBarWhenPushed = YES;
        peopleVC.ifshare = @"3";
    
        

        [self.navigationController pushViewController:peopleVC animated:YES];
        
        
    }
    // 微信好友
    if (index == 2) {
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说 /chuhe/
            extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 锄禾说 /chuhe/
            extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/%@",_circleDetailId];;
        }
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
    // 微信朋友圈
    if (index==3) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说 /chuhe/
            extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 锄禾说 /chuhe/
            extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/%@",_circleDetailId];;
        }
        
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // 新浪
    if (index==4) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        extConfig.sinaData.shareText =_describle;
        
        //        extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_topicId];
        
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说 /chuhe/
            extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 锄禾说 /chuhe/
            extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/%@",_circleDetailId];;
        }
        
        
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
    }
    // 空间
    if (index==5) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        extConfig.tencentData.shareText = _describle;
        
        //        extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huati/%@",_objectId];
        
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说 /chuhe/
            extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 锄禾说 /chuhe/
            extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/%@",_circleDetailId];;
        }
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // QQ
    if (index==6) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        
        extConfig.title = _mytitle;
        extConfig.qqData.shareText = _describle;
        
        //        extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huati/%@",_objectId];
        
        if ([_VcType isEqualToString:@"1"]) {
            // 圈子详情
            extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"2"]) {
            // 专栏详情
            extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"3"]) {
            // 星创学堂
            extConfig.qqData.url = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"6"]) {
            // 锄禾说 /chuhe/
            extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/%@",_circleDetailId];;
        }
        if ([_VcType isEqualToString:@"7"]) {
            // 锄禾说 /chuhe/
            extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/%@",_circleDetailId];;
        }
        
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    

    
}



// 右键三个点
-(void)setUpRightButton:(id)sender {
    
    // 圈子动态
    if ([_VcType isEqualToString:@"1"]) {
        
        if ([_toUserId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
            
            _actionshare = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"删除",@"分享",@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
            _actionshare.delegate = self;
            [_actionshare showInView:self.view.window];

        }
        else {
            
            _actionshare = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"分享",@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
            _actionshare.delegate = self;
            [_actionshare showInView:self.view.window];

        }
        
    }
    // 专栏 星创学堂
    if ([_VcType isEqualToString:@"2"]||[_VcType isEqualToString:@"3"]) {
        
        if ([_isCollect isEqualToString:@"0"]) {
            
            _actionshare = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"分享",@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
            _actionshare.delegate = self;
            [_actionshare showInView:self.view.window];
        }
        else {
            _actionshare = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"分享",@"收藏",@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
            _actionshare.delegate = self;
            [_actionshare showInView:self.view.window];
        }
    }
    // 评论
    if ([_VcType isEqualToString:@"4"]) {
        _actionshare = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
        _actionshare.delegate = self;
        [_actionshare showInView:self.view.window];
        
    }
    
    
    
}





#pragma mark - ZFActionSheetDelegate
- (void)clickAction:(ZFActionSheet *)actionSheet atIndex:(NSUInteger)index
{
    NSLog(@"选中了 %zd",index);
    // 圈详情
    if ([_VcType isEqualToString:@"1"]) {
        
        
        if ([_chatResportType isEqualToString:@"1"]) {
            
            // 举报
            ReportViewController *reportVC = [[ReportViewController alloc]init];
            reportVC.objId = _circleDetailId;
            reportVC.reportType = @"1";
            [self.navigationController pushViewController:reportVC animated:YES];
            
            
            
        }else {
            
            if ([_toUserId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                
                if (index==0) {
                    
                    // 删除
                    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                          @"topicId":_circleDetailId,
                                          @"token":[[MyUserInfoManager shareInstance]token],
                                          };
                    
                    self.requestURL = LKB_Delete_Topic_Url;

                }
                else if(index==2) {
                    // 举报
                    ReportViewController *reportVC = [[ReportViewController alloc]init];
                    reportVC.objId = _circleDetailId;
                    reportVC.reportType = @"1";
                    [self.navigationController pushViewController:reportVC animated:YES];
                }else
                {
                    [self shareView];
                    
                }
            }else {
                
                if (index==1) {
                    // 举报
                    ReportViewController *reportVC = [[ReportViewController alloc]init];
                    reportVC.objId = _circleDetailId;
                    reportVC.reportType = @"1";
                    [self.navigationController pushViewController:reportVC animated:YES];
                    
                    
                }else
                {
                    [self shareView];
                    
                }

            }
        }

        
    }
    // 专栏详情
    if ([_VcType isEqualToString:@"2"]||[_VcType isEqualToString:@"3"]) {
        
        if ([_isCollect isEqualToString:@"0"]) {
            
            if (index == 1){
                
                // 举报
                ReportViewController *reportVC = [[ReportViewController alloc]init];
                reportVC.objId = _circleDetailId;
                reportVC.reportType = @"1";
                [self.navigationController pushViewController:reportVC animated:YES];
                
                
            }
            else {
                // 分享
                [self shareView];
                
            }
            
        }
        else {
            if (index==1) {
                // 收藏
                self.requestParas = @{@"ucObjId":_circleDetailId,
                                      @"userId":[[MyUserInfoManager shareInstance]userId],
                                      @"token":[[MyUserInfoManager shareInstance]token],
                                      };
                self.requestURL = LKB_Common_Collection_Url;
                
                
                
            }else if (index == 2){
                
                // 举报
                ReportViewController *reportVC = [[ReportViewController alloc]init];
                reportVC.objId = _circleDetailId;
                reportVC.reportType = @"1";
                [self.navigationController pushViewController:reportVC animated:YES];
                
                
            }
            else {
                // 分享
                [self shareView];
                
            }
            
        }
        
    }
    //评论页面
    if ([_VcType isEqualToString:@"4"]) {
        
        // 举报
        ReportViewController *reportVC = [[ReportViewController alloc]init];
        reportVC.objId = _circleDetailId;
        reportVC.reportType = @"1";
        [self.navigationController pushViewController:reportVC animated:YES];
        
        
    }

    
    
    
    
    
}





- (void)configCommendUI{
    
    // 键盘回收
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.delegate = self;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    
}

// 消息页面 圈评论入口
- (void)showQuanDetail:(NSString *)QuanDetaillId {
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        // code here
    //
    //
    //        NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/activity/%@",LKB_WSSERVICE_HTTP,ActiveDetailId];
    //
    //        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //
    //        NSURL *url = [NSURL URLWithString:strmy];
    //
    //        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    //        outSideWeb.rightButtonType = @"1";
    //        outSideWeb.VcType = @"7";
    //        outSideWeb.circleDetailId = ActiveDetailId;
    //        //        outSideWeb.mytitle = attentionModel.name;
    //        //        outSideWeb.shareCover = attentionModel.img;
    //
    //        outSideWeb.hidesBottomBarWhenPushed = YES;
    //        [self.navigationController pushViewController:outSideWeb animated:YES];
    //
    //
    //
    //    });
    
    
}


// H5 专栏点击
- (void)showColumnDetail:(NSString *)ColumnDetailId {
    
    
    NSLog(@"-------------------------------------%@",_couAvatar);
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        
        ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
        ColumnListViewVC.featureId = ColumnDetailId;// 专栏Id
        //    ColumnListViewVC.title = attentionModel.featureName;
        ColumnListViewVC.featureAvatar = _couAvatar;
        //    ColumnListViewVC.featureDesc = attentionModel.featureDesc;
        
        [self.navigationController pushViewController:ColumnListViewVC animated:YES];
        
        
    });
    
    
}


// 圈评论列表有空沙发
- (void)showQuanWriteComment:(NSInteger )WriteCommentId {
    
    _commendVcType = @"1";
    
    NSLog(@"-----------------------------------------------------------");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        
        [self sendButton];
        
        
    });
    
    
}

// 文章评论列表有空沙发
- (void)showArticleWriteComment:(NSString *)ArticleDetailId {
    
    NSLog(@"-----------------------------------------------------------");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        
        [self sendButton];
        
        
    });
    
}




//- (void)showArticleDetail:(NSString *)ArticleDetailId;// 文章详情
// 文章评论列表有空沙发
- (void)initErrorContet{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        
        [_bottomView removeFromSuperview];
        
        rightBtn.hidden = YES;
        
    });
    
}





- (void)textViewDidChange:(UITextView *)textView{
    
    if ([textView.text length] == 0) {
        [label setHidden:NO];
        senderButton.userInteractionEnabled = NO;
        [senderButton setTitleColor:UIColorWithRGBA(22, 153, 71, 0.5) forState:UIControlStateNormal];
        
    }else{
        [label setHidden:YES];
        senderButton.userInteractionEnabled = YES;
        [senderButton setTitleColor:UIColorWithRGBA(22, 153, 71, 1) forState:UIControlStateNormal];
        
    }
    
    CGSize constraintSize;
    
    constraintSize. width = 260 ;
    
    constraintSize. height = MAXFLOAT ;
    
    CGSize sizeFrame =[textView.text sizeWithFont:textView.font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    
    //    textView.frame = CGRectMake( 0 , 0 ,sizeFrame.width,sizeFrame.height);
    
    if (sizeFrame.height < 140) {
        [commentText setFrame:CGRectMake(5, 5, self.view.frame.size.width-65, 140)];
        
        [topView setFrame:CGRectMake(0, -sizeFrame.height + 10, self.view.frame.size.width,140)];
        
        [senderButton setFrame:CGRectMake(kDeviceWidth -70, sizeFrame.height -14, 70, 40)];
    }
    else {
        
        [commentText setFrame:CGRectMake(5, 0, self.view.frame.size.width-70, 140)];
        [topView setFrame:CGRectMake(0, -98, self.view.frame.size.width, 140)];
        
        [senderButton setFrame:CGRectMake(kDeviceWidth -70, 98 , 70, 40)];
        
        commentText.scrollEnabled = YES;
        
    }
}


// 键盘回收
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    
    [commentText resignFirstResponder];
    
    [backGroundView removeFromSuperview];
    
    NSString *objectId = [NSString stringWithFormat:@"commendDetail%@",_objectId];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if (commentText.text != nil) {
        
        [user setObject:commentText.text forKey:objectId];
        if (![commentText.text isEqualToString:@""]) {
            
            [sendButton setTitle:@"[保存草稿]" forState:UIControlStateNormal];
            
        }
        
    }
    
    NSString *str = [user objectForKey:objectId];
    
    
    NSLog(@"------------------------------%@",str);
    
    
    
    
}

// 发表评论
- (void)sendButton {
    
    
    
    backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    backGroundView.backgroundColor = [UIColor blackColor];
    backGroundView.alpha = 0.4;
    
    [backGroundView addGestureRecognizer:tapGestureRecognizer];
    
    commentsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height - 216-40 -30, self.view.frame.size.width-70, 45.0)];
    commentsView.backgroundColor = [UIColor clearColor];
    
    commentText = [[UITextView alloc] initWithFrame:CGRectInset(commentsView.bounds, 5.0, 5.0)];
    commentText.layer.borderColor   = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    commentText.layer.borderWidth   = 1.0;
    commentText.layer.cornerRadius  = 2.0;
    commentText.layer.masksToBounds = YES;
    
    
    
    //            commentText.text = @"请输入回复内容";
    commentText.textColor= CCCUIColorFromHex(0x888888);
    commentText.keyboardType = UIKeyboardAppearanceDefault;
    commentText.returnKeyType = UIReturnKeyDefault;
    //        commentText.inputAccessoryView  = commentsView;
    commentText.backgroundColor = [UIColor whiteColor];
    commentText.delegate = self;
    commentText.font = [UIFont systemFontOfSize:15.0];
    
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 200, 14)];
    label.text = @"请输入回复内容";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = CCCUIColorFromHex(0x888888);
    
    [commentText addSubview:label];
    
    
    
    topView = [[UIToolbar alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 70, self.view.frame.size.height -216-40-40, 76, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    
    commentText.inputAccessoryView = topView;
    
    senderButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth -70, 0, 70, 40)];
    [senderButton setTitle:@"发送" forState:UIControlStateNormal];
    senderButton.backgroundColor = [UIColor whiteColor];
    
    
    
    NSString *objectId = [NSString stringWithFormat:@"commendDetail%@",_objectId];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //        [user setObject:commentText.text forKey:objectId];
    
    NSString *str = [user objectForKey:objectId];
    
    
    NSLog(@"------------------------------%@",str);
    
    
    if (str == nil || [str isEqualToString:@""]) {
        
        if ([_sendMessageType isEqualToString:@"3"]) {
            
            [sendButton setTitle:@"回复评论" forState:0];
            
        }
        else {
            
            [sendButton setTitle:@"发表评论" forState:0];
            
        }
        label.hidden = NO;
        [senderButton setTitleColor:UIColorWithRGBA(22, 153, 71, 0.5) forState:UIControlStateNormal];
        senderButton.userInteractionEnabled = NO;
    }
    else {
        
        commentText.text = [NSString stringWithFormat:@"%@",str];
        label.hidden = YES;
        senderButton.userInteractionEnabled = YES;
        [senderButton setTitleColor:UIColorWithRGBA(22, 153, 71, 1) forState:UIControlStateNormal];
        
    }
    
    
    [senderButton addTarget:self action:@selector(senderMessagerButton:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:senderButton];
    
    [topView addSubview:commentText];
    
    [commentsView addSubview:topView];
    
    [backGroundView addSubview:commentsView];
    [self.view.window addSubview:backGroundView];//添加到window上或者其他视图也行，只要在视图以外就好了
    
    
    [commentText becomeFirstResponder];//让textView成为第一响应者（第一次）这次键盘并未显示出来，（个人觉得这里主要是将commentsView设置为commentText的inputAccessoryView,然后再给一次焦点就能成功显示）
    
    
    //            [commentText becomeFirstResponder];//再次让textView成为第一响应者（第二次）这次键盘才成功显示
}

//发送评论
-(void)senderMessagerButton:(id)sender {
    
    static const NSInteger Min_Num_TextView = 10;
    static const NSInteger Max_Num_TextView = 5000;
    
    
    if (commentText.text.length==0) {
        
        [self ShowProgressHUDwithMessage:@"请输入评论"];
    }
    if (commentText.text.length > Max_Num_TextView ) {
        
        [self ShowProgressHUDwithMessage:@"评论内容最多5000个字"];
        
    }
    
    else
    {
        if ([_commendVcType isEqualToString:@"1"]) {
            
            if ([_VcType isEqualToString:@"1"]) {
                
                self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                      @"topicId":_circleDetailId,
                                      @"content":commentText.text,
                                      @"token":[[MyUserInfoManager shareInstance]token]};
                self.requestURL = LKB_Topic_Reply_Url;
                
            }
            else {
                // 专栏一级页面评论
                self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                      @"insightId":_objectId,
                                      @"content":commentText.text,
                                      @"token":[[MyUserInfoManager shareInstance]token]
                                      };
                self.requestURL = LKB_Insight_Reply_Url;
                
                
            }
            
            
        }
        else {
            
            if ([_commendVcType isEqualToString:@"2"]) {
                
                if ([_commentType isEqualToString:@"0"]) {
                    // 圈子二级页面评论
                    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                          @"topicId":_circleDetailId,
                                          @"parentId":_QuanDetailId,
                                          @"content":commentText.text,
                                          @"token":[[MyUserInfoManager shareInstance]token]};
                    self.requestURL = LKB_Topic_Reply_Url;
                    
                }
                else {
                    
                    // 专栏二级页面评论
                    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                          @"insightId":_circleDetailId,// 文章Id
                                          @"commentId":_objectId,// 评论Id
                                          @"content":commentText.text,
                                          @"token":[[MyUserInfoManager shareInstance]token]
                                          };
                    self.requestURL = LKB_Insight_Reply_Url;
                    
                }
            }
            
        }
        
    }
    if ([commentText isFirstResponder]) {
        [commentText resignFirstResponder];
        commentText.text = nil;
    }
    
    NSString *objectId = [NSString stringWithFormat:@"commendDetail%@",_objectId];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    [user setObject:nil forKey:objectId];
    
    
    NSString *str = [user objectForKey:objectId];
    
    
    NSLog(@"------------------------------%@",str);
    
    if ([_sendMessageType isEqualToString:@"3"]) {
        [sendButton setTitle:@"回复评论" forState:0];
        
    }
    else {
        [sendButton setTitle:@"发表评论" forState:0];
        
    }
    
    
    
    
}






- (void)configUI{
    
    //    [self congifIndicator];
    
    if (!_detailWeb) {
        
        _detailWeb = [[UIWebView alloc] init];
        _detailWeb.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight -64 );
        _detailWeb.scrollView.bounces = NO;
        _detailWeb.scalesPageToFit = YES;
        _detailWeb.delegate = self;
        [self.view addSubview:_detailWeb];
        [self.view addSubview:self.loadingView];
        
//        [self followRollingScrollView:_detailWeb];
    }
}




- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //将tianbai对象指向自身
    self.jsContext[@"appView"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    
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

    }else if ([requestURL rangeOfString:@".html"].location != NSNotFound) {
        
        
        YQWebDetailViewController* webDetailVC = [[YQWebDetailViewController alloc] init];
        webDetailVC.urlStr = requestURL;
//        webDetailVC.mytitle = insight.shareTitle;
//        webDetailVC.coverUrl = insight.shareImage;
        webDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webDetailVC animated:YES];
        
        return NO;

    }
    else {
        
        return YES;
    }
    
    
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    if ([_VcType isEqualToString:@"1"]||[_VcType isEqualToString:@"2"]||[_VcType isEqualToString:@"3"]||[_VcType isEqualToString:@"4"]) {
        
        _detailWeb.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight - 64 -50);
    }
    else {
        _detailWeb.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight -64 );
        
    }
    
    // 设置javaScriptContext上下文
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //将tianbai对象指向自身
    self.jsContext[@"appView"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    NSString *str = [_detailWeb stringByEvaluatingJavaScriptFromString:@"initErrorContet();"];
    
    
    
    NSLog(@"JS返回值：%@",str);
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    
    [_loadingView dismissLoadingView];
    _loadingView = nil;
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    if ([[pushJudge objectForKey:@"push"] isEqualToString:@"push"]) {
        
        [self.tabBarController.tabBar setHidden:YES];
        
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
        //    [self.navigationController.navigationBar addSubview:backBtn];
        [backBtn addTarget:self action:@selector(rebackToRootViewAction) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    }

    
    
    
    sendButton = [[UIButton alloc]init];
    if ([_sendMessageType isEqualToString:@"1"]) {
        
        sendButton.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.6, 50);
    }
    else if ([_sendMessageType isEqualToString:@"2"]) {
        
        sendButton.frame = CGRectMake(0, 0, SCREEN_WIDTH -104 , 50);
        
    }
    else {
        sendButton.frame = CGRectMake(0, 0, SCREEN_WIDTH  , 50);
        
    }
    
    sendButton.backgroundColor = [UIColor whiteColor];
    sendButton. contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [sendButton setImage:[UIImage imageNamed:@"comment_line"] forState:0];
    sendButton.imageEdgeInsets = UIEdgeInsetsMake(-4,16,0,0);
    
    NSString *objectId = [NSString stringWithFormat:@"commendDetail%@",_objectId];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //        [user setObject:commentText.text forKey:objectId];
    
    NSString *stree = [user objectForKey:objectId];
    
    NSLog(@"<<<<<<<<<<<<<<<<<<------------------------%@",stree);
    
    if (stree == nil || [stree isEqualToString:@""]) {
        
        if ([_sendMessageType isEqualToString:@"3"]) {
            [sendButton setTitle:@"回复评论" forState:0];
            
        }
        else {
            
            [sendButton setTitle:@"发表评论" forState:0];
            
        }
        
    }
    else {
        
        [sendButton setTitle:@"[保存草稿]" forState:0];
        
    }
    
    sendButton.titleEdgeInsets = UIEdgeInsetsMake(6,22, 10, 0);
    [sendButton setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [sendButton addTarget:self action:@selector(sendButton) forControlEvents:UIControlEventTouchUpInside];
    
    // 评论里面三个按钮的时候
    UIButton *commendButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 144, 0, 22, 50)];
    [commendButton setImage:[UIImage imageNamed:@"bottom_icon_comment_nor"] forState:0];
    commendButton.imageEdgeInsets = UIEdgeInsetsMake(-10,0,0,0);
    [commendButton setTitle:@"评论" forState:0];
    commendButton.titleEdgeInsets = UIEdgeInsetsMake(40,-22, 10, 0);
    commendButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [commendButton setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
    [commendButton addTarget:self action:@selector(commendButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *commendImage = [[UIImageView alloc]init];
    
    
    
    NSString *replyStr = _replyNum;
    
    int reply = [replyStr intValue];
    
    
    
    commendLabel = [[UILabel alloc]init];
    
    if (reply < 10) {
        
        commendImage.frame = CGRectMake(8, 3, 19, 17);
        commendLabel.frame =CGRectMake(0, 0, 19, 17);
        commendImage.image = [UIImage imageNamed:@"comment_number_bg_1"];
    }
    else if (reply < 100 && reply >10 ) {
        commendImage.frame = CGRectMake(8, 3, 25, 17);
        commendLabel.frame =CGRectMake(0, 0, 25, 17);
        commendImage.image = [UIImage imageNamed:@"comment_number_bg_2"];
        
    }
    else if (reply > 100) {
        commendImage.frame = CGRectMake(8, 3, 31, 17);
        commendLabel.frame =CGRectMake(0, 0, 31, 17);
        commendImage.image = [UIImage imageNamed:@"comment_number_bg_3"];
        
    }
    
    commendLabel.textColor = [UIColor whiteColor];
    commendLabel.font = [UIFont systemFontOfSize:10];
    commendLabel.textAlignment = NSTextAlignmentCenter;
    commendLabel.text = _replyNum;
    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 92, 0, 22, 50)];
    [shareButton setImage:[UIImage imageNamed:@"bottom_icon_share_nor"] forState:0];
    shareButton.imageEdgeInsets = UIEdgeInsetsMake(-10,0,0,0);
    [shareButton setTitle:@"分享" forState:0];
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(40,-22, 10, 0);
    [shareButton setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *columnButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -40, 0, 22, 50)];
    columnAvatar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, 22, 22)];
    
    columnAvatar.layer.cornerRadius = 11;
    columnAvatar.layer.masksToBounds = YES;
    
    [columnAvatar sd_setImageWithURL:[_couAvatar lkbImageUrl8] placeholderImage:LKBSecruitPlaceImage];
    
    
    UILabel * columnLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 26, 22, 26)];
    
    columnLabel.text = @"专栏";
    columnLabel.textColor =CCCUIColorFromHex(0xaaaaaa);
    columnLabel.font = [UIFont systemFontOfSize:10];
    [columnButton addSubview:columnAvatar];
    [columnButton addSubview:columnLabel];
    
    
    
    
    [columnButton addTarget:self action:@selector(columnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // 评论里面两个的时候
    collection = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 92, 12, 22, 22)];
    
    
    collection.imageEdgeInsets = UIEdgeInsetsMake(-10,0,0,0);
    [collection setTitle:@"关注" forState:0];
    collection.titleEdgeInsets = UIEdgeInsetsMake(40,-22, 10, 0);
    [collection setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
    collection.titleLabel.font = [UIFont systemFontOfSize:10];
    
        // 是否关注
        if ([_isAttention isEqualToString:@"0"]) {
            // 已经关注
            [collection setImage:[UIImage imageNamed:@"Discover_icon_collected_nor"] forState:UIControlStateNormal];
            collection.tag = UNATTENTION_TOPIC;
        }
        else {
            // 未关注
            [collection setImage:[UIImage imageNamed:@"bottom_icon_collect_nor"] forState:0];
            collection.tag = ATTENTION_TOPIC;
        }
    
    
    
    [collection addTarget:self action:@selector(collectionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * share = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40 ,12, 22, 22)];
    
    share.imageEdgeInsets = UIEdgeInsetsMake(-10,0,0,0);
    [share setTitle:@"分享" forState:0];
    share.titleEdgeInsets = UIEdgeInsetsMake(40,-22, 10, 0);
    [share setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
    share.titleLabel.font = [UIFont systemFontOfSize:10];
    
    
    [share setImage:[UIImage imageNamed:@"bottom_icon_share_nor"] forState:0];
    [share addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    if ([_sendMessageType isEqualToString:@"1"]) {
        
        [self.view addSubview:self.bottomView];
        [self.bottomView addSubview:sendButton];
        
        [self.bottomView addSubview:commendButton];
        [commendImage addSubview:commendLabel];
        
        //        [commendButton addSubview:commendImage];
        
        [commendButton addSubview:commendImage];
        [self.bottomView addSubview:shareButton];
        [self.bottomView addSubview:columnButton];
        
    }
    if ([_sendMessageType isEqualToString:@"2"]) {
        [self.view addSubview:self.bottomView];
        [self.bottomView addSubview:sendButton];
        [self.bottomView addSubview:share];
        [self.bottomView addSubview:collection];
        
    }
    if ([_sendMessageType isEqualToString:@"3"]) {
        [self.view addSubview:self.bottomView];
        [self.bottomView addSubview:sendButton];
        
    }
    
    
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    NSLog(@"url监听是什么：%@", currentURL);
    
    NSString *url1 = [NSString stringWithFormat:@"%@/detail/error/page",LKB_WSSERVICE_HTTP];
    
    if ([currentURL isEqual:url1]) {
        [self initErrorContet];
    }
    
    NSString *urlStr =  [NSString stringWithFormat:@"%@/detail/activity/form/%@",LKB_WSSERVICE_HTTP,_circleDetailId];
    
    if ([currentURL isEqual:urlStr]) {
        
        rightBtn .hidden = YES;
        _rightButtonType = @"3";
        
    }
    NSString *urlSuccessStr =  [NSString stringWithFormat:@"%@/detail/activity/success?id=%@",LKB_WSSERVICE_HTTP,_circleDetailId];
    
    if ([currentURL isEqual:urlSuccessStr]) {
        
        rightBtn .hidden = YES;
        _rightButtonType = @"3";
    }
    
    
    
    
    
    
    
    // 设置javaScriptContext上下文
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //将tianbai对象指向自身
    self.jsContext[@"appView"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    NSString *str = [_detailWeb stringByEvaluatingJavaScriptFromString:@"initErrorContet();"];
    NSLog(@"JS返回值：%@",str);
    
    //NSString *str = [_detailWeb stringByEvaluatingJavaScriptFromString:@"postStr();"];
    
}
- (void)call{
    NSLog(@"call");
    // 之后在回调JavaScript的方法Callback把内容传出去
    JSValue *Callback = self.jsContext[@"Callback"];
    //传值给web端
    [Callback callWithArguments:@[@"唤起本地OC回调完成"]];
}

// 举报
- (void)showReport
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _actionshare = [ZFActionSheet actionSheetWithTitle:@"请选择" confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
        _chatResportType = @"1";
        _actionshare.delegate = self;
        [_actionshare showInView:self.view.window];

        
    });

}


// 消息页面评论二级页面专栏的头部
- (void)showArticleDetail:(NSString *)QuanDetaillId {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //        // code here
        //
        //        FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
        //
        //
        //        //         NSDictionary *myCircleID = [self dictionaryWithJsonString:showCirCleId];
        //
        //
        //        NSString *circleIdAndIfJion = showCirCleId;
        //
        //        NSArray *array = [circleIdAndIfJion componentsSeparatedByString:@":"];
        //
        //
        //        NSString *circleId = array[0];
        //
        //        NSString *ifJion = array[1];
        //
        //
        //        NSString *str = [NSString stringWithFormat:@"circle%@",circleId];
        //
        //        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        //        //
        //        NSString *passWord = [ user objectForKey:str];
        //
        //        if (!passWord) {
        //            farmerVC.ifJion = ifJion;
        //        }
        //        else
        //        {
        //            farmerVC.ifJion = passWord;
        //        }
        //        farmerVC.circleId = circleId;
        //        farmerVC.toUserId = [MyUserInfoManager shareInstance].userId;
        //        farmerVC.mytitle = _groupName;
        //        //
        //
        //        farmerVC.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:farmerVC animated:YES];
    });
    
}


// 圈子详情的头部点击
- (void)showQuanList:(NSString *)showCirCleId
{
    
    
    NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",_groupName);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        
        FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
        
        
        //         NSDictionary *myCircleID = [self dictionaryWithJsonString:showCirCleId];
        
        
        NSString *circleIdAndIfJion = showCirCleId;
        
        NSArray *array = [circleIdAndIfJion componentsSeparatedByString:@":"];
        
        
        NSString *circleId = array[0];
        
        NSString *ifJion = array[1];
        
        
        NSString *str = [NSString stringWithFormat:@"circle%@",circleId];
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        //
        NSString *passWord = [ user objectForKey:str];
        
        if (!passWord) {
            farmerVC.ifJion = ifJion;
            [CircleIfJoinManager shareInstance].ifJoin = ifJion;

        }
        else
        {
            farmerVC.ifJion = passWord;
            [CircleIfJoinManager shareInstance].ifJoin = passWord;

        }
        

        farmerVC.circleId = circleId;
        farmerVC.toUserId = [MyUserInfoManager shareInstance].userId;
        farmerVC.mytitle = _groupName;
        NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",_groupName);
        farmerVC.type = @"1";
        
        
        farmerVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:farmerVC animated:YES];
    });
}


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}





- (void)showImg:(NSString *)showImgString{
    NSLog(@"Get:%@", showImgString);
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        __block WFWebImageShowView *showImageView = [[WFWebImageShowView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight - 50) imageUrl:showImgString];
        
        [showImageView show:[[UIApplication sharedApplication] keyWindow] didFinish:^{
            [showImageView removeFromSuperview];
            
            
        }];
    });
    
    
    
    
    // 成功回调JavaScript的方法Callback
    //    JSValue *Callback = self.jsContext[@"alerCallback"];
    //    [Callback callWithArguments:nil];
    
}
- (void)showUserDetail:(NSInteger )uid
{
    NSLog(@".....%ld",(long)uid);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
//        UserRootViewController *userVC = [[UserRootViewController alloc]init];
//        userVC.toUserId = [NSString stringWithFormat:@"%ld",(long)uid];
//        userVC.type = @"2";
//        userVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:userVC animated:YES];
        NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
        peopleVC.type = @"2";
        peopleVC.toUserId = [NSString stringWithFormat:@"%ld",(long)uid];
        peopleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:peopleVC animated:YES];
    });
    
    
}

- (void)showUserDetail2:(NSInteger )uid
{
    NSLog(@".....%d",uid);
}



// 锄禾详情页分享
- (void)shareDetailChuhe:(NSString *)DetailChuheId {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _circleDetailId = DetailChuheId;
        
        [self shareView];
        
        
    });
}

// 活动报名成功以后完成
- (void)showActiveDetail:(NSString *)ActiveDetailId {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/activity/%@",LKB_WSSERVICE_HTTP,ActiveDetailId];
        
        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        outSideWeb.rightButtonType = @"1";
        outSideWeb.VcType = @"7";
        outSideWeb.circleDetailId = ActiveDetailId;
        //        outSideWeb.mytitle = attentionModel.name;
        //        outSideWeb.shareCover = attentionModel.img;
        
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];
        
        
    });
    
}

// 活动报名成功以后分享
- (void)shareDetailActive:(NSString *)ActiveDetailId {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _circleDetailId = ActiveDetailId;
        
        [self shareView];
        
        
    });
    
    
}

// 邀请好友
- (void)invitedQuanDetail:(NSString *)CircleDetailId
{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
        peopleVC.requestUrl = LKB_Attention_Users_Url;
        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
        peopleVC.VCType = @"1";

        peopleVC.hidesBottomBarWhenPushed = YES;
        peopleVC.title = @"我的好友";
        NSString *circleDetailId = [NSString stringWithFormat:@"%@",@"23"];
        
        
        
        if (_mytitle==nil) {
            _mytitle= @"圈子详情";
        }
        if (_describle==nil) {
            _describle= @"点击查看详情";
        }
        if (_groupAvatar == nil) {
            _groupAvatar = @"";
        }
        
        _shareCover = [NSString stringWithFormat:@"http://7xjm08.com2.z0.glb.qiniucdn.com/%@",_groupAvatar];
        
        
        NSDictionary *shaDic = @{@"cover":_shareCover,
                                 @"userId":[[MyUserInfoManager shareInstance]userId],
                                 @"description":_describle,
                                 @"title":_mytitle,
                                 @"circleId":_circleId,
                                 @"linkUrl":_urlStr,
                                 @"featureId":_circleDetailId,
                                 @"fromLable":@"绿科邦新农圈",
                                 @"shareType":@"2",
                                 };
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shaDic options:NSJSONWritingPrettyPrinted error:nil];
        
        NSString *jsonStr=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        peopleVC.shareDes =[NSString stringWithFormat: @"%@邀请您回答：<a href='http://www.lvkebang.cn/wenda/%@'>【%@】</a>",[[MyUserInfoManager shareInstance]userName],circleDetailId,@"圈子名字"];
        
        peopleVC.shareDes = jsonStr;
        
        peopleVC.ifshare = @"2";
        peopleVC.questionId = CircleDetailId;
        //    peopleVC.questionUserId = _questionUserId;
        [self.navigationController pushViewController:peopleVC animated:YES];
        
        
    });
    
    
    
    
    
}

//跳转圈子评论页评论一级  阅读更多
- (void)showCommentQuanDetail:(NSString *)QuanDetailId {
    
    
    NSLog(@"===========================%@",QuanDetailId);
    NSLog(@".......>>>>>>>===========================%@",_objectId);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        // http://192.168.1.199:8082/app/detail/agriculture/comment/172?sourceId=1
        NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/comment/%@",LKB_WSSERVICE_HTTP,QuanDetailId];
        
        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        
        
        
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        outSideWeb.sendMessageType = @"3";
        outSideWeb.rightButtonType = @"2";
        outSideWeb.VcType = @"4";
        outSideWeb.circleDetailId = _circleDetailId;
        outSideWeb.QuanDetailId = QuanDetailId;
        outSideWeb.commendVcType = @"2";
        outSideWeb.objectId = QuanDetailId;
        outSideWeb.commentType = @"0";
        //        outSideWeb.isAttention = insight.isAttention;
        
        NSLog(@"----------------------------%@",outSideWeb.objectId);
        
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];
    });
    
}

// 跳转专栏评论详情页 评论二级
- (void)showArticleCommentDetail:(NSString *)ArticleCommentDetailId {
    
    
    NSLog(@"===========================%@",ArticleCommentDetailId);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        // http://192.168.1.199:8082/app/detail/agriculture/comment/172?sourceId=1
        NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/insight/comment/%@",LKB_WSSERVICE_HTTP,ArticleCommentDetailId];
        
        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        
        
        
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        outSideWeb.sendMessageType = @"3";
        outSideWeb.rightButtonType = @"2";
        outSideWeb.VcType = @"4";
        outSideWeb.circleDetailId = _circleDetailId; // 专栏文章详情Id
        outSideWeb.QuanDetailId = ArticleCommentDetailId; // 评论Id
        outSideWeb.commendVcType = @"2";
        outSideWeb.objectId = ArticleCommentDetailId;// 评论Id
        outSideWeb.commentType = @"1";
        
        NSLog(@"----------------------------%@",outSideWeb.objectId);
        
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];
    });
    
    
}



- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (errorMessage) {
       [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    
    if ([request.url isEqualToString:LKB_Topic_Reply_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
            [self ShowProgressHUDwithMessage:@"评论成功"];
            // 评论完回调 一级页面评论完回调
            if ([_commendVcType isEqualToString:@"1"]) {
                
                JSValue *Callback = self.jsContext[@"InitComment"];
                [Callback callWithArguments:nil];
                
            }
            if ([_commendVcType isEqualToString:@"2"]) {
                
                JSValue *CallDetailback = self.jsContext[@"InitAjaxSonComment"];
                [CallDetailback callWithArguments:nil];
                
            }
            
        }
        
        backGroundView.hidden = YES;
    }
    
    if ([request.url isEqualToString:LKB_Insight_Reply_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
            [self ShowProgressHUDwithMessage:@"评论成功"];
            // 评论完回调 一级页面评论完回调
            if ([_commendVcType isEqualToString:@"1"]) {
                
                JSValue *Callback = self.jsContext[@"InitComment"];
                [Callback callWithArguments:nil];
                
            }
            if ([_commendVcType isEqualToString:@"2"]) {
                
                JSValue *CallDetailback = self.jsContext[@"InitAjaxSonComment"];
                [CallDetailback callWithArguments:nil];
                
            }
            
        }
        
        backGroundView.hidden = YES;
    }
    
    if ([request.url isEqualToString:LKB_Topic_Attention_Url]) {
        
        collection.tag = UNATTENTION_TOPIC;
        
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        NSLog(@"-------------------------------------------%@",replymodel.msg);
        
        if ([replymodel.msg isEqualToString:@"关注成功！"]) {
            //            [self ShowProgressHUDwithMessage:@"关注成功！"];
            
            [collection setImage:[UIImage imageNamed:@"Discover_icon_collected_nor"] forState:UIControlStateNormal];
        }
        //        [self.tableView reloadData];
        
    }
    if ([request.url isEqualToString:LKB_Topic_UnAttention_Url]) {
        
        collection.tag = ATTENTION_TOPIC;
        
        
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        NSLog(@"-------------------------------------------%@",replymodel.msg);
        
        if ([replymodel.msg isEqualToString:@"取消关注成功！"]) {
            
            //            [self ShowProgressHUDwithMessage:@"取消关注成功！"];
            
            [collection setImage:[UIImage imageNamed:@"bottom_icon_collect_nor"] forState:0];
        }
        
    }
    if ([request.url isEqualToString:LKB_Common_Collection_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
            [self ShowProgressHUDwithMessage:replymodel.msg];
            
        }
    }
    if (self.requestURL ==LKB_Delete_Topic_Url) {
        
        LKBBaseModel* responseModel = (LKBBaseModel*)parserObject;
        
        if ([responseModel.success isEqualToString:@"1"]) {
            
            [self ShowProgressHUDwithMessage:responseModel.msg];

            NSLog(@"===========================%@",responseModel.msg);
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

    
}

// 专栏详情   跳转到评论页面
- (void)commendButton:(id)sender  {
    
    NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/insight/replys?insightId=%@",LKB_WSSERVICE_HTTP,_objectId];
    
    NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];
    
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    outSideWeb.sendMessageType = @"3";
    outSideWeb.rightButtonType = @"2";
    outSideWeb.VcType = @"4";
    outSideWeb.objectId = _objectId;// 专栏详情Id
    outSideWeb.commendVcType = @"1";
    outSideWeb.circleDetailId = _objectId; // 专栏详情Id
    //    outSideWeb.isAttention = insight.isAttention;
    
    NSLog(@"----------------------------%@",outSideWeb.objectId);
    
    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];
    
    
    
}

// 专栏详情   跳转到专栏详情页面
- (void)columnButton:(id)sender  {
    
    NSLog(@"-------------------------------------%@",_featureId);
    
    ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
    ColumnListViewVC.featureId = _featureId;// 专栏Id
    //    ColumnListViewVC.title = attentionModel.featureName;
    ColumnListViewVC.featureAvatar = _couAvatar;
    //    ColumnListViewVC.featureDesc = attentionModel.featureDesc;
    
    [self.navigationController pushViewController:ColumnListViewVC animated:YES];
    
    
    
}
// 圈子详情关注
- (void)collectionButton:(id)sender {
    
    if (collection.tag == UNATTENTION_TOPIC) {
        [collection setImage:[UIImage imageNamed:@"bottom_icon_collect_nor"] forState:UIControlStateNormal];
        
        self.requestParas = @{@"topicId":_circleDetailId,
                              @"userId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token]
                              };
        self.requestURL = LKB_Topic_UnAttention_Url;
    }
    else if (collection.tag == ATTENTION_TOPIC){
        [collection setImage:[UIImage imageNamed:@"Discover_icon_collected_nor"] forState:UIControlStateNormal];
        self.requestParas = @{@"topicId":_circleDetailId,
                              @"userId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token]
                              };
        self.requestURL = LKB_Topic_Attention_Url;
    }
    
}

- (void)ShowProgressHUDwithMessage:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.dimBackground = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}




- (void)getCall:(NSString *)callString{
    NSLog(@"Get:%@", callString);
    // 成功回调JavaScript的方法Callback
    JSValue *Callback = self.jsContext[@"alerCallback"];
    [Callback callWithArguments:nil];
}


- (void)alert{
    
    // 直接添加提示框
    NSString *str = @"alert('OC添加JS提示成功')";
    [self.jsContext evaluateScript:str];
    
}

- (void)h5backData:(NSString *)h5backDataJson
{
    

    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"============%@=====",h5backDataJson);
        
        NSDictionary *mydic = [self dictionaryWithJsonString:h5backDataJson];
        
        
        
        
        NSLog(@"字典是什么===%@",mydic);
        
        
        
        if ([_VcType isEqualToString:@"1"]) {
            if ([mydic[@"data"][@"isAttention"] isEqualToString:@"1"]) {
                // 是否关注
                
                // 未关注
                [collection setImage:[UIImage imageNamed:@"bottom_icon_collect_nor"] forState:0];
                collection.tag = ATTENTION_TOPIC;
                
                
            }
            else {
                // 已经关注
                [collection setImage:[UIImage imageNamed:@"Discover_icon_collected_nor"] forState:UIControlStateNormal];
                collection.tag = UNATTENTION_TOPIC;
                
            }
            
        }
        if ([_VcType isEqualToString:@"2"])
        {
            commendLabel.text =[NSString stringWithFormat:@"%@",mydic[@"data"][@"replyNum"]];
            
            
            
            _couAvatar = mydic[@"data"][@"featureAvatar"];
            [columnAvatar sd_setImageWithURL:[_couAvatar lkbImageUrl8] placeholderImage:LKBSecruitPlaceImage];

            _objectId = mydic[@"data"][@"insightId"];
            _featureId = mydic[@"data"][@"featureId"];
            _mytitle = mydic[@"data"][@"title"];
            _groupAvatar = mydic[@"data"][@"cover"];
            


        }
        if ([_VcType isEqualToString:@"7"])
        {
            
            
            
            _objectId = mydic[@"data"][@"id"];
            _mytitle = mydic[@"data"][@"name"];
            _groupAvatar = mydic[@"data"][@"img"];
            
        }

        

    });
    
    
    
    
    
}






@end
