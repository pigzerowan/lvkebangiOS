//
//  PaySystemViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 9/13/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "PaySystemViewController.h"
#import "MyUserInfoManager.h"
#import "NSStrUtil.h"
#import "TabbarManager.h"
#import "BaseTimeViewController.h"
#import "DiscoveryRootViewController.h"
#import "UserInforRootViewController.h"
#import "YanzhengModel.h"
#import "LKBNetworkManage.h"
#import "TranceApplyViewController.h"
#import "WFLoadingView.h"
#import "PermissionToApplyViewController.h"



@interface PaySystemViewController ()<NSXMLParserDelegate,UIGestureRecognizerDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    UIImageView *noNetImg;
    UILabel *nonetLable;
    UIButton *tryAgainBtn;
    UILabel * commendLabel;
    UIImageView *columnAvatar;

    UILabel * label;
    UIButton *collection;
    NSString *jsonStr;
    UIButton *rightBtn ;
    UIButton *sendButton;

}
@property (nonatomic,strong) WFLoadingView *loadingView;//加载视图
@property (nonatomic,strong) UIImageView *enterImg;//加载视图
//@property (strong, nonatomic) CustomURLCache *urlCache;
@property (strong, nonatomic) NSURLCache *urlCache;
@end


@implementation PaySystemViewController


- (NSArray *)words:(id)strmd5
{
    //#if ! __has_feature(objc_arc)
    //#else
    NSMutableArray *words = [[NSMutableArray alloc] init];
    //#endif
    
    const char *str = [strmd5 cStringUsingEncoding:NSUTF8StringEncoding];
    
    char *word;
    for (int i = 0; i < strlen(str);) {
        int len = 0;
        if (str[i] >= 0xFFFFFFFC) {
            len = 6;
        } else if (str[i] >= 0xFFFFFFF8) {
            len = 5;
        } else if (str[i] >= 0xFFFFFFF0) {
            len = 4;
        } else if (str[i] >= 0xFFFFFFE0) {
            len = 3;
        } else if (str[i] >= 0xFFFFFFC0) {
            len = 2;
        } else if (str[i] >= 0x00) {
            len = 1;
        }
        
        word = malloc(sizeof(char) * (len + 1));
        for (int j = 0; j < len; j++) {
            word[j] = str[j + i];
        }
        word[len] = '\0';
        i = i + len;
        
        NSString *oneWord = [NSString stringWithCString:word encoding:NSUTF8StringEncoding];
        free(word);
        [words addObject:oneWord];
    }
    
    return words;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    self.title = @"交易系统";
    _myWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    _myWebView.delegate =self;


    
    NSDictionary *jiaoyiDic = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                @"token":[[MyUserInfoManager shareInstance]token],
                                };
    
    
    //缓存取到的token值
    [[LKBNetworkManage sharedMange] postRequestCacheURLStr:LKB_jiaoyiValidate_Url withDic:jiaoyiDic success:^(id parserObject) {
        YanzhengModel *Model = (YanzhengModel *)parserObject;
        YanzhengDetailModel *yanzhengmodel = Model.data;
        
        
        _mallUrl = [NSString stringWithFormat:@"http://mall.lvkebang.cn/login/app/login.jhtml?token=%@&from=app",yanzhengmodel.mallToken];
        

        
        
        NSString *strmy = [_mallUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

        NSMutableURLRequest *request =   [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];

        //    //从请求中获取缓存输出
        NSCachedURLResponse *response =[self.urlCache cachedResponseForRequest:request];
        //判断是否有缓存
        if (response != nil){
            NSLog(@"如果有缓存输出，从缓存中获取数据");
            [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
        }
        //

        [_myWebView loadRequest:request];

    } failure:^(NSString *errorMessage) {
        
        _mallUrl = [NSString stringWithFormat:@"http://mall.lvkebang.cn/login/app/login.jhtml?token=%@&from=app",@""];
        
        
        
        NSString *strmy = [_mallUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSMutableURLRequest *request =   [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:500];
        
        //    //从请求中获取缓存输出
        NSCachedURLResponse *response =[self.urlCache cachedResponseForRequest:request];
        //判断是否有缓存
        if (response != nil){
            NSLog(@"如果有缓存输出，从缓存中获取数据");
            [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
        }
        //
        
        [_myWebView loadRequest:request];

        
        
        
        NSLog(@"******%@",errorMessage);
        
        if ([errorMessage isEqualToString:@"您的申请正在审核中"]) {
            
            _errorMessage = errorMessage;
            
            
        }
        
    }];
    
    
    
    _myWebView.delegate =self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myWebView];
    
    [self.view addSubview:self.enterImg];

    
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_write_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    // Do any additional setup after loading the view, typically from a nib.
}
     
#pragma mark - Getter
- (WFLoadingView *)loadingView{
    
    if (!_loadingView) {
        
        _loadingView = [[WFLoadingView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    }
    
    return _loadingView;
}


#pragma mark - Getter
- (UIImageView *)enterImg{
    
    if (!_enterImg) {
        
        _enterImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
        _enterImg.image = [UIImage imageNamed:@"Trading-System@2x"];
        _enterImg.backgroundColor = [UIColor redColor];
    }
    
    return _enterImg;
}


// 申请页面
- (void)goToApply {
    
    
    NSLog(@"==============================%@",_errorMessage);

    
    if ([_errorMessage isEqualToString:@"您的申请正在审核中"]) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            PermissionToApplyViewController * PermissionVC = [[PermissionToApplyViewController alloc]init];
            PermissionVC.btnType = @"1";
            PermissionVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:PermissionVC animated:YES];
            
        });

        
    }
    else {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            TranceApplyViewController * applyVC = [[TranceApplyViewController alloc]init];
            applyVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:applyVC animated:YES];
            
        });

    }

    
}

- (void)ShowErrorBack {
    
    NSLog(@"-----------------------------------------------------------");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        
        [self.navigationController.navigationBar setClipsToBounds:NO];
        [self.navigationController popViewControllerAnimated:YES];
        
        
    });
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setClipsToBounds:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBarTintColor:CCCUIColorFromHex(0x323436)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [MobClick beginLogPageView:@"PaySystemViewController"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"PaySystemViewController"];
    
    
}


-(void)backToMain
{
    NSLog(@"===============================%@",[TabbarManager shareInstance].vcType);
    
    if ([[TabbarManager shareInstance].vcType isEqualToString:@"0"]) {

//        BaseTimeViewController * baseTimeVC = [[BaseTimeViewController alloc]init];
//        
//        [self.navigationController presentViewController:baseTimeVC animated:YES completion:nil];

        LKBBaseTabBarController* baseTabBarVC = [[LKBBaseTabBarController alloc] init];
        baseTabBarVC.tabBar.translucent = NO;
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;

        
        [window setRootViewController:baseTabBarVC];

        
    }
    else if ([[TabbarManager shareInstance].vcType isEqualToString:@"2"]) {
        
//      DiscoveryRootViewController * discoveryRootVC = [[DiscoveryRootViewController alloc]init];
//      [self.navigationController presentViewController:discoveryRootVC animated:YES completion:nil];
        LKBBaseTabBarController* baseTabBarVC = [[LKBBaseTabBarController alloc] init];
        baseTabBarVC.tabBar.translucent = NO;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window setRootViewController:baseTabBarVC];
    }
    else if ([[TabbarManager shareInstance].vcType isEqualToString:@"3"]) {
        LKBBaseTabBarController* baseTabBarVC = [[LKBBaseTabBarController alloc] init];
        baseTabBarVC.tabBar.translucent = NO;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window setRootViewController:baseTabBarVC];
//      [self.navigationController popToRootViewControllerAnimated:YES];
//      userInforRootVC.hidesBottomBarWhenPushed = NO;
//      [self.navigationController presentViewController:userInforRootVC animated:YES completion:nil];
    }
    [TabbarManager shareInstance].vcType = nil;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
//    [_loadingView dismissLoadingView];
//    [_enterImg removeFromSuperview];
    
    
    
    [UIView animateWithDuration:1
     
                     animations:^{_enterImg.alpha = 0.0;}
     
                     completion:^(BOOL finished){
                         [_enterImg setHidden:YES];
                     }];
    
    
    
    [self removeNoNetUIWebview];
    _loadingView = nil;
    // 设置javaScriptContext上下文
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //将tianbai对象指向自身
    self.jsContext[@"appView"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    NSString *str = [_myWebView stringByEvaluatingJavaScriptFromString:@"initErrorContet();"];
    NSLog(@"JS返回值：%@",str);
    
    //NSString *str = [_detailWeb stringByEvaluatingJavaScriptFromString:@"postStr();"];


//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
//    //    [self.navigationController.navigationBar addSubview:backBtn];
//    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setImage:[UIImage imageNamed:@"nav_back_write_nor"] forState:UIControlStateNormal];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error

{
//    [_loadingView dismissLoadingView];
    [_enterImg removeFromSuperview];
    _loadingView = nil;
    [self setNoNetUIWebview];
//    [self.scrollView removeFromSuperview];
    _myWebView.scrollView.scrollEnabled = NO;
    
}

-(void)setNoNetUIWebview
{
    
    
    noNetImg = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-100, KDeviceHeight/2-180, 200, 200)];
    noNetImg.image = [UIImage imageNamed:@"noNet_image"];
    
    
    
    nonetLable = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2-100, KDeviceHeight/2-180+220, 200, 24)];
    nonetLable.text = @"无法连接到网络";
    nonetLable.textAlignment = NSTextAlignmentCenter;
    nonetLable.font = [UIFont systemFontOfSize:14];
    nonetLable.textColor = CCCUIColorFromHex(0x999999);
    
    
    tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth/2-50, KDeviceHeight/2-180+260, 100, 24)];
    [tryAgainBtn setBackgroundImage:[UIImage imageNamed:@"btn_tryagain_pre"] forState:UIControlStateNormal];
    [tryAgainBtn setTitle:@"再试试" forState:UIControlStateNormal];
    [tryAgainBtn addTarget:self action:@selector(tyrAgaintoNet:) forControlEvents:UIControlEventTouchUpInside];
    [tryAgainBtn setTitleColor:CCColorFromRGBA(33, 15, 49, 1) forState:UIControlStateNormal];
    
    
    [self.view addSubview:noNetImg];
    [self.view addSubview:nonetLable];
    [self.view addSubview:tryAgainBtn];
    
}

-(void)removeNoNetUIWebview
{
    
    [noNetImg removeFromSuperview];
     [nonetLable removeFromSuperview];
     [tryAgainBtn removeFromSuperview];

    
}


-(void)tyrAgaintoNet:(id)sender
{
    [noNetImg removeFromSuperview];
    [tryAgainBtn removeFromSuperview];
    [nonetLable removeFromSuperview];
    
    
    NSDictionary *jiaoyiDic = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                @"token":[[MyUserInfoManager shareInstance]token],
                                };
    [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_jiaoyiValidate_Url parameters:jiaoyiDic success:^(id parserObject) {
        
        NSLog(@"******%@",parserObject);
        
        
        
        YanzhengModel *Model = (YanzhengModel *)parserObject;
        YanzhengDetailModel *yanzhengmodel = Model.data;
        
        
        _mallUrl = [NSString stringWithFormat:@"http://mall.lvkebang.cn/login/app/login.jhtml?token=%@",yanzhengmodel.mallToken];
        
        
        
        NSString *strmy = [_mallUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [_myWebView loadRequest:request];
        
        
    } failure:^(NSString *errorMessage) {
        
        NSLog(@"******%@",errorMessage);
    }];

    
    
}







-(void)viewDidDisappear:(BOOL)animated
{

    [self.navigationController.navigationBar setClipsToBounds:NO];
    
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //将tianbai对象指向自身
    self.jsContext[@"appView"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    
    return YES;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//
- (BOOL)prefersStatusBarHidden//for iOS7.0
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    [urlCache removeAllCachedResponses];
    // Dispose of any resources that can be recreated.
}
@end
