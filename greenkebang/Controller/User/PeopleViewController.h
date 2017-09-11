//
//  PeopleViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PeopleViewController : BaseViewController
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
@property (strong, nonatomic) NSString* VCType; // 1 关注的人 2粉丝

@end
