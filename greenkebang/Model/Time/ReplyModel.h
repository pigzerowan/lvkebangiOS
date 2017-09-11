//
//  ReplyModel.h
//  greenkebang
//
//  Created by 郑渊文 on 9/23/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"

@protocol ReplyDetailModel <NSObject>
@end

@interface ReplyDetailModel : LKBBaseModel
@property (nonatomic, copy) NSString *answerDate;
@property (nonatomic, assign) NSInteger commonId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *starNum;
@property (nonatomic, copy) NSString *answerId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *questionId;
@property (nonatomic, copy) NSString *userAvatar;
@property (nonatomic, copy) NSString *operateDate;
@property (nonatomic, copy) NSString *replyDate;
@property (nonatomic, copy) NSString *replyNum;
@property (nonatomic, copy) NSString *applyNum;
@property (nonatomic, copy) NSString *replyId;
@property (nonatomic, copy) NSString *isStar;
@property (nonatomic, copy) NSString *commentId;
@property (nonatomic, copy) NSString *parentId;
@end


@interface ReplyModel : LKBBaseModel
@property (nonatomic, copy)NSArray<ReplyDetailModel>* data;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *isStar;

@end
