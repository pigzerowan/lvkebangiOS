//
//  YQWebDetailViewController.h
//  youqu
//
//  Created by chun.chen on 15/10/2.
//  Copyright (c) 2015年 youqu. All rights reserved.
//
#import "BaseViewController.h"



@interface YQWebDetailViewController : BaseViewController<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (copy, nonatomic) NSString *urlStr;

@property (copy, nonatomic) NSString *infoId;
@property (copy, nonatomic) NSString *sharetext;
@property (strong, nonatomic) NSString *mytitle;
@property (strong, nonatomic) NSString *coverUrl;
@property (strong, nonatomic) NSString *shareCover;// 分享字典里的图片

@end
