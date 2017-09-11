//
//  SecretTableViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 11/30/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecretModel;
@interface SecretTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *readLabel;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) UIButton *loveButton;

//- (void)configDiscoveryRecommCellWithModel:(SecretModel *)simleTopic;

@end
