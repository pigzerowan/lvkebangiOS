//
//  AttentionArticTableViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 4/5/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionContentsModel.h"
@protocol AttentionCellDelegate <NSObject>

@optional
/**
 *  点击跳转
 */

- (void)turnToArtic:(NSString *)sender;


@end

typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);

@interface AttentionArticTableViewCell : UITableViewCell
@property (nonatomic, copy) BottomBuyClickBlock clickBlock;
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UIImageView *headImageBackView;

@property (strong, nonatomic) UIImageView *nameImage;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *ArticNumLable;
@property (strong, nonatomic) UILabel *columnNameLable;
@property (strong, nonatomic) UIButton *turnToAticBtn;
@property (strong, nonatomic) UILabel *publishLable;
@property (nonatomic, copy) NSString *featureId;
@property (nonatomic , assign) id <AttentionCellDelegate>attentionCellDelegate;

@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) UIView *lineView;

- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID;

- (void)handlerButtonAction:(BottomBuyClickBlock)block;

- (void)configAttentionArticTableCellWithGoodModel:(AttentionContentsListModel *)admirGood;


@end
