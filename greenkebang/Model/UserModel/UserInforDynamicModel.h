//
//  UserInforDynamicModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/29.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol UserDynamicModelIntroduceModel <NSObject>
@end

@interface UserDynamicModelIntroduceModel : LKBBaseModel
@property (nonatomic,copy) NSString * cover; //动态内容的封面
@property (nonatomic,copy) NSString * insightId;
@property (nonatomic,copy) NSString * replyNum;
@property (nonatomic,copy) NSString * starNum;
@property (nonatomic,copy) NSString * summary;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * userName;
@property (nonatomic, assign) NSTimeInterval pubDate; // 发布时间
@property (nonatomic,copy) NSString * objectId; // 对象ID也就是话题、技术答疑、专栏文章的ID
@property (nonatomic, copy) NSString *userAvatar;
@property (nonatomic, copy) NSString *attentionNum;
@property (nonatomic, copy) NSString *isJoin;
@property (nonatomic, copy) NSString *label; // 标签
@property (nonatomic, copy) NSString *groupName;
@property (strong, nonatomic) NSString *isCollect;// 0已收藏1未收藏
@property (nonatomic, copy) NSString *isAttention;// 是否关注
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSArray *coverList;
@property (nonatomic, copy) NSString *isDisplay;
@property (nonatomic, copy) NSString *images;
@property (nonatomic, copy) NSString *shareImage;
@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareUrl;

@end

@interface UserInforDynamicModel : LKBBaseModel

@property (nonatomic, copy) NSArray<UserDynamicModelIntroduceModel>* data;

@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger totalPage;

@end
