//
//  SetGroupTagsViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 2/1/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SetGrouptagsBlock)(NSString *textField);
@interface SetGroupTagsViewController : BaseViewController
@property(nonatomic,copy)SetGrouptagsBlock setGrouptagsBlock;

-(void)sendeGrouptasgBlock:(SetGrouptagsBlock)block;
@end
