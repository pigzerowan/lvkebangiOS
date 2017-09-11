//
//  RecFriendModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 15/12/24.
//  Copyright © 2015年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"

@protocol friendModel <NSObject>
@end

@interface friendModel : LKBBaseModel
@property (nonatomic, copy) NSString * userId; // 用户ID
@property (nonatomic, copy) NSString * userName;// 用户姓名

@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * dynamicNum;
@property (nonatomic, copy) NSString * objectId;
@property (nonatomic, copy) NSString * summary;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * memberNum;
@end





@interface RecFriendModel : LKBBaseModel

@property (nonatomic, copy) NSArray<friendModel>* data;



//@property (nonatomic, assign) NSInteger num;

//@property (nonatomic, copy) NSMutableArray * infoData; // 用户信息

@end





