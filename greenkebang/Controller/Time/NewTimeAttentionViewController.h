//
//  NewTimeAttentionViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/9/9.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFActionSheet.h"

@interface NewTimeAttentionViewController : BaseViewController<ZFActionSheetDelegate>
@property (copy, nonatomic) NSString * linkUrl;
@property (copy, nonatomic) NSString* toRequestURL;
@property (strong, nonatomic)ZFActionSheet *actionSheet;
@property (copy, nonatomic) NSString * type;
@property (assign, nonatomic) NSInteger StartsectionIdex;
@property (assign, nonatomic)CGFloat oneImageWidth;
@property (assign, nonatomic)CGFloat oneImageHeight;

@end
