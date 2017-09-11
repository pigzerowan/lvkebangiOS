//
//  SimpleGroupIntroduceViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 2/1/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SetGroupIntroduceBlock)(NSString *textField);
@interface SimpleGroupIntroduceViewController : BaseViewController
@property(nonatomic,copy)SetGroupIntroduceBlock introduceBlock;

-(void)sendeGroupIntroduceBlock:(SetGroupIntroduceBlock)block;

@property (nonatomic, strong) UITextView * introductionView;
@property (nonatomic, strong) UILabel * wordNumberlLabel;
@property (retain ,nonatomic) NSString * fieldText;

@end
