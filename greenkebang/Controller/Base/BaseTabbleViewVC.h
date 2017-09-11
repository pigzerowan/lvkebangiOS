//
//  BaseTabbleViewVC.h
//  greenkebang
//
//  Created by 郑渊文 on 9/23/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQRequestModel.h"
#import "YQApi.h"
#import "LKBBaseModel.h"
#import "TabbarManager.h"
@interface BaseTabbleViewVC : UITableViewController


@property (nonatomic, assign) BOOL showBackBtn;
@property (nonatomic,   copy) NSString *itemTitle;
@property (nonatomic,   copy) NSString *requestURL;
@property (nonatomic,   copy) NSString *requestImgURL;
@property (nonatomic, strong) UIButton *navLeftBtn;
@property (nonatomic, strong) UIButton *navRightBtn;
@property (nonatomic, strong) NSDictionary *usrInfo;
@property (nonatomic, strong) NSDictionary *requestParas;

// Subclass can override
- (void)actionCustomLeftBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                  title:(NSString *)title
                                 action:(void(^)())btnClickBlock;
- (void)actionCustomRightBtnWithNrlImage:(NSString *)nrlImage htlImage:(NSString *)hltImage
                                   title:(NSString *)title
                                  action:(void(^)())btnClickBlock;
- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage;
- (void)cancelLoginEvent;
@end
