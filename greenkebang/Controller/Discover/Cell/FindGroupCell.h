//
//  FindGroupCell.h
//  greenkebang
//
//  Created by 郑渊文 on 1/20/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewFindModel.h"
@interface FindGroupCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *adressLable;
@property (strong, nonatomic) UIButton *groupBtn;

- (id)initWithHeight: (CGFloat)height reuseIdentifier: (NSString *)reuseID;


- (void)configNewFindGroupTableCellWithGoodModel:(NewFindDetailModel *)admirGood;

@end
