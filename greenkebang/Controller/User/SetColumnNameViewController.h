//
//  SetColumnNameViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/3.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SetColumnNameBlock)(NSString *textField);

@interface SetColumnNameViewController : BaseViewController

@property (nonatomic, strong) UITextField * ColumnNameTextField;
@property (nonatomic, strong) UIView * line_1;
@property (nonatomic, strong) NSString *column;

@property(nonatomic,copy)SetColumnNameBlock nextVCBlock;

-(void)nextVCBlock:(SetColumnNameBlock)block;
@end
