//
//  ColumnModel.h
//  greenkebang
//
//  Created by 郑渊文 on 1/26/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ColumnIntroduceModel <NSObject>
@end

@interface ColumnIntroduceModel : LKBBaseModel
@property (nonatomic, copy) NSString *featureAvatar;
@property (nonatomic, copy) NSString *featureDesc;
@property (nonatomic, copy) NSString *featureId;
@property (nonatomic, copy) NSString *featureName;
@property (nonatomic, copy) NSString *status;// 0未删除1删除
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *attNum;
@property (nonatomic, copy) NSString *insightType; // 0 普通专栏1 星创学堂专栏
@end


@interface ColumnModel : LKBBaseModel
@property (nonatomic, copy) NSDictionary<ColumnIntroduceModel>* data;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger totalPage;
@end
