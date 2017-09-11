//
//  CirclePeopleViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 10/13/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface CirclePeopleViewController : BaseViewController
@property (strong, nonatomic) NSString* requestUrl;
@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) NSString* ifgroup;
@property (strong, nonatomic) NSString*groupId;
@property (copy, nonatomic) NSString * ifshare;
@property (copy, nonatomic) NSString * shareDes;
@property (copy, nonatomic) NSString * userName;
@property (copy, nonatomic) NSString * ownerId;
@end
