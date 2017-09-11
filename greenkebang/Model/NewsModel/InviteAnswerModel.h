//
//  InviteAnswerModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol InviteAnswerDetailModel <NSObject>
@end

@interface InviteAnswerDetailModel : LKBBaseModel

@property (nonatomic, copy) NSArray *avatars;
@property (nonatomic, assign) NSInteger inviteAnswerNum;
@property (nonatomic, copy) NSString *objId;
@property (nonatomic, copy) NSString *objType;
@property (nonatomic, copy) NSString *objTitle;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *groupNmae;
@property (nonatomic, assign) BOOL shouldUpdateCache;
//@property (nonatomic, copy) NSDictionary *groupNmae;

-(instancetype)initWithDic:(NSArray *)dic;


@end

@interface InviteAnswerModel : LKBBaseModel
@property (nonatomic, copy) NSArray<InviteAnswerDetailModel>* data;
@property (nonatomic, assign)NSInteger  num;
@property (nonatomic, assign) NSInteger totalPage; // 分页总的页数
@end
