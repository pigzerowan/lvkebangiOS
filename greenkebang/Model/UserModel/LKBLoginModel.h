//
//  YQLoginModel.h
//  youqu
//
//  Created by chun.chen on 15/7/27.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import "LKBBaseModel.h"

@interface YQUser : LKBBaseModel

@property (nonatomic, copy) NSString *token;// Token验证
@property (nonatomic, copy) NSString *mobile;// 手机号
@property (nonatomic, copy) NSString *checkCode;// 验证码
@property (nonatomic, copy) NSString *code;// 返回值
@property (nonatomic, copy) NSString *lables;// 所属行业
@property (nonatomic,copy) NSString *gender;// 用户性别
@property (nonatomic,copy) NSString *education;// 教育背景
@property (nonatomic,copy) NSString *cityCode;// 所在城市编号
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *uId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *birthType;
@property (nonatomic,copy) NSString *lunarBirthday;
@property (nonatomic,assign) float attentionNum;
@property (nonatomic,assign) float perfectionDegree;
@property (nonatomic,copy) NSString *solarBirthday;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *lkbId;
@property (nonatomic,copy) NSString *email;

+ (YQUser *)usr;
- (void)doLoginOut;
- (void)archiveUsrData;
@end

@interface LKBLoginModel : LKBBaseModel
@property (nonatomic, strong) YQUser *data;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *msg;

+ (LKBLoginModel *)loginModel;
- (void)doLoginOutToken;


@end
