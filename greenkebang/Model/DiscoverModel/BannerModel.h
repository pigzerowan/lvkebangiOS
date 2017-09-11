//
//  BannerModel.h
//  greenkebang
//
//  Created by 郑渊文 on 11/13/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LKBBaseModel.h"
@protocol BannerDetailModel <NSObject>
@end

@interface BannerDetailModel : LKBBaseModel
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString * coverId;
@property (nonatomic, copy) NSString * coverUrl;
@property (nonatomic, copy) NSString * coverLink;
@property (nonatomic, copy) NSString * aliveFlag;
@property (nonatomic, copy) NSString * endDate;
@property (nonatomic, copy) NSString *beginDate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *insightId;//文章ID
@property (nonatomic, copy) NSString *replyNum;//回复数
@property (nonatomic, copy) NSString *featureId;//专栏ID
@property (nonatomic, copy) NSString *featureAvatar;//专栏头像
@property (nonatomic, copy) NSString * summary;//文章缩略
@property (nonatomic, copy) NSString *cover;//文章封面图


@end


@interface BannerModel : LKBBaseModel
@property (nonatomic, copy) NSArray<BannerDetailModel>* data;
@end
