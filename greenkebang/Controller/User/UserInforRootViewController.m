//
//  UserInforRootViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/6.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforRootViewController.h"
#import "LKBPrefixHeader.pch"
#import "FileHelpers.h"
#import "MyUserInfoManager.h"
#import "UserInforModel.h"
#import "UserInforDynamicModel.h"
#import "UserSettingViewController.h"
#import "MyAttentionBaseViewController.h"
#import "UserInforSettingViewController.h"
#import "UserInforGroupViewController.h"
#import "ColumnListViewController.h"
#import "UserInforActivityViewController.h"
#import "UserInforCollectionViewController.h"
#import "UserInforDynamicViewController.h"
#import "MyAttentionSeperateViewController.h"
#import "MyAttentionSeperateTopicViewController.h"
#import <UIImageView+WebCache.h>
#import "PeopleViewController.h"
#import "NewUserMainPageViewController.h"
#import "SVPullToRefresh.h"
#import "MyFeatureIdManager.h"
#import "NewsRootViewController.h"
#import "TabbarManager.h"
static NSString* UserCellIdentifier = @"TimeTableViewCellIdentifier";

@interface UserInforRootViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;

}

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSArray *classArray;
@property (strong, nonatomic) UIButton *headerImageBtn;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIButton *attentionBtn;
@property (strong, nonatomic) UIButton *fansBtn;
@property (strong, nonatomic) NSString *featureId;
@property (strong, nonatomic) NSString *userNameStr;
@property (strong, nonatomic) NSString *attentionNumStr;
@property (strong, nonatomic) NSString *fansNumStr;

@property (strong, nonatomic) UIImageView *headerImage;

@end

@implementation UserInforRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
    //                          @"ownerId":[MyUserInfoManager shareInstance].userId,
    //                          @"token":[MyUserInfoManager shareInstance].token
    //                          };
    //    self.requestURL = LKB_User_Infor_Url;
    
    
    _classArray = @[@"我的圈子",@"我的动态",@"我的专栏",@"我的活动",@"关注的动态",@"关注的专栏",@"我的收藏",@"资料",@"设置"];
    
    
    [self initializePageSubviews];

    
    
    //    _headerImage = [[UIImageView alloc]init];
    //    [_headerImage sd_setImageWithURL:[[MyUserInfoManager shareInstance].avatar lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
    //
    //    [_headerImageBtn setImage:_headerImage.image forState:UIControlStateNormal];
    
    _photoUrl = [[MyUserInfoManager shareInstance].avatar lkbImageUrl4];
    
    // 消息按钮
    UIButton *  newsButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -14 , 8, 17.5, 14)];
    //    [newsButton setTitle:@"消息" forState:UIControlStateNormal];
    [newsButton setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
    
    [newsButton addTarget:self action:@selector(newsButton:) forControlEvents:UIControlEventTouchUpInside];
    newsButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:newsButton];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"newMessage" object:nil];
    
    //获取评论点消失时通知中心单例对象
    NSNotificationCenter * chatCenter = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [chatCenter addObserver:self selector:@selector(notice:) name:@"chatListVCMessage" object:nil];
    
    
    self.view.multipleTouchEnabled=TRUE;
    
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


- (void)initializePageSubviews {
    
    [self.view addSubview:self.tableView];
    
    self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          @"token":[MyUserInfoManager shareInstance].token
                          };
    self.RequestPostWithChcheURL = LKB_User_Infor_Url;


}


// 页面更新时获得消息
-(void)notice:(NSNotification *)sender{
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"《《《》》》》》》》》》》》》》》》》》%@",sender.userInfo);
    
    if (sender.userInfo == nil) {
        
        _dotImage.hidden = YES;
        
        NSString *chatVCId =[NSString stringWithFormat:@"chatVC%@",[MyUserInfoManager shareInstance].userId] ;
        
        [userDefault setObject:@"isUnRead" forKey:chatVCId];
        
        
    }else {
        
        _dotImage.hidden = NO;
        
        
    }
    
    
    
    
    NSString *objectId =[NSString stringWithFormat:@"userInforNews%@",[MyUserInfoManager shareInstance].userId] ;
    
    [userDefault setObject:@"isUnRead" forKey:objectId];
    
    
    
}

// 消息
-(void)newsButton:(id)sender
{
    _dotImage.hidden = YES;
    
    //    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    //
    //    NSString *objectId =[NSString stringWithFormat:@"userInforNews%@",[MyUserInfoManager shareInstance].userId] ;
    //
    //    [userDefault setObject:@"isRead" forKey:objectId];
    //
    //    NSString * str =[userDefault objectForKey:objectId];
    //
    //
    //    NSLog(@"========================%@",str);
    
    
    NewsRootViewController *newsNoticeVC = [[NewsRootViewController alloc]init];
    
    newsNoticeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newsNoticeVC animated:YES];
}




-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setBarTintColor:CCCUIColorFromHex(0x323436)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    
    [TabbarManager shareInstance].vcType = @"3";
    
    [MobClick beginLogPageView:@"UserInforRootViewController"];
    
    //创建一个消息对象
    NSNotification *newUserInforCenter = [NSNotification notificationWithName:@"UserInfornewsCancel" object:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:newUserInforCenter];
    
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    // 通知
    NSString *noticeVCKey = [NSString stringWithFormat:@"noticeVC%@",[MyUserInfoManager shareInstance].userId];
    NSString * noticeVCstr =[userDefault objectForKey:noticeVCKey];
    
    // 评论
    NSString *commentVCKey = [NSString stringWithFormat:@"commentVC%@",[MyUserInfoManager shareInstance].userId];
    NSString * commentVCstr =[userDefault objectForKey:commentVCKey];
    
    // 私信
    NSString *chatVCKey = [NSString stringWithFormat:@"chatVC%@",[MyUserInfoManager shareInstance].userId];
    NSString * chatVCstr =[userDefault objectForKey:chatVCKey];
    
    
    
    
    
    
    // 显示图片
    _dotImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBardot"]];
    _dotImage.frame = CGRectMake(kDeviceWidth - 19,  12, 9, 9);
    
    _dotImage.backgroundColor = [UIColor clearColor];
    
    // 通知
    NSString *userInforVCKey = [NSString stringWithFormat:@"userInforRead%@",[MyUserInfoManager shareInstance].userId];
    
    
    if ([noticeVCstr isEqualToString:@"isUnRead"] ||[commentVCstr isEqualToString:@"isUnRead"] ||[chatVCstr isEqualToString:@"isUnRead"]  ) {
        
        _dotImage.hidden = NO;
        
        
        
        [userDefault setObject:@"isUnRead" forKey:userInforVCKey];
        
        
        
        
        
    }
    else {
        
        _dotImage.hidden = YES;
        
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        // 通知
        NSString *userInforVCKey = [NSString stringWithFormat:@"userInforRead%@",[MyUserInfoManager shareInstance].userId];
        
        [userDefault setObject:@"isRead" forKey:userInforVCKey];
        
        
    }
    
    
    [self.navigationController.navigationBar addSubview:_dotImage];
    
    
    
    //    [userDefault setObject:@"isUnRead" forKey:objectId];
    
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"UserInforRootViewController"];
    
    
    
    [_dotImage removeFromSuperview];
    
}




- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UserCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 4;
    }
    else if (section == 2){
        
        return 3;
    }
    else if (section == 3){
        return 1;
    }
    else {
        
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        
        if ([errorMessage isEqualToString:@"没有网络，连接失败"]) {
            
            if (_dataArray.count == 0) {
                
                [self.tableView removeFromSuperview];
                
                WithoutInternetImage.hidden = NO;
                tryAgainButton.hidden = NO;
            }
            else {
                
                WithoutInternetImage.hidden = YES;
                tryAgainButton.hidden = YES;
                
            }
            
            
            
        }
        return;
    }
    if ([request.url isEqualToString:LKB_User_Infor_Url]) {
        UserInforModel *userInfor = (UserInforModel *)parserObject;
        
        
        NSLog(@"========================%@",[userInfor.data valueForKey:@"featureId"]);
        
        _headerImg =[userInfor.data valueForKey:@"avatar"];
        
        _userNameStr = [userInfor.data valueForKey:@"userName"];
        _genderStr = [userInfor.data valueForKey:@"gender"];
        _goodFiledStr = [userInfor.data valueForKey:@"goodFiled"];
        _addressStr = [userInfor.data valueForKey:@"address"];
        _identityStr= [userInfor.data valueForKey:@"identity"];
        _remarkStr= [userInfor.data valueForKey:@"remark"];
        
        _nameLabel.text = _userNameStr;
        
        _attentionNumStr = [userInfor.data valueForKey:@"attentionNum"];
        [_attentionBtn setTitle:[NSString stringWithFormat:@"关注 %@",_attentionNumStr] forState:UIControlStateNormal];
        
        _fansNumStr = [userInfor.data valueForKey:@"fansNum"];
        [_fansBtn setTitle:[NSString stringWithFormat:@"粉丝 %@",_fansNumStr] forState:UIControlStateNormal];
        
        
        _featureId =[NSString stringWithFormat:@"%@",[userInfor.data valueForKey:@"featureId"]];
        
        [MyFeatureIdManager shareInstance].featureId = _featureId;
        
        
        [_tableView reloadData];
    }
    
}






- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
        
    }else {
        return 15;
        
    }
}


- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 106;
        
    }else {
        return 50;
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLNONE = @"CELLNONE";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserCellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserCellIdentifier];
    }
    else{
        // 避免cell重叠
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(42, 17, kDeviceWidth - 22, 15)];
    titleLabel.textColor = CCCUIColorFromHex(0x333333);
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [cell.contentView addSubview:titleLabel];
    
    
    UIImageView * headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(14, 16,18,  18)];
    
    [cell.contentView addSubview:headerImage];
    
    
    
    
    if (indexPath.section == 0) {
        
        _headerImageBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 18, 70, 70)];
        _headerImageBtn.layer.masksToBounds = YES;
        _headerImageBtn.layer.cornerRadius = 35;
        _headerImageBtn.backgroundColor = CCCUIColorFromHex(0xdddddd);
        [_headerImageBtn addTarget:self action:@selector(headerImageBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        if (_photoUrl== nil) {
            
            [_headerImageBtn setImage:[UIImage imageNamed:@"setHeaderImage"] forState:UIControlStateNormal];
        }
        else {
            
            //            if (hasCachedImage(_photoUrl))
            //            {
            //                [_headerImageBtn setImage:_headImg forState:UIControlStateNormal];
            //            }
            //            else
            //            {
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_photoUrl,@"myUserAvatar",nil];
            [FileHelpers dispatch_process_with_thread:^{
                UIImage* ima = [self LoadImage:dic];
                return ima;
            } result:^(UIImage *ima){
                [_headerImageBtn setImage:ima forState:UIControlStateNormal];
            }];
            //            }
            
            
        }
        
        
        
        //        [_headerImage sd_setImageWithURL:[[MyUserInfoManager shareInstance].avatar lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
        //
        //        [_headerImageBtn setImage:_headerImage.image forState:UIControlStateNormal];
        
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 31.5, kDeviceWidth - 116, 18)];
        _nameLabel.textColor = CCCUIColorFromHex(0x333333);
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.text = _userNameStr;
        
        _attentionBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 62.5, _attentionNumStr.length + 60, 20)];
        
        
        _attentionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_attentionBtn setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
        
        [_attentionBtn addTarget:self action:@selector(attentionBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_attentionNumStr == nil) {
            [_attentionBtn setTitle:[NSString stringWithFormat:@"关注 0"] forState:UIControlStateNormal];
            
        }else {
            
            [_attentionBtn setTitle:[NSString stringWithFormat:@"关注 %@",_attentionNumStr] forState:UIControlStateNormal];
            
        }
        
        
        
        
        
        _fansBtn = [[UIButton alloc]initWithFrame:CGRectMake(_attentionNumStr.length +196, 62.5, _fansNumStr.length +60, 20)];
        _fansBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _fansBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_fansBtn setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
        [_fansBtn addTarget:self action:@selector(fansBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_fansNumStr == nil) {
            [_fansBtn setTitle:[NSString stringWithFormat:@"粉丝 0"] forState:UIControlStateNormal];
            
        }else {
            
            [_fansBtn setTitle:[NSString stringWithFormat:@"粉丝 %@",_fansNumStr] forState:UIControlStateNormal];
            
        }
        
        UIImageView *rightImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27,48,6, 10.5)];
        rightImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        
        [cell.contentView addSubview:rightImage];
        
        
        
        [cell.contentView addSubview:_headerImageBtn];
        [cell.contentView addSubview:_nameLabel];
        [cell.contentView addSubview:_attentionBtn];
        [cell.contentView addSubview:_fansBtn];
        
        
        
        
        
    }
    else if (indexPath.section == 1){
        
        UIImageView *rightImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27,19,6, 10.5)];
        rightImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        
        [cell.contentView addSubview:rightImage];
        titleLabel.text = _classArray[indexPath.row];
        if (indexPath.row == 0) {
            headerImage.image = [UIImage imageNamed:@"my_icon_circle"];
        }
        if (indexPath.row == 1) {
            //            cell.textLabel.text = _classArray[indexPath.row+1];
            headerImage.image = [UIImage imageNamed:@"my_icon_dynamic"];
            
            
        }
        if (indexPath.row == 2) {
            //            cell.textLabel.text = _classArray[indexPath.row+2];
            headerImage.image = [UIImage imageNamed:@"my_icon_column"];
            
            
        }
        if (indexPath.row == 3) {
            //            cell.textLabel.text = _classArray[indexPath.row+3];
            headerImage.image = [UIImage imageNamed:@"my_icon_activity"];
            
            
        }
        if (indexPath.row == 4) {
            //            cell.textLabel.text = _classArray[indexPath.row+4];
            headerImage.image = [UIImage imageNamed:@"my_icon_follow"];
            
            
        }
        
        
    }
    else if (indexPath.section == 2){
        titleLabel.text = _classArray[indexPath.row +4];
        UIImageView *rightImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27,19,6, 10.5)];
        rightImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        
        [cell.contentView addSubview:rightImage];
        
        if (indexPath.row == 0) {
            headerImage.image = [UIImage imageNamed:@"my_icon_follow"];
        }
        if (indexPath.row == 1) {
            headerImage.image = [UIImage imageNamed:@"my_icon_subscribe"];
        }
        if (indexPath.row == 2) {
            headerImage.image = [UIImage imageNamed:@"my_icon_collection"];
            
        }
        
    }
    else if (indexPath.section == 3){
        
        titleLabel.text = _classArray[indexPath.row +7];
        UIImageView *rightImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27,19,6, 10.5)];
        rightImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        
        [cell.contentView addSubview:rightImage];
        
        headerImage.image = [UIImage imageNamed:@"my_icon_data"];
    }
    else {
        titleLabel.text = _classArray[indexPath.row +8];
        UIImageView *rightImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27,19,6, 10.5)];
        rightImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        
        [cell.contentView addSubview:rightImage];
        
        headerImage.image = [UIImage imageNamed:@"my_icon_set"];
    }
    
    return cell;
    
}

//异步加载图片
- (UIImage *)LoadImage:(NSDictionary*)aDic{
    
    NSLog(@"--------------------------%@",aDic);
    
    
    //    NSURL *aURL=[NSURL URLWithString:[aDic objectForKey:@"featureAvatar"]];
    NSURL *aURL = [aDic objectForKey:@"myUserAvatar"];
    
    NSData *data=[NSData dataWithContentsOfURL:aURL];
    if (data == nil) {
        return nil;
    }
    UIImage *image=[UIImage imageWithData:data];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager createFileAtPath:pathForURL(aURL) contents:data attributes:nil];
    return image;
}



- (void)headerImage:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [actionSheet addButtonWithTitle:@"拍照"];
    [actionSheet addButtonWithTitle:@"从手机相册选择"];
    // 同时添加一个取消按钮
    [actionSheet addButtonWithTitle:@"取消"];
    // 将取消按钮的index设置成我们刚添加的那个按钮，这样在delegate中就可以知道是那个按钮
    actionSheet.destructiveButtonIndex = actionSheet.numberOfButtons - 1;
    [actionSheet showInView:self.view];
}



- (void)headerImageBtn:(id)sender {
    
    
    NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
    peopleVC.toUserId= [MyUserInfoManager shareInstance].userId;
    peopleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:peopleVC animated:YES];
    
}
// 关注
- (void)attentionBtn:(id)sender {
    
    PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
    peopleVC.requestUrl = LKB_Attention_Users_Url;
    peopleVC.hidesBottomBarWhenPushed = YES;
    peopleVC.title = @"我的关注";
    peopleVC.VCType = @"1";

    peopleVC.userId = [MyUserInfoManager shareInstance].userId;
    [self.navigationController pushViewController:peopleVC animated:YES];
    
}
// 粉丝
- (void)fansBtn:(id)sender {
    
    PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
    peopleVC.requestUrl = LKB_Attention_All_Fans_Url;
    peopleVC.hidesBottomBarWhenPushed = YES;
    peopleVC.title = @"我的粉丝";
    peopleVC.userId = [MyUserInfoManager shareInstance].userId;
    peopleVC.VCType = @"2";

    [self.navigationController pushViewController:peopleVC animated:YES];
    
}




- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    if (indexPath.section == 0) {
        // 我的主页
        NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
        
        peopleVC.type = @"1";
        peopleVC.toUserId = [MyUserInfoManager shareInstance].userId;
        
        peopleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:peopleVC animated:YES];
        
        
    }
    else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            // 我的圈子
            UserInforGroupViewController * userGroupVC =[[ UserInforGroupViewController alloc]init];
            userGroupVC.toUserId = [MyUserInfoManager shareInstance].userId;
            userGroupVC.title = @"我的圈子";
            userGroupVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userGroupVC animated:YES];
            
            
            
            
        }
        if (indexPath.row == 1) {
            
            // 我的动态
            UserInforDynamicViewController * userDynamicVC =[[ UserInforDynamicViewController alloc]init];
            userDynamicVC.toUserId = [MyUserInfoManager shareInstance].userId;
            userDynamicVC.title = @"我的动态";
            userDynamicVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userDynamicVC animated:YES];
            
            
            
        }
        if (indexPath.row == 2) {
            
            // 我的专栏
            ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
            ColumnListViewVC.featureId = _featureId;
            ColumnListViewVC.title = @"我的专栏";
            ColumnListViewVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ColumnListViewVC animated:YES];
            
            
        }
        if (indexPath.row == 3) {
            
            // 我的活动
            UserInforActivityViewController * userActivityVC =[[ UserInforActivityViewController alloc]init];
            
            userActivityVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userActivityVC animated:YES];
            
            
            
        }
        
        
        
        
    }
    else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            // 关注的动态
            MyAttentionSeperateTopicViewController *discoveryRecommVC = [[MyAttentionSeperateTopicViewController alloc]init];
            discoveryRecommVC.userId = [MyUserInfoManager shareInstance].userId;
            discoveryRecommVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:discoveryRecommVC animated:YES];
            
            
            
            
        }
        if (indexPath.row == 1) {
            
            // 关注的专栏
            MyAttentionSeperateViewController *timeQAVC =[[MyAttentionSeperateViewController alloc]init];
            timeQAVC.userId = [MyUserInfoManager shareInstance].userId;
            timeQAVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:timeQAVC animated:YES];
            
            
            
            
        }
        if (indexPath.row == 2) {
            
            // 我的收藏
            UserInforCollectionViewController * userActivityVC =[[ UserInforCollectionViewController alloc]init];
            
            userActivityVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userActivityVC animated:YES];
            
            
            
            
            
        }
        
        
    }
    else if (indexPath.section == 3){
        // 资料
        UserInforSettingViewController* userInforVC = [[UserInforSettingViewController alloc]init];
        userInforVC.headerImg = [MyUserInfoManager shareInstance].avatar;
        userInforVC.nameStr = _userNameStr;
        userInforVC.genderStr = _genderStr;
        userInforVC.goodFiledStr = _goodFiledStr;
        userInforVC.addressStr = _addressStr;
        userInforVC.identityStr = _identityStr;
        userInforVC.remarkStr = _remarkStr;
        
        userInforVC.attentionNum = @"1";
        userInforVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userInforVC animated:YES];
        
    }
    else {
        
        UserSettingViewController *userVC = [[UserSettingViewController alloc]init];
        userVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userVC animated:YES];
        
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
