//
//  FindTopicCell.h
//  greenkebang
//
//  Created by 郑渊文 on 1/28/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewFindModel.h"
typedef void(^BottomBuyClickBlock)(NSInteger clickIndex);
@interface FindTopicCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, copy) BottomBuyClickBlock clickBlock;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *adressLable;
@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *replyBtn;

- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID;

- (void)configNewFindTopicTableCellWithGoodModel:(NewFindDetailModel *)admirGood;

@end
