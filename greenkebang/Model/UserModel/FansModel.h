//
//  FansModel.h
//  greenkebang
//
//  Created by 郑渊文 on 9/1/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"

@protocol peopeleModel <NSObject>
@end

@interface peopeleModel : LKBBaseModel
//@property (nonatomic, copy) NSString *contactName;
//@property (nonatomic, assign) NSInteger custId;
//@property (nonatomic, copy) NSString *custName;
//@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *remark;
//@property (nonatomic, copy) NSString *singleDescription;
@end

@interface FansModel : LKBBaseModel
@property (nonatomic, copy) NSArray<peopeleModel>* data;
@property (nonatomic, strong) peopeleModel* object;
@property (nonatomic, assign) NSInteger num;

@end
