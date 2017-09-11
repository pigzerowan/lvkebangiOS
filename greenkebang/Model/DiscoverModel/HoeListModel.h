//
//  HoeListModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/23.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol HoeListModelDetailModel <NSObject>
@end

@interface HoeListModelDetailModel : LKBBaseModel
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *hoeId;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *hoeStatus;// 状态0正常1删除
@property (nonatomic, copy) NSString *readNum;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *shareNum;
@property (nonatomic, copy) NSString *source;// 来源
@property (nonatomic, copy) NSString *starNum;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *content;
@end
@interface HoeListModel : LKBBaseModel
@property (nonatomic, copy)NSArray<HoeListModelDetailModel>* data;
@property (nonatomic, assign) NSInteger num;

@end
