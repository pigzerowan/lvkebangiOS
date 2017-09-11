//
//  NewDynamicModel.h
//  greenkebang
//
//  Created by 郑渊文 on 1/12/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"

@protocol NewDynamicDetailModel <NSObject>
@end

@interface NewDynamicDetailModel : LKBBaseModel

@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, assign) NSTimeInterval pubDate;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *userAvatar;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *replyNum;
@property (nonatomic, copy) NSString *starNum;
@property (nonatomic, copy) NSString *isJoin;
@property (nonatomic, copy) NSString *attentionNum;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *isAttention;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *featureId;
@property (nonatomic, copy) NSString *featureAvatar;
@property (nonatomic, copy) NSString *isCollect;
@property (nonatomic, copy) NSArray *replyList;
@property (nonatomic, copy) NSArray *coverList;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSArray *userAvatars;
@property (nonatomic, copy) NSString *isStar;
@property (nonatomic, copy) NSString *images;
@property (nonatomic, copy) NSData *imageInfo;
@property (nonatomic, copy) NSString *groupAvatar;
@property (nonatomic, copy) NSString *shareImage;
@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL shouldUpdateCache;

-(instancetype)initWithDic:(NSArray *)dic;
- (void)updateWithDictionary:(NSArray *)dic;


@end

@interface NewTimeDynamicModel : LKBBaseModel
@property (nonatomic, copy) NSArray<NewDynamicDetailModel>* data;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, assign) NSDictionary * object;

@end
