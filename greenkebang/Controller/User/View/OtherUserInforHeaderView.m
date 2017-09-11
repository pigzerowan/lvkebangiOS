//
//  OtherUserInforHeaderView.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/28.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "OtherUserInforHeaderView.h"
#import <UIImageView+WebCache.h>
#import "LKBPrefixHeader.pch"
#import "FileHelpers.h"
#import "UserRootViewController.h"
#import "PeopleViewController.h"
@implementation OtherUserInforHeaderView

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

- (void)configSearchPeopleRecommCellWithModel:(UserInforModel*)model{
    
    //    [self.myIcon sd_setImageWithURL:[model.image lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    //    _textLabel.text = model.contactName;
    [self.headImageView sd_setImageWithURL:[[model.data valueForKey:@"avatar"] lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
    [self.blurImageView sd_setImageWithURL:[[model.data valueForKey:@"avatar"] lkbImageUrl4] placeholderImage:YQNormalPlaceImage];

    NSLog(@"~~~~>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>~~~~%@",[model.data valueForKey:@"userName"]);
    // 用户名
    self.nameLabel.text = [NSString stringWithFormat:@"%@",[model.data valueForKey:@"userName"]];
    
    // 关注
    _attentionLabel.text =[NSString stringWithFormat:@"%@",[model.data valueForKey:@"attentionNum"]];
    if ([model.data valueForKey:@"remark"] == nil) {
        _signatureLabel.text = @"此人很懒，什么也没有留下~";
        _signatureLabel.textColor = [UIColor grayColor];
    }else{
        _signatureLabel.text = [NSString stringWithFormat:@"%@",[model.data valueForKey:@"remark"]];
    }
//    //    // 专栏
//    _specialColumnLabel.text =[NSString stringWithFormat:@"%@ ",[model.data valueForKey:@"insightNum"]];
    //    // 粉丝
    _fansLabel.text = [NSString stringWithFormat:@"%@ ",[model.data valueForKey:@"fansNum"]];
}


- (void)headerView {
    
    _blurImageView = [[UIImageView alloc]init];
    _blurImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 229);
//    [_blurImageView setImage:_headImageView.image];
    _blurImageView.userInteractionEnabled = YES;
    
    [self addSubview:_blurImageView];
    
    _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    _visualEffectView.frame = _blurImageView.frame;
    _visualEffectView.alpha = 1.0;
    [_blurImageView addSubview:_visualEffectView];
    
//    // 设置头像
//    _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _headButton.layer.cornerRadius = 40.f;
//    _headButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    _headButton.layer.borderWidth = 1.0f;
//    _headButton.layer.masksToBounds = YES;
//    _headButton.frame = CGRectMake(SCREEN_WIDTH / 2 - 40 , 14, 80, 80);
//    if (_headImg == nil) {
//        _headButton.backgroundColor = [UIColor lightGrayColor];
//    }
//    //    [_headButton addTarget:self action:@selector(headerImage:) forControlEvents:UIControlEventTouchUpInside];
//    _headImg = [UIImage imageWithContentsOfFile:pathForURL(_photoUrl)];
//    [_headButton setImage:_headImg forState:UIControlStateNormal];
//    [_visualEffectView.contentView addSubview:_headButton];
    _headImageView = [[UIImageView alloc]init];
    _headImageView.layer.cornerRadius = 40.f;
    _headImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _headImageView.layer.borderWidth = 1.0f;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.frame = CGRectMake(SCREEN_WIDTH / 2 - 40 , 14, 80, 80);
//    if (_headImageView.image == nil) {
//        _headImageView.backgroundColor = [UIColor lightGrayColor];
//    }
    //    [_headButton addTarget:self action:@selector(headerImage:) forControlEvents:UIControlEventTouchUpInside];
    //    _headImg = [UIImage imageWithContentsOfFile:pathForURL(_photoUrl)];
    //    [_headImageView setImage:_headImg forState:UIControlStateNormal];
    //    [_headImageView.image]
//    _headImageView.image = [UIImage imageWithContentsOfFile:pathForURL(_photoUrl)];
    [_visualEffectView.contentView addSubview:_headImageView];

    
    // 姓名
    _nameLabel = [[UILabel alloc]init];
//    _nameLabel.frame = CGRectMake(SCREEN_WIDTH / 2 - 40, 110, 60, 30);
    _nameLabel.frame = CGRectMake(0, 110, SCREEN_WIDTH, 30);
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [_visualEffectView.contentView addSubview:_nameLabel];
    
    // 关注
    _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _attentionButton.frame = CGRectMake(SCREEN_WIDTH / 2 + 50, 110, 60, 30);
//    [_attentionButton setTitle:@"关注" forState:UIControlStateNormal];
//    [_attentionButton setImage:[UIImage imageNamed:@"attention"] forState:UIControlStateNormal];
    _attentionButton.titleLabel.textColor = [UIColor blackColor];
//    _attentionButton.backgroundColor = [UIColor LkbBtnColor];
    _attentionButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_attentionButton addTarget:self action:@selector(attentionOtherButton:) forControlEvents:UIControlEventTouchUpInside];
    _attentionButton.layer.masksToBounds = YES;
    _attentionButton.layer.cornerRadius = 5;
    [_visualEffectView.contentView addSubview:_attentionButton];
    
    // 个性签名
    _signatureLabel = [[UILabel alloc]init];
    _signatureLabel.frame = CGRectMake(0, 145, SCREEN_WIDTH, 20);
//    _signatureLabel.text = @"1233455678932223555666";
    _signatureLabel.font = [UIFont systemFontOfSize:14];
    _signatureLabel.textAlignment = NSTextAlignmentCenter;
    [_visualEffectView.contentView addSubview:_signatureLabel];
    
    // 关注
    _myAttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _myAttentionButton.frame = CGRectMake(0 , 174, kDeviceWidth / 3, 55);
    _myAttentionButton.backgroundColor = [UIColor blackColor ];
    _myAttentionButton.alpha = 0.5;
    [_myAttentionButton setTitle:@"Ta关注的人" forState:UIControlStateNormal];
    _myAttentionButton.titleEdgeInsets = UIEdgeInsetsMake(40, _myAttentionButton.titleLabel.bounds.size.width -30 , 10, 0);
    _myAttentionButton.tintColor = [UIColor whiteColor];
    _myAttentionButton.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
    //
    [_myAttentionButton setImage:[UIImage imageNamed:@"icon_attention_people_nor"] forState:UIControlStateNormal];
    _myAttentionButton.imageEdgeInsets = UIEdgeInsetsMake(10,43,25,25);
    _myAttentionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_myAttentionButton addTarget:self action:@selector(attentionButton:) forControlEvents:UIControlEventTouchUpInside];
    // 关注个数
    
    _attentionLabel = [[UILabel alloc]initWithFrame:CGRectMake( kDeviceWidth * 0.24, 203, 50, 30)];
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
    [_fansButton setTitle:@"关注Ta的人 " forState:UIControlStateNormal];
    _fansButton.titleEdgeInsets = UIEdgeInsetsMake(40, _fansButton.titleLabel.bounds.size.width-10, 10, 0);
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
    //    _specialColumnButton.titleEdgeInsets = UIEdgeInsetsMake(20, _specialColumnButton.titleLabel.bounds.size.width -50, 0, 0);
    _specialColumnButton.titleEdgeInsets = UIEdgeInsetsMake(40, _specialColumnButton.titleLabel.bounds.size.width -30, 10, 0);
    _specialColumnButton.tintColor = [UIColor whiteColor];
    _specialColumnButton.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
    [_specialColumnButton setImage:[UIImage imageNamed:@"icon_attention_content_nor"] forState:UIControlStateNormal];
    _specialColumnButton.imageEdgeInsets = UIEdgeInsetsMake(10,43,25,25);
    _specialColumnButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_specialColumnButton addTarget:self action:@selector(specialColumnButton:) forControlEvents:UIControlEventTouchUpInside];
    // 专栏个数
    _specialColumnLabel = [[UILabel alloc]initWithFrame:CGRectMake( kDeviceWidth * 0.93, 203, 50, 30)];
    //    _specialColumnLabel.text = @"21";
    _specialColumnLabel.textColor = [UIColor redColor];
    _specialColumnLabel.font = [UIFont systemFontOfSize:14];
    [_visualEffectView addSubview:_specialColumnLabel];
    [_visualEffectView.contentView addSubview:_specialColumnButton];
    
    [self configSubViews];
    
}

- (void)specialColumnButton:(id)sender {
    
    if (self.otherclickBlock) {
        self.otherclickBlock(5);
    }
    
}


- (void)attentionButton:(id)sender {
    
//    if (self.otherclickBlock) {
//        self.otherclickBlock(6);
//    }
    
    UserRootViewController *controller ;
    
    id next =[self nextResponder];
    while (![next isKindOfClass:[UserRootViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[UserRootViewController class]]) {
        controller = (UserRootViewController *)next;
        
//        QuestionModelIntroduceModel *questionModel =(QuestionModelIntroduceModel *)_dataArray[indexPath.row];
        
//        NSLog(@"--------------------------%@",questionModel.questionId);
        
//        QADetailViewController *QADetailVC = [[QADetailViewController alloc] init];
//        QADetailVC.questionId = questionModel.questionId;
//        QADetailVC.hidesBottomBarWhenPushed = YES;
//        
//        [controller.navigationController pushViewController:QADetailVC animated:YES];
        
    }

    
}


- (void)fansButton:(id)sender {
    
    if (self.otherclickBlock) {
        self.otherclickBlock(7);
    }
    
}


- (void)configSubViews {
    
    [self addSubview:self.otherSpecialColumnBut];
    [self addSubview:self.otherGroupBut];
    [self addSubview:self.otherTopicBut];
    [self addSubview:self.otherQuestionBut];
    [self addSubview:self.otherCollectionBut];
    
    // 我的专栏
    [_otherSpecialColumnBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.visualEffectView.bottom).offset(10);
        make.left.mas_equalTo(self).offset(-10);
        make.right.mas_equalTo(_otherGroupBut.mas_left).offset(0);
        make.width.mas_equalTo(kDeviceWidth  /5);
        make.height.mas_equalTo(100);
        
        
    }];
    // 我的群组
    [_otherGroupBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.visualEffectView.bottom).offset(10);
        make.left.mas_equalTo(_otherSpecialColumnBut.right).offset(0);
        make.right.mas_equalTo(_otherTopicBut.mas_left).offset(0);
        make.width.mas_equalTo(kDeviceWidth  /5);
        make.height.mas_equalTo(100);
        
        
    }];
    
    // 我的话题
    [_otherTopicBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.visualEffectView.bottom).offset(10);
        make.left.mas_equalTo(_otherGroupBut.mas_right).offset(0);
        make.right.mas_equalTo(_otherQuestionBut.mas_left).offset(0);
        make.width.mas_equalTo(kDeviceWidth  /5);
        make.height.mas_equalTo(100);
    }];
    // 我的答疑
    [_otherQuestionBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.visualEffectView.bottom).offset(10);
//        make.left.mas_equalTo(_otherTopicBut.mas_right).offset(0);
        make.right.mas_equalTo(_otherCollectionBut.mas_left).offset(0);

        make.width.mas_equalTo(kDeviceWidth  /5);
        make.height.mas_equalTo(100);
        
    }];
    // 我的收藏
    [_otherCollectionBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.visualEffectView.bottom).offset(10);
        make.right.mas_equalTo(self).offset(0);
        make.left.mas_equalTo(_otherQuestionBut.mas_right).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH /5);
        make.height.mas_equalTo(100);

    }];
    
    
}


-(void)attentionOtherButton:(id)sender
{
    
    if (self.otherclickBlock) {
        self.otherclickBlock(8);
    }

}


// 我的专栏
- (UIButton *)otherSpecialColumnBut {
    
    _otherSpecialColumnBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _otherSpecialColumnBut.backgroundColor = [UIColor whiteColor];
//    [_otherSpecialColumnBut setTitle:@"Ta的专栏 " forState:UIControlStateNormal];
    [_otherSpecialColumnBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _otherSpecialColumnBut.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
    
    _otherSpecialColumnBut.titleEdgeInsets = UIEdgeInsetsMake(20, _otherSpecialColumnBut.titleLabel.bounds.size.width-90, _otherSpecialColumnBut.titleLabel.bounds.size.width-30,-30);
    [_otherSpecialColumnBut setImage:[UIImage imageNamed:@"HisColumn"] forState:UIControlStateNormal];
    _otherSpecialColumnBut.imageEdgeInsets = UIEdgeInsetsMake(5,13,30,_otherSpecialColumnBut.titleLabel.bounds.size.width);
    [_otherSpecialColumnBut addTarget:self action:@selector(pushtoMyColumn:) forControlEvents:UIControlEventTouchUpInside];
    _otherSpecialColumnBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_otherSpecialColumnBut];
    
    
    return _otherSpecialColumnBut;
}
- (void)handlerButtonAction:(OtherChoseToClickBlock)block
{
    self.otherclickBlock = block;
}

#pragma mark - Event response
- (void)pushtoMyColumn:(id)sender
{
    
    if (self.otherclickBlock) {
        self.otherclickBlock(1);
    }
    
}



// 我的群组
- (UIButton *)otherGroupBut {
    
    _otherGroupBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _otherGroupBut.backgroundColor = [UIColor whiteColor];
//    [_otherGroupBut setTitle:@"Ta的群组 " forState:UIControlStateNormal];
    _otherGroupBut.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
    _otherGroupBut.titleEdgeInsets = UIEdgeInsetsMake(20, _otherGroupBut.titleLabel.bounds.size.width-90, _otherGroupBut.titleLabel.bounds.size.width-30,-30);
    [_otherGroupBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_otherGroupBut setImage:[UIImage imageNamed:@"HisGroup"] forState:UIControlStateNormal];
    _otherGroupBut.imageEdgeInsets = UIEdgeInsetsMake(5,13,30,_otherGroupBut.titleLabel.bounds.size.width);
    [_otherGroupBut addTarget:self action:@selector(pushtoOtherGroup:) forControlEvents:UIControlEventTouchUpInside];
    _otherGroupBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_otherGroupBut];
    return _otherGroupBut;
}

#pragma mark - Event response
- (void)pushtoOtherGroup:(id)sender
{
    
    if (self.otherclickBlock) {
        self.otherclickBlock(2);
    }
    
}

//我的话题
- (UIButton *)otherTopicBut {
    
    _otherTopicBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _otherTopicBut.backgroundColor = [UIColor whiteColor];
//    [_otherTopicBut setTitle:@"Ta的话题 " forState:UIControlStateNormal];
    _otherTopicBut.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
    _otherTopicBut.titleEdgeInsets = UIEdgeInsetsMake(20, _otherTopicBut.titleLabel.bounds.size.width-90, _otherTopicBut.titleLabel.bounds.size.width-30,-30);
    [_otherTopicBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_otherTopicBut setImage:[UIImage imageNamed:@"HisTopic"] forState:UIControlStateNormal];
    _otherTopicBut.imageEdgeInsets = UIEdgeInsetsMake(5,13,30,_otherTopicBut.titleLabel.bounds.size.width);
    [_otherTopicBut addTarget:self action:@selector(pushtoOtherTopic:) forControlEvents:UIControlEventTouchUpInside];
    
    _otherTopicBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_otherTopicBut];
    return _otherTopicBut;
}

#pragma mark - Event response
- (void)pushtoOtherTopic:(id)sender
{
    
    if (self.otherclickBlock) {
        self.otherclickBlock(3);
    }
    
    
}

// 我的答疑
- (UIButton *)otherQuestionBut {
    
    _otherQuestionBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _otherQuestionBut.backgroundColor = [UIColor whiteColor];
//    [_otherQuestionBut setTitle:@"Ta的答疑" forState:UIControlStateNormal];
    _otherQuestionBut.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji"size:12];
    _otherQuestionBut.titleEdgeInsets = UIEdgeInsetsMake(20, _otherQuestionBut.titleLabel.bounds.size.width-110, _otherQuestionBut.titleLabel.bounds.size.width-30,-30);
    [_otherQuestionBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_otherQuestionBut setImage:[UIImage imageNamed:@"HisQuestion"] forState:UIControlStateNormal];
    _otherQuestionBut.imageEdgeInsets = UIEdgeInsetsMake(5,13,30,_otherQuestionBut.titleLabel.bounds.size.width);
    [_otherQuestionBut addTarget:self action:@selector(pushtoOtherQuestion:) forControlEvents:UIControlEventTouchUpInside];
    _otherQuestionBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_otherQuestionBut];
    return _otherQuestionBut;
}

#pragma mark - Event response
- (void)pushtoOtherQuestion:(id)sender
{
    
    if (self.otherclickBlock) {
        self.otherclickBlock(4);
    }
    
}


// 我的收藏
- (UIButton *)otherCollectionBut {
    
    _otherCollectionBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _otherCollectionBut.backgroundColor = [UIColor whiteColor];
    [_otherCollectionBut setImage:[UIImage imageNamed:@"HisCollection"] forState:UIControlStateNormal];
    _otherCollectionBut.imageEdgeInsets = UIEdgeInsetsMake(5,13,30,_otherCollectionBut.titleLabel.bounds.size.width);
    [_otherCollectionBut addTarget:self action:@selector(pushtoOtherCollection:) forControlEvents:UIControlEventTouchUpInside];
    _otherCollectionBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;    [self addSubview:_otherCollectionBut];
    return _otherCollectionBut;
}
- (void)pushtoOtherCollection:(id)sender
{
    
    if (self.otherclickBlock) {
        self.otherclickBlock(9);
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
