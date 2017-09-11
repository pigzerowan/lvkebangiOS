//
//  SetColumnIntroduceViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/3.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SetColumnIntroduceBlock)(NSString *textField);

@interface SetColumnIntroduceViewController : BaseViewController

@property(nonatomic,copy)SetColumnIntroduceBlock introduceBlock;

@property (nonatomic ,strong)NSString *introduce;

-(void)sendeGroupIntroduceBlock:(SetColumnIntroduceBlock)block;

@end
