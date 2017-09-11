//
//  WFWebView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFWebView.h"

@implementation WFWebView
{
    UITapGestureRecognizer  *tapGesture;//给webview添加单击手势
}
//- (id)initWithFrame:(CGRect)frame{
//
//    if (self == [super initWithFrame:frame]) {
//        self.delegate = self;
//        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//        tapGesture.delegate = self;
//        [self addGestureRecognizer:tapGesture];
//        
//    }
//    return self;
//}
//
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    

    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //将tianbai对象指向自身
    self.jsContext[@"tianbai"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    
    
    
//    static  NSString * const jsGetImages =
//    @"function getImages(){\
//    var objs = document.getElementsByTagName(\"img\");\
//    var imgScr = '';\
//    for(var i=0;i<objs.length;i++){\
//    imgScr = imgScr + objs[i].src + '+';\
//    };\
//    return imgScr;\
//    };";
//    
//    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
//    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
////    mUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
////    if (mUrlArray.count >= 2) {
////        [mUrlArray removeLastObject];
////    }
//    //urlResurlt 就是获取到得所有图片的url的拼接；mUrlArray就是所有Url的数组
//    
//    //添加图片可点击js
//    [webView stringByEvaluatingJavaScriptFromString:@"function registerImageClickAction(){\
//     var imgs=document.getElementsByTagName('img');\
//     var length=imgs.length;\
//     for(var i=0;i<length;i++){\
//     img=imgs[i];\
//     img.onclick=function(){\
//     window.location.href='image-preview:'+this.src}\
//     }\
//     }"];
//    [webView stringByEvaluatingJavaScriptFromString:@"registerImageClickAction();"];
}
    

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
   
//    NSString *urlString = [request.URL absoluteString];
//    if ([urlString hasPrefix:@"about:blank"] ) {
//        return YES;
//    
//    }else{
//        [_webDelegate clickActionOnHyperlink:urlString];
//        return NO;
//    }
    return YES;

}


- (void)call{
    NSLog(@"call");
    // 之后在回调JavaScript的方法Callback把内容传出去
    JSValue *Callback = self.jsContext[@"Callback"];
    //传值给web端
    [Callback callWithArguments:@[@"唤起本地OC回调完成"]];
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




//- (void)webViewDidStartLoad:(UIWebView *)webView{
// 
//    NSLog(@"webView.url did start= %@",webView.request.URL);
//
//}
//
//#pragma mark - UIGestureRecognizerDelegate -
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    
//    if (gestureRecognizer == tapGesture){//如果是自定义的单击手势 返回yes
//        return YES;
//    }
//    return NO;
//}
//
//
//#pragma mark - Override -
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    if (event.type == UIEventTypeTouches) {
//        
//        NSSet *touches = [event touchesForView:self];
//        UITouch *touch = [touches anyObject];
//        
//        if (touch.phase == UITouchPhaseBegan) {
//            
//            [self addGestureRecognizer:self.scrollView.panGestureRecognizer];
//        }
//    }
//    return [super hitTest:point withEvent:event];
//}
//
//
//#pragma mark - Tap Action -
//- (void)tapAction:(UITapGestureRecognizer *)gesture{
//    
//    CGPoint touchPoint = [gesture locationInView:self];
//    
//    
//    [self getImage:touchPoint];
//    
//
//    
//}
//
//- (void)getImage:(CGPoint)pt{
//    
//    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).tagName", pt.x, pt.y];
//    
//    
//    NSString * tagName = [self stringByEvaluatingJavaScriptFromString:js];
//
//    if ([tagName isEqualToString:@"IMG"]) {
//        
//        NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
//        NSString *urlToShow = [self stringByEvaluatingJavaScriptFromString:imgURL];
//        
//        [_webDelegate clickActionOnImage:urlToShow];
//        
//    }else
//    {
//        [_webDelegate hideButtomView:nil];
//    }
//
//}

- (id)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        self.delegate = self;

//        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//        tapGesture.delegate = self;
//        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
   NSLog(@"webView.url did start= %@",webView.request.URL);
    
}

//#pragma mark - UIGestureRecognizerDelegate -
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    
//    if (gestureRecognizer == tapGesture){//如果是自定义的单击手势 返回yes
//        return YES;
//    }
//    return NO;
//}
//
//
//#pragma mark - Override -
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    
//    if (event.type == UIEventTypeTouches) {
//        
//        NSSet *touches = [event touchesForView:self];
//        UITouch *touch = [touches anyObject];
//        
//        if (touch.phase == UITouchPhaseBegan) {
//            
//            [self addGestureRecognizer:self.scrollView.panGestureRecognizer];
//        }
//    }
//    return [super hitTest:point withEvent:event];
//}
//
//
//#pragma mark - Tap Action -
//- (void)tapAction:(UITapGestureRecognizer *)gesture{
//    
//    CGPoint touchPoint = [gesture locationInView:self];
//    [self getImage:touchPoint];
//    
//}
//
//- (void)getImage:(CGPoint)pt{
//    
//    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).tagName", pt.x, pt.y];
//    
//    NSString * tagName = [self stringByEvaluatingJavaScriptFromString:js];
//    
//    if ([tagName isEqualToString:@"IMG"]) {
//        
//        NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
//        NSString *urlToShow = [self stringByEvaluatingJavaScriptFromString:imgURL];
        
//        [_webDelegate clickActionOnImage:urlToShow];
//
//    }
//    
//}
//



@end
