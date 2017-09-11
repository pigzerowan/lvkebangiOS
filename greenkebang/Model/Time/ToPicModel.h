//
//  ToPicModel.h
//  greenkebang
//
//  Created by 郑渊文 on 9/1/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"


@protocol PeoplestopicModel <NSObject>
@end

@interface PeoplestopicModel : LKBBaseModel
@property (nonatomic, copy) NSString *topicDesc;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *replyNum; // 话题回复数
@property (nonatomic, copy) NSString *ownerAvatar;
@property (nonatomic, copy) NSString *ownerName;
@property (nonatomic, copy) NSString *operUser;
@property (nonatomic, copy) NSString *operTime;
@property (nonatomic, copy) NSString *isSalon;
@property (nonatomic, copy) NSString *topicId; // 话题ID
@property (nonatomic, copy) NSString *topicAvatar; 
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, assign) NSTimeInterval topicDate; // 话题发布时间
@property (nonatomic, copy) NSString *topicSummary;// 话题缩略
@property (nonatomic, copy) NSString *userId;// 话题发布者
@property (nonatomic, copy) NSString *userName;// 话题发布者昵称
@property (nonatomic, copy) NSString * isAttention;// 是否关注
@property (nonatomic, copy) NSString *attentionNum;
@property (nonatomic, copy) NSString *starNum;
@end

@interface ToPicModel : LKBBaseModel
@property (nonatomic, copy) NSArray<PeoplestopicModel>* data;

@property (nonatomic, assign) NSInteger num;// 话题总数
@property (nonatomic, assign) NSInteger totalPage; // 分页总的页数
@property (nonatomic, copy) NSString * isStar;// 是否点赞


@end
