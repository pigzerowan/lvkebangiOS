//
//  InviteAnswerModel.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "InviteAnswerModel.h"
@implementation InviteAnswerDetailModel

-(instancetype)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        
        self.shouldUpdateCache  = NO;
        
        NSLog(@"=============================%@",dic );
        
//        for (NSDictionary * goodDic in dic) {
        
            self.objId = [dic valueForKey:@"objId"];
//        }
        
        NSLog(@"==========%@",self.objId);
        
    }
    return self;
    
    
}



@end
@implementation InviteAnswerModel

@end
