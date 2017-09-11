//
//  ColumnAttentionModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/2/25.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol AttentionColumnModel <NSObject>
@end

@interface AttentionColumnModel : LKBBaseModel

@property (nonatomic, copy) NSString * attentionDate;
@property (nonatomic, copy) NSString * featureId;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * userId;

@end

@interface ColumnAttentionModel : LKBBaseModel
@property (nonatomic, strong) NSArray<AttentionColumnModel>* data;


@end
