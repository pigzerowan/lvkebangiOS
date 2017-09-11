//
//  AttentionCell.h
//  greenkebang
//
//  Created by 郑渊文 on 12/14/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecFriendModel.h"
#import "GroupModel.h"

@interface AttentionCell : UICollectionViewCell
{
    BOOL m_checked;
}
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *attentionBtn;
@property (nonatomic, strong) UILabel *passLabel;

- (void)configDiscoveryOtherFallCellWithModel:(friendModel *)good;

- (void)setChecked:(BOOL)checked;
- (void)configDiscoveryCircleCellWithModel:(GroupDetailModel *)good;
@end
