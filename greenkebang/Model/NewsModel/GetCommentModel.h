//
//  GetCommentModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/6.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GetDetailCommentModel <NSObject>
@end

@interface GetDetailCommentModel : LKBBaseModel

@property (nonatomic, copy) NSString *summary;//被评论内容对象的简介
@property (nonatomic, copy) NSString *content;//评论的内容
@property (nonatomic, assign) NSInteger commentType;// 评论类型 （1 专栏文章 2 技术答疑 3 群组话题 4 专栏文章的评论的评论 5 技术答疑的回复的回复 6 群组话题的回复的回复）
@property (nonatomic, copy) NSString *commentId; //评论内容的ID


@property (nonatomic, copy) NSString *commentDate; //评论的时间

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *objId;

@property (nonatomic, copy) NSString *starNum;

@property (nonatomic, copy) NSString *replyNum;

@property (nonatomic, copy) NSString *applyNum;

@property (nonatomic, copy) NSString *isStar;
@property (nonatomic, copy) NSString *parentReply; // 评论的评论 内容
@property (nonatomic, copy) NSString *parentId;
@end

@interface GetCommentModel : LKBBaseModel
@property (nonatomic, copy) NSArray<GetDetailCommentModel>* data;
@property (nonatomic, assign) NSInteger num;// 话题总数
@property (nonatomic, assign) NSInteger totalPage; // 分页总的页数

@end
