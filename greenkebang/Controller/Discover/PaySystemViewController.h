//
//  PaySystemViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 9/13/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
//导入头文件
#import <JavaScriptCore/JavaScriptCore.h>

@protocol PaySystemJSObjectDelegate <JSExport>
- (void)goToApply;// 申请页面

@end

@interface PaySystemViewController : UIViewController<UIWebViewDelegate,PaySystemJSObjectDelegate>

@property (nonatomic,strong)UIWebView *myWebView;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) NSString *mallUrl;
@property (nonatomic, strong) NSString *errorMessage;

@end
