//
//  NewTimeViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 1/12/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFActionSheet.h"

@interface NewTimeViewController : BaseViewController<ZFActionSheetDelegate>
@property (copy, nonatomic) NSString * linkUrl;
@property (copy, nonatomic) NSString* toRequestURL;
@property (strong, nonatomic)ZFActionSheet *actionSheet;
@property (assign, nonatomic)CGFloat oneImageWidth;
@property (assign, nonatomic)CGFloat oneImageHeight;

@end
