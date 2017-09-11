//
//  AFHTTPRequestOperation+urlTag.h
//  youqu
//
//  Created by chun.chen on 15/7/27.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface AFHTTPRequestOperation (urlTag)

@property (nonatomic, copy) NSString *urlTag;
@property (nonatomic, assign) BOOL isLoadingMore;

@end
