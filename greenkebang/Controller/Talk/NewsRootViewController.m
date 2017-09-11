//
//  NewsRootViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "NewsRootViewController.h"
#import "TalkRootViewController.h"
#import "NewsCommentViewController.h"
#import "NewsNoticeViewController.h"
#import "EMCDDeviceManager.h"
#import "TabbarManager.h"
#import "MyUserInfoManager.h"
@interface NewsRootViewController ()<ViewPagerDataSource,ViewPagerDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *classArray;
//@property (strong, nonatomic) UIImageView *dotImage;

@end

@implementation NewsRootViewController
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
    
    self.title = @"消息";
    self.view.backgroundColor = [UIColor whiteColor];
    // @"通知"
    _classArray = @[@"通知",@"评论",@"私信"];
    
    self.dataSource = self;
    self.delegate = self;
    [self reloadData];
    
    self.view.multipleTouchEnabled = YES;
    
    self.view.userInteractionEnabled = YES;
    
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"newMessage" object:nil];
    
    //获取消息页面通知中心单例对象
    NSNotificationCenter * chatCenter = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [chatCenter addObserver:self selector:@selector(chatCenter:) name:@"chatListVCMessage" object:nil];
    
    
    
    
    
    _commentVCImage = [[UIImageView alloc]init];
    _commentVCImage.frame = CGRectMake(kDeviceWidth *0.53,74, 9, 9);
    [_commentVCImage setImage:[UIImage imageNamed:@"tabBardot"]];
    
    
    _chatVCImage = [[UIImageView alloc]init];
    _chatVCImage.frame = CGRectMake(kDeviceWidth *0.87,74, 9, 9);
    [_chatVCImage setImage:[UIImage imageNamed:@"tabBardot"]];
    
    
    
    _noticeVCImage = [[UIImageView alloc]init];
    _noticeVCImage.frame = CGRectMake(kDeviceWidth *0.2,74, 9, 9);
    [_noticeVCImage setImage:[UIImage imageNamed:@"tabBardot"]];
    
    
    
    [self.view addSubview:_commentVCImage];
    [self.view addSubview:_noticeVCImage];
    [self.view addSubview:_chatVCImage];
    
    
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    // 通知
    NSString *noticeVCKey = [NSString stringWithFormat:@"noticeVC%@",[MyUserInfoManager shareInstance].userId];
    NSString * noticeVCstr =[userDefault objectForKey:noticeVCKey];
    
    
    if ([noticeVCstr isEqualToString:@"isUnRead"]) {
        
        _noticeVCImage.hidden = NO;
    }
    else {
        
        _noticeVCImage.hidden = YES;
        
    }
    
    // 评论
    NSString *commentVCKey = [NSString stringWithFormat:@"commentVC%@",[MyUserInfoManager shareInstance].userId];
    NSString * commentVCstr =[userDefault objectForKey:commentVCKey];
    if ([commentVCstr isEqualToString:@"isUnRead"]) {
        
        _commentVCImage.hidden = NO;
    }
    else {
        
        _commentVCImage.hidden = YES;
        
    }
    
    // 私信
    NSString *chatVCKey = [NSString stringWithFormat:@"chatVC%@",[MyUserInfoManager shareInstance].userId];
    NSString * chatVCstr =[userDefault objectForKey:chatVCKey];
    if ([chatVCstr isEqualToString:@"isUnRead"]) {
        
        _chatVCImage.hidden = NO;
    }
    else {
        
        _chatVCImage.hidden = YES;
        
        
    }
    
    
    
    
    // Do any additional setup after loading the view.
    
    
    
    //获取tableView滚动通知中心单例对象
    NSNotificationCenter * slidercenter = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [slidercenter addObserver:self selector:@selector(slider:) name:@"scrollViewWillBeginDragging" object:nil];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10,22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setClipsToBounds:NO];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    // 通知
    NSString *noticeVCKey = [NSString stringWithFormat:@"noticeVC%@",[MyUserInfoManager shareInstance].userId];
    NSString * noticeVCstr =[userDefault objectForKey:noticeVCKey];
    
    
    if ([noticeVCstr isEqualToString:@"isUnRead"]) {
        
        _noticeVCImage.hidden = NO;
    }
    else {
        
        _noticeVCImage.hidden = YES;
        
    }
    
    // 评论
    NSString *commentVCKey = [NSString stringWithFormat:@"commentVC%@",[MyUserInfoManager shareInstance].userId];
    NSString * commentVCstr =[userDefault objectForKey:commentVCKey];
    if ([commentVCstr isEqualToString:@"isUnRead"]) {
        
        _commentVCImage.hidden = NO;
    }
    else {
        
        _commentVCImage.hidden = YES;
        
    }
    
    // 私信
    NSString *chatVCKey = [NSString stringWithFormat:@"chatVC%@",[MyUserInfoManager shareInstance].userId];
    NSString * chatVCstr =[userDefault objectForKey:chatVCKey];
    if ([chatVCstr isEqualToString:@"isUnRead"]) {
        
        _chatVCImage.hidden = NO;
    }
    else {
        
        _chatVCImage.hidden = YES;
        
    }
    
    
    [MobClick beginLogPageView:@"NewsRootViewController"];
    
}

// tableView开始滚动消失
- (void)slider:(id)sender {
    
    _commentVCImage.hidden = YES;
    
}

// 页面更新时获得消息
-(void)notice:(NSNotification *)sender{
    
    NSLog(@"《《《》》》》》》》》》》》》》》》》》%@",sender.userInfo);
    
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    
    for (NSString * key in sender.userInfo) {
        
        
        NSRange range = [key rangeOfString:@"payloadMsg:"]; //现获取要截取的字符串位置
        NSString * result = [key substringFromIndex:range.location]; //截取字符串
        
        NSString *dicStr = [result substringFromIndex:11];
        
        NSData *data = [dicStr dataUsingEncoding:NSUTF8StringEncoding];
        
        _DicOfNsnotification = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"/////////////////<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<%@",_DicOfNsnotification);
        // type  0 通知 1 评论
        NSString *wweee = [NSString stringWithFormat:@"%@",[_DicOfNsnotification objectForKey:@"type"]];
        
        // noticeType 1 问答邀请
        NSString *noticeType = [NSString stringWithFormat:@"%@",[_DicOfNsnotification objectForKey:@"noticeType"]];
        if ([noticeType isEqualToString:@"1"]) {
            
            /*
             {
             msg = "\U60a8\U6709\U4e00\U6761\U65b0\U7684\U53c2\U4e0e\U9080\U8bf7";
             noticeName = "\U9080\U8bf7\U53c2\U4e0e";
             noticeType = 1;
             object =         {
             avatar = "2017-01-12_Rizd0qm5.png";
             avatars =             (
             );
             cover = "0ebf8810-b2c0-450c-be1e-369306204e92.jpg";
             groupId = 79;
             inviteAnswerNum = 0;
             isAttention = 1;
             noticeContent = "\U60a8\U6709\U4e00\U6761\U65b0\U7684\U53c2\U4e0e\U9080\U8bf7";
             noticeDate = 1489042466715;
             objId = 1730;
             objTitle = "";
             userId = 127;
             userName = Jasmine;
             };
             title = "\U9080\U8bf7\U53c2\U4e0e";
             type = 0;
             }
             
             
             */
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            
            NSString *KeyStr = [NSString stringWithFormat:@"QuestionAndAnswer%@",[MyUserInfoManager shareInstance].userId];
            
            
            NSMutableArray *updateNewArr = [[userDefault objectForKey:KeyStr]mutableCopy];
            
            
            
            
            if (updateNewArr > 0 ) {
                
                [updateNewArr addObject:_DicOfNsnotification];
                
                
                NSArray *AnswerArr = [NSArray arrayWithArray:updateNewArr];
                
                
                [userDefault setObject:AnswerArr forKey:KeyStr];
                
                
                NSLog(@"=======================%@",updateNewArr);// 数组里
                
                
                
            }
            else {
                
                NSMutableArray *QuestionAndAnswerArr = [NSMutableArray arrayWithObject:_DicOfNsnotification];
                
                NSArray *QuestionArr = [NSArray arrayWithArray:QuestionAndAnswerArr];
                
                //            [QuestionAndAnswerArr addObject:_DicOfNsnotification];
                [userDefault setObject:QuestionArr forKey:KeyStr];
                
                
                
                NSMutableArray *updateNewArr = [[userDefault objectForKey:KeyStr]mutableCopy];
                
                NSLog(@"=======================%@",updateNewArr);// 数组里
                
                
            }
            
            
            
            
            
            
            NSLog(@"=======================%@",updateNewArr);// 数组里
            
            NSLog(@"=======================%lu数量",(unsigned long)updateNewArr.count);// 数组里
            
            //            //创建一个消息对象
            //            NSNotification *questionslider = [NSNotification notificationWithName:@"QuesAndAnsView" object:nil userInfo:_DicOfNsnotification];
            //            //发送消息
            //            [[NSNotificationCenter defaultCenter]postNotification:questionslider];
            
            
            
            
            
        }
        
        
        // 通知
        if ([wweee isEqualToString:@"0"]) {
            
            _noticeVCImage.hidden = NO;
            
            
            NSString *objectId =[NSString stringWithFormat:@"noticeVC%@",[MyUserInfoManager shareInstance].userId] ;
            
            [userDefault setObject:@"isUnRead" forKey:objectId];
            
            
            //创建一个消息对象
            NSNotification *slider = [NSNotification notificationWithName:@"NewsNoticeVC" object:nil userInfo:_DicOfNsnotification];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:slider];
            
            
            
        }
        else {
            _commentVCImage.hidden = NO;
            
            
            NSString *objectId =[NSString stringWithFormat:@"commentVC%@",[MyUserInfoManager shareInstance].userId] ;
            
            [userDefault setObject:@"isUnRead" forKey:objectId];
            
            //            //创建一个消息对象
            //            NSNotification *slider = [NSNotification notificationWithName:@"NewsNoticeVC" object:nil userInfo:_DicOfNsnotification];
            //            //发送消息
            //            [[NSNotificationCenter defaultCenter]postNotification:slider];
            
            
        }
        
    }
    
    
    
}


// 聊天页面
-(void)chatCenter:(NSNotification *)sender {
    
    NSLog(@"《《《》》》》》》》》》》》》》》》》》%@",sender.userInfo);
    
    _chatVCImage.hidden = NO;
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *objectId =[NSString stringWithFormat:@"chatVC%@",[MyUserInfoManager shareInstance].userId] ;
    
    [userDefault setObject:@"isUnRead" forKey:objectId];
    
    
    
}





- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    _commentVCImage.hidden = YES;
    
    _noticeVCImage.hidden = YES;
    
    _chatVCImage.hidden = YES;
    
    
    //    [_chatVCImage removeFromSuperview];
    
    //    //创建一个消息对象
    //    NSNotification *newcommententer = [NSNotification notificationWithName:@"newsCommentCancel" object:nil];
    //    //发送消息
    //    [[NSNotificationCenter defaultCenter]postNotification:newcommententer];
    [MobClick endLogPageView:@"NewsRootViewController"];
    
    
}


- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    //    [_chatVCImage removeFromSuperview];
    
    
}



- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {
    
    
    //    [_chatVCImage removeFromSuperview];
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    
    if (index == 0) {
        _noticeVCImage.hidden = YES;
        
        
        NSString *noticeVCId =[NSString stringWithFormat:@"noticeVC%@",[MyUserInfoManager shareInstance].userId] ;
        
        [userDefault setObject:@"isRead" forKey:noticeVCId];
        
        
        
    }else if (index == 1){
        
        _commentVCImage.hidden = YES;
        
        
        NSString *commentVCId =[NSString stringWithFormat:@"commentVC%@",[MyUserInfoManager shareInstance].userId] ;
        
        [userDefault setObject:@"isRead" forKey:commentVCId];
        
        
    }else {
        
        _chatVCImage.hidden = YES;
        
        NSString *chatVCId =[NSString stringWithFormat:@"chatVC%@",[MyUserInfoManager shareInstance].userId] ;
        
        [userDefault setObject:@"isRead" forKey:chatVCId];
        
        
        
    }
    
    
    
    
    if ([[TabbarManager shareInstance].vcType isEqual:nil]) {
        
        //创建一个消息对象
        NSNotification *newcommententer = [NSNotification notificationWithName:@"newsCommentCancel" object:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:newcommententer];
        
    }
    
    
}



#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return _classArray.count;
}
- (NSString *)viewPager:(ViewPagerController *)viewPager titleForTabAtIndex:(NSUInteger)index
{
    return _classArray[index];
}

-(UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index{
    
    if (index == 0)  {
        NewsNoticeViewController * noticeVC = [[NewsNoticeViewController alloc]init];
        return noticeVC;
    }
    
    if (index == 1)  {
        NewsCommentViewController * commentVC = [[NewsCommentViewController alloc]init];
        return commentVC;
    }
    else {
        TalkRootViewController *talkVC = [[TalkRootViewController alloc]init];
        //        talkVC.hidesBottomBarWhenPushed = YES;
        return talkVC;
    }
    
}









#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
            break;
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        case ViewPagerOptionTabWidth:
            return kDeviceWidth / _classArray.count;
        default:
            break;
        case ViewPagerOptionTabHeight:
            return 40.0;
            break;
            
            
    }
    return value;
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            //            return CCColorFromRGB(21, 174, 237);
            //            return CCCUIColorFromHex(0x32D6FF);
            return [UIColor colorWithHex:0x22ac38];
        case ViewPagerTabsView:
            return [UIColor whiteColor];
        case ViewPagerContent:
            return [UIColor clearColor];
        default:
            return color;
    }
}


#pragma mark - Navigation
- (void)didLeftBarButtonItemAction:(id)sender
{
    
}
- (void)searchBarButtonItemAction:(id)sender
{
    //    DiscoverSearchViewController* discoverSearchVC = [[DiscoverSearchViewController alloc] init];
    //    [self.navigationController pushViewController:discoverSearchVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
