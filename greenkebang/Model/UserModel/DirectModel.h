//
//  DirectModel.h
//  greenkebang
//
//  Created by 郑渊文 on 11/2/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"

@protocol DirectDetailModel <NSObject>
@end

@interface DirectDetailModel : LKBBaseModel
@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString* className;

@end
@interface DirectModel : LKBBaseModel
@property (nonatomic, strong) NSArray<DirectDetailModel>* data;
@end
