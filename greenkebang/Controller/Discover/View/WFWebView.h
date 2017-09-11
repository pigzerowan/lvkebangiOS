//
//  WFWebView.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WFDetailVM.h"

//
#import <JavaScriptCore/JavaScriptCore.h>
//
//@protocol JSObjcDelegate <JSExport>
////tianbai对象调用的JavaScript方法，必须声明！！！
//- (void)call;
//- (void)getCall:(NSString *)callString;
//
//@end


@protocol WFWebViewDelegate <NSObject>

@optional
/**
 *  点击图片触发事件
 *
 *  @param imageUrl 图片url
 */
- (void)clickActionOnImage:(NSString *)imageUrl;
- (void)hideButtomView:(id *)sender;
- (void)sendeHeight:(float )height;
/**
 *  点击超链接触发事件
 *
 *  @param linkUrl 链接url
 */
- (void)clickActionOnHyperlink:(NSString *)linkUrl;

@end

@interface WFWebView : UIWebView<UIWebViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic, assign) id<WFWebViewDelegate>webDelegate;

@property (nonatomic, strong) JSContext *jsContext;

@property(copy,nonatomic) NSString *urlResurlt;

@end
