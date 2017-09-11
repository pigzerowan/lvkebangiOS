//
//  AccountLoginViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 15/12/3.
//  Copyright © 2015年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AccountLoginViewController : BaseViewController
@property(nonatomic,copy)NSString *access_token;
@property(nonatomic,copy)NSString *openid;
@property(nonatomic,copy)NSDictionary *myInfoDic;
@property (copy, nonatomic) NSString *code;

- (void)loginButtonClicked:(id)sender;

@end
