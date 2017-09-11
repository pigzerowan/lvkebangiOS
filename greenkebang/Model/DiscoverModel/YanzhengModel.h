//
//  YanzhengModel.h
//  greenkebang
//
//  Created by 郑渊文 on 10/18/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YanzhengDetailModel <NSObject>


@end
@interface YanzhengDetailModel : LKBBaseModel
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *idCardImage;
@property (nonatomic, copy) NSString *licenseImage;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *linkUser;
@property (nonatomic, copy) NSString *legalPerson;
@property (nonatomic, copy) NSString *idCard;
@property (nonatomic, copy) NSString *groupNum;
@property (nonatomic, copy) NSString *applySource;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *lkbId;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *mallToken;


@end
@interface YanzhengModel : LKBBaseModel

@property (nonatomic, strong) YanzhengDetailModel *data;


@end

