//
//  QuestionAndAnswerCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/30.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);

@interface QuestionAndAnswerCell : UITableViewCell
@property (nonatomic, copy) BottomBuyClickBlock clickBlock;

@property(strong,nonatomic)UIButton *headerButton;
@property(strong, nonatomic)UIButton * titleButton;
@property(strong,nonatomic)UIImageView *headerImage;
@property(strong,nonatomic)UIImageView *headerImage_2;
@property(strong,nonatomic)UIImageView *headerImage_3;
@property(strong,nonatomic)UILabel *answerLabel;
@property(strong,nonatomic)UIImageView *redImage;
@property(strong,nonatomic)UIView *lineView;

- (void)handlerButtonAction:(BottomBuyClickBlock)block;

@end
