//
//  PeopleViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "PeopleViewController.h"
#import "SVPullToRefresh.h"
#import "PeopleTableViewCell.h"
#import "FansModel.h"
#import "MyUserInfoManager.h"
#import "ToUserManager.h"
#import "OtherUserInforViewController.h"
#import "ChatViewController.h"
#import "ChineseToPinyin.h"
#import "UserRootViewController.h"
#import "UserProfileManager.h"
#import "TTTAttributedLabel.h"
#import "NewUserMainPageViewController.h"
static NSString* UserCellIdentifier = @"PepleTableViewCellIdentifier";

@interface PeopleViewController ()<UITableViewDelegate,UITableViewDataSource,ChatViewControllerDelegate,TTTAttributedLabelDelegate,TTTAttributedLabel>
{
    NSMutableArray *sortedArray;
    UIImageView *navBarHairlineImageView;
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;

}
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic)  NSMutableArray *myTalkArray;
@property (strong, nonatomic) NSMutableArray *contactsSource;
//@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *textArray;
@property (strong, nonatomic) NSMutableArray *sectionTitles;


@end

@implementation PeopleViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _contactsSource = [NSMutableArray array];
        _sectionTitles = [NSMutableArray array];
        _textArray = [NSMutableArray array];
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor =  CCCUIColorFromHex(0xf7f7f7);
    self.dataArray = [[NSMutableArray alloc] init];
    _myTalkArray  = [NSMutableArray array];
    
    
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    
    //    [self initializeData];
    

    // 隐藏导航下的线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
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
//    WithoutInternetImage.hidden = YES ;
//    tryAgainButton.hidden = YES;
    
    [self.view addSubview:WithoutInternetImage];
    [self.view addSubview:tryAgainButton];
    
    [self initializePageSubviews];

    


}

- (void)tryAgainButton:(id )sender {
    
    [self initializePageSubviews];
    
}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏导航下的线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

    self.navigationController.navigationBarHidden = NO;
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    navBarHairlineImageView.hidden = YES;
    
    [MobClick beginLogPageView:@"PeopleViewController"];


}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
    [MobClick endLogPageView:@"PeopleViewController"];

}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark -fetchDataWithIsLoadingMore
- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    
    if ([_ifgroup isEqualToString:@"1"]) {
        
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"groupId":_groupId,
                              @"token":[MyUserInfoManager shareInstance].token,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              };
        self.requestURL = LKB_Group_ALLUsers_Url;
        
    }
    
    else
    {
        
        self.requestParas = @{@"userId":_userId,
                              @"ownerId":[MyUserInfoManager shareInstance].userId,
                              @"token":[MyUserInfoManager shareInstance].token,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)
                              };
        
        NSLog(@"###################################%@",self.requestUrl);
        self.requestURL = self.requestUrl;
        
    }
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        if (!isLoadingMore) {
    //            [self.tableView.pullToRefreshView stopAnimating];
    //        }
    //        else {
    ////            [self.dataArray addObject:[NSNull null]];
    //            [self.tableView.infiniteScrollingView stopAnimating];
    //        }
    //        [self.tableView reloadData];
    //    });
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (_dataArray.count == 0) {
        return 1;
        
    }else {

    return [self.textArray count];
    
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_dataArray.count == 0) {
        return 1;

    }else {
    
        return [[self.textArray objectAtIndex:(section)] count];

    }

}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (_dataArray.count == 0) {
        return CGFLOAT_MIN;
    }
    else {
    
        if ( [[self.textArray objectAtIndex:(section)] count] == 0|| [self.textArray objectAtIndex:(section)] == [NSNull null]||[self.textArray objectAtIndex:(section)]==nil)
        {
            return CGFLOAT_MIN;
        }
        else{
            return 22;
        }

        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_dataArray.count == 0) {
        return CGFLOAT_MIN;
    }
    else {

    
    return CGFLOAT_MIN;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_dataArray.count == 0) {
        return nil;
        
    }
    else {
    
        if ( [[self.textArray objectAtIndex:(section)] count] == 0)
        {
            return nil;
        }
        else{
            UIView *contentView = [[UIView alloc] init];
            contentView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
            label.font = [UIFont systemFontOfSize:11];
            label.textColor = CCCUIColorFromHex(0xaaaaaa);
            [label setText:[self.sectionTitles objectAtIndex:(section )]];
            [contentView addSubview:label];
            return contentView;
            
        }

    }
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



- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    return [_sectionTitles indexOfObject:title];
}

#pragma mark - private

- (NSMutableArray *)sortDataArray:(NSMutableArray *)dataArray
{
    
    //建立索引的核心
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    [self.sectionTitles removeAllObjects];
    [_textArray removeAllObjects];
  
    
    
    [self.sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    //    [self.sectionTitles insertObject:@"圈主" atIndex:0];
    //    NSLog(@"=sectionTitles===============%@",self.sectionTitles);
    
    //返回27，是a－z和＃
    NSInteger highSection = [self.sectionTitles count];
    //tableView 会被分成27个section
    sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i <= highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    
    //名字分section
    for (peopeleModel *buddy in dataArray) {
        
        NSString *firstLetter;
        
        //        if ([buddy.userName isEqualToString:@"vivian"]) {
        //            firstLetter = @"圈主";
        //        }else
        //        {
        //getuseName是实现中文拼音检索的核心，见NameIndex类
        
        //        NSLog(@"====userName=====%@",buddy.userName);
        firstLetter = [ChineseToPinyin pinyinFromChineseString:buddy.userName];
        
        //        NSLog(@"======firstLetter====%@",firstLetter);
        
        
        if (!firstLetter||[firstLetter isEqualToString:@""]) {
            firstLetter = @"#";
            
        }
        
        //        }
        //
        NSInteger section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
        
        NSMutableArray *array = [sortedArray objectAtIndex:section];
        [array addObject:buddy];
        
        
    }
    
    //每个section内的数组排序
    for (int i = 0; i < [sortedArray count]; i++) {
        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(peopeleModel *obj1, peopeleModel *obj2) {
            //getuseName是实现中文拼音检索的核心，见NameIndex类
            //            NSLog(@"*******************=============%@",[[UserProfileManager sharedInstance] getNickNameWithUsername:obj1.userName]);
            NSString *firstLetter1 = [ChineseToPinyin pinyinFromChineseString:[[UserProfileManager sharedInstance] getNickNameWithUsername:obj1.userName]];
            
            if (!firstLetter1||[firstLetter1 isEqualToString:@""]) {
                firstLetter1 = @"#";
                
            }
            
            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
            
            NSString *firstLetter2 = [ChineseToPinyin pinyinFromChineseString:[[UserProfileManager sharedInstance] getNickNameWithUsername:obj2.userName]];
            
            if (!firstLetter2||[firstLetter2 isEqualToString:@""]) {
                firstLetter2 = @"#";
                
            }
            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
            
            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
        }];
        
        
        [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
    }
    
    for (peopeleModel *buddy in sortedArray) {
        {
            [self.textArray addObject:buddy];
        }
    }
    //    NSLog(@"======textArray=============%@",_textArray);
    
    return sortedArray;
    
}



#pragma mark - dataSource

- (void)reloadDataSource
{
    [self sortDataArray:self.dataArray];
    
    [_tableView reloadData];
    
    
}


//#pragma mark -get dataSource from datebase
//-(void)getDataSourceFromDb{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        _contactsSource =   [ContactsDao queryData];
//        NSLog(@"=========%@======",_contactsSource);
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self sortDataArray:self.contactsSource];
//            [_tableView reloadData];
//        });
//    });
//
//}




- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (!request.isLoadingMore) {
        [self.tableView.pullToRefreshView stopAnimating];
    } else {
        [self.tableView.infiniteScrollingView stopAnimating];
    }
    
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        
        
        if ([errorMessage isEqualToString:@"没有网络，连接失败"]) {
            
            [self.tableView removeFromSuperview];
            WithoutInternetImage.hidden = NO;
            tryAgainButton.hidden = NO;
            
            
        }
        
        return;
    }

    if ([request.url isEqualToString:LKB_Attention_Users_Url]) {
        
        FansModel *fansmodel = (FansModel *)parserObject;
        //        peopeleModel *fansmodel = (peopeleModel *)parserObject;
        
        NSLog(@"————————————————————————————————————————%@",fansmodel.data);
        
        NSLog(@"<<<<<<<<<<————————————————————————————————————————%@",[fansmodel.data valueForKey:@"userId"]);
        
        NSMutableArray * fansmodelArr= [NSMutableArray arrayWithArray:fansmodel.data];
        
        peopeleModel * peopleModel;
        for (peopeleModel *model  in fansmodel.data) {
            
            NSLog(@"*-------------------%@",model);
            NSLog(@"*-------------------%@",model.userId);
            
            if ([model.userId isEqualToString:_questionUserId]) {
                
                peopleModel = model;
                
            }
        }
        
        [fansmodelArr removeObject:peopleModel];
        NSArray * myArray = [fansmodelArr copy];
        
        if (!request.isLoadingMore) {
            
            if ([_ifshare isEqualToString:@"2"]) {
                
                _dataArray = [NSMutableArray arrayWithArray:myArray];
                
            }
            else {
                
                _dataArray = [NSMutableArray arrayWithArray:fansmodel.data];
                
            }
            
            
            
            [self reloadDataSource];
        } else {
            
            if (_dataArray.count<fansmodel.num) {
                if ([_ifshare isEqualToString:@"2"]) {
                    
                    [_dataArray addObjectsFromArray:myArray];
                    
                }
                else {
                    [_dataArray addObjectsFromArray:fansmodel.data];
                }
                
                [self reloadDataSource];
            }
        }
        
        [self.tableView reloadData];
        
    }
    
    if ([request.url isEqualToString:LKB_Invite_answer]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        
        if ([replymodel.success isEqualToString:@"1"]) {
            
            [self ShowProgressHUDwithMessage:@"邀请成功"];
            
        }

    }
    
    else if ([request.url isEqualToString:LKB_Attention_All_Fans_Url]) {
        FansModel *fansmodel = (FansModel *)parserObject;
        if (!request.isLoadingMore) {
            
            
            _dataArray = [NSMutableArray arrayWithArray:fansmodel.data];
            [self reloadDataSource];
        } else {
            
            
            if (_dataArray.count<fansmodel.num) {
                [_dataArray addObjectsFromArray:fansmodel.data];
            }
            
            
            [self reloadDataSource];
            
        }
        
        [self.tableView reloadData];
        
    }
    
    else if ([request.url isEqualToString:LKB_Group_ALLUsers_Url]) {
        FansModel *fansmodel = (FansModel *)parserObject;
        if (!request.isLoadingMore) {
            
            
            _dataArray = [NSMutableArray arrayWithArray:fansmodel.data];
            
            
            [self reloadDataSource];
        } else {
            
            
            if (_dataArray.count<fansmodel.num) {
                [_dataArray addObjectsFromArray:fansmodel.data];
                
                [self reloadDataSource];
            }
        }
        
        [self.tableView reloadData];
        
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



- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count == 0) {
        
        return KDeviceHeight;
    }else {
        
        return 55;

    }
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString *CELLNONE = @"CELLNONE";

    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView * loadingImage = [[UIImageView alloc]init];

        if ([_VCType isEqualToString:@"1"]) {
            // 关注
            loadingImage.image = [UIImage imageNamed:@"Concerned-about-people"];

        }
        else {
            // 粉丝
            loadingImage.image = [UIImage imageNamed:@"No-fans"];

            
        }
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );
        
        [cell addSubview:loadingImage];
        return cell;
    }

    PeopleTableViewCell* simplescell = [tableView dequeueReusableCellWithIdentifier:UserCellIdentifier];

    if (indexPath.row < self.dataArray.count) {
        
        
        peopeleModel *model = [[self.textArray objectAtIndex:(indexPath.section )]objectAtIndex:indexPath.row];
        
        NSLog(@"------------------------%@",self.textArray);
        //        friendDetailModel *model = [[self.textArray objectAtIndex:(indexPath.section )] objectAtIndex:indexPath.row];
        
        //        peopeleModel *model = (peopeleModel *)_dataArray[indexPath.row];
        
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (model.avatar==nil) {
            model.avatar = @"";
        }
        if (model.userName==nil) {
            model.userName = model.userName;
        }
        NSDictionary *mydic = @{@"userName":model.userName,
                                @"userAvatar":model.avatar
                                };
        NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
        [userDefaults setObject:dic  forKey:model.userId];
        
        [simplescell configPeopleCellWithModel:model];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return simplescell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArray.count) {
        //        peopeleModel *findPeoleModel = (peopeleModel *)_dataArray[indexPath.row];
        peopeleModel *findPeoleModel = [[self.textArray objectAtIndex:(indexPath.section )]objectAtIndex:indexPath.row];
        _userName = findPeoleModel.userName;
        _ownerId = findPeoleModel.userId;
        
        NSLog(@"-------------------------%@",_userName);
        NSLog(@"-------------------------%@",_ownerId);
        
        if ([_ifshare isEqualToString:@"2"]) {
            // 邀请
            self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"objectId":_questionId,
                                  @"receiveUserId":_ownerId,
                                  @"token":[[MyUserInfoManager shareInstance]token]
                                  };
            self.requestURL = LKB_Invite_answer;
            
            
        }
        else if ([_ifshare isEqualToString:@"3"]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否分享到这里" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alert show];
            
        }
        
        else
        {
            [ToUserManager shareInstance].userName = findPeoleModel.userName;
            [ToUserManager shareInstance].userId = findPeoleModel.userId;
            //        OtherUserInforViewController *otherVC =[[OtherUserInforViewController alloc]init];
            //        OtherRootViewController * otherVC =[[OtherRootViewController alloc]init];
            
            
            NSLog(@"++++++++++++++++++++++++++++++%@",findPeoleModel.userId);
            
//            UserRootViewController *otherVC = [[UserRootViewController alloc]init];
//            otherVC.type = @"2";
//            otherVC.toUserId = [ToUserManager shareInstance].userId;
//            otherVC.userAvatar = findPeoleModel.avatar;
//            otherVC.toName = findPeoleModel.userName;
//            [self.navigationController pushViewController:otherVC animated:YES];
            
            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
            peopleVC.type = @"2";
            peopleVC.toUserId = [ToUserManager shareInstance].userId;
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];

        }
    }
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        
        
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:_ownerId isGroup:NO];
        
        chatVC.delelgate  = self;
        [chatVC sendShareMessage:_shareDes withIfShare:_shareType];
        
        //                        [chatVC sendTextMessage:_shareDes];
        
        
        chatVC.title = _userName;
        chatVC.ifShare = YES;
        
        [self.navigationController pushViewController:chatVC animated:YES];
        self.hidesBottomBarWhenPushed=YES;
        
        //            [self.navigationController popViewControllerAnimated:YES];
        
        [self ShowProgressHUDwithMessage:@"分享成功"];
        
        
    }
}



#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
    
    [self fetchDataWithIsLoadingMore:NO];

}



#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[PeopleTableViewCell class] forCellReuseIdentifier:UserCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //右侧索引列表的颜色
        _tableView.sectionIndexColor = CCCUIColorFromHex(0x999999);
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        
    }
    return _tableView;
}




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




#pragma mark - Page subviews
//- (void)initializeData
//{
//    self.dataArray = [[NSMutableArray alloc] init];
//    for (NSInteger i = 0; i < 10; i++) {
//        [self.dataArray addObject:[NSNull null]];
//    }
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
