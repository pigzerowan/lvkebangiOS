//
//  CircleInfoModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/10/28.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CircleInfoDetailModel <NSObject>
@end

@interface CircleInfoDetailModel : LKBBaseModel

@property (nonatomic, copy) NSString *attNum;
@property (nonatomic, copy) NSArray *avatars;
@property (nonatomic, copy) NSString *easyMobId;
@property (nonatomic, copy) NSString *groupAvatar;
@property (nonatomic, copy) NSString *groupDate;
@property (nonatomic, copy) NSString *groupDesc;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *groupStatus;
@property (nonatomic, copy) NSString *groupTrade;
@property (nonatomic, copy) NSString *groupType;
@property (nonatomic, copy) NSString *isHot;
@property (nonatomic, copy) NSString *isIndex;
@property (nonatomic, copy) NSString *isJoin;
@property (nonatomic, copy) NSString *memberNum;
@property (nonatomic, copy) NSString *passStatus;
@property (nonatomic, copy) NSString *readNum;
@property (nonatomic, copy) NSString *topicNum;
@property (nonatomic, copy) NSString *userId;
@end

@interface CircleInfoModel : LKBBaseModel

@property (nonatomic, copy) NSDictionary<CircleInfoDetailModel>* data;

@end
