//
//  UserCollectionNoImageNoDetailCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/5.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"
typedef void(^AttentionColumnToClickBlock)(NSInteger clickIndex);

@interface UserCollectionNoImageNoDetailCell : UITableViewCell
@property (nonatomic, copy) AttentionColumnToClickBlock AttentionColumnClickBlock;

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *replyBtn;
@property (nonatomic, assign) BOOL didLike;

@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) UIButton *loveButton;
@property (strong, nonatomic) UIButton *iocnBtn;





@property (strong, nonatomic) UILabel *comentNumLable;
@property (strong, nonatomic) UIImageView *repleyImageView;
@property (strong, nonatomic) UIImageView *starImage;
@property (strong, nonatomic) UILabel *starLabel;

@property (strong, nonatomic) UILabel *attentionNumLable;
@property (strong, nonatomic) UILabel *fromGroup;
@property (strong, nonatomic) UIButton *GroupButton;
- (void)handlerButtonAction:(AttentionColumnToClickBlock)block;

- (void)configCollectionNoImageNoDetailCellWithModel:(CollectionDetailModel *)model;

@end
