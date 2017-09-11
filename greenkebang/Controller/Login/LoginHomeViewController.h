//
//  LoginHomeViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 15/12/1.
//  Copyright © 2015年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginHomeViewControllerDelegate <NSObject>


@optional


-(void)getWeiXinCodeFinishedWithResp:(NSString*)code;

@end


@interface LoginHomeViewController : BaseViewController


@end
