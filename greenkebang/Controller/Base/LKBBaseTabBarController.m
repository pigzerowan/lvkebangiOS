//
//  LKBBaseTabBarController.m
//  greenkebang
//
//  Created by 郑渊文 on 8/26/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "LKBBaseTabBarController.h"
#import "DiscoveryRootViewController.h"
#import "TalkRootViewController.h"
#import "TimeRootViewController.h"
#import "UserRootViewController.h"
#import "LKBBaseNavigationController.h"
#import "NewTimeViewController.h"
#import "NewDiscovieryRootViewController.h"
#import "UIViewController+HUD.h"
#import "ApplyViewController.h"
#import "CallViewController.h"
#import "ChatViewController.h"
#import "EMCDDeviceManager.h"
#import "RobotManager.h"
#import "UserProfileManager.h"
#import "TrendsRootViewController.h"
#import "UserInforRootViewController.h"
#import "BaseTimeViewController.h"
#import "NewsRootViewController.h"
#import "PaySystemViewController.h"
#import "TabbarManager.h"
#import "MyUserInfoManager.h"

//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";


@interface LKBBaseTabBarController ()
<UIAlertViewDelegate, IChatManagerDelegate, EMCallManagerDelegate>
{
    NewsRootViewController *_chatListVC;
}
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@property (strong, nonatomic) UIImageView *dotImage;

@end

@implementation LKBBaseTabBarController

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
    
    
    //if 使tabBarController中管理的viewControllers都符合 UIRectEdgeNone
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#warning 把self注册为SDK的delegate
    [self registerNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callOutWithChatter:) name:@"callOutWithChatter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callControllerClose:) name:@"callControllerClose" object:nil];
    
    //    [self setupSubviews];
    
    
    
    //    NewDiscovieryRootViewController *discoveryRootVC = [[NewDiscovieryRootViewController alloc] init];
    // 发现
    DiscoveryRootViewController *discoveryRootVC = [[DiscoveryRootViewController alloc]init];
    discoveryRootVC.navigationItem.title = @"发现";
    [discoveryRootVC.navigationController.navigationBar setBarTintColor:[UIColor navbarColor]];
    [discoveryRootVC.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //    _chatListVC = [[TalkRootViewController alloc] init];
    
    // 消息
    _chatListVC = [[NewsRootViewController alloc] init];
    _chatListVC.navigationItem.title = @"绿科邦";
    //    [_chatListVC networkChanged:_connectionState];
    
    
    // 交易
    PaySystemViewController * paySystemVC =  [[PaySystemViewController alloc] init];
    //    paySystemVC.mallUrl = [NSString stringWithFormat:@"http://mall.lvkebang.cn/login/app/login.jhtml?token=f340e87fe9964cf7bcd41507603d7a33"];
    
    paySystemVC.hidesBottomBarWhenPushed = YES;
    
    // f340e87fe9964cf7bcd41507603d7a33
    
    // 新农圈
    BaseTimeViewController *timeRootVC = [[BaseTimeViewController alloc] init];
    timeRootVC.navigationItem.title = @"绿科邦";
    //    [timeRootVC.navigationController.navigationBar setBarTintColor:[UIColor navbarColor]];
    //    [timeRootVC.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    // 我的
    UserInforRootViewController *userRootVC = [[UserInforRootViewController alloc] init];
    //    UserRootViewController *userRootVC = [[UserRootViewController alloc] init];
    
    userRootVC.navigationItem.title = @"我的";
    
    // 新农圈
    LKBBaseNavigationController *timeNav = [[LKBBaseNavigationController alloc] initWithRootViewController:timeRootVC];
    // 交易
    LKBBaseNavigationController *paySystemNav = [[LKBBaseNavigationController alloc] initWithRootViewController:paySystemVC];
    
    
    
    // 发现
    LKBBaseNavigationController *discoveryNav = [[LKBBaseNavigationController alloc] initWithRootViewController:discoveryRootVC];
    // 我的
    LKBBaseNavigationController *userNav = [[LKBBaseNavigationController alloc] initWithRootViewController:userRootVC];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0xaaaaaa), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    //    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],  NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    
    
    //    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
    //                                                       UIColorWithRGBA(192 , 138, 82, 1),  NSForegroundColorAttributeName,
    //                                                       nil] forState:UIControlStateSelected];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x555555),  NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    
    //    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],  NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    timeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新农圈" image:[UIImage imageNamed:@"tab_icon_nfcircle_dis"] selectedImage:[[UIImage imageNamed:@"tab_icon_nfcircle"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    paySystemNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"交易" image:[UIImage imageNamed:@"tab_icon_pay_dis"] selectedImage:[[UIImage imageNamed:@"tab_icon_pay_nor"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [paySystemNav.tabBarController.tabBar setHidden:YES];
    
    discoveryNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"tab_icon_find_dis"] selectedImage:[[UIImage imageNamed:@"tab_icon_find_nor"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    userNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tab_icon_my_dis"] selectedImage:[[UIImage imageNamed:@"tab_icon_my_nor"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    self.viewControllers = @[timeNav,paySystemNav,discoveryNav,userNav];
    
    if ([TabbarManager shareInstance].vcType == nil ) {
        self.selectedIndex = 0;
        
    }
    else {
        self.selectedIndex = [[TabbarManager shareInstance].vcType intValue];
        
    }
    
    
    
    
    //    self.tabBar.backgroundImage = [[UIImage alloc]init];
    //    self.tabBar.shadowImage = [[UIImage alloc]init];
    
    
    // 显示图片
    _dotImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBardot"]];
    
    _dotImage.backgroundColor = [UIColor clearColor];
    
    
    CGRect tabFrame = userRootVC.tabBarController.tabBar.frame;
    
    CGFloat x = ceilf(0.89 * tabFrame.size.width);
    //
    CGFloat y = ceilf(0.15 * tabFrame.size.height);
    
    _dotImage.frame = CGRectMake(x,y, 9, 9);
    
    [userRootVC.tabBarController.tabBar addSubview:_dotImage];
    
    
    [self setupUnreadMessageCount];
    
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"newMessage" object:nil];
    
    //获取tableView滚动通知中心单例对象
    NSNotificationCenter * slidercenter = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [slidercenter addObserver:self selector:@selector(slider:) name:@"scrollViewWillBeginDragging" object:nil];
    
    
    //获取评论点消失时通知中心单例对象
    NSNotificationCenter * newUserInforCenter = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [newUserInforCenter addObserver:self selector:@selector(newUserInforCenter:) name:@"UserInfornewsCancel" object:nil];
    
    
    
    
    
    //    [ChatDemoHelper shareHelper].contactViewVC = _contactsVC;
    //    [ChatDemoHelper shareHelper].conversationListVC = _chatListVC;
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



- (void)networkChanged:(EMConnectionState)connectionState
{
    _connectionState = connectionState;
    //    [_chatListVC networkChanged:connectionState];
}

// 页面更新时获得消息
-(void)notice:(id)sender{
    
    NSLog(@"%@",sender);
    
    _dotImage.hidden = NO;
    
    
}

// tableView开始滚动消失
- (void)slider:(id)sender {
    
    _dotImage.hidden = YES;
    
}

// 获取评论点消失时通知中心单例对象
- (void)newUserInforCenter:(id)sender {
    
    _dotImage.hidden = YES;
    
}




// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    
    
    if (_chatListVC) {
        if (unreadCount > 0) {
            
            // tabbar 显示数量
            //            _chatListVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
            
            //            if ([TabbarManager shareInstance].vcType != nil) {
            //
            //                _dotImage.hidden = YES;
            //
            //            }
            //            else {
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            
            
            NSString *chatVCId =[NSString stringWithFormat:@"chatVC%@",[MyUserInfoManager shareInstance].userId] ;
            
            NSString *ifReadStr = [user objectForKey:chatVCId];
            
            NSLog(@"==========================%@",ifReadStr);
            
            
            // 通知
            NSString *userInforVCKey = [NSString stringWithFormat:@"userInforRead%@",[MyUserInfoManager shareInstance].userId];
            
            NSString *userInforIfReadStr = [user objectForKey:userInforVCKey];
            
            //            [userDefault setObject:@"isUnRead" forKey:userInforVCKey];
            
            
            
            if ([ifReadStr isEqualToString:@"isRead"] || ifReadStr == nil ) {
                
                
                if ([userInforIfReadStr isEqualToString:@"isRead"]) {
                    
                    _dotImage.hidden = YES;
                    
                    
                }
                else {
                    
                    _dotImage.hidden = NO;
                    
                }
                
            }else {
                
                _dotImage.hidden = NO;
                
            }
            
            
            
        }else{
            _chatListVC.tabBarItem.badgeValue = nil;
            
            _dotImage.hidden = YES;
            
            _chatListVC.chatVCImage.backgroundColor = [UIColor whiteColor];
            [_chatListVC.view addSubview:_chatListVC.chatVCImage];
            
            
        }
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}

- (void)callControllerClose:(NSNotification *)notification
{
    //    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    //    [audioSession setActive:YES error:nil];
    
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
}
- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                bCanRecord = granted;
            }];
        }
    }
    
    if (!bCanRecord) {
        UIAlertView * alt = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"setting.microphoneNoAuthority", @"No microphone permissions") message:NSLocalizedString(@"setting.microphoneAuthority", @"Please open in \"Setting\"-\"Privacy\"-\"Microphone\".") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
        [alt show];
    }
    
    return bCanRecord;
}




// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    BOOL needShowNotification = (message.messageType != eMessageTypeChat) ? [self needShowNotification:message.conversationChatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        
        //        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        //        if (!isAppActivity) {
        //            [self showNotificationWithMessage:message];
        //        }else {
        //            [self playSoundAndVibration];
        //        }
        
        //        //创建一个消息对象
        //        NSNotification *newcommententer = [NSNotification notificationWithName:@"chatListVCMessage" object:nil];
        //        //发送消息
        //        [[NSNotificationCenter defaultCenter]postNotification:newcommententer];
        
        
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        switch (state) {
            case UIApplicationStateActive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateInactive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateBackground:
                [self showNotificationWithMessage:message];
                break;
            default:
                break;
        }
#endif
    }
}

- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    return ret;
}

- (void)callOutWithChatter:(NSNotification *)notification
{
    id object = notification.object;
    if ([object isKindOfClass:[NSDictionary class]]) {
        if (![self canRecord]) {
            return;
        }
        
        EMError *error = nil;
        NSString *chatter = [object objectForKey:@"chatter"];
        EMCallSessionType type = [[object objectForKey:@"type"] intValue];
        EMCallSession *callSession = nil;
        if (type == eCallSessionTypeAudio) {
            callSession = [[EaseMob sharedInstance].callManager asyncMakeVoiceCall:chatter timeout:50 error:&error];
        }
        else if (type == eCallSessionTypeVideo){
            if (![CallViewController canVideo]) {
                return;
            }
            callSession = [[EaseMob sharedInstance].callManager asyncMakeVideoCall:chatter timeout:50 error:&error];
        }
        
        if (callSession && !error) {
            [[EaseMob sharedInstance].callManager removeDelegate:self];
            
            CallViewController *callController = [[CallViewController alloc] initWithSession:callSession isIncoming:NO];
            callController.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self presentViewController:callController animated:NO completion:nil];
        }
        
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"error", @"error") message:error.description delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

//未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
    
    
    
}

- (void)didFinishedReceiveOfflineMessages
{
    [self setupUnreadMessageCount];
}

#pragma mark - IChatManagerDelegate 消息变化

- (void)didUpdateConversationList:(NSArray *)conversationList
{
    [self setupUnreadMessageCount];
    //    [_chatListVC refreshDataSource];
}

-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].callManager removeDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo)
    {
        if ([self.navigationController.topViewController isKindOfClass:[ChatViewController class]]) {
            ChatViewController *chatController = (ChatViewController *)self.navigationController.topViewController;
            [chatController hideImagePicker];
        }
        
        NSArray *viewControllers = self.navigationController.viewControllers;
        [viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            if (obj != self)
            {
                if (![obj isKindOfClass:[ChatViewController class]])
                {
                    [self.navigationController popViewControllerAnimated:NO];
                }
                else
                {
                    NSString *conversationChatter = userInfo[kConversationChatter];
                    ChatViewController *chatViewController = (ChatViewController *)obj;
                    if (![chatViewController.chatter isEqualToString:conversationChatter])
                    {
                        [self.navigationController popViewControllerAnimated:NO];
                        EMMessageType messageType = [userInfo[kMessageType] intValue];
                        chatViewController = [[ChatViewController alloc] initWithChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
                        switch (messageType) {
                            case eMessageTypeGroupChat:
                            {
                                NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
                                for (EMGroup *group in groupArray) {
                                    if ([group.groupId isEqualToString:conversationChatter]) {
                                        chatViewController.title = group.groupSubject;
                                        break;
                                    }
                                }
                            }
                                break;
                            default:
                                chatViewController.title = conversationChatter;
                                break;
                        }
                        [self.navigationController pushViewController:chatViewController animated:NO];
                    }
                    *stop= YES;
                }
            }
            else
            {
                ChatViewController *chatViewController = (ChatViewController *)obj;
                NSString *conversationChatter = userInfo[kConversationChatter];
                EMMessageType messageType = [userInfo[kMessageType] intValue];
                chatViewController = [[ChatViewController alloc] initWithChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
                switch (messageType) {
                    case eMessageTypeGroupChat:
                    {
                        NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
                        for (EMGroup *group in groupArray) {
                            if ([group.groupId isEqualToString:conversationChatter]) {
                                chatViewController.title = group.groupSubject;
                                break;
                            }
                        }
                    }
                        break;
                    default:
                        chatViewController.title = conversationChatter;
                        break;
                }
                [self.navigationController pushViewController:chatViewController animated:NO];
            }
        }];
    }
    else if (_chatListVC)
    {
        [self.navigationController popToViewController:self animated:NO];
        [self setSelectedViewController:_chatListVC];
    }
}

- (EMConversationType)conversationTypeFromMessageType:(EMMessageType)type
{
    EMConversationType conversatinType = eConversationTypeChat;
    switch (type) {
        case eMessageTypeChat:
            conversatinType = eConversationTypeChat;
            break;
        case eMessageTypeGroupChat:
            conversatinType = eConversationTypeGroupChat;
            break;
        case eMessageTypeChatRoom:
            conversatinType = eConversationTypeChatRoom;
            break;
        default:
            break;
    }
    return conversatinType;
}

- (void)didAutoReconnectFinishedWithError:(NSError *)error{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *showreconnect = [ud objectForKey:@"identifier_showreconnect_enable"];
    if (showreconnect && [showreconnect boolValue]) {
        [self hideHud];
        if (error) {
            [self showHint:NSLocalizedString(@"reconnection.fail", @"reconnection failure, later will continue to reconnection")];
        }else{
            [self showHint:NSLocalizedString(@"reconnection.success", @"reconnection successful！")];
        }
    }
}


-(void)didReceiveCmdMessage:(EMMessage *)message
{
    [self showHint:NSLocalizedString(@"receiveCmd", @"receive cmd message")];
}

- (void)playSoundAndVibration{
    
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
    
    //创建一个消息对象
    NSNotification *chatListCenter = [NSNotification notificationWithName:@"chatListVCMessage" object:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:chatListCenter];
    
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        NSString *title = [[UserProfileManager sharedInstance] getNickNameWithUsername:message.from];
        if (message.messageType == eMessageTypeGroupChat) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversationChatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        else if (message.messageType == eMessageTypeChatRoom)
        {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:@"username" ]];
            NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
            NSString *chatroomName = [chatrooms objectForKey:message.conversationChatter];
            if (chatroomName)
            {
                title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, chatroomName];
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.messageType] forKey:kMessageType];
    [userInfo setObject:message.conversationChatter forKey:kConversationChatter];
    notification.userInfo = userInfo;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}


- (void)_removeBuddies:(NSArray *)userNames
{
    [[EaseMob sharedInstance].chatManager removeConversationsByChatters:userNames deleteMessages:YES append2Chat:YES];
    //    [_chatListVC refreshDataSource];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    ChatViewController *chatViewContrller = nil;
    for (id viewController in viewControllers)
    {
        if ([viewController isKindOfClass:[ChatViewController class]] && [userNames containsObject:[(ChatViewController *)viewController chatter]])
        {
            chatViewContrller = viewController;
            break;
        }
    }
    if (chatViewContrller)
    {
        [viewControllers removeObject:chatViewContrller];
        [self.navigationController setViewControllers:viewControllers animated:YES];
    }
    [self showHint:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"delete", @"delete"), userNames[0]]];
}
#pragma mark - ICallManagerDelegate

- (void)callSessionStatusChanged:(EMCallSession *)callSession changeReason:(EMCallStatusChangedReason)reason error:(EMError *)error
{
    if (callSession.status == eCallSessionStatusConnected)
    {
        EMError *error = nil;
        do {
            BOOL isShowPicker = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isShowPicker"] boolValue];
            if (isShowPicker) {
                error = [EMError errorWithCode:EMErrorInitFailure andDescription:NSLocalizedString(@"call.initFailed", @"Establish call failure")];
                break;
            }
            
            if (![self canRecord]) {
                error = [EMError errorWithCode:EMErrorInitFailure andDescription:NSLocalizedString(@"call.initFailed", @"Establish call failure")];
                break;
            }
            
#warning 在后台不能进行视频通话
            if(callSession.type == eCallSessionTypeVideo && ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive || ![CallViewController canVideo])){
                error = [EMError errorWithCode:EMErrorInitFailure andDescription:NSLocalizedString(@"call.initFailed", @"Establish call failure")];
                break;
            }
            
            if (!isShowPicker){
                [[EaseMob sharedInstance].callManager removeDelegate:self];
                CallViewController *callController = [[CallViewController alloc] initWithSession:callSession isIncoming:YES];
                callController.modalPresentationStyle = UIModalPresentationOverFullScreen;
                [self presentViewController:callController animated:NO completion:nil];
                if ([self.navigationController.topViewController isKindOfClass:[ChatViewController class]])
                {
                    ChatViewController *chatVc = (ChatViewController *)self.navigationController.topViewController;
                    chatVc.isInvisible = YES;
                }
            }
        } while (0);
        
        if (error) {
            [[EaseMob sharedInstance].callManager asyncEndCall:callSession.sessionId reason:eCallReasonHangup];
            return;
        }
    }
}

- (void)didReceiveGroupRejectFrom:(NSString *)groupId
                          invitee:(NSString *)username
                           reason:(NSString *)reason
{
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.beRefusedToAdd", @"you are shameless refused by '%@'"), username];
    TTAlertNoTitle(message);
}


- (void)didReceiveAcceptApplyToJoinGroup:(NSString *)groupId
                               groupname:(NSString *)groupname
{
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"group.agreedAndJoined", @"agreed to join the group of \'%@\'"), groupname];
    [self showHint:message];
}

#pragma mark - IChatManagerDelegate 收到聊天室邀请

- (void)didReceiveChatroomInvitationFrom:(NSString *)chatroomId
                                 inviter:(NSString *)username
                                 message:(NSString *)message
{
    message = [NSString stringWithFormat:NSLocalizedString(@"chatroom.somebodyInvite", @"%@ invite you to join chatroom \'%@\'"), username, chatroomId];
    [self showHint:message];
}

#pragma mark - IChatManagerDelegate 登录状态变化

- (void)didLoginFromOtherDevice
{
    //    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginAtOtherDevice", @"your login account has been in other places") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    //        alertView.tag = 100;
    //        [alertView show];
    //
    //    } onQueue:nil];
}

- (void)didRemovedFromServer
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginUserRemoveFromServer", @"your account has been removed from the server side") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        alertView.tag = 101;
        [alertView show];
    } onQueue:nil];
}

- (void)didServersChanged
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
}

- (void)didAppkeyChanged
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
}

#pragma mark - 自动登录回调

- (void)willAutoReconnect{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *showreconnect = [ud objectForKey:@"identifier_showreconnect_enable"];
    if (showreconnect && [showreconnect boolValue]) {
        [self hideHud];
        [self showHint:NSLocalizedString(@"reconnection.ongoing", @"reconnecting...")];
    }
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
