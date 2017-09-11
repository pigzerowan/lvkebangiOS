//
//  ActivityListModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/25.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ActivityListDetailModel <NSObject>
@end

@interface ActivityListDetailModel : LKBBaseModel

@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *applyEndTime;
@property (nonatomic, copy) NSString *beginTime;
@property (nonatomic, copy) NSString *context;
@property (nonatomic, copy) NSString *cost;
@property (nonatomic, copy) NSString *countNum;
@property (nonatomic, copy) NSString *detailTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *readNum;
@property (nonatomic, copy) NSString *span;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *myId;

@end


@interface ActivityListModel : LKBBaseModel
@property (nonatomic, copy)NSArray<ActivityListDetailModel>* data;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger totalPage;

@end
