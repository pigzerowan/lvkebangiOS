//
//  HeaderView.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/19.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "HeaderView.h"
#import "FileHelpers.h"
#import "UserRootViewController.h"
#import "UserInforSettingViewController.h"
#import "MyUserInfoManager.h"
#import "PeopleViewController.h"
#import "MyAttentionBaseViewController.h"
#import "OtherUserInforSettingViewController.h"
#import "NewUserMainPageViewController.h"
@implementation HeaderView
- (instancetype)init
{
    self = [super init];
    if (!self)
        return nil;
    [self UserHeaderView];
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
        return nil;
    [self UserHeaderView];
    
    return self;
}


- (void)configMyInforRecommCellWithModel:(UserInforModel*)model{
    
    _headerImage = [[UIImage alloc]init];
    _headerImage = [UIImage imageWithContentsOfFile:pathForURL([[model.data valueForKey:@"avatar"] lkbImageUrl4])];
    
    // 关注
    _hadAttentionLabel.text =[NSString stringWithFormat:@"%@",[model.data valueForKey:@"attentionNum"]];
    // 粉丝
    _beAttentionedLabel.text = [NSString stringWithFormat:@"%@ ",[model.data valueForKey:@"fansNum"]];
    _attentionContentLabel.text = [NSString stringWithFormat:@"%@ ",[model.data valueForKey:@"attContentNum"]];

    _userId = [model.data valueForKey:@"userId"];
    
    _describeLabel.text =[model.data valueForKey:@"remark"];
    _remark = [model.data valueForKey:@"remark"];
    CGRect rect2 = [_describeLabel.text boundingRectWithSize:CGSizeMake(kDeviceWidth -20, KDeviceHeight ) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : _describeLabel.font} context:nil];

    NSLog(@"######----------------%f",rect2.size.height);
    
    if (self.isExpandedNow) {
        [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_headerImageButton.mas_bottom).offset(10);
            make.height.mas_equalTo(rect2.size.height+ 20 );
            
        }];
        
        self.describeLabel.backgroundColor = [UIColor whiteColor];
        _OpenButton.hidden =NO;
        _OpenButton.frame = CGRectMake(10, rect2.size.height +80 , kDeviceWidth -20 , 24);
        _OpenButton.backgroundColor= [UIColor whiteColor];
        
        [_OpenButton setImage:[UIImage imageNamed:@"my_icon_arrow_up"] forState:UIControlStateNormal];

    }
    else{
        
        if (rect2.size.height <130) {
            
            [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(_headerImageButton.mas_bottom).offset(5);
                make.height.mas_equalTo(rect2.size.height +20);
                
            }];
            
        }
        else {
            [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(_headerImageButton.mas_bottom).offset(10);
                make.height.mas_equalTo( 130);
                
            }];
            
            _OpenButton.hidden = NO;
            _OpenButton.frame = CGRectMake(10,130 +90+10 , kDeviceWidth -20 , 24);
            _OpenButton.backgroundColor= [UIColor whiteColor];
            
            [_OpenButton setImage:[UIImage imageNamed:@"my_icon_arrow_down"] forState:UIControlStateNormal];
        }

    }
    
}


- (void)UserHeaderView {
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    self.describeLabel = [[UILabel alloc]init];
    
    
    [self addSubview:self.describeLabel];
    
    self.describeLabel.numberOfLines = 0;
    self.describeLabel.backgroundColor = [UIColor whiteColor];
    self.describeLabel.preferredMaxLayoutWidth = w -30;
    self.describeLabel.userInteractionEnabled = YES;
    
    _Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
    [self.describeLabel addGestureRecognizer:_Tap];
    
    
    
    [self addSubview:self.headerImageButton];
    [self addSubview:self.hadAttentionLabel];
    [self addSubview:self.hadAttentionButton];
    [self addSubview:self.beAttentionedLabel];
    [self addSubview:self.beAttentionedButton];
    [self addSubview:self.attentionContentLabel];
    [self addSubview:self.attentionContentButton];
    [self addSubview:self.describeLabel];
    [self addSubview:self.OpenButton];
    
    [_headerImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(28);
        make.left.mas_equalTo(self).offset(24);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
    }];
    
    [_hadAttentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(35);
        if (iPhone5) {
            make.left.mas_equalTo(self.headerImageButton.right).offset(30);

        }
        else {
            make.left.mas_equalTo(self.headerImageButton.right).offset(40);

        }
        make.size.mas_equalTo(CGSizeMake(35, 16));
    }];
    
    [_hadAttentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(30);
        if (iPhone5) {
            make.left.mas_equalTo(self.headerImageButton.right).offset(10);

        }
        else {
            make.left.mas_equalTo(self.headerImageButton.right).offset(20);

        }
        make.size.mas_equalTo(CGSizeMake(70,70));
    }];
    
    [_beAttentionedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(35);
        if (iPhone5) {
            make.left.mas_equalTo(self.hadAttentionLabel.right).offset(40);

        }
        else {
            make.left.mas_equalTo(self.hadAttentionLabel.right).offset(50);

        }
        make.size.mas_equalTo(CGSizeMake(35, 16));
        
    }];
    
    [_beAttentionedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(30);
        if (iPhone5) {
            make.left.mas_equalTo(_hadAttentionButton.right).offset(10);

        }
        else {
            make.left.mas_equalTo(_hadAttentionButton.right).offset(20);

        }
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    [_attentionContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(35);
        if (iPhone5) {
            make.left.mas_equalTo(_beAttentionedLabel.right).offset(50);

        }
        else {
            make.left.mas_equalTo(_beAttentionedLabel.right).offset(60);

        }
        make.size.mas_equalTo(CGSizeMake(35, 16));
        
    }];
    
    [_attentionContentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(30);
        if (iPhone5) {
            make.left.mas_equalTo(_beAttentionedButton.right).offset(10);

        }
        else {
            make.left.mas_equalTo(_beAttentionedButton.right).offset(20);

        }
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    
}



- (UIButton *)headerImageButton {
    
    if (!_headerImageButton) {
        
        _headerImageButton = [[UIButton alloc]init];
        _headerImageButton.backgroundColor = [UIColor lightGrayColor];
        [self.headerImageButton setImage:[UIImage imageNamed:@"defualt_normal.png" ]forState:UIControlStateNormal];
        [_headerImageButton addTarget:self action:@selector(userInfo:) forControlEvents:UIControlEventTouchUpInside];
        _headerImageButton.layer.masksToBounds = YES;
        _headerImageButton.layer.cornerRadius = 25;
        
    }
    return _headerImageButton;
}


//异步加载图片
- (UIImage *)LoadImage:(NSDictionary*)aDic{
    
    NSLog(@"--------------------------%@",aDic);
    NSLog(@"--------------------------%@",[aDic objectForKey:@"avatar"]);
    
    
    NSURL *aURL=[aDic objectForKey:@"avatar"];
    NSLog(@"--------------------------%@",aURL);
    
    NSData *data=[NSData dataWithContentsOfURL:aURL];
    if (data == nil) {
        return nil;
    }
    UIImage *image=[UIImage imageWithData:data];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager createFileAtPath:pathForURL(aURL) contents:data attributes:nil];
    return image;
}


- (UILabel *)hadAttentionLabel {
    
    if (!_hadAttentionLabel) {
        _hadAttentionLabel = [[UILabel alloc]init];
        _hadAttentionLabel.backgroundColor = [UIColor whiteColor];
        _hadAttentionLabel.textColor = CCCUIColorFromHex(0x333333);
        _hadAttentionLabel.textAlignment=NSTextAlignmentCenter;
        _hadAttentionLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _hadAttentionLabel;
}

- (UIButton *)hadAttentionButton {
    
    if (!_hadAttentionButton) {
        _hadAttentionButton = [[UIButton alloc]init];
        [_hadAttentionButton setTitle:@"我关注的人" forState:UIControlStateNormal];
        _hadAttentionButton.titleLabel.font = [UIFont systemFontOfSize:11];
        _hadAttentionButton.backgroundColor = [UIColor clearColor];
        [_hadAttentionButton setTitleColor:CCCUIColorFromHex(0x888888) forState:UIControlStateNormal];
        [_hadAttentionButton addTarget:self action:@selector(attentionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hadAttentionButton;
    
}

- (UILabel *)beAttentionedLabel {
    
    if (!_beAttentionedLabel) {
        _beAttentionedLabel = [[UILabel alloc]init];
        _beAttentionedLabel.font = [UIFont systemFontOfSize:16];
        _beAttentionedLabel.textAlignment = NSTextAlignmentCenter;
        _beAttentionedLabel.backgroundColor = [UIColor whiteColor];
        _beAttentionedLabel.textColor = CCCUIColorFromHex(0x333333);
    }
    return _beAttentionedLabel;
}

- (UIButton *)beAttentionedButton {
    
    if (!_beAttentionedButton) {
        _beAttentionedButton = [[UIButton alloc]init];
        [_beAttentionedButton setTitle:@"关注我的人" forState:UIControlStateNormal];
        _beAttentionedButton.titleLabel.font = [UIFont systemFontOfSize:11];
        _beAttentionedButton.backgroundColor = [UIColor clearColor];
        [_beAttentionedButton setTitleColor:CCCUIColorFromHex(0x888888) forState:UIControlStateNormal];
        [_beAttentionedButton addTarget:self action:@selector(fansButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _beAttentionedButton;
}


- (UILabel *)attentionContentLabel {
    
    if (!_attentionContentLabel) {
        _attentionContentLabel = [[UILabel alloc]init];
        _attentionContentLabel.font = [UIFont systemFontOfSize:16];
        _attentionContentLabel.textAlignment = NSTextAlignmentCenter;
        _attentionContentLabel.backgroundColor = [UIColor whiteColor];
        _attentionContentLabel.textColor = CCCUIColorFromHex(0x333333);
    }
    
    return _attentionContentLabel;
}

- (UIButton *)attentionContentButton {
    
    if (!_attentionContentButton) {
        _attentionContentButton = [[UIButton alloc]init];
        [_attentionContentButton setTitle:@"关注的内容" forState:UIControlStateNormal];
        _attentionContentButton.titleLabel.font = [UIFont systemFontOfSize:11];
        _attentionContentButton.backgroundColor = [UIColor clearColor];
        [_attentionContentButton setTitleColor:CCCUIColorFromHex(0x888888) forState:UIControlStateNormal];
        [_attentionContentButton addTarget:self action:@selector(specialColumnButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _attentionContentButton;
}

- (UILabel *)describeLabel {
    
    if (!_describeLabel) {
        
        _describeLabel = [[UILabel alloc]init];
        _describeLabel.numberOfLines = 0;
        _describeLabel.font = [UIFont systemFontOfSize:14];
        _describeLabel.textColor = CCCUIColorFromHex(0x333333);
        _describeLabel.backgroundColor = [UIColor blackColor];
    }
    return _describeLabel;
}

- (UIButton *)OpenButton {
    if (!_OpenButton) {
        
        _OpenButton = [[UIButton alloc]init];
        [_OpenButton addTarget:self action:@selector(OpenButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _OpenButton;
}

- (void)onTap {

    if (self.expandBlock) {
        self.expandBlock(!self.isExpandedNow);
    }
    
}


- (void)userInfo:(id)sender {
    
    UserRootViewController *controller ;
    
    id next =[self nextResponder];
    while (![next isKindOfClass:[UserRootViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[UserRootViewController class]]) {
        controller = (UserRootViewController *)next;
        
        if ([_type isEqualToString:@"2"]) {
            
            if ([_userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                UserInforSettingViewController* userInforVC = [[UserInforSettingViewController alloc]init];
                userInforVC.hidesBottomBarWhenPushed = YES;
                userInforVC.headerImg = [MyUserInfoManager shareInstance].avatar;
                userInforVC.attentionNum = @"1";
                [controller.navigationController pushViewController:userInforVC animated:YES];

            }
            else {
            OtherUserInforSettingViewController *otherVC =[[OtherUserInforSettingViewController alloc]init];
            otherVC.userId = _userId;
            [controller.navigationController pushViewController:otherVC animated:YES];
            }
            
        }
        else {
            UserInforSettingViewController* userInforVC = [[UserInforSettingViewController alloc]init];
            userInforVC.hidesBottomBarWhenPushed = YES;
            userInforVC.headerImg = [MyUserInfoManager shareInstance].avatar;
            userInforVC.attentionNum = @"1";
            [controller.navigationController pushViewController:userInforVC animated:YES];

        }
        
    }
    

    
}


- (void)fansButton:(id)sender {
    
    UserRootViewController *controller ;
    
    id next =[self nextResponder];
    while (![next isKindOfClass:[UserRootViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[UserRootViewController class]]) {
        controller = (UserRootViewController *)next;
        
        PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
        peopleVC.requestUrl = LKB_Attention_All_Fans_Url;
        peopleVC.VCType = @"1";


        if ([_type isEqualToString:@"2"]) {
            peopleVC.title = @"关注ta的人";
            peopleVC.userId = _userId;

        }
        else {
            peopleVC.title = @"我的粉丝";
            peopleVC.userId = [MyUserInfoManager shareInstance].userId;
            peopleVC.hidesBottomBarWhenPushed = YES;

        }
        
        [controller.navigationController pushViewController:peopleVC animated:YES];
        
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
        
        PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
        peopleVC.requestUrl = LKB_Attention_Users_Url;
        peopleVC.VCType = @"1";

        peopleVC.hidesBottomBarWhenPushed = YES;
        if ([_type isEqualToString:@"2"]) {
            peopleVC.title = @"ta关注的人";
            peopleVC.userId = _userId;

        }
        else {
            peopleVC.title = @"我的关注";
            peopleVC.userId = [MyUserInfoManager shareInstance].userId;

        }
        
        
        [controller.navigationController pushViewController:peopleVC animated:YES];
        
    }

    

}


- (void)specialColumnButton:(id)sender {
    
    UserRootViewController *controller ;
    
    id next =[self nextResponder];
    while (![next isKindOfClass:[UserRootViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[UserRootViewController class]]) {
        controller = (UserRootViewController *)next;
        
        // 我关注的内容
        MyAttentionBaseViewController *peopleVC = [[MyAttentionBaseViewController alloc] init];
        
        
        
        
        
        if ([_type isEqualToString:@"2"]) {
            peopleVC.userId = _userId;
        }
        else {
        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
        }
        peopleVC.hidesBottomBarWhenPushed = YES;
        
        [controller.navigationController pushViewController:peopleVC animated:YES];
        
    }
    

}

- (void)OpenButton:(id)sender {
    
    if (self.expandBlock) {
        self.expandBlock(!self.isExpandedNow);
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
