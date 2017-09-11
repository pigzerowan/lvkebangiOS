//
//  SocialRigistManager.h
//  greenkebang
//
//  Created by 郑渊文 on 9/14/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocialRigistManager : NSObject
+(SocialRigistManager *)shareInstance;

@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *openId;
@property (nonatomic,copy)NSString *gender;
@property (nonatomic,copy)NSString *birthDay;
@property (nonatomic,strong)UIImageView *avatar;

@end
