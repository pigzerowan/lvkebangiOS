//
//  CommentViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/24.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardBar.h"
@interface CommentViewController : BaseViewController<KeyboardBarDelegate>
@property (copy, nonatomic) NSString *parentId;
@property (copy, nonatomic) NSString *topicId;
//@property (nonatomic, copy) NSString *authorId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userAvatar;
@property (nonatomic, copy) NSString *isStar;
@property (nonatomic, copy) NSString *starNum;
@property (nonatomic, copy) NSString *replyNum;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *replyDate;
@property (nonatomic, copy) NSString *timeStr;

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *commentType; // 1  添加一个头部

@property (nonatomic, copy) NSString *type; // 页面类型1 话题 2疑难 3专栏



@end
