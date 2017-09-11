//
//  GroupModel.h
//  greenkebang
//
//  Created by 郑渊文 on 9/10/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"
@protocol GroupDetailModel <NSObject>
@end

@interface GroupDetailModel : LKBBaseModel
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString * creater;
@property (nonatomic, copy) NSString * groupTrade;
@property (nonatomic, copy) NSString * emobGroupId;
@property (nonatomic, copy) NSString * isAdmin;
@property (nonatomic, copy) NSString * groupId;//群组ID
@property (nonatomic, copy) NSString *groupDesc; // 群组简介
@property (nonatomic, copy) NSString *groupSubject;
@property (nonatomic, copy) NSString *otherAvatar;
@property (nonatomic, copy) NSString * gUserId;
@property (nonatomic, copy) NSString * isApply;
@property (nonatomic, copy) NSString * topicNum;
@property (nonatomic, copy) NSString * applyStatus;
@property (nonatomic, copy) NSString * easyMobId;
@property (nonatomic, copy) NSString * isJoin;
@property (nonatomic, copy) NSString * groupStatus;
@property (nonatomic, copy) NSString *groupAvatar; // 群组头像
@property (nonatomic, copy) NSString *groupLabel; // 群组标签
@property (nonatomic, copy) NSString *groupName; // 群组名称
@property (nonatomic, copy) NSString *groupDate;
@property (nonatomic, copy) NSString *groupType;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passStatus;// 0待审核 1 审核通过 2未通过

@property (nonatomic, assign) BOOL shouldUpdateCache;

-(instancetype)initWithDic:(NSArray *)dic;


@end

@interface GroupModel : LKBBaseModel

@property (nonatomic, copy) NSArray <GroupDetailModel>* data;
@property (nonatomic, copy) NSString *joinStatus;// 是否是群成员
@property (nonatomic, assign) NSInteger num;// 是否是群成员
@end
