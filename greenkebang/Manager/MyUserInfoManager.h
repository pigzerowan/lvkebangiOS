//
//  MyUserInfoManager.h
//  greenkebang
//
//  Created by 郑渊文 on 9/16/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBLoginModel.h"


@interface MyUserInfoManager : NSObject

+(MyUserInfoManager *)shareInstance;


- (BOOL)userLogin;
- (NSString *)userId;
- (NSString *)lkbId;
- (NSString *)userName;
- (NSString*)token;
- (NSString*)avatar;
- (float )attentionNum;
- (NSString *)shaImage;
- (NSString *)shaUrl;
- (NSString *)shaTitle;
- (NSString *)shaDes;
- (float)perfectionDegree;
- (NSString *)gender;
- (NSString *)remark;
- (NSString *)mobile;
- (NSString *)email;
- (NSString *)touchtoCircle;
@property (nonatomic,copy)NSString *avatar; // 用户头像
@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *emobId;
@property (nonatomic,copy)NSString *msg;
@property (nonatomic,copy)NSString *nickName; // 用户昵称
@property (nonatomic,copy)NSString *userId; // 用户ID
@property (nonatomic,copy)NSString *desc;
@property (nonatomic,assign)float attentionNum;
@property (nonatomic,assign)float perfectionDegree;
@property (nonatomic,copy)NSString *remark; //个人简介
@property (nonatomic,copy)NSString *gender; // 性别0男 1女
@property (nonatomic,copy)NSString *lables; // 行业
@property (nonatomic,copy)NSString *education;// 教育背景
@property (nonatomic,copy)NSString *cityCode; //城市编号
@property (nonatomic,copy)NSString *token;//Token验证
@property (nonatomic,copy)NSString *lkbId;//Token验证
@property (nonatomic,copy)NSString *shaImage; // 行业
@property (nonatomic,copy)NSString *shaUrl;// 教育背景
@property (nonatomic,copy)NSString *shaTitle; //城市编号
@property (nonatomic,copy)NSString *shaDes;//Token验证
@property (nonatomic,copy)NSString *introduceStr;//Token验证

@property (nonatomic,copy)NSString *shareType;//Token验证

@property (nonatomic,copy)NSString *mobile;//Token验证
@property (nonatomic,copy)NSString *email;//Token验证
@property (nonatomic,copy)NSString *touchtoCircle;
@property (nonatomic, copy)NSMutableArray *inforationData;//数组信息
@property (nonatomic,copy)NSString *userIds;

@end
