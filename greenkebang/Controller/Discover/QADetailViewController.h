//
//  QADetailViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 9/29/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardBar.h"
#import "CustomView.h"
#import "ReplyTabViewCell.h"
#import "SVPullToRefresh.h"
#import "ReplyModel.h"
#import <UIImageView+WebCache.h>
#import "GTMNSString+HTML.h"
#import "UILabel+StringFrame.h"
#import "MyUserInfoManager.h"
#import "WFWebView.h"

#define TABLE_VIEW_TAG 8004
static NSString* CellIdentifier = @"TimeTableViewCellIdentifier";
@interface QADetailViewController : BaseViewController<KeyboardBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
//@property (copy, nonatomic) NSString *questionDesc;
@property (weak, nonatomic) id<KeyboardBarDelegate> keyboardBarDelegate;
@property (copy, nonatomic) NSString *autherName;
@property (copy, nonatomic) NSString *autherId;
@property (copy, nonatomic) NSString *timeStr;
@property (copy, nonatomic) NSString *questionId;
@property (copy, nonatomic) NSString *questionUserId;
@property (copy, nonatomic) NSString *coverImg;
@property (copy, nonatomic) NSString *pushTipe;
@property (copy, nonatomic) NSString *questionTitle;
@property (assign, nonatomic) BOOL ifStart;
@property (copy, nonatomic) NSMutableString *htmlss;
@property (copy, nonatomic) NSString *isAttention;// 是否关注

@property (strong, nonatomic) WFWebView *mywebView;


@end
