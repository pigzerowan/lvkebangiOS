//
//  LKBBaseFactory.h
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"

@interface LKBBaseFactory : NSObject
+ (LKBBaseModel *)modelWithURL:(NSString *)url responseJson:(NSDictionary *)jsonDict;
@end
