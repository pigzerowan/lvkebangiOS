//
//  UserInforModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/28.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol UserInforModellIntroduceModel <NSObject>
@end

@interface UserInforModellIntroduceModel : LKBBaseModel
@property (nonatomic,copy) NSString * attentionNum;
@property (nonatomic,copy) NSString * fansNum;
@property (nonatomic,copy) NSString * insightNum;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * ifAttention;
@property (nonatomic,copy) NSString * pubDate;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * education;
@property (nonatomic,copy) NSString * gender;
@property (nonatomic,copy) NSString * trade;
@property (nonatomic,copy) NSString * attContentNum;
@property (nonatomic,copy) NSString * goodFiled;
@property (nonatomic,copy) NSString * identity;
@property (nonatomic,copy) NSString * featureId;
@end
@interface UserInforModel : LKBBaseModel
@property (nonatomic, strong) UserInforModellIntroduceModel * data;

@end

