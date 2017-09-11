//
//  InsightModel.h
//  greenkebang
//
//  Created by 郑渊文 on 9/2/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"

@protocol NewInsightModel <NSObject>
@end

@interface NewInsightModel : LKBBaseModel

@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, copy) NSString * createBy;
@property (nonatomic, assign) NSInteger readNum;
@property (nonatomic, copy) NSString *blogId;
//@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *blogTitle;
@property (nonatomic, copy) NSString *blogAbstract;
@property (nonatomic, copy) NSString *userName;


@end

@interface InsightModel : LKBBaseModel
@property (nonatomic, strong) NSArray<NewInsightModel>* data;
@property (nonatomic, assign) NSInteger num;
@end
