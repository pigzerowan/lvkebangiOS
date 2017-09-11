//
//  LKBBaseTabBarController.h
//  greenkebang
//
//  Created by 郑渊文 on 8/26/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKBBaseTabBarController : UITabBarController
{
    EMConnectionState _connectionState;
}

- (void)jumpToChatList;

- (void)setupUntreatedApplyCount;

- (void)networkChanged:(EMConnectionState)connectionState;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;

@end
