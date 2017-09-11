//
//  LKBBaseModel.h
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface LKBBaseModel : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *qiniuToken;
@property (nonatomic, copy) NSString *success;
@property (nonatomic, copy) NSString *emobId;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *emobPwd;
@property (nonatomic, assign) BOOL rspCode;
@property (nonatomic, copy) NSString* code;
@property (nonatomic, copy) NSString *more;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) BOOL isLoadingMore;
@property (nonatomic, copy) NSString* message;
@property (nonatomic, copy) NSString *checkCode;// 验证码
//@property (nonatomic, copy) NSString *token;
//@property (nonatomic, copy) NSDictionary *data; //完善信息的字典
//@property (nonatomic, copy) NSMutableArray *recommendData; // 推荐好友的数组



- (NSDictionary *)modelKeyJSONKeyMapper;
- (instancetype)initWithJSONDict:(NSDictionary *)dict;

@end
