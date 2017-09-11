//
//  NewShareToViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 12/5/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewShareToViewController : BaseViewController
@property (nonatomic, assign) BOOL variable;
@property (nonatomic, assign) BOOL showNavBar;

@property (strong, nonatomic) NSString* requestUrl;
@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) NSString* ifgroup;
@property (strong, nonatomic) NSString*groupId;
@property (copy, nonatomic) NSString * ifshare;
@property (copy, nonatomic) NSString * shareDes;
@property (copy, nonatomic) NSString * userName;
@property (copy, nonatomic) NSString * ownerId;
@property (copy, nonatomic) NSString * questionId;
@property (strong, nonatomic) NSString* questionUserId;
@property (strong, nonatomic) NSString* shareType;


@end
