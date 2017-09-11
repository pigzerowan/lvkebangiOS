//
//  GroupModel.m
//  greenkebang
//
//  Created by 郑渊文 on 9/10/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "GroupModel.h"
@implementation GroupDetailModel
- (NSDictionary *)modelKeyJSONKeyMapper {
    return @{@"otherAvatar":@"newAvatar"};
}
-(instancetype)initWithDic:(NSArray *)dic {
    
    self = [super init];
    if (self) {
        
        self.shouldUpdateCache  = NO;
    }
    return self;
    
    
}

@end


@implementation GroupModel

@end
