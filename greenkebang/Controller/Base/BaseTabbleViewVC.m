//
//  BaseTabbleViewVC.m
//  greenkebang
//
//  Created by 郑渊文 on 9/23/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "BaseTabbleViewVC.h"

@implementation BaseTabbleViewVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Subclass can override
- (void)actionCustomLeftBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                  title:(NSString *)title  action:(void(^)())btnClickBlock

{
    
}

- (void)actionCustomRightBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                   title:(NSString *)title  action:(void(^)())btnClickBlock

{
    
}
#pragma mark -actionFetchRequest
- (void)actionFetchRequest:(YQRequestModel*)request result:(LKBBaseModel*)parserObject
              errorMessage:(NSString*)errorMessage
{
    
    //    NSLog(@"url=====================%@",self.requestURL);
    //    if (self.requestURL == LKB_Social_Regist_Url) {
    //        if ([parserObject.msg isEqualToString:@"openid已注册"]) {
    //
    //            NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //            NSString *openId = [userDefaultes stringForKey:@"openId"];
    //
    //            if (openId!=nil) {
    //                NSLog(@"=============emobId======%@===",openId);
    //                self.requestParas = @{@"openId":openId,
    //                                      @"idType":@"2",
    //                                      };
    //                self.requestURL = LKB_Social_Login_Url;
    //            }
    //    }else
    //    {
    //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //        [userDefaults setObject:parserObject.emobId forKey:@"emobId"];
    //        [userDefaults setObject:parserObject.emobPwd forKey:@"emobPwd"];
    //
    //        NSLog(@"======================%@===",parserObject.emobId);
    //         NSLog(@"======================%@===",parserObject.emobPwd);
    //        self.requestParas = @{@"userName":parserObject.emobId,
    //                              @"pwd":parserObject.emobPwd,
    //                              };
    //
    //        self.requestURL = LKB_Login_Url;
    //
    //    }
    //   }
    //
    //
    //
    //    if ((self.requestURL == LKB_Login_Url))
    //    {
    //        if ([parserObject.msg isEqualToString:@"登陆成功"]) {
    //            AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    //            [appDelegate showUserTabBarViewController];
    //        }
    //    }
    //
    //
    //
    //    if ((self.requestURL == LKB_Social_Login_Url))
    //    {
    //        if ([parserObject.msg isEqualToString:@"登陆成功"]) {
    //            AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    //            [appDelegate showUserTabBarViewController];
    //        }
    //    }
}


- (void)setRequestURL:(NSString*)url
{
    _requestURL = url;
    BOOL showLoading = [[self.requestParas objectForKey:loadingKey] boolValue];
    BOOL isLoadingMore = [[self.requestParas objectForKey:isLoadingMoreKey] boolValue];
    if (showLoading) {
        [MBProgressHUD showMessag:@"请稍后..." toView:self.view];
    }
    NSMutableDictionary* transferParas = [NSMutableDictionary dictionaryWithDictionary:[self.requestParas mutableCopy]];
    [transferParas removeObjectForKey:loadingKey];
    [transferParas removeObjectForKey:isLoadingMoreKey];
    
    YQRequestModel* requestModel = [[YQRequestModel alloc] initWithUrl:url isLoadingMore:isLoadingMore];
    __weak typeof(self) wSelf = self;
    [[LKBNetworkManage sharedMange] postResultWithServiceUrl:url
                                                  parameters:transferParas
                                                     success:^(id parserObject) {
                                                         if (showLoading) {
                                                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                         }
                                                         
                                                         LKBBaseModel* responseModel = (LKBBaseModel*)parserObject;
                                                         if ([responseModel.msg isEqualToString:@"NOT_LOGIN"]) {
                                                             [wSelf authFromLoginWithReqURL:url];
                                                         }
                                                         else {
                                                             [wSelf actionFetchRequest:requestModel result:responseModel errorMessage:nil];
                                                         }
                                                     }
                                                     failure:^(NSString* errorMessage) {
                                                         if (showLoading) {
                                                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                         }
                                                         [wSelf actionFetchRequest:requestModel result:nil errorMessage:errorMessage];
                                                     }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark -doLogin
- (void)authFromLoginWithReqURL:(NSString*)reqURL
{
}

#pragma mark -cancelLoginEvent
- (void)cancelLoginEvent
{
}

@end
