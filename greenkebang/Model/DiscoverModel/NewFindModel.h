//
//  NewFindModel.h
//  greenkebang
//
//  Created by 郑渊文 on 1/19/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"

@protocol NewFindDetailModel <NSObject>
@end

@interface NewFindDetailModel : LKBBaseModel

@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, assign) NSTimeInterval pubDate;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *type; // 动态之间的类型
@property (nonatomic, copy) NSString *userAvatar;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *famousName;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *groupAvatar;
@property (nonatomic, copy) NSString *groupDesc;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *easyMobId;
@property (nonatomic, copy) NSString *starNum;
@property (nonatomic, copy) NSString *replyNum;

@end


@interface NewFindModel : LKBBaseModel
@property (nonatomic, copy) NSArray<NewFindDetailModel>* data;
@property (nonatomic, assign) NSInteger num;
@end
