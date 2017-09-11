//
//  UserCollectionImageButNoDetailCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/5.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"
typedef void(^AttentionColumnToClickBlock)(NSInteger clickIndex);


@protocol AttentionColumnCellDelegate <NSObject>

@optional

- (void)turnToColumn:(NSString *)sender;


@end

@interface UserCollectionImageButNoDetailCell : UITableViewCell
@property (nonatomic, copy) AttentionColumnToClickBlock AttentionColumnClickBlock;


@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *replyBtn;
@property (nonatomic, assign) BOOL didLike;
//@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UIImageView *addressIconImageView;
@property (strong, nonatomic) UILabel *nameLabel;
//@property (strong, nonatomic) UILabel *loveTimeLabel;
@property (strong, nonatomic) UILabel *goodsTitleLabel;
@property (strong, nonatomic) UILabel *goodsDesLabel;
@property (strong, nonatomic) UILabel *goodsTimeLabel;
@property (strong, nonatomic) UILabel *goodsAddressLabel;
@property (strong, nonatomic) UILabel *goodsPriceLabel;
@property (strong, nonatomic) UIButton *loveButton;
@property (strong, nonatomic) UIButton *iocnBtn;
@property (strong, nonatomic) UIView *detailView;
@property (strong, nonatomic) UIView *controllerView;
@property (strong, nonatomic) NSString *typeStr;
//@property (strong, nonatomic) UIButton *squeBtn;
//定义一个contentLabel文本高度的属性
@property (nonatomic,assign) CGFloat contentLabelH;


@property (strong, nonatomic) UILabel *comentNumLable;
@property (strong, nonatomic) UIImageView *repleyImageView;
@property (strong, nonatomic) UILabel *attentionNumLable;

@property (strong, nonatomic) UIImageView *starImage;
@property (strong, nonatomic) UILabel *starLabel;

@property (strong, nonatomic) UILabel *fromGroup;
@property (strong, nonatomic) UIButton *GroupButton;
@property (copy, nonatomic) NSString *columnId;

@property (nonatomic , assign) id <AttentionColumnCellDelegate>attentionCellDelegate;
- (void)handlerButtonAction:(AttentionColumnToClickBlock)block;


- (void)configCollectionImageButNoDetailCellCellWithModel:(CollectionDetailModel *)model;

@end
