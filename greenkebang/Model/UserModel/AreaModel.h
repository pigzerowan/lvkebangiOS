//
//  GroupModel.h
//  greenkebang
//
//  Created by 郑渊文 on 11/2/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"

@protocol AreaDetailModel <NSObject>
@end

@interface AreaDetailModel : LKBBaseModel
@property (nonatomic, copy) NSString *areaId;
@property (nonatomic, copy) NSString* areaName;

@end

@interface AreaModel : LKBBaseModel

@property (nonatomic, strong) NSArray<AreaDetailModel>* data;

@end
