//
//  ColumnListModel.h
//  greenkebang
//
//  Created by 郑渊文 on 1/26/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SingelColumnModel <NSObject>
@end

@interface SingelColumnModel : LKBBaseModel

@property (nonatomic, copy) NSString *collectNum;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * featureId;
@property (nonatomic, copy) NSString *insightId;
@property (nonatomic, copy) NSString *labels;
@property (nonatomic, assign) NSTimeInterval pubDate;
@property (nonatomic, copy) NSString *readNum;
@property (nonatomic, copy) NSString *replyNum;
@property (nonatomic, copy) NSString *starNum;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString * featureAvatar;// 专栏头像
@property (nonatomic, copy) NSString * isCollect;

@end

@interface ColumnListModel : LKBBaseModel
@property (nonatomic, strong) NSArray<SingelColumnModel>* data;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger totalPage;
@end
