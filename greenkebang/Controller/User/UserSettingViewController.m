//
//  UserSettingViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 9/18/15.
//  Copyright © 2015 transfar. All rights reserved.
//
static NSString* CellIdentifier = @"UserCellIdentifier";
#import "UserSettingViewController.h"
#import "LKBBaseNavigationController.h"
#import "AboutLvKebangViewController.h"
#import "SDImageCache.h"
#import "TalkSettingViewControllrt.h"
#import "EMSDImageCache.h"
#import "UMFeedbackViewController.h"
#import "PushNotificationViewController.h"
#import "LoginHomeViewController.h"
#import "SetPassWordViewController2.h"
#import "MyUserInfoManager.h"
#import "UserInforSettingViewController.h"
#import "RevisePassWordViewController.h"


#define cachePath  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

@interface UserSettingViewController ()
@property (strong, nonatomic) NSArray *classArray;
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) UILabel* huancunView;
@end

@implementation UserSettingViewController

#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"设置";
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    self.tableView.scrollEnabled = NO;
    _classArray = @[@"修改密码",@"清理缓存",@"反馈",@"关于",@"给绿科邦打分"];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    
    
    //    NSString *city = [[UserMationMange sharedInstance] userDefaultCity];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:city style:UIBarButtonItemStylePlain target:self action:@selector(didLeftBarButtonItemAction:)];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarButtonItemAction:)];
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super viewWillAppear:animated];
    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [MobClick beginLogPageView:@"UserSettingViewController"];


}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"UserSettingViewController"];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){
        return 1;
    }
    else if (section == 1){
        return 1;
    }
    else if(section==2)
    {
        return 3;
    }else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 50;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = _classArray[indexPath.row];

        
        UIImageView *rightImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27,19,6, 10.5)];
        rightImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        
        [cell.contentView addSubview:rightImage];

    }
    
    if (indexPath.section==1) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor =UIColorWithRGBA(237, 238, 239, 1);
        [cell addSubview:lineView];
        cell.textLabel.text = _classArray[indexPath.row +1 ];
        [_huancunView removeFromSuperview];
        _huancunView = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90, 10, 60, 30)];
        
        
        NSString *str = [NSString stringWithFormat:@"%.2fM",[[SDImageCache sharedImageCache]getSize]/1024.0/1024.0];
        _huancunView.text = str;
        
        _huancunView.textAlignment = NSTextAlignmentRight;
        _huancunView.textColor = [UIColor lightGrayColor];
        //            cell.detailTextLabel.text  = str;
        [cell addSubview:_huancunView];
        //        if (indexPath.row==1) {
        //
        //        }
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    }else if(indexPath.section==2)
    {
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor =UIColorWithRGBA(237, 238, 239, 1);
        [cell addSubview:lineView];
        cell.textLabel.text = _classArray[indexPath.row+2];
        
        UIImageView *rightImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27,19,6, 10.5)];
        rightImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        
        [cell.contentView addSubview:rightImage];

//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }else if(indexPath.section==3)
    {
        cell.contentView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 40)];
        cell.backgroundColor =UIColorWithRGBA(237, 238, 239, 1);
        logoutBtn.backgroundColor = [UIColor whiteColor];
        [logoutBtn setTitle:@"退出账号" forState:UIControlStateNormal];
        logoutBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [logoutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [logoutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:logoutBtn];
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    // cell 小箭头
    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section==0)
    {
//        SetPassWordViewController2 *setPassVC = [[SetPassWordViewController2 alloc]init];
//        setPassVC.type = @"1";
//        setPassVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:setPassVC animated:YES];
        
        RevisePassWordViewController *setPassVC = [[RevisePassWordViewController alloc]init];
        setPassVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setPassVC animated:YES];
        
    }

    else if (indexPath.section==1) {
        if (indexPath.row==0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清除缓存"
                                                            message:@"是否清除缓存"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定",nil];
            
            [alert show];
            
            //            TalkSettingViewControllrt *talkSetting = [[TalkSettingViewControllrt alloc]init];
            //            [self.navigationController pushViewController:talkSetting animated:YES];
            //            [self ShowProgressHUDwithMessage:@"赞未开放此功能"];
            
            
        }else
        {
            
            
            
            
        }
        
        
    }else if(indexPath.section==2){
        if (indexPath.row==0) {
            // 反馈
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:[UMFeedbackViewController new]
                                                 animated:YES];
            
        }
        else if(indexPath.row==1)
        {
            // 关于绿科邦
            AboutLvKebangViewController *aboutLKB = [[AboutLvKebangViewController alloc]init];
            aboutLKB.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutLKB animated:YES];
        }
        else if(indexPath.row==2)
        {
            // 给绿科邦打分
            NSString *str = [NSString stringWithFormat: @"https://itunes.apple.com/cn/app/id1054282891"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];//
        }
        
        //        else if(indexPath.row==3)
        //        {
        //            PushNotificationViewController *pushController = [[PushNotificationViewController alloc] initWithStyle:UITableViewStylePlain];
        //            [self.navigationController pushViewController:pushController animated:YES];
        //        }
        //        else if (indexPath.row == 4) {
        //
        //            // 修改密码
        //            SetPassWordViewController2 *setPassVC = [[SetPassWordViewController2 alloc]init];
        //            setPassVC.type = @"1";
        //            [self.navigationController pushViewController:setPassVC animated:YES];
        //        }
        
    }
    else {
        
        
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        [self clearTmpPics];
    }
    
    
}
-(void)logout:(id)sender
{
    
    
    [[YQUser usr]doLoginOut];
    
    LoginHomeViewController *loginRootVC = [[LoginHomeViewController alloc]init];
    LKBBaseNavigationController* loginNav = [[LKBBaseNavigationController alloc] initWithRootViewController:loginRootVC];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error && info) {
            
            NSLog(@"退出成功");
        }
    } onQueue:nil];
    
    AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.window setRootViewController:loginNav];
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


#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}


- (void)clearTmpPics
{
    [[SDImageCache sharedImageCache] clearDisk];
    
    //    [[SDImageCache sharedImageCache] clearMemory];//可有可无
    
    NSLog(@"clear disk");
    
    
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    [urlCache removeAllCachedResponses];
    
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:cachePath error:nil];
    //    float tmpSize = [[SDImageCache sharedImageCache] clearDisk];
    //
    //    NSString *clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",tmpSize] : [NSString stringWithFormat:@"清理缓存(%.2fK)",tmpSize * 1024];
    
    //    [configDataArray replaceObjectAtIndex:2 withObject:clearCacheName];
    
    [_tableView reloadData];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
