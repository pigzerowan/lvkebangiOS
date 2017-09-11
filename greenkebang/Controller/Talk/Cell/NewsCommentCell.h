//
//  NewsCommentCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/30.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetCommentModel.h"
typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);

@interface NewsCommentCell : UITableViewCell
@property (nonatomic, copy) BottomBuyClickBlock clickBlock;

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIButton *headerButton;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *commentLabel;
//@property (strong, nonatomic) UIImageView *replyImage;
@property (strong, nonatomic) UIButton *replyButton;
@property (strong, nonatomic) UIButton *titleButton;

@property (strong, nonatomic) UIView *lineView;

@property (strong, nonatomic) NSString *titleType;
@property (strong, nonatomic)     UIImageView *btnImage;
- (void)handlerButtonAction:(BottomBuyClickBlock)block;
- (void)configSingelGetCommentTableCellWithGoodModel:(GetDetailCommentModel *)admirGood;
@end
