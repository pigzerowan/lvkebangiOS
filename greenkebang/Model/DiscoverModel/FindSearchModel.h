//
//  FindSearchModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/26.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FindSearchModelDetailModel <NSObject>
@end

@interface FindSearchModelDetailModel : LKBBaseModel

@property (nonatomic, copy) NSString *groupUserNum;
@property (nonatomic, copy) NSString *objectId; // 对象Id
@property (nonatomic, copy) NSString *pubDate;
@property (nonatomic, copy) NSString *replyNum;
@property (nonatomic, copy) NSString *starNum;
@property (nonatomic, copy) NSString *summary;// 内容缩略
@property (nonatomic, copy) NSString *title; //内容标题
@property (nonatomic, copy) NSString *topicNum;
@property (nonatomic, copy) NSString *type; // 1 专栏文章 2 技术答疑 3 群组话题 4 群组 5 人 6 锄禾说 7专栏
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *groupAvatar;// 群组头像
@property (nonatomic, copy) NSString *groupDesc;
@property (nonatomic, copy) NSString *groupName;

@property (nonatomic, copy) NSString *lable;
@property (nonatomic, copy) NSString *famousName;

@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *userAvatar;// 用户头像
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *featureId; // 专栏Id
@property (nonatomic, copy) NSString *featureAvatar; // 专栏头像
@property (nonatomic, copy) NSString *insightNum;

@end

@interface FindSearchModel : LKBBaseModel
@property (nonatomic, copy) NSArray<FindSearchModelDetailModel>* data;
@property (nonatomic, assign) NSInteger num;
@end
