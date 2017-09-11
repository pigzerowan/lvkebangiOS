//
//  SetGroupNameViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 2/1/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SetGroupNameBlock)(NSString *textField);


@interface SetGroupNameViewController : BaseViewController
@property (nonatomic, strong) UITextField * GroupNameTextField;
@property (nonatomic, strong) UIView * line_1;
@property (nonatomic, strong) NSString * nameLabel;

@property(nonatomic,copy)SetGroupNameBlock nextVCBlock;

-(void)nextVCBlock:(SetGroupNameBlock)block;

@end
