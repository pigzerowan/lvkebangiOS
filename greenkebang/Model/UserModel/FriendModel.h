//
//  FriendModel.h
//  greenkebang
//
//  Created by zhengyuanwen on 15/9/6.
//  Copyright (c) 2015年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"



@protocol friendDetailModel <NSObject>
@end

@interface friendDetailModel : LKBBaseModel

//@property (nonatomic,copy) NSString *contactID;
//@property (nonatomic, copy) NSString *contactName;
//@property (nonatomic, copy) NSString * custId;
//@property (nonatomic, copy) NSString *custName;
//@property (nonatomic, copy) NSString *image;
//
@property (nonatomic, copy) NSString *userId;
//@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *remark;
//@property (nonatomic, copy) NSString *singleDescription;

//+ (instancetype)buddyWithUsername:(NSString *)userName;

//+ (instancetype)contactPeopleWithName:(NSString *)contactName andCustId:(NSInteger )custId andSingleDescription:(NSString *)singleDescription andCustName:(NSString *)custName andImage:(NSString *)image andUserId:(NSString *)userId andUserName:(NSString *)userName;
@end

@interface FriendModel : LKBBaseModel
@property (nonatomic, strong) NSArray<friendDetailModel>* data;

@end
