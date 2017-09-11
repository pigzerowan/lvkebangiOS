/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "BaseViewController.h"
#import "TabbarManager.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
    
    
}




- (void)setRequestPostWithChcheURL:(NSString*)url
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
    
    
    [[LKBNetworkManage sharedMange] postRequestCacheURLStr:url withDic:transferParas success:^(id parserObject) {
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
        
        
    } failure:^(NSString *errorMessage) {
        
        NSLog(@"=========================%@",errorMessage);
        
        
        if (showLoading) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        [wSelf actionFetchRequest:requestModel result:nil errorMessage:errorMessage];
    }];
    
    
    
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



- (void)setRequestGetURL:(NSString*)url
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
    
    [[LKBNetworkManage sharedMange] getInfoDataWithServiceUrl:url
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

//#ifdef __IPHONE_7_0
//- (UIRectEdge)edgesForExtendedLayout
//{
//    return UIRectEdgeNone;
//}


@end
