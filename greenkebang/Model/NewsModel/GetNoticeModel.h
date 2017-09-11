//
//  GetNoticeModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/24.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GetDetailNoticeModel <NSObject>
@end

@interface GetDetailNoticeModel : LKBBaseModel

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *noticeDate;
@property (nonatomic, copy) NSString *objId;
@property (nonatomic, copy) NSString *objTitle;
@property (nonatomic, copy) NSString *objType; // 0代表问答、1代表话题
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *replyId;
@property (nonatomic, copy) NSString *replyNum;
@property (nonatomic, copy) NSString *starNum;
@property (nonatomic, copy) NSString *replyContent;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *groupName;

//@property (nonatomic, assign) BOOL isSelected;

@end


@interface GetNoticeModel : LKBBaseModel
@property (nonatomic, copy) NSArray<GetDetailNoticeModel>* data;
@property (nonatomic, assign) NSInteger num;// 总数
@property (nonatomic, assign) NSInteger totalPage; // 分页总的页数

@end
