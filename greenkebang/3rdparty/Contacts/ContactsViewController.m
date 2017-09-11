/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "ContactsViewController.h"
#import "FriendModel.h"
#import "RealtimeSearchUtil.h"
#import "ChineseToPinyin.h"
#import "SVPullToRefresh.h"
#import "EMSearchBar.h"
#import "SRRefreshView.h"
#import "EMSearchDisplayController.h"
#import "AddFriendViewController.h"
#import "ApplyViewController.h"
#import "GroupListViewController.h"
#import "ChatViewController.h"
#import "MyChatroomListViewController.h"
#import "ChatroomListViewController.h"
#import "RobotListViewController.h"
#import "UserProfileManager.h"
#import "PeopleTableViewCell.h"
#import "UIImageView+EMWebCache.h"
#import "MyUserInfoManager.h"
#import "ContactsDao.h"
#import "UserGroupViewController.h"

static NSString* CellIdentifier = @"PepleTableViewCellIdentifier";

@implementation friendDetailModel (search)

//根据用户昵称进行搜索
- (NSString*)showName
{
    return [[UserProfileManager sharedInstance] getNickNameWithUsername:self.userName];
}

@end

@interface ContactsViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UIActionSheetDelegate,IChatManagerDelegate,ChatViewControllerDelegate>
{
    NSIndexPath *_currentLongPressIndex;
}

@property (strong, nonatomic) NSMutableArray *contactsSource;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *textArray;
@property (strong, nonatomic) NSMutableArray *sectionTitles;

@property (strong, nonatomic) UILabel *unapplyCountLabel;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) EMSearchBar *searchBar;
@property (strong, nonatomic) SRRefreshView *slimeView;
@property (strong, nonatomic) GroupListViewController *groupController;

@property (strong, nonatomic) EMSearchDisplayController *searchController;

@end

@implementation ContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
        _contactsSource = [NSMutableArray array];
        _sectionTitles = [NSMutableArray array];
        _textArray = [NSMutableArray array];
        [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"通讯录";
    //    _textArray = [NSMutableArray array];
    //    _dataSource = [NSMutableArray array];
    //    _contactsSource = [NSMutableArray array];
    //    _sectionTitles = [NSMutableArray array];
    [self initializePageSubviews];
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    
    
    //    [self searchController];
    self.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    //    [self.view addSubview:self.searchBar];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.tableView];
    //    [self.tableView addSubview:self.slimeView];
    
    
    // 环信UIdemo中有用到Parse, 加载用户好友个人信息
    [[UserProfileManager sharedInstance] loadUserProfileInBackgroundWithBuddy:self.contactsSource saveToLoacal:YES completion:NULL];
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)dealloc
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}
#pragma mark - getter

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[EMSearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.placeholder = NSLocalizedString(@"search", @"Search");
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
    }
    
    return _searchBar;
}

- (UILabel *)unapplyCountLabel
{
    if (_unapplyCountLabel == nil) {
        _unapplyCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 5, 20, 20)];
        _unapplyCountLabel.textAlignment = NSTextAlignmentCenter;
        _unapplyCountLabel.font = [UIFont systemFontOfSize:11];
        _unapplyCountLabel.backgroundColor = [UIColor redColor];
        _unapplyCountLabel.textColor = [UIColor whiteColor];
        _unapplyCountLabel.layer.cornerRadius = _unapplyCountLabel.frame.size.height / 2;
        _unapplyCountLabel.hidden = YES;
        _unapplyCountLabel.clipsToBounds = YES;
    }
    
    return _unapplyCountLabel;
}


//- (UITableView *)tableView
//{
//    if (_tableView == nil)
//    {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.tableFooterView = [[UIView alloc] init];
//    }
//
//    return _tableView;
//}

#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[PeopleTableViewCell class] forCellReuseIdentifier:CellIdentifier];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (EMSearchDisplayController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak ContactsViewController *weakSelf = self;
        [_searchController setCellForRowAtIndexPathCompletion:^PeopleTableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *CellIdentifier = @"ContactListCell";
            PeopleTableViewCell *cell = (PeopleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (cell == nil) {
                cell = [[PeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            friendDetailModel *buddy = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            cell.imageView.image = [UIImage imageNamed:@"chatListCellHead.png"];
            //            cell.textLabel.text = buddy.userName;
            cell.nameLable.text= buddy.userName;
//            cell.adressLable.text = buddy.singleDescription;
            
            return cell;
        }];
        
        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return 50;
        }];
        
        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            friendDetailModel *buddy = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
            NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
            if (loginUsername && loginUsername.length > 0) {
                if ([loginUsername isEqualToString:buddy.userName]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notChatSelf", @"can't talk to yourself") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                    [alertView show];
                    
                    return;
                }
            }
            
            [weakSelf.searchController.searchBar endEditing:YES];
            ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:buddy.userName isGroup:NO];
            chatVC.title = [[UserProfileManager sharedInstance] getNickNameWithUsername:buddy.userName];
            [weakSelf.navigationController pushViewController:chatVC animated:YES];
        }];
    }
    
    return _searchController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.textArray count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
        //        return 1;
    }
    
    return [[self.textArray objectAtIndex:(section - 1) ] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeopleTableViewCell *cell;
    
    
    cell = (PeopleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    if (cell == nil) {
        cell = [[PeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendCell"];
    }
    if (indexPath.section == 0 ) {
        if (indexPath.row==0) {
            cell.imageView.image = [UIImage imageNamed:@"mygroup"];
            cell.textLabel.text = @"我的群组";
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
        }else if(indexPath.row==1)
        {
            cell.imageView.image = [UIImage imageNamed:@"groupnotice"];
            cell.textLabel.text = @"加群通知";
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    
    if(indexPath.section!=0){
        PeopleTableViewCell* mycell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (mycell == nil) {
            mycell = [[PeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if (indexPath.section < self.textArray.count) {
            friendDetailModel *buddy = [[self.textArray objectAtIndex:(indexPath.section - 1)]objectAtIndex:indexPath.row];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            if (buddy.avatar==nil) {
                buddy.avatar = @"";
            }
            if (buddy.userName==nil) {
                buddy.userName = buddy.userName;
            }
            
            NSDictionary *mydic = @{@"userName":buddy.userName,
                                    @"userAvatar":buddy.avatar
                                    };
            NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
            [userDefaults setObject:dic  forKey:buddy.userId];
            NSArray *array = [self.textArray objectAtIndex:(indexPath.section-1)];
            if (indexPath.row<array.count) {
                [mycell configFriendCellWithModel:buddy];
            }
            
            [mycell setNeedsUpdateConstraints];
            [mycell updateConstraintsIfNeeded];
            
        }
        return mycell;
    }
    return cell;
    
}

////// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    if (indexPath.section == 0) {
//        return NO;
//        [self isViewLoaded];
//    }
//    return YES;
//}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
        friendDetailModel *buddy = [[self.textArray objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
        if ([buddy.userName isEqualToString:loginUsername]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notDeleteSelf", @"can't delete self") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
        
        EMError *error = nil;
        [[EaseMob sharedInstance].chatManager removeBuddy:buddy.userName removeFromRemote:YES error:&error];
        if (!error) {
            [[EaseMob sharedInstance].chatManager removeConversationByChatter:buddy.userName deleteMessages:YES append2Chat:YES];
            
            [tableView beginUpdates];
            [[self.dataSource objectAtIndex:(indexPath.section - 1)] removeObjectAtIndex:indexPath.row];
            [self.contactsSource removeObject:buddy];
            [tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView  endUpdates];
        }
        else{
            [self showHint:[NSString stringWithFormat:NSLocalizedString(@"deleteFailed", @"Delete failed:%@"), error.description]];
            [tableView reloadData];
        }
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || [[self.textArray objectAtIndex:(section - 1)] count] == 0|| [self.textArray objectAtIndex:(section-1)] == [NSNull null]||[self.textArray objectAtIndex:(section-1)]==nil)
    {
        return 0;
    }
    else{
        return 22;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 || [[self.textArray objectAtIndex:(section - 1)] count] == 0)
    {
        return nil;
    }
    else{
        UIView *contentView = [[UIView alloc] init];
        [contentView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
        label.backgroundColor = [UIColor clearColor];
        [label setText:[self.sectionTitles objectAtIndex:(section - 1)]];
        [contentView addSubview:label];
        return contentView;}
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray * existTitles = [NSMutableArray array];
    //section数组为空的title过滤掉，不显示
    for (int i = 0; i < [self.sectionTitles count]; i++) {
        if ([[self.textArray objectAtIndex:i] count] > 0) {
            [existTitles addObject:[self.sectionTitles objectAtIndex:i]];
        }
    }
    return existTitles;
}

//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    //传入 section title 和index 返回其应该对应的session序号。
//    //一般不需要写 默认section index 顺序与section对应。除非 你的section index数量或者序列与section不同才用修改
//    return index+1;
//
//
//}

//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count = 1;
    
    NSLog(@"%@-%ld",title,(long)index);
    
    for(NSString *character in _sectionTitles)
    {
        if([character isEqualToString:title])
        {
            return count;
        }
        count ++;
    }
    return 0;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0)
        {
            if (_groupController==nil) {
                _groupController = [[GroupListViewController alloc]initWithStyle:UITableViewStylePlain];
            }else{
                [_groupController reloadDataSource];
            }

            UserGroupViewController *groupVC = [[UserGroupViewController alloc]init];
            
            groupVC.therquestUrl = [MyUserInfoManager shareInstance].userId;
            [self.navigationController pushViewController:groupVC animated:YES];
        }
    }
    else{
        
        friendDetailModel *buddy = [[self.textArray objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *loginuseName = [loginInfo objectForKey:kSDKUsername];
        if (loginuseName && loginuseName.length > 0) {
            if ([loginuseName isEqualToString:buddy.userName]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notChatSelf", @"can't talk to yourself") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                [alertView show];
                
                return;
            }
        }
        
        
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:buddy.userId isGroup:NO];
        chatVC.delelgate = self;
        //        chatVC.title = buddy.userName;
        chatVC.title = [[UserProfileManager sharedInstance] getNickNameWithUsername:buddy.userName];
        
        
        
        chatVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatVC animated:YES];
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
    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.contactsSource searchText:(NSString *)searchText collationStringSelector:@selector(showName) resultBlock:^(NSArray *results) {
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

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex && _currentLongPressIndex) {
        friendDetailModel *buddy = [[self.textArray objectAtIndex:(_currentLongPressIndex.section - 1)] objectAtIndex:_currentLongPressIndex.row];
        [self hideHud];
        [self showHudInView:self.view hint:NSLocalizedString(@"wait", @"Pleae wait...")];
        
        __weak typeof(self) weakSelf = self;
        [[EaseMob sharedInstance].chatManager asyncBlockBuddy:buddy.userName relationship:eRelationshipBoth withCompletion:^(NSString *useName, EMError *error){
            typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf hideHud];
            if (!error)
            {
                //由于加入黑名单成功后会刷新黑名单，所以此处不需要再更改好友列表
            }
            else
            {
                [strongSelf showHint:error.description];
            }
        } onQueue:nil];
    }
    _currentLongPressIndex = nil;
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
//刷新列表
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    __weak ContactsViewController *weakSelf = self;
    [[[EaseMob sharedInstance] chatManager] asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        [weakSelf.slimeView endRefresh];
    } onQueue:nil];
}



#pragma mark - BaseTableCellDelegate

- (void)cellImageViewLongPressAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row >= 1) {
        // 群组，聊天室
        return;
    }
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginuseName = [loginInfo objectForKey:kSDKUsername];
    friendDetailModel *buddy = [[self.textArray objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
    if ([buddy.userName isEqualToString:loginuseName])
    {
        return;
    }
    
    _currentLongPressIndex = indexPath;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") destructiveButtonTitle:NSLocalizedString(@"friend.block", @"join the blacklist") otherButtonTitles:nil, nil];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark - private

- (NSMutableArray *)sortDataArray:(NSMutableArray *)dataArray
{
    
    [_dataSource removeAllObjects];
    //建立索引的核心
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    //    [self.sectionTitles removeAllObjects];
    
    [self.sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    NSLog(@"=sectionTitles===============%@",self.sectionTitles);
    
    //返回27，是a－z和＃
    NSInteger highSection = [self.sectionTitles count];
    //tableView 会被分成27个section
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i <= highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    
    //名字分section
    for (friendDetailModel *buddy in dataArray) {
        //getuseName是实现中文拼音检索的核心，见NameIndex类
        NSLog(@"*******************=============%@",[[UserProfileManager sharedInstance] getNickNameWithUsername:buddy.userName]);
        NSString *firstLetter = [ChineseToPinyin pinyinFromChineseString:[[UserProfileManager sharedInstance] getNickNameWithUsername:buddy.userName]];
        NSInteger section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
        
        NSMutableArray *array = [sortedArray objectAtIndex:section];
        [array addObject:buddy];
    }
    
    //每个section内的数组排序
    for (int i = 0; i < [sortedArray count]; i++) {
        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(friendDetailModel *obj1, friendDetailModel *obj2) {
            //getuseName是实现中文拼音检索的核心，见NameIndex类
            NSLog(@"*******************=============%@",[[UserProfileManager sharedInstance] getNickNameWithUsername:obj1.userName]);
            NSString *firstLetter1 = [ChineseToPinyin pinyinFromChineseString:[[UserProfileManager sharedInstance] getNickNameWithUsername:obj1.userName]];
            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
            
            NSString *firstLetter2 = [ChineseToPinyin pinyinFromChineseString:[[UserProfileManager sharedInstance] getNickNameWithUsername:obj2.userName]];
            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
            
            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
        }];
        
        
        [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
    }
    
    for (friendDetailModel *buddy in sortedArray) {
        {
            [self.textArray addObject:buddy];
        }
    }
    NSLog(@"======textArray=============%@",_textArray);
    
    return sortedArray;
    
}

#pragma mark - Page subviews获取数据
- (void)initializePageSubviews
{
    
    [self fetchDataWithIsLoadingMore:NO];
    
    if (self.dataSource.count == 0) {
        
    }
}


#pragma mark -fetchDataWithIsLoadingMore获取数据
- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          @"token":[MyUserInfoManager shareInstance].token,
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    
    self.requestURL = LKB_Attention_Users_Url;
    

    
}
#pragma mark -fetchDataWithIsLoadingMore获取数据
- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (!request.isLoadingMore) {
        //        [self.tableView.pullToRefreshView stopAnimating];
    } else {
        //        [self.tableView.infiniteScrollingView stopAnimating];
    }
    
    if (errorMessage) {
       [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    if ([request.url isEqualToString:LKB_Attention_Users_Url]) {
        FriendModel *fansmodel = (FriendModel *)parserObject;
        
        if (!request.isLoadingMore) {
            _dataSource = [NSMutableArray arrayWithArray:fansmodel.data];
        }
        
        [self reloadDataSource];
        
    }
    
}




#pragma mark - dataSource

- (void)reloadDataSource
{
    NSLog(@"============daasource%@=====",_dataSource);
    
    for (friendDetailModel *buddy in _dataSource) {
        {
            //            [self.contactsSource addObject:buddy];
            [ContactsDao insertData:buddy];
            
        }
    }
    [self getDataSourceFromDb];
    
    
    
    NSLog(@"============daasource%@=====",_dataSource);
    //    [self sortDataArray:self.contactsSource];
    
    NSLog(@"============daasource%@=====",self.contactsSource);
    [_tableView reloadData];
}

#pragma mark -get dataSource from datebase
-(void)getDataSourceFromDb{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _contactsSource =   [ContactsDao queryData];
        NSLog(@"=========%@======",_contactsSource);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self sortDataArray:self.contactsSource];
            [_tableView reloadData];
        });
    });
    
}

#pragma mark - action

- (void)reloadApplyView
{
    NSInteger count = [[[ApplyViewController shareController] dataSource] count];
    
    if (count == 0) {
        self.unapplyCountLabel.hidden = YES;
    }
    else
    {
        NSString *tmpStr = [NSString stringWithFormat:@"%i", (int)count];
        CGSize size = [tmpStr sizeWithFont:self.unapplyCountLabel.font constrainedToSize:CGSizeMake(50, 20) lineBreakMode:NSLineBreakByWordWrapping];
        CGRect rect = self.unapplyCountLabel.frame;
        rect.size.width = size.width > 20 ? size.width : 20;
        self.unapplyCountLabel.text = tmpStr;
        self.unapplyCountLabel.frame = rect;
        self.unapplyCountLabel.hidden = NO;
    }
}

- (void)reloadGroupView
{
    
}


- (void)addFriendAction
{
    AddFriendViewController *addController = [[AddFriendViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:addController animated:YES];
}

//#pragma mark - EMChatManagerBuddyDelegate
//- (void)didUpdateBlockedList:(NSArray *)blockedList
//{
//    [self reloadDataSource];
//}

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


@end
