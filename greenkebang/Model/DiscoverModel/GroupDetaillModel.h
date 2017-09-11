//
//  GroupDetaillModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/29.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GroupDetaillInforModel <NSObject>
@end

@interface GroupDetaillInforModel : LKBBaseModel
@property (nonatomic, copy) NSString *groupAvatar;
@property (nonatomic, copy) NSString *groupDate;
@property (nonatomic, copy) NSString *groupDesc;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *groupLabel;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *groupTrade;
@property (nonatomic, copy) NSString *groupType;
@property (nonatomic, copy) NSString *topicNum;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *easyMobId;


@end

@interface GroupDetaillModel : LKBBaseModel

@property (nonatomic, copy) NSDictionary<GroupDetaillInforModel>* data;
@property (nonatomic, copy) NSString *joinStatus;// 是否加入群
@property (nonatomic, copy) NSString *isCreater;// 是否是创建者
@end
