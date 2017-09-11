//
//  CollectionModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/6.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol CollectionDetailModel <NSObject>
@end

@interface CollectionDetailModel : LKBBaseModel
// 专栏
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *readNum;
@property (nonatomic, copy) NSString *replyNum;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *insightId;
@property (nonatomic, copy) NSString *featureName;

@property (nonatomic, copy) NSString *featureId;

@property (nonatomic, copy) NSString *pubDate;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *featureAvatar;
@end

@interface CollectionModel : LKBBaseModel
@property (nonatomic, copy) NSArray<CollectionDetailModel>* data;

@end
