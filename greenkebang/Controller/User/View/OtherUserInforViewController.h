//
//  OtherUserInforViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/28.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherUserInforHeaderView.h"
@interface OtherUserInforViewController : BaseViewController
@property(nonatomic,copy)NSString *toUserId;
@property(nonatomic,copy)NSString *ifAttention;

-(void)userHeaderView;
@end
