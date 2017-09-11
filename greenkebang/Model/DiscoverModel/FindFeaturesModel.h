//
//  FindFeaturesModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 2017/3/6.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FeaturesDetailModel <NSObject>


@end
@interface FeaturesDetailModel : LKBBaseModel
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *dynamicNum;
@property (nonatomic, copy) NSString *memberNum;
@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *title;


@end

@interface FindFeaturesModel : LKBBaseModel
@property (nonatomic, copy) NSArray <FeaturesDetailModel>* data;

@end
