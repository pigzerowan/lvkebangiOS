//
//  MyGroupInfoManager.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/16.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "MyGroupInfoManager.h"

@implementation MyGroupInfoManager
static MyGroupInfoManager *_myGroupInfor;

+(MyGroupInfoManager *)myGroupInfor {
    
    @synchronized([MyGroupInfoManager class]) {
        
        if (_myGroupInfor == nil) {
            _myGroupInfor = [[MyGroupInfoManager alloc]init];
            
        }
        return _myGroupInfor;
    }
}







@end
