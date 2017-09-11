//
//  InsightReplistViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 11/4/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LQXkeyboard.h"
@interface InsightReplistViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) NSString *blogId;
@property (nonatomic, strong) UIView *critiqueView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *commentType; // 1  添加一个头部
@property (nonatomic, copy) NSString *commentId;
@end
