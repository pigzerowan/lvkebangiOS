//
//  YQLoginModel.m
//  youqu
//
//  Created by chun.chen on 15/7/27.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import "LKBLoginModel.h"

@implementation YQUser

static YQUser* usr;
+ (YQUser *)usr {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        usr = [[YQUser alloc] init];
    });
    return usr;
}
#pragma mark -init
- (instancetype)init
{
    if (self = [super init]) {
        NSData* usrData = [USERDEFAULT dataForKey:iYQUserDataKey];
        if (usrData) {
            self = [NSKeyedUnarchiver unarchiveObjectWithData:usrData];
        }
    }
    return self;
}
- (void)doLoginOut {
    
    self.userId = @"";
    self.nickName = @"";
    self.token = @"";
    self.lkbId = @"";
    self.userName = @"";
    self.avatar = @"";
    self.mobile = @"";
    self.birthType = @"";
    self.gender = @"";
    self.lunarBirthday = @"";
    self.solarBirthday = @"";
    self.remark = @"";
    self.email = @"";
    self.attentionNum = 0.0;
    self.perfectionDegree =0.0;
    [USERDEFAULT removeObjectForKey:iYQUserDataKey];
    [USERDEFAULT synchronize];
    
    // removeCookie
    NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie* cookie in cookieStorage.cookies) {
        [cookieStorage deleteCookie:cookie];
    }
}

#pragma mark -override
- (instancetype)initWithJSONDict:(NSDictionary*)dict
{
    self = [self.class usr];
    if (self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [self performSelector:@selector(injectJSONData:)
                   withObject:dict];
#pragma clang diagnostic pop
        [self archiveUsrData];
    }
    return self;
}

#pragma mark -archiveUsrData
- (void)archiveUsrData
{
    
    if (![NSStrUtil isEmptyOrNull:self.userId]) {
        NSData* usrData = [NSKeyedArchiver archivedDataWithRootObject:usr];
        [USERDEFAULT setObject:usrData forKey:iYQUserDataKey];
        [USERDEFAULT synchronize];
        
        if (![NSStrUtil isEmptyOrNull:self.userName]) {
            NSData* usrData = [NSKeyedArchiver archivedDataWithRootObject:usr];
            [USERDEFAULT setObject:usrData forKey:iYQUserDataKey];
            [USERDEFAULT synchronize];
        }
    }
}
#pragma mark -NSCoding
- (id)initWithCoder:(NSCoder*)aDecoder
{
    [self setUserId:[aDecoder decodeObjectForKey:@"userId"]];
    [self setNickName:[aDecoder decodeObjectForKey:@"nickName"]];
    [self setMobile:[aDecoder decodeObjectForKey:@"mobile"]];
    [self setUserName:[aDecoder decodeObjectForKey:@"userName"]];
    [self setBirthType:[aDecoder decodeObjectForKey:@"birthType"]];
    [self setGender:[aDecoder decodeObjectForKey:@"gender"]];
    [self setCheckCode:[aDecoder decodeObjectForKey:@"checkCode"]];
    [self setToken:[aDecoder decodeObjectForKey:@"token"]];
    [self setAvatar:[aDecoder decodeObjectForKey:@"avatar"]];
    [self setRemark:[aDecoder decodeObjectForKey:@"remark"]];
    [self setPerfectionDegree:[aDecoder decodeFloatForKey:@"perfectionDegree"]];
    [self setAttentionNum:[aDecoder decodeFloatForKey:@"attentionNum"]];
    [self setLkbId:[aDecoder decodeObjectForKey:@"lkbId"]];
    [self setEmail:[aDecoder decodeObjectForKey:@"email"]];
    return self;
}


- (void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.checkCode forKey:@"checkCode"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.birthType forKey:@"birthType"];
    [aCoder encodeObject:self.lunarBirthday forKey:@"lunarBirthday"];
    [aCoder encodeObject:self.solarBirthday forKey:@"solarBirthday"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    [aCoder encodeFloat:self.perfectionDegree forKey:@"perfectionDegree"];
    [aCoder encodeFloat:self.attentionNum forKey:@"attentionNum"];
    [aCoder encodeObject:self.lkbId forKey:@"lkbId"];
    [aCoder encodeObject:self.email forKey:@"email"];
}
@end

@implementation LKBLoginModel

static LKBLoginModel* loginModel;

+ (LKBLoginModel *)loginModel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginModel = [[LKBLoginModel alloc] init];
    });
    return loginModel;
}

#pragma mark -init
- (instancetype)init
{
    if (self = [super init]) {
        NSData* usrData = [USERDEFAULT dataForKey:iYQUserTokenKey];
        if (usrData) {
            self = [NSKeyedUnarchiver unarchiveObjectWithData:usrData];
        }
    }
    return self;
}


#pragma mark -override
- (instancetype)initWithJSONDict:(NSDictionary*)dict
{
    self = [self.class loginModel];
    if (self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [self performSelector:@selector(injectJSONData:)
                   withObject:dict];
#pragma clang diagnostic pop
        [self archiveUsrData];
    }
    return self;
}

#pragma mark -archiveUsrData
- (void)archiveUsrData
{
    
    if (![NSStrUtil isEmptyOrNull:self.token]) {
        NSData* usrData = [NSKeyedArchiver archivedDataWithRootObject:loginModel];
        [USERDEFAULT setObject:usrData forKey:iYQUserTokenKey];
        [USERDEFAULT synchronize];
    }
}


- (id)initWithCoder:(NSCoder*)aDecoder
{
    [self setToken:[aDecoder decodeObjectForKey:@"token"]];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    
    [aCoder encodeObject:self.token forKey:@"token"];
}

@end
