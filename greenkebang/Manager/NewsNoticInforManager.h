//
//  NewsNoticInforManager.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/29.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsNoticInforManager : NSObject
+(NewsNoticInforManager *)shareInstance;

@property(nonatomic, copy)NSString *inviteAnswerNum;
@property(nonatomic, copy)NSString *userName;
@property(nonatomic, copy)NSString *objTitle;
@property(nonatomic, copy)NSString *noticeDate;
@property(nonatomic, copy)NSString *wenDaDetail;
@property(nonatomic, copy)NSString *dongTaiDetail;
@property(nonatomic, copy)NSString *dongTaiType;

@property(nonatomic, copy)NSString *guanZhuDetail;
@property(nonatomic, copy)NSString *guanZhuType;

//@property(nonatomic, copy)NSString *inviteAnswerNum;

@end
