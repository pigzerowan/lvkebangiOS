//
//  ColumnInfoMation.h
//  greenkebang
//
//  Created by 郑渊文 on 1/26/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ColumnInfoMationDetailModel <NSObject>
@end

@interface ColumnInfoMationDetailModel : LKBBaseModel
@property (nonatomic, copy) NSString *featureAvatar;
@property (nonatomic, copy) NSString *featureDesc;
@property (nonatomic, copy) NSString *featureId;
@property (nonatomic, copy) NSString *featureName;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *ifAttention;

@end

@interface ColumnInfoMation : LKBBaseModel

@property (nonatomic, strong) ColumnInfoMationDetailModel* data;
@end
