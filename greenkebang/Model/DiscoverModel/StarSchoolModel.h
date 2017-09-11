//
//  StarSchoolModel.h
//  greenkebang
//
//  Created by 郑渊文 on 7/25/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol StarSchoolModelDetailModel <NSObject>
@end

@interface StarSchoolModelDetailModel : LKBBaseModel
// 专栏
@property (nonatomic, copy) NSString *couAvatar;
@property (nonatomic, copy) NSString *couDate;
@property (nonatomic, copy) NSString *couId;
@property (nonatomic, copy) NSString *couInsight;
@property (nonatomic, copy) NSString *couTitle;
@property (nonatomic, copy) NSString *starNum;
@property (nonatomic, copy) NSString *couTeacher;
@property (nonatomic, copy) NSString *teacherDesc;
@property (nonatomic, copy) NSString *replyNum;
@property (nonatomic, copy) NSString *featureAvatar;
@property (nonatomic, copy) NSString *featureId;
@property (nonatomic, copy) NSString *isCollect;
@property (nonatomic, copy) NSString *lkbId;

@end
@interface StarSchoolModel :LKBBaseModel
@property (nonatomic, copy) NSArray<StarSchoolModelDetailModel>* data;
@end
