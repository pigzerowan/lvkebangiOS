//
//  DynamicModel.h
//  greenkebang
//
//  Created by 郑渊文 on 9/2/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"


@protocol NewDynamicModel <NSObject>
@end

@interface NewDynamicModel : LKBBaseModel
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, assign) float attentionNum;
@property (nonatomic, copy) NSString* questionId;
@property (nonatomic, assign) NSInteger click;
@property (nonatomic, assign) NSInteger replyNum;
//@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *questionTitle;
@property (nonatomic, copy) NSString *questionDesc;
@property (nonatomic, copy) NSString *operTime;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString* userId;

@end
@interface DynamicModel : LKBBaseModel
@property (nonatomic, copy) NSArray<NewDynamicModel>* data;
@property (nonatomic, copy) NSDictionary<NewDynamicModel>* data2;
@property (nonatomic, assign)NSInteger  num;
@property (nonatomic, copy) NSString *isAttention;// 是否关注
@end
