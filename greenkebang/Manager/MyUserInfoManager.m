//
//  MyUserInfoManager.m
//  greenkebang
//
//  Created by 郑渊文 on 9/16/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "MyUserInfoManager.h"

@implementation MyUserInfoManager
static MyUserInfoManager *_shareInstance;

+(MyUserInfoManager *)shareInstance
{
    @synchronized ([MyUserInfoManager class])
    {
        if (_shareInstance == nil)
        {
            _shareInstance = [[MyUserInfoManager alloc] init];
        }
    }
    return _shareInstance;
}


- (BOOL)userLogin
{
    if ([YQUser usr].userId) {
        return YES;
    }
    return NO;
}

- (NSString*)userId
{
    NSString* uid = [YQUser usr].userId;
    if (uid) {
        return uid;
    }
    else {
        return nil;
    }
}




- (NSString*)email
{
    NSString* email = [YQUser usr].email;
    if (email) {
        return email;
    }
    else {
        return nil;
    }
}

- (NSString*)lkbId
{
    NSString* lkbId = [YQUser usr].lkbId;
    if (lkbId) {
        return lkbId;
    }
    else {
        return nil;
    }
}


- (NSString*)mobile
{
    NSString* mobile = [YQUser usr].mobile;
    if (mobile) {
        return mobile;
    }
    else {
        return nil;
    }
}


- (NSString*)userName
{
    NSString* userName = [YQUser usr].userName;
    if (userName) {
        return userName;
    }
    else {
        return nil;
    }
}


- (NSString*)avatar
{
    NSString* avatar = [YQUser usr].avatar;
    
    if ([avatar isEqualToString:@""] || avatar == nil) {
        
        avatar =@"default.jpg";
    }
    
    if (avatar) {
        return avatar;
    }
    else {
        return nil;
    }
}

- (NSString*)gender
{
    NSString* gender = [YQUser usr].gender;
    if (gender) {
        return gender;
    }
    else {
        return nil;
    }
}

- (NSString*)remark
{
    NSString* remark = [YQUser usr].remark;
    if (remark) {
        return remark;
    }
    else {
        return nil;
    }
}
- (NSString*)token
{
    NSString* token = [LKBLoginModel loginModel].token;
    if (token) {
        return token;
    }
    else {
        return nil;
    }
}


- (float)attentionNum
{
    float attentionNum = [YQUser usr].attentionNum;
    if (attentionNum) {
        return attentionNum;
    }
    else {
        return 0;
    }
}

//- (NSString*)attentionNum
//{
//    NSString* token = [LKBLoginModel loginModel].token;
//    if (token) {
//        return token;
//    }
//    else {
//        return nil;
//    }
//}

- (float)perfectionDegree
{
    float perfectionDegree = [YQUser usr].perfectionDegree;
    if (perfectionDegree) {
        return perfectionDegree;
    }
    else {
        return 0;
    }
}




@end
