//
//  UserGroupViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 9/21/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UserGroupViewControllerDelegate <NSObject>

@optional
- (void)turnTopage:(NSInteger )index;

@end

@interface UserGroupViewController : BaseViewController


@property(nonatomic, assign) id<UserGroupViewControllerDelegate>topageDelegate;
@property (copy, nonatomic) NSString * therquestUrl;
@property (copy, nonatomic) NSString * circlerquestUrl;
@property (copy, nonatomic) NSString  *ifgrouptype;
@property (copy, nonatomic) NSString * ifshare;
@property (copy, nonatomic) NSMutableDictionary * shareDic;
@property (copy, nonatomic) NSString * shareDes;
@property (copy, nonatomic) NSString * easyMobId;
@property (copy, nonatomic) NSString *groupName;
@property (copy, nonatomic) NSString *groupId;
@end
