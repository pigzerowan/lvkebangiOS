//
//  InsightDetailViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 9/24/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardBar.h"
#import "WFWebView.h"
@interface InsightDetailViewController : BaseViewController<KeyboardBarDelegate>

@property (copy, nonatomic) NSString *topicId;
@property (weak, nonatomic) id<KeyboardBarDelegate> keyboardBarDelegate;
@property (strong, nonatomic) WFWebView *mywebView;
@property (copy, nonatomic) NSMutableString *htmlss;
@property (copy, nonatomic) NSString *InsightTitle;
@property (copy, nonatomic) NSString *autherName;
@property (copy, nonatomic) NSString *createBy;
@property (copy, nonatomic) NSString *pushTipe;
@property (copy, nonatomic) NSString *ifStar;
@property (copy, nonatomic) NSString *featureId;
@property (copy, nonatomic) NSString *isReport; // 是否举报 0已举报 1 未举报
@property (copy, nonatomic) NSString *collNum;
@property (copy, nonatomic) NSString *starNum;
@property (copy, nonatomic) NSString *shareNum;

@end
