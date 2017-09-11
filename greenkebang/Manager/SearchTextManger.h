//
//  SearchTextManger.h
//  greenkebang
//
//  Created by 郑渊文 on 10/16/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchTextManger : NSObject
+(SearchTextManger *)shareInstance;

@property (nonatomic,copy)NSString *searchText;

@end
