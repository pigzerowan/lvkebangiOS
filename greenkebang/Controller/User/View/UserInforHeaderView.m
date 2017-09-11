//
//  UserInforHeaderView.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/8.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforHeaderView.h"
#import "LKBPrefixHeader.pch"
#import "FileHelpers.h"
#import <UIImageView+WebCache.h>
#import "UserRootViewController.h"
#import "PeopleViewController.h"
#import "MyUserInfoManager.h"
#import "NewUserMainPageViewController.h"
@implementation UserInforHeaderView

- (instancetype)init
{
    self = [super init];
    if (!self)
        return nil;
    [self headerView];

    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
        return nil;
    [self headerView];
    
    return self;
}


- (void)configMyInforRecommCellWithModel:(UserInforModel*)model{
    
    //    [self.myIcon sd_setImageWithURL:[model.image lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    //    _textLabel.text = model.contactName;
    [self.headImageView sd_setImageWithURL:[[model.data valueForKey:@"avatar"] lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    [self.blurImageView sd_setImageWithURL:[[model.data valueForKey:@"avatar"] lkbImageUrl4]  placeholderImage:YQNormalPlaceImage];
    
    // 用户名
    self.nameLabel.text = [NSString stringWithFormat:@"%@",[model.data valueForKey:@"userName"]];
    
    
    
    // 关注
    _attentionLabel.text =[NSString stringWithFormat:@"%@",[model.data valueForKey:@"attentionNum"]];
    if ([[model.data valueForKey:@"remark"] isEqualToString:@""]||[model.data valueForKey:@"remark"] == nil ) {
        _signatureLabel.text = @"此人很懒，什么也没有留下~";
        _signatureLabel.textColor = [UIColor grayColor];
    }else{
        _signatureLabel.text = [NSString stringWithFormat:@"%@",[model.data valueForKey:@"remark"]];
//        _signatureLabel.textColor = [UIColor lightGrayColor];
        
    }
    //    // 粉丝
    _fansLabel.text = [NSString stringWithFormat:@"%@ ",[model.data valueForKey:@"fansNum"]];
}


- (void)headerView {
    
    _blurImageView = [[UIImageView alloc]init];
    _blurImageView.frame = CGRectMake(0, 0, kDeviceWidth, 229);
//    [_blurImageView setImage:_headImg];
    _blurImageView.userInteractionEnabled = YES;
    
    [self addSubview:_blurImageView];
    
    _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    _visualEffectView.frame = _blurImageView.frame;
    _visualEffectView.alpha = 1.0;
    [_blurImageView addSubview:_visualEffectView];
    
    
    // 设置按钮
    _setUpButton = [[UIButton alloc]init];
    _setUpButton.frame = CGRectMake(kDeviceWidth  - 50 , 14, 40, 40);
    [_setUpButton setImage:[UIImage imageNamed:@"Infor"] forState:UIControlStateNormal];
    [_setUpButton addTarget:self action:@selector(setUpInforButton:) forControlEvents:UIControlEventTouchUpInside];
    [_visualEffectView.contentView addSubview:_setUpButton];
    
    // 头像
    _headImageView = [[UIImageView alloc]init];
    _headImageView.layer.cornerRadius = 40.f;
    _headImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _headImageView.layer.borderWidth = 1.0f;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.frame = CGRectMake(kDeviceWidth / 2 - 40 , 14, 80, 80);
    if (_headImageView.image == nil) {
        _headImageView.backgroundColor = [UIColor lightGrayColor];
    }
    //    [_headButton addTarget:self action:@selector(headerImage:) forControlEvents:UIControlEventTouchUpInside];
//    _headImg = [UIImage imageWithContentsOfFile:pathForURL(_photoUrl)];
//    [_headImageView setImage:_headImg forState:UIControlStateNormal];
//    [_headImageView.image]
//    _headImageView.image = [UIImage imageWithContentsOfFile:pathForURL(_photoUrl)];
    [_visualEffectView.contentView addSubview:_headImageView];
    
    
    // 姓名
    _nameLabel = [[UILabel alloc]init];
//    _nameLabel.frame = CGRectMake(SCREEN_WIDTH / 2 -60, 110,100, 30);
    _nameLabel.frame = CGRectMake(0, 110,kDeviceWidth, 30);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [_visualEffectView.contentView addSubview:_nameLabel];
    
    
    // 个性签名
    _signatureLabel = [[UILabel alloc]init];
    _signatureLabel.frame = CGRectMake( 0, 145, kDeviceWidth, 20);
//    _signatureLabel.text = @"1233455678932223555666";
    _signatureLabel.font = [UIFont systemFontOfSize:14];
    _signatureLabel.textAlignment = NSTextAlignmentCenter;
    [_visualEffectView.contentView addSubview:_signatureLabel];
    

    // 关注
    _myAttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _myAttentionButton.frame = CGRectMake(0 , 174, kDeviceWidth / 3, 55);
    _myAttentionButton.backgroundColor = [UIColor blackColor ];
    _myAttentionButton.alpha = 0.5;
    [_myAttentionButton setTitle:@"我关注的人" forState:UIControlStateNormal];
    if (iPhone5) {
        _myAttentionButton.titleEdgeInsets = UIEdgeInsetsMake(40, _myAttentionButton.titleLabel.bounds.size.width -30 , 10, 0);

    }else {
    _myAttentionButton.titleEdgeInsets = UIEdgeInsetsMake(40, _myAttentionButton.titleLabel.bounds.size.width -40 , 10, 0);
    }
    _myAttentionButton.tintColor = [UIColor whiteColor];
    _myAttentionButton.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
    //
    [_myAttentionButton setImage:[UIImage imageNamed:@"icon_attention_people_nor"] forState:UIControlStateNormal];
    _myAttentionButton.imageEdgeInsets = UIEdgeInsetsMake(10,43,25,25);
    _myAttentionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_myAttentionButton addTarget:self action:@selector(attentionButton:) forControlEvents:UIControlEventTouchUpInside];
    // 关注个数
    if (iPhone5) {
        _attentionLabel = [[UILabel alloc]initWithFrame:CGRectMake( kDeviceWidth * 0.25, 203, 50, 30)];

    }
    else {
    _attentionLabel = [[UILabel alloc]initWithFrame:CGRectMake( kDeviceWidth * 0.23, 203, 50, 30)];
    }
//    _attentionLabel.text = @"21";
    _attentionLabel.textColor = [UIColor redColor];
    _attentionLabel.font = [UIFont systemFontOfSize:14];
    [_visualEffectView addSubview:_attentionLabel];
     [_visualEffectView.contentView addSubview:_myAttentionButton];
    
    
    // 粉丝
    _fansButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _fansButton.frame = CGRectMake( kDeviceWidth / 3  , 174, kDeviceWidth / 3, 55);
    _fansButton.backgroundColor = [UIColor blackColor];
    _fansButton.alpha =0.5;
    [_fansButton setTitle:@"关注我的人 " forState:UIControlStateNormal];
    _fansButton.titleEdgeInsets = UIEdgeInsetsMake(40, _fansButton.titleLabel.bounds.size.width-20, 10, 0);
    _fansButton.tintColor = [UIColor whiteColor];
    _fansButton.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
    // icon_attention_people_nor
    [_fansButton setImage:[UIImage imageNamed:@"icon_had_attention_people_nor"] forState:UIControlStateNormal];
    _fansButton.imageEdgeInsets = UIEdgeInsetsMake(10,43,25,30);
    [_fansButton addTarget:self action:@selector(fansButton:) forControlEvents:UIControlEventTouchUpInside];
    _fansButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    // 粉丝个数
    _fansLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth *0.57, 203, 50, 30)];
//    _fansLabel.text = @"21";
    _fansLabel.textColor = [UIColor redColor];
    _fansLabel.font = [UIFont systemFontOfSize:14];
    [_visualEffectView addSubview:_fansLabel];
    [_visualEffectView.contentView addSubview:_fansButton];
    
    
    //关注的内容
    _specialColumnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _specialColumnButton.frame = CGRectMake(kDeviceWidth- kDeviceWidth /3, 174, kDeviceWidth / 3 , 55);
    _specialColumnButton.backgroundColor = [UIColor blackColor];
    _specialColumnButton.alpha = 0.5;
    [_specialColumnButton setTitle:@"关注的内容" forState:UIControlStateNormal];
    if (iPhone5) {
    _specialColumnButton.titleEdgeInsets = UIEdgeInsetsMake(40, _specialColumnButton.titleLabel.bounds.size.width -20, 10, 0);

    }else {
    _specialColumnButton.titleEdgeInsets = UIEdgeInsetsMake(40, _specialColumnButton.titleLabel.bounds.size.width -36, 10, 0);
    }
    _specialColumnButton.tintColor = [UIColor whiteColor];
    _specialColumnButton.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
    [_specialColumnButton setImage:[UIImage imageNamed:@"icon_attention_content_nor"] forState:UIControlStateNormal];
    _specialColumnButton.imageEdgeInsets = UIEdgeInsetsMake(10,43,25,25);
    _specialColumnButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_specialColumnButton addTarget:self action:@selector(specialColumnButton:) forControlEvents:UIControlEventTouchUpInside];
    // 专栏个数
    if (iPhone5) {
        _specialColumnLabel = [[UILabel alloc]initWithFrame:CGRectMake( kDeviceWidth * 0.93, 203, 50, 30)];

    }
    else {
    _specialColumnLabel = [[UILabel alloc]initWithFrame:CGRectMake( kDeviceWidth * 0.9, 203, 50, 30)];
    }
    _specialColumnLabel.textColor = [UIColor redColor];
    _specialColumnLabel.font = [UIFont systemFontOfSize:14];
    [_visualEffectView addSubview:_specialColumnLabel];
    [_visualEffectView.contentView addSubview:_specialColumnButton];

    [self configSubViews];

}


- (void)setUpInforButton:(id)sender {
    
    if (self.myclickBlock) {
        self.myclickBlock(8);
    }

}

- (void)specialColumnButton:(id)sender {
    
    if (self.myclickBlock) {
        self.myclickBlock(5);
    }

}


- (void)attentionButton:(id)sender {
    
    UserRootViewController *controller ;
    
    id next =[self nextResponder];
    while (![next isKindOfClass:[UserRootViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[UserRootViewController class]]) {
        controller = (UserRootViewController *)next;
        
//        QuestionModelIntroduceModel *questionModel =(QuestionModelIntroduceModel *)_dataArray[indexPath.row];
        
//        NSLog(@"--------------------------%@",questionModel.questionId);
        
        PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
        peopleVC.requestUrl = LKB_Attention_Users_Url;
        peopleVC.VCType = @"1";
        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
        peopleVC.hidesBottomBarWhenPushed = YES;
        peopleVC.title = @"我的关注";
        [controller.navigationController pushViewController:peopleVC animated:YES];
        
        
        
        
        
        
    }


}


- (void)fansButton:(id)sender {
    
    if (self.myclickBlock) {
        self.myclickBlock(7);
    }

}


- (void)configSubViews {

    [self addSubview:self.mySpecialColumnBut];
    [self addSubview:self.myGroupBut];
    [self addSubview:self.myTopicBut];
    [self addSubview:self.myQuestionBut];
    [self addSubview:self.myCollectionBut];
    
    // 我的专栏
    [_mySpecialColumnBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.visualEffectView.bottom).offset(10);
        make.left.mas_equalTo(self).offset(-10);
        make.right.mas_equalTo(_myGroupBut.mas_left).offset(0);
        //        make.size.mas_equalTo(CGSizeMake(65, 85));
        make.width.mas_equalTo(kDeviceWidth  /5);
        make.height.mas_equalTo(100);
        
        
    }];
    // 我的群组
    [_myGroupBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.visualEffectView.bottom).offset(10);
        //        make.left.mas_equalTo(_mySpecialColumnBut.right).offset(10);
        make.right.mas_equalTo(_myTopicBut.mas_left).offset(0);
        //        make.size.mas_equalTo(CGSizeMake(65, 85));
        make.width.mas_equalTo(kDeviceWidth/5);
        make.height.mas_equalTo(100);
        
        
    }];
    
    // 我的话题
    [_myTopicBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.visualEffectView.bottom).offset(10);
        //        make.left.mas_equalTo(_myGroupBut.mas_right).offset(10);
        make.right.mas_equalTo(_myQuestionBut.mas_left).offset(0);
        //        make.size.mas_equalTo(CGSizeMake(65, 85));
        make.width.mas_equalTo(kDeviceWidth  /5);
        make.height.mas_equalTo(100);
        
        
    }];
    // 我的答疑
    [_myQuestionBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.visualEffectView.bottom).offset(10);
//        make.left.mas_equalTo(_myCollectionBut.mas_left).offset(0);
        make.right.mas_equalTo(_myCollectionBut.mas_left).offset(0);
        //        make.size.mas_equalTo(CGSizeMake(65, 85));
        make.width.mas_equalTo(kDeviceWidth/5);
        make.height.mas_equalTo(100);
        
    }];
        // 我的收藏
        [_myCollectionBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.visualEffectView.bottom).offset(10);
            make.right.mas_equalTo(self).offset(-0);
            make.left.mas_equalTo(_myQuestionBut.mas_right).offset(0);
//            make.size.mas_equalTo(CGSizeMake(60, 80));
            make.width.mas_equalTo(kDeviceWidth/5);
            make.height.mas_equalTo(100);

        }];
    

    
}

// 我的专栏
- (UIButton *)mySpecialColumnBut {
    
    _mySpecialColumnBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _mySpecialColumnBut.backgroundColor = [UIColor whiteColor];
    [_mySpecialColumnBut setImage:[UIImage imageNamed:@"myColumn"] forState:UIControlStateNormal];
    _mySpecialColumnBut.imageEdgeInsets = UIEdgeInsetsMake(5,15,30,_mySpecialColumnBut.titleLabel.bounds.size.width);
    [_mySpecialColumnBut addTarget:self action:@selector(pushtoMyColumn:) forControlEvents:UIControlEventTouchUpInside];
    _mySpecialColumnBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_mySpecialColumnBut];
    
    
    return _mySpecialColumnBut;
}
- (void)handlerButtonAction:(MyChoseToClickBlock)block
{
    self.myclickBlock = block;
}

#pragma mark - Event response
- (void)pushtoMyColumn:(id)sender
{

    if (self.myclickBlock) {
        self.myclickBlock(1);
    }
    
}



// 我的群组
- (UIButton *)myGroupBut {
    
    _myGroupBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _myGroupBut.backgroundColor = [UIColor whiteColor];

    [_myGroupBut setImage:[UIImage imageNamed:@"myGroup"] forState:UIControlStateNormal];
    _myGroupBut.imageEdgeInsets = UIEdgeInsetsMake(5,13,30,_myGroupBut.titleLabel.bounds.size.width);
    [_myGroupBut addTarget:self action:@selector(pushtoMyGroup:) forControlEvents:UIControlEventTouchUpInside];
    _myGroupBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_myGroupBut];
    return _myGroupBut;
}

#pragma mark - Event response
- (void)pushtoMyGroup:(id)sender
{
    
    if (self.myclickBlock) {
        self.myclickBlock(2);
    }
    
}

//我的话题
- (UIButton *)myTopicBut {
    
    _myTopicBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _myTopicBut.backgroundColor = [UIColor whiteColor];
    [_myTopicBut setImage:[UIImage imageNamed:@"myTopic"] forState:UIControlStateNormal];
    _myTopicBut.imageEdgeInsets = UIEdgeInsetsMake(5,13,30,_myTopicBut.titleLabel.bounds.size.width);
    [_myTopicBut addTarget:self action:@selector(pushtoMyTopic:) forControlEvents:UIControlEventTouchUpInside];
    _myTopicBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_myTopicBut];
    return _myTopicBut;
}

#pragma mark - Event response
- (void)pushtoMyTopic:(id)sender
{
    
    if (self.myclickBlock) {
        self.myclickBlock(3);
    }
    
}

// 我的答疑
- (UIButton *)myQuestionBut {
    
    _myQuestionBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _myQuestionBut.backgroundColor = [UIColor whiteColor];
    [_myQuestionBut setImage:[UIImage imageNamed:@"myQuestion"] forState:UIControlStateNormal];
    _myQuestionBut.imageEdgeInsets = UIEdgeInsetsMake(5,13,30,_myQuestionBut.titleLabel.bounds.size.width);
    [_myQuestionBut addTarget:self action:@selector(pushtoMyQuestion:) forControlEvents:UIControlEventTouchUpInside];
    _myQuestionBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_myQuestionBut];
    return _myQuestionBut;
}

#pragma mark - Event response
- (void)pushtoMyQuestion:(id)sender
{
    
    if (self.myclickBlock) {
        self.myclickBlock(4);
    }
    
}


// 我的收藏
- (UIButton *)myCollectionBut {
    
    _myCollectionBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _myCollectionBut.backgroundColor = [UIColor whiteColor];
    [_myCollectionBut setImage:[UIImage imageNamed:@"myCollection"] forState:UIControlStateNormal];
    _myCollectionBut.imageEdgeInsets = UIEdgeInsetsMake(5,13,30,_myCollectionBut.titleLabel.bounds.size.width);
    [_myCollectionBut addTarget:self action:@selector(pushtoMyCollection:) forControlEvents:UIControlEventTouchUpInside];
    _myCollectionBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_myCollectionBut];
    return _myCollectionBut;
}

- (void)pushtoMyCollection:(id)sender
{
    
    if (self.myclickBlock) {
        self.myclickBlock(9);
    }
    
}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
