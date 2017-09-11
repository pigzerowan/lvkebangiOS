//
//  NewDynamicModel.m
//  greenkebang
//
//  Created by 郑渊文 on 1/12/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "NewTimeDynamicModel.h"


@implementation NewDynamicDetailModel
-(instancetype)initWithDic:(NSArray *)dic {
    
    self = [super init];
    if (self) {
        
        self.shouldUpdateCache  = NO;
        
        NSLog(@"=============================%@",dic );

        for (NSDictionary * goodDic in dic) {
            
            self.avatar = [goodDic valueForKey:@"avatar"];
        }
        
        NSLog(@"==========%@",self.avatar);

    }
    return self;

    
}


//根据字典更新Model对象的属性
- (void)updateWithDictionary:(NSArray *)dic{
    
    for (NSDictionary * goodDic in dic) {
        
        self.avatar = [goodDic valueForKey:@"avatar"];
    }
    
    NSLog(@"==========%@",self.avatar);
    
    
    
    /*
     {
     msg = "\U70b9\U8d5e\U901a\U77e5";
     noticeName = "\U70b9\U8d5e\U901a\U77e5";
     noticeType = 5;
     object =     {
     avatar = "2016-08-20_s1PIqUUa.png";
     inviteAnswerNum = 0;
     noticeContent = "";
     objId = 960;
     objType = 1;
     userId = 128;
     userName = "\U5c0f\U82b1";
     };
     type = 0;
     }
     */


}




@end

@implementation NewTimeDynamicModel



@end
