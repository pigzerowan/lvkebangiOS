//
//  CircleInforViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/10/17.
//  Copyright © 2016年 transfar. All rights reserved.
//

#define Start_X 14.0f           // 第一个按钮的X坐标
#define Start_Y 43.0f           // 第一个按钮的Y坐标
#define Width_Space 10.0f        // 2个按钮之间的横间距
#define Height_Space 10.0f      // 竖间距

#define Button_Height 30.0f    // 高
#define Button_Width 30.0f      // 宽


#import "CircleInforViewController.h"
#import <UIImageView+WebCache.h>
#import "MyUserInfoManager.h"
#import "SVPullToRefresh.h"
#import "CirclePeopleViewController.h"
#import "NewShareActionView.h"
#import "TYAlertController.h"
#include "UMSocial.h"
#import "PeopleViewController.h"
#import "CircleInfoModel.h"
#import "CircleIfJoinManager.h"
#import "ZFActionSheet.h"
#import "TYAlertController+BlurEffects.h"

static NSString* CircleInforCellIdentifier = @"CircleInforCellIdentifier";

@interface CircleInforViewController ()<UITableViewDelegate,UITableViewDataSource,NewShareActionViewDelegete,ZFActionSheetDelegate>
{
    
    CGRect  rect2;
    NSString *jsonStr;
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;


}

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableDictionary* dataArray;
@property(nonatomic,strong)TYAlertController *alertController;
@property (strong, nonatomic)ZFActionSheet *actionSheet;

@end

@implementation CircleInforViewController
#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


#pragma mark - Page subviews
- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.dataArray = [[NSMutableDictionary alloc] init];
    self.title = @"圈资料";
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 30, 10, 20, 20)];
    [rightBtn setImage:[UIImage imageNamed:@"bottom_icon_share_nor"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    // 左键按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    

    [self initializePageSubviews];
    
    WithoutInternetImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Network-error"]];
    
    WithoutInternetImage.frame = CGRectMake((kDeviceWidth - 161.5)/2 , 155,161.5, 172);
    
    tryAgainButton = [[UIButton alloc]init];
    
    tryAgainButton.frame = CGRectMake((kDeviceWidth - 135)/2, 374, 135, 33);
    tryAgainButton.backgroundColor = CCCUIColorFromHex(0x01b654);
    tryAgainButton.layer.cornerRadius = 3.0f;
    [tryAgainButton setTitle:@"刷新" forState:UIControlStateNormal];
    [tryAgainButton setTitleColor:CCCUIColorFromHex(0xffffff) forState:UIControlStateNormal];
    tryAgainButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [tryAgainButton addTarget:self action:@selector(tryAgainButton:) forControlEvents:UIControlEventTouchUpInside];
    WithoutInternetImage.hidden = YES ;
    tryAgainButton.hidden = YES;
    
    [self.view addSubview:WithoutInternetImage];
    [self.view addSubview:tryAgainButton];

}

- (void)tryAgainButton:(id )sender {
    
    [self initializePageSubviews];
    
}


- (void)initializePageSubviews
{
    
    [self.view addSubview:self.tableView];

    self.requestParas = @{
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"groupId":_circleId,
                          @"token":[[MyUserInfoManager shareInstance]token],
                          };
    
    
    self.requestURL = LKB_Circle_Info_Url;
    
    


    
}





-(void)viewWillAppear:(BOOL)animated {
    
    
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    
    [MobClick beginLogPageView:@"CircleInforViewController"];

    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"CircleInforViewController"];
}



-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
    
//    [self.tableView removeFromSuperview];
}

-(void)shareButton:(id)sender
{
    [self shareView];
}
- (void)shareView {
    
    if (_nameStr==nil) {
        _nameStr= @"圈子详情";
    }
    if (_IntroduceStr==nil) {
        _IntroduceStr= @"点击查看详情";
    }
    if (_headerImageStr==nil) {
        _headerImageStr= @" ";
    }
    
    
    _urlStr = [NSString stringWithFormat:@"http://www.lvkebang.cn/quan/%@", _circleId];
    _shareCover = [NSString stringWithFormat:@"http://imagetest.lvkebang.cn/static/group_header/%@",_headerImageStr];
    
    
    NSDictionary *shaDic = @{@"cover":_shareCover,
                             @"userId":[[MyUserInfoManager shareInstance]userId],
                             @"description":_IntroduceStr,
                             @"title":_nameStr,
                             @"circleId":_circleId,
                             @"linkUrl":_urlStr,
                             @"shareType":@"1",
                             //                             @"featureId":_circleDetailId
                             @"fromLable":@"绿科邦新农圈",
                             };
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shaDic options:NSJSONWritingPrettyPrinted error:nil];
    
    jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NewShareActionView *newshare = [[NewShareActionView alloc]init];
    newshare.delegate = self;
    newshare.layer.cornerRadius = 10;
    
    _alertController = [TYAlertController alertControllerWithAlertView:newshare preferredStyle:TYAlertControllerStyleAlert];
    _alertController.backgoundTapDismissEnable = YES;
    
//    [_alertController setBlurEffectWithView:self.view];

    [self presentViewController:_alertController animated:YES completion:nil];
    
}


- (void)newShareActionView:(NewShareActionView *)UserHeaderView didatterntion:(NSInteger)index
{
    NSLog(@"点击了群组");
    
    if (index == 1) {
        [_alertController dismissViewControllerAnimated:YES];
        
        PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
        peopleVC.shareDes = jsonStr;
        peopleVC.requestUrl = LKB_Attention_Users_Url;
        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
        peopleVC.questionId = _circleId;
        peopleVC.VCType = @"1";
        peopleVC.shareType = @"1";
        peopleVC.hidesBottomBarWhenPushed = YES;
        peopleVC.title = @"我的好友";
        peopleVC.ifshare = @"3";
        [self.navigationController pushViewController:peopleVC animated:YES];
        
        
    }
    // 微信
    if (index == 2) {
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _nameStr;
        extConfig.wechatSessionData.url  = _urlStr;
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_IntroduceStr shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    // 微信朋友圈
    if (index==3) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _nameStr;
        extConfig.wechatTimelineData.url  = _urlStr;;
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_IntroduceStr shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // 新浪
    if (index==4) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _nameStr;
        //
        extConfig.sinaData.shareText =_IntroduceStr;
        
        //        extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_topicId];
        
        
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_IntroduceStr shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
    }
    // 空间
    if (index==5) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _nameStr;
        
        extConfig.tencentData.shareText = _IntroduceStr;
        extConfig.qzoneData.url  = _urlStr;
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_IntroduceStr shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // QQ
    if (index==6) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        
        extConfig.title = _nameStr;
        extConfig.qqData.shareText = _IntroduceStr;
        extConfig.qqData.url  = _urlStr;
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_IntroduceStr shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
    
    
}


#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CircleInforCellIdentifier];
        _tableView.backgroundColor =CCCUIColorFromHex(0xf7f7f7);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        return 2;
    }else if(section==1)
    {
        return 1;
    }
    else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
        return 10;

}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 92;
        }
        else {
            UILabel *inforLabel = [UILabel new];
            inforLabel.numberOfLines = 0;
            inforLabel.text = _IntroduceStr;
            inforLabel.textColor = CCCUIColorFromHex(0x999999);
            inforLabel.font = [UIFont systemFontOfSize:16];
            
            [inforLabel sizeToFit];
            
            rect2 = [inforLabel.text boundingRectWithSize:CGSizeMake(kDeviceWidth -28, KDeviceHeight ) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : inforLabel.font} context:nil];
            NSLog(@"=================================%f",rect2.size.height);
            
            
            return rect2.size.height + 50;
        }
    }else if(indexPath.section==1)
    {
        return 89;
    }
    else {
        return 50;
    }

}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CircleInforCellIdentifier];
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CircleInforCellIdentifier];
    }
    else{
        // 避免cell重叠
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
//    cell.textLabel.text = @"章鱼小丸子";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    if (indexPath.section==0) {
        
        if (indexPath.row == 0) {
            
            UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(14, 16, 60, 60)];
            headerImage.backgroundColor = CCCUIColorFromHex(0xddddd);
            headerImage.layer.masksToBounds = YES;
            headerImage.layer.cornerRadius = 30;
            
            [headerImage sd_setImageWithURL:[_headerImageStr lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
            
            
            [cell.contentView addSubview:headerImage];
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(94, 37, kDeviceWidth - 102, 20)];
            nameLabel.text = _nameStr;
            nameLabel.textColor = CCCUIColorFromHex(0x333333);
            nameLabel.font = [UIFont systemFontOfSize:20];
            [cell.contentView addSubview:nameLabel];

            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 92, SCREEN_WIDTH, 0.5)];
            lineView.backgroundColor =UIColorWithRGBA(237, 238, 239, 1);
            
            [cell.contentView addSubview:lineView];
            
        }
        if (indexPath.row == 1) {
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 14, 60, 20)];
            nameLabel.text = @"简介";
            nameLabel.textColor = CCCUIColorFromHex(0x333333);
            nameLabel.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:nameLabel];
            
            UILabel *inforLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 34, kDeviceWidth -28, rect2.size.height)];
            inforLabel.numberOfLines = 0;
            inforLabel.text = _IntroduceStr;
            inforLabel.lineBreakMode = 3.5;
            inforLabel.textColor = CCCUIColorFromHex(0x999999);
            inforLabel.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:inforLabel];


            
        }

        
    }else if(indexPath.section==1)
    {
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 14, 60, 20)];
        nameLabel.text = @"成员";
        nameLabel.textColor = CCCUIColorFromHex(0x333333);
        nameLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:nameLabel];
        
        UILabel *memberLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth -80 -8,13,60, 20)];
        memberLabel.text = [NSString stringWithFormat:@"%@",_memberNumStr];
        memberLabel.textColor = CCCUIColorFromHex(0x999999);
        memberLabel.font = [UIFont systemFontOfSize:14];
        memberLabel.textAlignment= NSTextAlignmentRight;
        [cell.contentView addSubview:memberLabel];
        UIImageView *memberImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 18, 18.5, 6, 10.5)];
        memberImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        
        [cell.contentView addSubview:memberImage];
        
        
        if (iPhone5) {
            
            if (_memberArr.count == 6) {
                for (int i = 0 ; i < _memberArr.count -1; i++) {
                    
                    
                    NSInteger index = 1/ 2;
                    
                    NSInteger page = i;
                    // 图片
                    UIImageView *avatarImage = [[UIImageView alloc]init];
                    [avatarImage sd_setImageWithURL:[_memberArr[i] lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
                    avatarImage.frame = CGRectMake(page * (Button_Width + Width_Space) + Start_X, index  * (Button_Height + Height_Space)+Start_Y , Button_Width, Button_Height);
                    avatarImage.backgroundColor = [UIColor grayColor];
                    avatarImage.layer.masksToBounds = YES;
                    avatarImage.layer.cornerRadius = Button_Width / 2;
                    [cell.contentView addSubview:avatarImage];
                }

            }
            else {
                for (int i = 0 ; i < _memberArr.count; i++) {
                    
                    
                    NSInteger index = 1/ 2;
                    
                    NSInteger page = i;
                    // 图片
                    UIImageView *avatarImage = [[UIImageView alloc]init];
                    [avatarImage sd_setImageWithURL:[_memberArr[i] lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
                    avatarImage.frame = CGRectMake(page * (Button_Width + Width_Space) + Start_X, index  * (Button_Height + Height_Space)+Start_Y , Button_Width, Button_Height);
                    avatarImage.backgroundColor = [UIColor grayColor];
                    avatarImage.layer.masksToBounds = YES;
                    avatarImage.layer.cornerRadius = Button_Width / 2;
                    [cell.contentView addSubview:avatarImage];
                }

            }
            

            
        }
        else {
            for (int i = 0 ; i < _memberArr.count; i++) {
                
                
                NSInteger index = 1/ 2;
                
                NSInteger page = i;
                // 图片
                UIImageView *avatarImage = [[UIImageView alloc]init];
                [avatarImage sd_setImageWithURL:[_memberArr[i] lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
                avatarImage.frame = CGRectMake(page * (Button_Width + Width_Space) + Start_X, index  * (Button_Height + Height_Space)+Start_Y , Button_Width, Button_Height);
                avatarImage.backgroundColor = [UIColor grayColor];
                avatarImage.layer.masksToBounds = YES;
                avatarImage.layer.cornerRadius = Button_Width / 2;
                [cell.contentView addSubview:avatarImage];
            }

            
        }
    }
    else if(indexPath.section==2)
    {
        UILabel * joinLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
        if ([_isJoin isEqualToString:@"1"]) {
            // 未加入
            joinLabel.text = @"加入圈子";
            joinLabel.textColor = CCCUIColorFromHex(0x22a941);
            
        }
        else{
            joinLabel.text = @"退出圈子";
            joinLabel.textColor = CCCUIColorFromHex(0x999999);

            
        }
        joinLabel.textAlignment = NSTextAlignmentCenter;
        joinLabel.font = [UIFont systemFontOfSize:15];
        
        [cell.contentView addSubview:joinLabel];

    }
    // cell 点击时候的颜色
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = CCCUIColorFromHex(0xf0f1f2);
    cell.textLabel.font =  [UIFont systemFontOfSize:13];
    
    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section==1)
    {
        // 圈好友 加入
        CirclePeopleViewController * circlePeopleVC = [[CirclePeopleViewController alloc]init];
        circlePeopleVC.groupId = _circleId;
        circlePeopleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:circlePeopleVC animated:YES];
        
    }

    if(indexPath.section==2)
    {
        if ([_isJoin isEqualToString:@"1"]) {
            // 未加入  加入
            self.requestParas = @{@"groupId":_circleId,
                                  @"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"token":[[MyUserInfoManager shareInstance]token]
                                  };
            self.requestURL = LKB_Group_Join_Url;
        }
        else{
            
            
            _actionSheet = [ZFActionSheet actionSheetWithTitle:@"确定圈子将不能发布动态" confirms:@[@"确定"] cancel:@"取消" style:ZFActionSheetStyleDestructive];
            _actionSheet.delegate = self;
            [_actionSheet showInView:self.view.window];


        }
        
    }

    
}

- (void)clickAction:(ZFActionSheet *)actionSheet atIndex:(NSUInteger)index
{
    NSLog(@"选中了 %zd",index);
    
    
    // 已加入  退出
    self.requestParas = @{@"groupId":_circleId,
                          @"userId":[MyUserInfoManager shareInstance].userId,
                          @"token":[MyUserInfoManager shareInstance].token
                          };
    self.requestURL = LKB_Group_Logout_Url;

}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        
        NSLog(@"=====================%@",errorMessage);
        
        if ([errorMessage isEqualToString:@"没有网络，连接失败"]) {
            
            [self.tableView removeFromSuperview];
            
            WithoutInternetImage.hidden = NO;
            tryAgainButton.hidden = NO;
        }

    }

    

    if ([request.url isEqualToString:LKB_Circle_Info_Url])  {
        
        
        CircleInfoModel * inforModel = (CircleInfoModel *)parserObject;

        NSLog(@"=============================%@",inforModel.data);
        
        NSLog(@"=============================%@",[inforModel.data valueForKey:@"groupDesc"]);
        
        _dataArray = [NSMutableDictionary dictionaryWithDictionary:inforModel.data];
        
        _headerImageStr = [inforModel.data valueForKey:@"groupAvatar"];
        _nameStr = [inforModel.data valueForKey:@"groupName"];
        _IntroduceStr = [inforModel.data valueForKey:@"groupDesc"];
        _memberNumStr = [inforModel.data valueForKey:@"memberNum"];
        _memberArr = [inforModel.data valueForKey:@"avatars"];
        _isJoin = [inforModel.data valueForKey:@"isJoin"];
        
        [CircleIfJoinManager shareInstance].ifJoin = _isJoin;
        


        
        [self.tableView reloadData];
        

    }
    
    
    
    if ([request.url isEqualToString:LKB_Group_Join_Url]) {
        LKBBaseModel *baseModel = (LKBBaseModel *)parserObject;
        if ([baseModel.success isEqualToString:@"1"]) {
            
            
            
            [XHToast showTopWithText:baseModel.msg topOffset:60.0];

            [CircleIfJoinManager shareInstance].ifJoin = @"0";

            
            [self initializePageSubviews];

            

            
        }
        
    }
    if ([request.url isEqualToString:LKB_Group_Logout_Url]) {
        LKBBaseModel *baseModel = (LKBBaseModel *)parserObject;
        if ([baseModel.success isEqualToString:@"1"]) {
            
            [XHToast showTopWithText:baseModel.msg topOffset:60.0];

//            [self ShowProgressHUDwithMessage:@"退出成功"];
//            _isJoin = @"1";
            
//            [self initializePageSubviews];
            [CircleIfJoinManager shareInstance].ifJoin = @"1";

            
            [self.navigationController popViewControllerAnimated:YES];



            
        }
    }

    
}

- (void)ShowProgressHUDwithMessage:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.dimBackground = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}







@end
