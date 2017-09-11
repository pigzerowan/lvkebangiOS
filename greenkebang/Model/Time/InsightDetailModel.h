//
//  InsightDetailModel.h
//  greenkebang
//
//  Created by 郑渊文 on 9/24/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol InsightDetailChildModel <NSObject>
@end

@interface InsightDetailChildModel : LKBBaseModel
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, copy) NSString *createBy;
//@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *blogContent;
@property (nonatomic, copy) NSString *blogAbstract;
@property (nonatomic, copy) NSString *blogId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *readNum;
@property (nonatomic, copy) NSString *blogTitle;
@property (nonatomic, copy) NSString *collectNum;// 收藏数

@property (nonatomic, copy) NSString *content;// 专栏文章内容

@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *featureDesc;// 该专栏文章所在的专栏的专栏简介
@property (nonatomic, copy) NSString *featureId;// 该专栏文章所在的专栏的专栏ID
@property (nonatomic, copy) NSString *featureName; // 该专栏文章所在的专栏的专栏名
@property (nonatomic, copy) NSString *insightId;// 该专栏文章的ID
@property (nonatomic, copy) NSString *isIndex;
@property (nonatomic, copy) NSString *labels;

@property (nonatomic, assign) NSTimeInterval pubDate;

@property (nonatomic, copy) NSString *replyNum;
@property (nonatomic, copy) NSString *starNum;
@property (nonatomic, copy) NSString *shareNum;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *isCollection;
@property (nonatomic, copy) NSString *isStar;
@property (nonatomic, assign) BOOL havehold;
@property (nonatomic, assign) BOOL haveup;
@property (nonatomic, copy) NSString *isReport;
//@property (nonatomic, copy) NSString *userName;
@end


@interface InsightDetailModel : LKBBaseModel
@property (nonatomic, strong) InsightDetailChildModel *data;
@property (nonatomic, copy) NSString *isStar;;
@end
