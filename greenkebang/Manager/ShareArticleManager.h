//
//  ShareArticleManager.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/7.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ShareArticleManager : NSObject







//+(ShareArticleManager)shareInstanc2e;






















+(ShareArticleManager *)shareInstance;
@property(nonatomic, copy) NSString *shareObjId;
@property(nonatomic, copy) NSString *shareTitle;
@property(nonatomic, copy) NSString *shareUrl;
@property(nonatomic, copy) NSString *groupId;
@property(nonatomic, copy) NSString *shareImage;
@property(nonatomic, copy) NSString *shareType;

@end
