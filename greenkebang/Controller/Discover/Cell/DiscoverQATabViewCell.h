//
//  DiscoverQATabViewCell.h
//  greenkebang
//
//  Created by 郑渊文 on 9/21/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
#import "InsightModel.h"
#import "InsetsLabel.h"

@interface DiscoverQATabViewCell : UITableViewCell
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) UILabel *nametimeLable;
@property (strong, nonatomic) UILabel *simpleLable;

- (void)configDynamicCellWithModel:(NewDynamicModel *)model;
@end
