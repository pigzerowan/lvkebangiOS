//
//  UserCenterModel.h
//  greenkebang
//
//  Created by 郑渊文 on 9/18/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCenterModel : LKBBaseModel


@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, assign) NSInteger custId;
@property (nonatomic, copy) NSString *attentionNum;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *ifAttention;
@property (nonatomic, copy) NSString *fansNum;
@property (nonatomic, copy) NSString *singleDescription;
@property (nonatomic, copy) NSString *industryId;
@property (nonatomic, copy) NSString *postAddr;
@property (nonatomic, copy) NSString *contactName;

@end
