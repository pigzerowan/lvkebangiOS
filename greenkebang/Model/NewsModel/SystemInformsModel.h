//
//  SystemInformsModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 2017/3/17.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SystemInformsDetailModel <NSObject>
@end

@interface SystemInformsDetailModel : LKBBaseModel

@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, copy) NSString *msgId;
@property (nonatomic, copy) NSString *msgType;
@property (nonatomic, copy) NSString *objType;
@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, assign) NSInteger sendDate;
@property (nonatomic, copy) NSString *userId;

@end

@interface SystemInformsModel : LKBBaseModel
@property (nonatomic, copy) NSArray<SystemInformsDetailModel>* data;

@end
