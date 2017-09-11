//
//  UserInforTableViewCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/13.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInforDynamicModel.h"
@interface UserInforTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong)UIImageView *headerImage;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *issueLabel;//发布文章
@property (nonatomic, strong)UILabel *personalLabel;// 个人介绍
@property (nonatomic, strong)UILabel *timeLabel;// 时间

@property (nonatomic, strong)UIView *articleView;// 文章
@property (nonatomic, strong)UILabel *titleLabel;// 标题
@property (nonatomic, strong)UIView *line_1;// 划线
@property (nonatomic, strong)UILabel *contentLabel;//内容

@property (nonatomic, strong)UIButton *commentButton;//评论
@property (nonatomic, strong)UILabel *commentLabel;//评论数
@property (nonatomic, strong)UIView *line_2;
@property (nonatomic, strong)UIButton *goodButton;//点赞
@property (nonatomic, strong)UILabel *goodLabel;// 点赞数

- (void)configUserInforCellWithModel:(UserDynamicModelIntroduceModel *)model;


@end
