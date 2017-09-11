//
//  TalkRootViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 8/26/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "TalkRootViewController.h"
#import "ChatViewController.h"
#import "PopoverView.h"
#import "SRRefreshView.h"
#import "ChatListCell.h"
#import "EMSearchBar.h"
#import "NSDate+Category.h"
#import "RealtimeSearchUtil.h"
#import "ChatViewController.h"
#import "EMSearchDisplayController.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "RobotManager.h"
#import "UserProfileManager.h"
#import "RobotChatViewController.h"
#import "ContactsViewController.h"
#import <UIImageView+WebCache.h>
#import "MyUserInfoManager.h"
#import "ShowMyGroupBaseViewController.h"
#import "SecretModel.h"
#import "LittleSecruitViewController.h"
#import "SearchRootViewController.h"
@implementation EMConversation (search)

//根据用户昵称,环信机器人名称,群名称进行搜索
- (NSString*)showName
{
    if (self.conversationType == eConversationTypeChat) {
        if ([[RobotManager sharedInstance] isRobotWithUsername:self.chatter]) {
            return [[RobotManager sharedInstance] getRobotNickWithUsername:self.chatter];
        }
        return [[UserProfileManager sharedInstance] getNickNameWithUsername:self.chatter];
    } else if (self.conversationType == eConversationTypeGroupChat) {
        if ([self.ext objectForKey:@"groupSubject"] || [self.ext objectForKey:@"isPublic"]) {
            return [self.ext objectForKey:@"groupSubject"];
        }
    }
    return self.chatter;
}

@end

@interface TalkRootViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate,SRRefreshDelegate, UISearchBarDelegate, IChatManagerDelegate,ChatViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray        *dataSource;
@property (strong, nonatomic)NSMutableArray *array;
@property (nonatomic, strong) EMSearchBar           *searchBar;
@property (nonatomic, strong) SRRefreshView         *slimeView;
@property (nonatomic, strong) UIView                *networkStateView;
@property (nonatomic, strong) NSIndexPath*                indexPath;

@property (strong, nonatomic) EMSearchDisplayController *searchController;
@end

@implementation TalkRootViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//     self.title = @"消息";
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor = [UIColor redColor];
//    btn.frame = CGRectMake(100, 100, 100, 60);
//    [btn setTitle:@"单聊页面" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
////    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:@"8001" password:@"111111" withCompletion:^(NSString *username, NSString *password, EMError *error) {
////        if (!error) {
////            NSLog(@"注册成功");
////        }
////    } onQueue:nil];
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//- (void)btnClick
//{
//    ChatViewController *cvc = [[ChatViewController alloc] initWithChatter:@"13575701832" isGroup:NO];
//    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:cvc];
//    nc.navigationBar.backgroundColor = [UIColor LkbgreenColor];
//    [self presentViewController:nc animated:YES completion:nil];
//    
//}

//- (void)showTabBar
//
//{
//    if (self.tabBarController.tabBar.hidden == NO)
//    {
//        return;
//    }
//    UIView *contentView;
//    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
//        
//        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
//    
//    else
//        
//        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
//    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
//    self.tabBarController.tabBar.hidden = NO;
//    
//}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    [self removeEmptyConversationsFromDB];
    

    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.slimeView];
    [self networkStateView];
    
    [self searchController];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshDataSource];
    [self registerNotifications];

    [MobClick beginLogPageView:@"TalkRootViewController"];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self unregisterNotifications];
    [MobClick endLogPageView:@"TalkRootViewController"];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self registerNotifications];
//    self.tabBarController.tabBar.hidden = NO;
}


- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.conversationType == eConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}

- (void)removeChatroomConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (conversation.conversationType == eConversationTypeChatRoom) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}


#pragma mark - getter

- (SRRefreshView *)slimeView
{
    if (!_slimeView) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
        _slimeView.backgroundColor = [UIColor whiteColor];
    }
    
    return _slimeView;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[EMSearchBar alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = NSLocalizedString(@"search", @"Search");
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
    }
    
    return _searchBar;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ChatListCell class] forCellReuseIdentifier:@"chatListCell"];
    }
    
    return _tableView;
}

- (EMSearchDisplayController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak TalkRootViewController *weakSelf = self;
        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *CellIdentifier = @"ChatListCell";
            ChatListCell *cell = (ChatListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (cell == nil) {
                cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            EMConversation *conversation = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            cell.name = conversation.chatter;
            if (conversation.conversationType == eConversationTypeChat) {
                cell.name = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.chatter];
                cell.placeholderImage = [UIImage imageNamed:@"chatListCellHead.png"];
            }
            else{
                NSString *imageName = @"groupPublicHeader";
                NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
                for (EMGroup *group in groupArray) {
                    if ([group.groupId isEqualToString:conversation.chatter]) {
                        cell.name = group.groupSubject;
                        imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
                        break;
                    }
                }
                cell.placeholderImage = [UIImage imageNamed:imageName];
            }
            cell.detailMsg = [weakSelf subTitleMessageByConversation:conversation];
            cell.time = [weakSelf lastMessageTimeByConversation:conversation];
            cell.unreadCount = [weakSelf unreadMessageCountByConversation:conversation];
            if (indexPath.row % 2 == 1) {
                cell.contentView.backgroundColor = UIColorWithRGBA(246, 246, 246, 1);
            }else{
                cell.contentView.backgroundColor = [UIColor whiteColor];
            }
            return cell;
        }];
        
        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];
        }];
        
        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [weakSelf.searchController.searchBar endEditing:YES];
            
            EMConversation *conversation = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            ChatViewController *chatController;
            if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.chatter]) {
                chatController = [[RobotChatViewController alloc] initWithChatter:conversation.chatter
                                                                 conversationType:conversation.conversationType];
                chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.chatter];
            }else {
                chatController = [[ChatViewController alloc] initWithChatter:conversation.chatter
                                                            conversationType:conversation.conversationType];
                chatController.title = [conversation showName];
            }

            [weakSelf.navigationController pushViewController:chatController animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
            [weakSelf.tableView reloadData];
        }];
    }
    
    return _searchController;
}

- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark - private

- (NSMutableArray *)loadDataSource
{
    NSMutableArray *ret = nil;
    NSMutableArray *conversations =[NSMutableArray arrayWithArray:[[EaseMob sharedInstance].chatManager conversations]] ;
    
    
    
    
    
    for ( EMConversation *conversation in conversations) {
        
        if (conversation.conversationType == eConversationTypeGroupChat) {
            [conversations removeObject:conversation];
        }
    }
//
//    
//    
//    NSMutableArray *conversations =
//    [NSMutableArray arrayWithArray:dataArray] ;
    
    
//    NSLog(@"==============%@===========",conversations);
//    
//
//    NSArray * array = [NSArray arrayWithArray: conversations];
//    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSArray *myAttentionArray = [userDefault objectForKey:@"myAttention"];
//     for (EMConversation *obj333 in array) {
//         
//         if (obj333.conversationType ==eConversationTypeChat) {
//             [conversations enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                 if ([myAttentionArray indexOfObject:obj333.chatter] == NSNotFound) {
//                     *stop = YES;
//                     if (*stop == YES) {
//                         
//                         [conversations removeObject:obj333];
//                         
//                     }
//                 }
//                 
//                 if (*stop) {
//                     
//                     NSLog(@"array is %@",conversations);
//                     
//                 }
//             }];
//         }
//
//}
    

    NSArray* sorte = [conversations sortedArrayUsingComparator:
                      ^(EMConversation *obj1, EMConversation* obj2){
                          EMMessage *message1 = [obj1 latestMessage];
                          EMMessage *message2 = [obj2 latestMessage];
                          if(message1.timestamp > message2.timestamp) {
                              return(NSComparisonResult)NSOrderedAscending;
                          }else {
                              return(NSComparisonResult)NSOrderedDescending;
                          }
                      }];
    
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    return ret;
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
//    NSDictionary *dic = conversation.latestMessage.ext;
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到最后消息图片
-(NSString *)lastMessageImgByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";

    EMMessage *lastMessage = conversation.latestMessage;
    
    NSDictionary *dic = lastMessage.ext;
   
    if (conversation.conversationType == eConversationTypeChat) {
        if (dic) {
            ret = dic[@"userAvatar"];
            NSLog(@"==========%@=========",dic[@"userId"]);
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:dic  forKey:lastMessage.from];
    }

    }
    return ret;
}

// 得到最后消息名字
-(NSString *)lastMessageNameByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    NSDictionary *dic = lastMessage.ext;
    if (dic) {
        ret = dic[@"userName"] ;
    }
    
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
//NSDictionary *dic = conversation.latestMessage.ext;
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    return  ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
//    NSDictionary *dic = conversation.latestMessage.ext;
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                ret = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                if ([[RobotManager sharedInstance] isRobotMenuMessage:lastMessage]) {
                    ret = [[RobotManager sharedInstance] getRobotMenuMessageDigest:lastMessage];
                } else {
                    
                    if ([didReceiveText rangeOfString:@"shareType"].location!=NSNotFound ) {
                        ret = @"分享消息";
                    }
                    else
                    {
                    ret = didReceiveText;
                    }
                }
            } break;
            case eMessageBodyType_Voice:{
                ret = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                ret = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                ret = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            default: {
            } break;
        }
    }
    
    return ret;
}

#pragma mark - TableViewDelegate & TableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"chatListCell";

    

    
    
    ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row];

    if (conversation.conversationType == eConversationTypeChat) {
        
        NSString *str =[self lastMessageImgByConversation:conversation];
        cell.imageURL = str;
        //     [cell.imageView sd_setImageWithURL:[str lkbImageUrl] placeholderImage:YQNormalPlaceImage];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *mydic = [userDefaults objectForKey:conversation.chatter];
        
        
        if (mydic) {
            cell.name = mydic[@"userName"];
            cell.imageURL = mydic[@"userAvatar"];
            NSLog(@"==============%@头像图片=======",cell.imageURL);
            
             [cell.imageView sd_setImageWithURL:[cell.imageURL lkbImageUrl4] placeholderImage:YQUserPlaceImage];
            cell.detailMsg = [self subTitleMessageByConversation:conversation];
            // NSString *imageUrl = mydic[@"headImg"];
            // [cell.imageView sd_setImageWithURL:[imageUrl lkbImageUrl] placeholderImage:nil];
        }
        else
        {
            cell.name = [self lastMessageNameByConversation:conversation];
            str =[self lastMessageImgByConversation:conversation];
            [cell.imageView sd_setImageWithURL:[str lkbImageUrl4] placeholderImage:YQUserPlaceImage];
            cell.detailMsg = [self subTitleMessageByConversation:conversation];
        }
        
        if (mydic[@"userName"]==nil) {
            cell.name = conversation.chatter;
            cell.imageURL = @"";
            if ([conversation.chatter isEqualToString:@"9999999"]) {
                cell.name = @"绿科邦小秘书";
                cell.imageView.image = YQNormalPlaceImage;
//                [cell.imageView setImage:LKBSecruitPlaceImage];
        
             
                NSLog(@"%@=============",conversation.latestMessageFromOthers.ext[@"title"]);
                
                 cell.detailMsg = conversation.latestMessageFromOthers.ext[@"title"];

            }

        }
        
//      cell.detailMsg = [self subTitleMessageByConversation:conversation];
        cell.time = [self lastMessageTimeByConversation:conversation];
        cell.unreadCount = [self unreadMessageCountByConversation:conversation];

        if (mydic) {
//            NSString *imageUrl = mydic[@"headImg"];
//            NSLog(@"============imageUrl=%@=======",imageUrl);
            
             cell.imageURL = mydic[@"userAvatar"];
            [cell.imageView sd_setImageWithURL:[mydic[@"userAvatar"] lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
        }else{
            NSString *str =[self lastMessageImgByConversation:conversation];
            [cell.imageView sd_setImageWithURL:[str lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
        }

    }
    if (conversation.conversationType == eConversationTypeGroupChat) {
        
//        cell.type = @"1";
        NSString *str =[self lastMessageImgByConversation:conversation];
        cell.imageURL = str;
        NSUserDefaults *userDefault = [[NSUserDefaults alloc]init];
        NSLog(@"=========群组ID====%@===========",conversation.chatter);
        NSDictionary *mydic = [userDefault objectForKey:conversation.chatter];
        if (mydic) {
            cell.name = mydic[@"userName"];
            NSLog(@"========名字======%@=======",mydic[@"userName"]);
            cell.imageURL = mydic[@"groupAvatar"];
             [cell.imageView sd_setImageWithURL:[cell.imageURL lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
            NSLog(@"========群组======%@头像图片=======",cell.imageURL);
            cell.detailMsg = [self subTitleMessageByConversation:conversation];
            // NSString *imageUrl = mydic[@"headImg"];
            // [cell.imageView sd_setImageWithURL:[imageUrl lkbImageUrl] placeholderImage:nil];
        }
        else
        {
            cell.name = [self lastMessageNameByConversation:conversation];
            str =[self lastMessageImgByConversation:conversation];
            [cell.imageView sd_setImageWithURL:[str lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
            cell.detailMsg = [self subTitleMessageByConversation:conversation];
        }
        
        cell.detailMsg = [self subTitleMessageByConversation:conversation];
        cell.time = [self lastMessageTimeByConversation:conversation];
        cell.unreadCount = [self unreadMessageCountByConversation:conversation];
    }
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];
    
    return 64;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *mydic = [userDefaults objectForKey:conversation.chatter];

        NSString *title = mydic[@"userName"];
    
    ChatViewController *chatController;
//    NSString *title = conversation.chatter;
    if (conversation.conversationType != eConversationTypeChat) {
        if ([[conversation.ext objectForKey:@"groupSubject"] length])
        {
            title = [conversation.ext objectForKey:@"groupSubject"];
        }
        else
        {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    title = group.groupSubject;
                    break;
                }
            }
              NSString *chatter = conversation.chatter;
            chatController = [[ChatViewController alloc] initWithChatter:chatter
                                                        conversationType:conversation.conversationType];
            chatController.delelgate = self;
              chatController.hidesBottomBarWhenPushed =YES;
//            self.hidesBottomBarWhenPushed = YES;
//            
//            
//            [self.navigationController pushViewController:chatController animated:YES];

        }
    } else if (conversation.conversationType == eConversationTypeChat) {
          NSString *chatter = conversation.chatter;
        title = [[UserProfileManager sharedInstance] getNickNameWithUsername:conversation.chatter];
        chatController = [[ChatViewController alloc] initWithChatter:chatter
                                                    conversationType:conversation.conversationType];
          chatController.hidesBottomBarWhenPushed =YES;

        
        
    }
    
    NSString *chatter = conversation.chatter;
    

    if ([[RobotManager sharedInstance] isRobotWithUsername:chatter]) {
        chatController = [[RobotChatViewController alloc] initWithChatter:chatter
                                                         conversationType:conversation.conversationType];
        chatController.delelgate = self;
        chatController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatController animated:YES];

        
//   chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:chatter];
    }else {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *mydic = [userDefaults objectForKey:conversation.chatter];
        NSString *title = mydic[@"userName"];
        
        if (mydic[@"userName"]==nil) {

            if ([conversation.chatter isEqualToString:@"9999999"]) {
                LittleSecruitViewController *  lalalal = [[LittleSecruitViewController alloc] init];
                lalalal.title = @"绿科帮小秘书";
                [conversation markAllMessagesAsRead:YES];
                
                NSMutableArray *timeArray = [NSMutableArray array];
                
               _array = [NSMutableArray array];
                NSArray *array1 = [conversation loadAllMessages];
                
                for ( int i = 0; i<array1.count; i++) {
                    EMMessage *mes = array1[i];
                    NSDictionary *dic= mes.ext;
                    [_array addObject:dic];
                    
                    long long obj = mes.timestamp;
                    NSString *str = [NSString stringWithFormat:@"%lld",obj];
                    
                    
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
                    [formatter setDateStyle:NSDateFormatterMediumStyle];
                    [formatter setTimeStyle:NSDateFormatterShortStyle];
                    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                    NSTimeInterval time=[str doubleValue]/1000;
                    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
                    
                    NSString *confromTimespStr = [formatter stringFromDate:detaildate];
                    
                    
                    NSString *timeStr = [NSString stringWithFormat:@"%@",confromTimespStr];
                    
                    
                    [timeArray addObject:timeStr];
                }
                NSLog(@"=======%@========",_array);
                NSLog(@"=======%@========",timeArray);
                lalalal.secretAarry = [NSMutableArray arrayWithArray:_array];
                lalalal.timeArray = [NSMutableArray arrayWithArray:timeArray];
                lalalal.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:lalalal animated:YES];
                
                
            }
           
        }

        else
        {
        chatController = [[ChatViewController alloc] initWithChatter:chatter
        conversationType:conversation.conversationType];
        chatController.title = title;
             chatController.type = @"0";
            chatController.delelgate = self;
            chatController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chatController animated:YES];
        }
 

    }
    
   }

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMConversation *converation = [self.dataSource objectAtIndex:indexPath.row];
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:converation.chatter deleteMessages:YES append2Chat:YES];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}




#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    __weak typeof(self) weakSelf = self;
    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.dataSource searchText:(NSString *)searchText collationStringSelector:@selector(showName) resultBlock:^(NSArray *results) {
        if (results) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.searchController.resultsSource removeAllObjects];
                [weakSelf.searchController.resultsSource addObjectsFromArray:results];
                [weakSelf.searchController.searchResultsTableView reloadData];
            });
        }
    }];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate
//刷新消息列表
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self refreshDataSource];
    [_slimeView endRefresh];
   
}

#pragma mark - IChatMangerDelegate

-(void)didUnreadMessagesCountChanged
{
    [self refreshDataSource];
    
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self refreshDataSource];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [_tableView reloadData];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - public

-(void)refreshDataSource
{
    self.dataSource = [self loadDataSource];
    [_tableView reloadData];
    [self hideHud];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        _tableView.tableHeaderView = _networkStateView;
    }
    else{
        _tableView.tableHeaderView = nil;
    }
    
}

- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == eEMConnectionDisconnected) {
        _tableView.tableHeaderView = _networkStateView;
    }
    else{
        _tableView.tableHeaderView = nil;
    }
}

- (void)willReceiveOfflineMessages{
    [self refreshDataSource];
    [_slimeView endRefresh];
    NSLog(NSLocalizedString(@"message.beginReceiveOffine", @"Begin to receive offline messages"));
}

- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages
{
    [self refreshDataSource];
  
}

- (void)didFinishedReceiveOfflineMessages{
    [self refreshDataSource];
    NSLog(NSLocalizedString(@"message.endReceiveOffine", @"End to receive offline messages"));
}

#pragma mark - ChatViewControllerDelegate

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *mydic = [userDefaults objectForKey:chatter];
//    if (mydic) {
    
        NSString *strr = mydic[@"userAvatar"];
    
//    }
    NSString *strrr = [NSString stringWithFormat:@"%@%@",LKB_USERHEADER_HTTP,strr];
    return strrr;
//    NSLog(@"======%@==========",chatter);
////        return @"http://img0.bdstatic.com/img/image/shouye/jianbihua0525.jpg";
//    NSString *strr = [NSString stringWithFormat:@"%@%@",LKB_IMAGEBASE_HTTP,[MyUserInfoManager shareInstance].avatar];
//    return strr;

//    return @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
    //    return nil;
}

// 根据环信id得到要显示用户名，如果返回nil，则默认显示环信id
- (NSString *)nickNameWithChatter:(NSString *)chatter{
    return chatter;
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
