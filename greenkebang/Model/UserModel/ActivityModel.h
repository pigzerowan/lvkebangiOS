//
//  ActivityModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/8/2.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ActivityIntroduceModel <NSObject>
@end

@interface ActivityIntroduceModel : LKBBaseModel

@property (nonatomic,copy) NSString * addTime;// 发布时间
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * applyEndTime;
@property (nonatomic,copy) NSString * beginTime;// 活动开始时间
@property (nonatomic,copy) NSString * context;
@property (nonatomic,copy) NSString * cost;
@property (nonatomic,copy) NSString * countNum;
@property (nonatomic,copy) NSString * detailTime;
@property (nonatomic,copy) NSString * endTime; // 活动结束时间
@property (nonatomic,copy) NSString *myId;
@property (nonatomic,copy) NSString * isEnd;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * readNum;
@property (nonatomic,copy) NSString * replyNum;
@property (nonatomic,copy) NSString * span;
@property (nonatomic,copy) NSString * starNum;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * userSubmitInfo;
@property (nonatomic,copy) NSString * img;
@end

@interface ActivityModel : LKBBaseModel
@property (nonatomic, copy) NSArray<ActivityIntroduceModel>* data;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger totalPage;

@end
