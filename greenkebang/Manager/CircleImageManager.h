//
//  CircleImageManager.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/11/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircleImageManager : NSObject
+(CircleImageManager *)shareInstance;
@property(nonatomic, copy) NSString *CircleImage;


@end
