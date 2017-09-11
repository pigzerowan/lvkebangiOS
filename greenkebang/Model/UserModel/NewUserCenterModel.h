//
//  NewUserCenterModel.h
//  greenkebang
//
//  Created by 郑渊文 on 11/15/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol insightFeatureModel <NSObject>
@end

@interface insightFeatureModel : LKBBaseModel


@property (nonatomic, copy) NSString *attNum;
@property (nonatomic, copy) NSString *featureAvatar;
@property (nonatomic, copy) NSString *featureDesc;
@property (nonatomic, copy) NSString *featureId;
@property (nonatomic, copy) NSString *featureName;
@property (nonatomic, copy) NSString *insightType;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *groupAvatars;
@property (nonatomic, copy) NSString *userId;
@end

@protocol NewUserCenterDetailModel <NSObject>
@end

@interface NewUserCenterDetailModel : LKBBaseModel

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *attentionNine;
@property (nonatomic, copy) NSString *attentionNum;
@property (nonatomic, copy) NSString *education;
@property (nonatomic, copy) NSString *fansNum;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *goodFiled;
@property (nonatomic, copy) NSString *groupAvatars;
@property (nonatomic, copy) NSString *identity;
@property (nonatomic, strong) insightFeatureModel* insightFeature;
@property (nonatomic, copy) NSString *insightNum;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *perfectionDegree;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *topicImages;
@property (nonatomic, copy) NSString *trade;
@property (nonatomic, copy) NSString *uSid;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *ifAttention;
@property (nonatomic, assign) NSInteger dynamicNum;

@end

@interface NewUserCenterModel : LKBBaseModel
@property (nonatomic, strong) NewUserCenterDetailModel* data;

@end





