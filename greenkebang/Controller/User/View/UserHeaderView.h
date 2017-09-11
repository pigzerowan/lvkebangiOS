//
//  UserHeaderView.h
//  greenkebang
//
//  Created by 郑渊文 on 9/9/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCenterModel.h"


@class UserHeaderView;
@protocol UserHeaderViewDelegate <NSObject>

@optional
- (void)userHeaderView:(UserHeaderView *)UserHeaderView didatterntion:(NSString *)userId;

@end

@interface UserHeaderView : UIView
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIImageView *myIcon;
@property (strong, nonatomic) UILabel *attententionLab;
@property (strong, nonatomic) UILabel *myWorlds;
@property (strong, nonatomic) UIButton *attentionBtn;

@property(nonatomic,assign) id<UserHeaderViewDelegate> delegate;

- (void)configDiscoveryRecommCellWithModel:(UserCenterModel*)model;

@end
