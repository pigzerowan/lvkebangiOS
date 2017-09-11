//
//  ChooseGroupTypeViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 2/1/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SetGroupTypeBlock)(NSString *textField);
@interface ChooseGroupTypeViewController : UIViewController
@property(nonatomic,copy)NSString *typeStr;
@property(nonatomic,copy)SetGroupTypeBlock setGroupTypeBlock;

-(void)sendeGrouptypeBlock:(SetGroupTypeBlock)block;

@end
