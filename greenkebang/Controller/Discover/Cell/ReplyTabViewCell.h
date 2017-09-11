//
//  ReplyTabViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 9/23/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);

@interface ReplyTabViewCell : UITableViewCell
@property (nonatomic, copy) BottomBuyClickBlock clickBlock;
@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *replyBtn;
//用户名
@property(nonatomic,strong) UILabel *name;
//时间
@property(nonatomic,strong) UILabel *timeLable;
//回复评论
@property(nonatomic,strong) UITextView *introduction;
//用户头像
@property(nonatomic,strong) UIButton *userImage;

@property(nonatomic,strong) UIView *borthView;



@property (assign, nonatomic) BOOL  isChecked;
//给用户介绍赋值并且实现自动换行
-(void)setIntroductionText:(NSString*)text;
//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

- (void)handlerButtonAction:(BottomBuyClickBlock)block;


@end
