//
//  AgricultureCircleHeaderView.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/10/13.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTimeDynamicModel.h"
typedef void(^AgricultureCircleToClickBlock)(NSInteger clickIndex);

@interface AgricultureCircleHeaderView : UIView
@property (nonatomic, copy) AgricultureCircleToClickBlock AgricultureClickBlock;

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong)UIImageView * blurImageView; // 需要虚化的照片
@property (strong, nonatomic)UIButton* headImageButton;//头像
@property (nonatomic, strong)UIVisualEffectView * visualEffectView; //毛玻璃效果
@property (nonatomic, strong)UIView * blurImageBackView;// 毛玻璃上面的黑色
@property (nonatomic, strong)UILabel * nameLabel;// 姓名
@property (nonatomic, strong)UILabel * memberNumLabel;// 介绍
@property (nonatomic, strong)UIButton * joinButton ;// 加入
@property (strong, nonatomic) UIView *circleBackView;// 圈子的背景

@property (nonatomic, strong)UILabel * circleIntNameLabel;//圈子简介名称
@property (nonatomic, strong)UILabel * circleIntroduceLabel;//圈子简介内容
@property (nonatomic, strong)UILabel * memberNum;//成员数量
@property (nonatomic, strong)UIImageView * memberNumImage;//成员数量图片
@property (nonatomic, strong)UIButton * circleIntroduceButton;//圈子简介
@property (strong, nonatomic) UIView *memberView;// 群成员
@property (nonatomic, strong)UIButton * memberInviteButton;//圈子简介
@property (nonatomic, strong)UIButton * navBackButton;//返回按钮
@property (nonatomic, strong)UIButton * topmenubtn;//返回按钮
@property (nonatomic, strong)NSArray* avatarsArray;//是否加入
@property (nonatomic, strong)UIImageView * avatarImage;

- (void)handlerButtonAction:(AgricultureCircleToClickBlock)block;

- (void)configAgricultureCircleHeaderViewWithModel:(NewTimeDynamicModel*)model;

@end
