//
//  YQRequestModel.m
//  youqu
//
//  Created by chun.chen on 15/7/31.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import "YQRequestModel.h"

@implementation YQRequestModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithUrl:(NSString *)url isLoadingMore:(BOOL)isLoadingMore
{
    self = [super init];
    if (self) {
        _url = url;
        _isLoadingMore = isLoadingMore;
    }
    return self;
}
@end
