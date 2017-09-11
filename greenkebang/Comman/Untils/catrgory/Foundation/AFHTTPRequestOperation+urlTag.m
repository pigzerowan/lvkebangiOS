//
//  AFHTTPRequestOperation+urlTag.m
//  youqu
//
//  Created by chun.chen on 15/7/27.
//  Copyright (c) 2015年 youqu. All rights reserved.
//

#import "AFHTTPRequestOperation+urlTag.h"
#import <objc/runtime.h>

@implementation AFHTTPRequestOperation (urlTag)

static char *operationUrlTag;
static char *operationLoadingMore;

- (void)setUrlTag:(NSString *)urlTag {
    objc_setAssociatedObject(self, &operationUrlTag, urlTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)urlTag{
    return objc_getAssociatedObject(self, &operationUrlTag);
}

- (void)setIsLoadingMore:(BOOL)isLoadingMore {
    objc_setAssociatedObject(self, &operationLoadingMore, @(isLoadingMore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isLoadingMore {
    return [objc_getAssociatedObject(self, &operationLoadingMore) boolValue];
}

@end
