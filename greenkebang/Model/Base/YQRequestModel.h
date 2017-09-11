//
//  YQRequestModel.h
//  youqu
//
//  Created by chun.chen on 15/7/31.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQRequestModel : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) BOOL isLoadingMore;

- (instancetype)initWithUrl:(NSString *)url isLoadingMore:(BOOL)isLoadingMore;
@end
