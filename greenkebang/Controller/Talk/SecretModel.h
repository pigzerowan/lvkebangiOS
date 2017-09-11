//
//  SecretModel.h
//  greenkebang
//
//  Created by 郑渊文 on 11/30/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKBBaseModel.h"
@protocol SecretModel <NSObject>
@end
@interface SecretModel : LKBBaseModel

@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;


@end
