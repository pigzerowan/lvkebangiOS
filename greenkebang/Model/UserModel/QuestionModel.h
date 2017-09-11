//
//  QuestionModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/28.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol QuestionModelIntroduceModel <NSObject>
@end

@interface QuestionModelIntroduceModel : LKBBaseModel
@property (nonatomic,copy) NSString *answerNum;
@property (nonatomic,copy) NSString *fansNum;

@property (nonatomic, assign) NSTimeInterval questionDate;
@property (nonatomic,copy) NSString * questionId;
@property (nonatomic,copy) NSString * summary;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString * cover;

@end
@interface QuestionModel : LKBBaseModel
@property (nonatomic, copy) NSArray<QuestionModelIntroduceModel>* data;
@property (nonatomic, assign) NSInteger num;

@end
