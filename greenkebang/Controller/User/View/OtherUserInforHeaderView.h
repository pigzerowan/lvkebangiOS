//
//  OtherUserInforHeaderView.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/28.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInforModel.h"


typedef void(^OtherChoseToClickBlock)(NSInteger clickIndex);

@interface OtherUserInforHeaderView : UIView

@property (nonatomic, copy) OtherChoseToClickBlock otherclickBlock;

//@property (strong, nonatomic) UIButton * headButton;//头像按钮
@property (strong, nonatomic) UIImageView * headImageView;//头像
//@property (strong, nonatomic) UIImage *headImg; // 头像图片
@property (nonatomic, copy) NSURL *photoUrl;
@property (nonatomic, strong)UILabel * nameLabel;// 姓名
@property (nonatomic, strong)UIButton * attentionButton;// 关注
@property (nonatomic, strong)UILabel * signatureLabel;// 签名
@property (nonatomic, strong)UIImageView * blurImageView; // 需要虚化的照片
@property (nonatomic, strong)UIButton * specialColumnButton;// 专栏
@property (nonatomic, strong)UILabel * specialColumnLabel;// 专栏数
@property (nonatomic, strong)UIImageView * line_1;// 线条
@property (nonatomic, strong)UIButton * myAttentionButton; //我的关注
@property (nonatomic, strong)UILabel * attentionLabel;// 关注数
@property (nonatomic, strong)UIImageView * line_2;// 线条
@property (nonatomic, strong)UIButton * fansButton; // 粉丝
@property (nonatomic, strong)UILabel * fansLabel;// 粉丝数
@property (nonatomic, strong)UIVisualEffectView * visualEffectView; //毛玻璃效果
@property (nonatomic, strong)UIButton * otherSpecialColumnBut;// ta的群组
@property (nonatomic, strong)UIButton * otherGroupBut;// ta的群组
@property (nonatomic, strong)UIButton * otherTopicBut;// ta的话题
@property (nonatomic, strong)UIButton * otherQuestionBut;// ta的答疑
@property (nonatomic, strong)UIButton * otherCollectionBut;// ta的收藏
@property (nonatomic, strong)NSString * ifAttention;




- (void)handlerButtonAction:(OtherChoseToClickBlock)block;

- (void)configSearchPeopleRecommCellWithModel:(UserInforModel*)model;

@end
