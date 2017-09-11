//
//  AttentionContentsModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/6.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AttentionContentsListModel <NSObject>
@end

@interface AttentionContentsListModel : LKBBaseModel
// 群组话题
@property (nonatomic, copy) NSString *attentionNum;
@property (nonatomic, copy) NSString *replyNum;
@property (nonatomic, copy) NSString *topicAvatar;
//@property (nonatomic, copy) NSString *topicDate;
@property (nonatomic, copy) NSString *topicId;
@property (nonatomic, copy) NSString *topicSummary;
@property (nonatomic, copy) NSString *userId;
// 专栏
@property (nonatomic, copy) NSString *featureAvatar;
@property (nonatomic, copy) NSString *featureDesc;
@property (nonatomic, copy) NSString *featureId;
@property (nonatomic, copy) NSString *featureName;
@property (nonatomic, copy) NSString *insightNum;
//@property (nonatomic, copy) NSString *pubDate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *insightId;
// 技术答疑
@property (nonatomic, copy) NSString *answerNum;
@property (nonatomic, copy) NSString *fansNum;
@property (nonatomic, copy) NSString *questionDate;
@property (nonatomic, copy) NSString *questionId;

@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *isCollect;//是否收藏 0 已收藏 1 未收藏
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSData *imageInfo;
@property (nonatomic, copy) NSArray *coverList;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, strong) NSString *shareImage;
@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) NSString *shareDescrible;
@property (nonatomic, strong) NSString *shareType;
@property (nonatomic, copy) NSString *userAvatar;
@property (nonatomic, copy) NSString * summary;
@property (nonatomic, assign) NSTimeInterval topicDate;
@property (nonatomic, copy) NSString *isJoin;
@property (nonatomic, copy) NSString * isAttention;// 是否关注
@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *topicContent;

@end
@interface AttentionContentsModel : LKBBaseModel
@property (nonatomic, copy) NSArray<AttentionContentsListModel>* data;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger totalPage;

@end
