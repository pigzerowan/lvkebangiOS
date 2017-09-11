//
//  PeopleViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "CirclePeopleViewController.h"
#import "SVPullToRefresh.h"
#import "PeopleTableViewCell.h"
#import "FansModel.h"
#import "MyUserInfoManager.h"
#import "ToUserManager.h"
#import "OtherUserInforViewController.h"
#import "ChatViewController.h"
#import <UIImageView+WebCache.h>
#import "NewUserMainPageViewController.h"
static NSString* CirclePeopleCellIdentifier = @"CirclePeopleCellIdentifier";

//@interface CirclePeopleViewController ()<UITableViewDelegate,UITableViewDataSource>
//@property (strong, nonatomic) UITableView* tableView;
//@property (strong, nonatomic) NSMutableArray* dataArray;
//@property (strong, nonatomic)  NSMutableArray *myTalkArray;
//
//
//@end
//
//@implementation CirclePeopleViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
//    self.dataArray = [[NSMutableArray alloc] init];
//    _myTalkArray  = [NSMutableArray array];
//    
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
//    //    [self.navigationController.navigationBar addSubview:backBtn];
//    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
//    
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(editMyCircelPeople)];
//
//    ;
//    
//    //    [self initializeData];
//    [self initializePageSubviews];
//    // Do any additional setup after loading the view.
//}
//
//
//-(void)editMyCircelPeople{
//}
//
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    self.navigationController.navigationBarHidden = NO;
//}
//
//-(void)backToMain
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark -fetchDataWithIsLoadingMore
//- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
//{
//    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
//    if (!isLoadingMore) {
//        currPage = 1;
//    } else {
//        ++ currPage;
//    }
//    
//    
//        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
//                              @"groupId":_groupId,
//                              @"token":[MyUserInfoManager shareInstance].token,
//                              @"page":@(currPage),
//                              isLoadingMoreKey:@(isLoadingMore)
//                              };
//        self.requestURL = LKB_Group_ALLUsers_Url;
//        
//
//}
//
//
//
//- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
//              errorMessage:(NSString *)errorMessage
//{
//    if (!request.isLoadingMore) {
//        [self.tableView.pullToRefreshView stopAnimating];
//    } else {
//        [self.tableView.infiniteScrollingView stopAnimating];
//    }
//
//
//    
//  if ([request.url isEqualToString:LKB_Group_ALLUsers_Url]) {
//        FansModel *fansmodel = (FansModel *)parserObject;
//        if (!request.isLoadingMore) {
//            
//            
//            _dataArray = [NSMutableArray arrayWithArray:fansmodel.data];
//        } else {
//            
//            
//            if (_dataArray.count<fansmodel.num) {
//                [_dataArray addObjectsFromArray:fansmodel.data];
//            }
//        }
//        
//        [self.tableView reloadData];
//        if (fansmodel.data.count == 0) {
//            [self.tableView.infiniteScrollingView endScrollAnimating];
//        } else {
//            self.tableView.showsInfiniteScrolling = YES;
//            [self.tableView.infiniteScrollingView beginScrollAnimating];
//            
//        }
//    }
//    
//    
//    
//    
//}
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
//{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.dataArray.count;
//}
//- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 8;
//}
//- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 80;
//}
//
//- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
//{
//    return CGFLOAT_MIN;
//}
//- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    PeopleTableViewCell* simplescell = [tableView dequeueReusableCellWithIdentifier:CirclePeopleCellIdentifier];
//    if (indexPath.row < self.dataArray.count) {
//        
//        peopeleModel *model = (peopeleModel *)_dataArray[indexPath.row];
//        
//        
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        if (model.avatar==nil) {
//            model.avatar = @"";
//        }
//        if (model.userName==nil) {
//            model.userName = model.userName;
//        }
//        NSDictionary *mydic = @{@"userName":model.userName,
//                                @"userAvatar":model.avatar
//                                };
//        NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
//        [userDefaults setObject:dic  forKey:model.userId];
//        
//        
//        [simplescell configPeopleCellWithModel:model];
//        [simplescell setNeedsUpdateConstraints];
//        [simplescell updateConstraintsIfNeeded];
//    }
//    return simplescell;
//}
//- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row < self.dataArray.count) {
//        peopeleModel *findPeoleModel = (peopeleModel *)_dataArray[indexPath.row];
//        _userName = findPeoleModel.userName;
//        _ownerId = findPeoleModel.userId;
//
//            
//    }
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否分享到这里" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            
//            [alert show];
//            
//         
//    
//}
//
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    if (buttonIndex == 0) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
//
//
//
//#pragma mark - Page subviews
//- (void)initializePageSubviews
//{
//    [self.view addSubview:self.tableView];
//    __weak __typeof(self) weakSelf = self;
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        
//        [weakSelf fetchDataWithIsLoadingMore:NO];
//        
//    }];
//    [self.tableView addInfiniteScrollingWithActionHandler:^{
//        [weakSelf fetchDataWithIsLoadingMore:YES];
//    }];
//    self.tableView.showsInfiniteScrolling = YES;
//    [self.tableView triggerPullToRefresh];
//    
//    if (self.dataArray.count == 0) {
////                LoveTableFooterView *footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
////                footerVew.addFriendBlock = ^(){
////                    NSLog(@"addFriendClicked");
////                };
////                self.tableView.tableFooterView = footerVew;
//    }
//}
//
//
//
//#pragma mark - Getters & Setters
//- (UITableView*)tableView
//{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStyleGrouped];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [_tableView registerClass:[PeopleTableViewCell class] forCellReuseIdentifier:CirclePeopleCellIdentifier];
//    }
//    return _tableView;
//}
//


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

//static NSString* UserCellIdentifier = @"PepleTableViewCellIdentifier";

@interface CirclePeopleViewController ()<UITableViewDelegate,UITableViewDataSource,ChatViewControllerDelegate,TTTAttributedLabelDelegate,TTTAttributedLabel>

{
    peopeleModel *CircleOwner;
    NSMutableArray *sortedArray;
}
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic)  NSMutableArray *myTalkArray;
@property (strong, nonatomic) NSMutableArray *contactsSource;
//@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *textArray;
@property (strong, nonatomic) NSMutableArray *sectionTitles;
@property (copy, nonatomic) NSString *requestType;
@property (strong, nonatomic) NSMutableArray *titleArray;
@end

@implementation CirclePeopleViewController


//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        _contactsSource = [NSMutableArray array];
//        _sectionTitles = [NSMutableArray array];
//        _textArray = [NSMutableArray array];
//        
//    }
//    return self;
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
    self.dataArray = [[NSMutableArray alloc] init];

    _contactsSource = [NSMutableArray array];
    _sectionTitles = [NSMutableArray array];
    _textArray = [NSMutableArray array];
    
    
    [self fetchDataWithIsLoadingMore:NO];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;

    [self initializePageSubviews];
    

    // Do any additional setup after loading the view.
}


- (void)toedit
{
    //编辑模式
    [self.tableView setEditing:YES animated:YES];
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(toNotedit)];
    
}

-(void)toNotedit
{
     [self.tableView setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"管理" style:UIBarButtonItemStyleDone target:self action:@selector(toedit)];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [MobClick beginLogPageView:@"CirclePeopleViewController"];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"CirclePeopleViewController"];
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
    

     [_sectionTitles removeAllObjects];
    [_dataArray removeAllObjects];
    [_textArray  removeAllObjects];
    
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"groupId":_groupId,
                              @"token":[MyUserInfoManager shareInstance].token,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(NO)
                              };
     self.RequestPostWithChcheURL = LKB_Group_ALLUsers_Url;

}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%d打印看看是多少",[self.textArray count]+1);
    // Return the number of sections.
    return [self.textArray count]+1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
        //        return 1;
    }else
    {
    return [[self.textArray objectAtIndex:(section - 1) ] count];
    }

    
//    return [[self.textArray objectAtIndex:(section-1)] count];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if ( [[self.textArray objectAtIndex:(section)] count] == 0|| [self.textArray objectAtIndex:(section)] == [NSNull null]||[self.textArray objectAtIndex:(section)]==nil)
//    {
//        return CGFLOAT_MIN;
//    }
//    else{
//        return 22;
//    }
 
    
    
    if (section>0) {
        if ([[self.textArray objectAtIndex:(section - 1)] count] == 0|| [self.textArray objectAtIndex:(section-1)] == [NSNull null]||[self.textArray objectAtIndex:(section-1)]==nil)
        {
            return CGFLOAT_MIN;
        }
    }
    if (section==0) {
        return 22;
    }
    
    else{
        return 22;
    }
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return CGFLOAT_MIN;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
//    if (section>0) {
//
//        
//    if ( [[self.textArray objectAtIndex:(section)] count] == 0)
//    {
//        return nil;
//    }
//    }
    
    if(section==0)
    {
        UIView *contentView = [[UIView alloc] init];
       contentView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = CCCUIColorFromHex(0xaaaaaa);
        label.font = [UIFont systemFontOfSize:12];
        [label setText:@"圈主"];
        [contentView addSubview:label];
        return contentView;
    }

    
    else{
        
        if ( [[self.textArray objectAtIndex:(section-1)] count] == 0)
        {
            return nil;
        }
        
        else
        {
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = CCCUIColorFromHex(0xaaaaaa);
        [label setText:[self.sectionTitles objectAtIndex:(section-1)]];
        [contentView addSubview:label];
        return contentView;
        }
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    _titleArray = [NSMutableArray array];
    //section数组为空的title过滤掉，不显示
    for (int i = 0; i < [self.sectionTitles count]; i++) {
        if ([[self.textArray objectAtIndex:i] count] > 0) {
            [_titleArray addObject:[self.sectionTitles objectAtIndex:i]];
        }
    }
    
    [_titleArray insertObject:@"圈主" atIndex:0];
    
    return _titleArray;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {

    NSMutableArray *myArray = [NSMutableArray arrayWithArray:_sectionTitles];
    
    [myArray insertObject:@"圈主" atIndex:0];
    
    return [myArray indexOfObject:title];
}

//删除cell操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    peopeleModel *object = self.textArray[indexPath.section-1][indexPath.row];;
    
    
    http://192.168.1.199:8082/app/agriculture/member/remove?userId=110&token=68bc42cdeded4077a3e37a4bc125b3d1&memberId=126&groupId=78
    
    
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"groupId":_groupId,
                          @"token":[MyUserInfoManager shareInstance].token,
                          @"memberId":object.userId
                          };
    self.requestURL = LKB_Group_DLEATEUser_Url;

    
    [self.dataArray removeObject:object];
    
    [_sectionTitles removeAllObjects];
    [_textArray removeAllObjects];

    
    [self  reloadDataSource];
    [_tableView reloadData];
}

//哪几行可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        return NO;
    }
    if ([CircleOwner.userId isEqualToString:[[MyUserInfoManager shareInstance]userId]]) {
        return YES;
    }
    
    else{
        
        return NO;
    }
}

//哪几行可以移动(可移动的行数小于等于可编辑的行数)
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


////响应点击索引时的委托方法  跟上面两个方法都可以。
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    NSInteger count = 1;
//    
////    NSLog(@"%@-%ld",title,(long)index);
//    
//
//    for(NSString *character in _sectionTitles)
//    {
//        if([character isEqualToString:title])
//        {
//            return count;
//        }
//        count ++;
//    }
//    return 0;
//}



#pragma mark - private

- (NSMutableArray *)sortDataArray:(NSMutableArray *)dataArray
{
    
    //建立索引的核心
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
 
    [self.sectionTitles removeAllObjects];
    [_textArray removeAllObjects];
    [_titleArray removeAllObjects];

    
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
    
    
    if ([_requestType isEqualToString:@"1"]) {
        NSLog(@"不刷新界面");
    }
    
//     [self.tableView.pullToRefreshView stopAnimating];
    else
    {
    
        if (errorMessage) {
            
            [XHToast showTopWithText:errorMessage topOffset:60.0];
            return;
        }
    
      if ([request.url isEqualToString:LKB_Group_ALLUsers_Url]) {
        FansModel *fansmodel = (FansModel *)parserObject;
//        if (!request.isLoadingMore) {
          
          CircleOwner = fansmodel.object;
          
          if ([CircleOwner.userId isEqualToString:[[MyUserInfoManager shareInstance]userId]]) {
                    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"管理" style:UIBarButtonItemStyleDone target:self action:@selector(toedit)];
          }else
          {
              
          }
          
          
            _dataArray = [NSMutableArray arrayWithArray:fansmodel.data];
            

          

            [self reloadDataSource];
//        } else {
          
            
//            if (_dataArray.count<fansmodel.num) {
//                [_dataArray addObjectsFromArray:fansmodel.data];
            
//                [self reloadDataSource];
//            }
//        }
        
        [self.tableView reloadData];
        
    }
    
    
    if ([request.url isEqualToString:LKB_Group_DLEATEUser_Url]) {

     LKBBaseModel *model = (LKBBaseModel *)parserObject;
    
        NSLog(@"看看打出什么字来%@",model.msg);
        
        if ([model.code isEqualToString:@"2000"]) {
            [XHToast showTopWithText:model.msg];
            _requestType = @"1";
        }
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"groupId":_groupId,
                              @"token":[MyUserInfoManager shareInstance].token,
                              @"page":@(1),
                              };
        self.RequestPostWithChcheURL = LKB_Group_ALLUsers_Url;
    
    }
    }
}





- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    
    
    UITableViewCell *cell;
    
    
    cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
 
    
    
    if (indexPath.section == 0 ) {
        
      cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendCell"];
        }
        
        

          UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 40, 40)];
                headImageView.clipsToBounds = YES;
                headImageView.layer.masksToBounds = YES;
                headImageView.layer.cornerRadius = 20;
                headImageView.contentMode = UIViewContentModeScaleAspectFill;
        
       [headImageView sd_setImageWithURL:[CircleOwner.avatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];

        UIImageView *biaojiLable = [[UIImageView alloc]initWithFrame:CGRectMake(60, 20, 32, 18)];
//        biaojiLable.textAlignment = NSTextAlignmentCenter;
//        [biaojiLable setFont:[UIFont systemFontOfSize:12]];
//        biaojiLable.text = @"圈主";
//        biaojiLable.textColor = [UIColor whiteColor];
//        biaojiLable.backgroundColor = [UIColor LkbgreenColor];
        [biaojiLable setImage:[UIImage imageNamed:@"CircleHomer"]];
        
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 100, 40)];
        nameLable.text = CircleOwner.userName;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:headImageView];
        [cell addSubview:biaojiLable];
        [cell addSubview:nameLable];
    }

//    PeopleTableViewCell* mycell = [tableView dequeueReusableCellWithIdentifier:CirclePeopleCellIdentifier];
    
    
    
    if(indexPath.section!=0){
        PeopleTableViewCell* mycell = [tableView dequeueReusableCellWithIdentifier:CirclePeopleCellIdentifier];
        mycell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (mycell == nil) {
            mycell = [[PeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CirclePeopleCellIdentifier];
        }
        
        if (indexPath.section < self.textArray.count) {
            peopeleModel *buddy = [[self.textArray objectAtIndex:(indexPath.section-1 )]objectAtIndex:indexPath.row];
            [mycell configPeopleCellWithModel:buddy];
            [mycell setNeedsUpdateConstraints];
            [mycell updateConstraintsIfNeeded];
            
        }
        return mycell;
    }
    return cell;


}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section==0) {
        
//        UserRootViewController *otherVC = [[UserRootViewController alloc]init];
//        
//        if ([CircleOwner.userId isEqualToString:[[MyUserInfoManager shareInstance]userId]]) {
//           
//        }else
//        {
//         otherVC.type = @"2";
//        otherVC.toUserId = CircleOwner.userId;
//        otherVC.userAvatar = CircleOwner.avatar;
//        otherVC.toName = CircleOwner.userName;
//        [self.navigationController pushViewController:otherVC animated:YES];
//        }
        
        
        NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
        
        
        if ([CircleOwner.userId isEqualToString:[[MyUserInfoManager shareInstance]userId]]) {
            
        }else
        {
            peopleVC.type = @"2";
            peopleVC.toUserId = CircleOwner.userId;
            peopleVC.userAvatar = CircleOwner.avatar;
            peopleVC.toName = CircleOwner.userName;
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
        }


        
    }
    
    
    else
    {
    if (indexPath.row < self.dataArray.count) {
        //        peopeleModel *findPeoleModel = (peopeleModel *)_dataArray[indexPath.row];
        peopeleModel *findPeoleModel = [[self.textArray objectAtIndex:(indexPath.section -1)]objectAtIndex:indexPath.row];
        
        
        _userName = findPeoleModel.userName;
        _ownerId = findPeoleModel.userId;
        
    
//            UserRootViewController *otherVC = [[UserRootViewController alloc]init];
//            otherVC.type = @"2";
//            otherVC.toUserId = findPeoleModel.userId;
//            otherVC.userAvatar = findPeoleModel.avatar;
//            otherVC.toName = findPeoleModel.userName;
//            [self.navigationController pushViewController:otherVC animated:YES];
        NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
        peopleVC.type = @"2";
        peopleVC.toUserId = findPeoleModel.userId;
        peopleVC.userAvatar = findPeoleModel.avatar;
        peopleVC.toName = findPeoleModel.userName;
        peopleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:peopleVC animated:YES];

    }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}



#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
//        __weak __typeof(self) weakSelf = self;
//        [self.tableView addPullToRefreshWithActionHandler:^{
//    
//            [weakSelf fetchDataWithIsLoadingMore:NO];
//    
//        }];


}



#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [_tableView registerClass:[PeopleTableViewCell class] forCellReuseIdentifier:CirclePeopleCellIdentifier];
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


//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
// 
//    _dataArray = nil;
//    sortedArray = nil;
//    _contactsSource = nil;
//    _sectionTitles = nil;
//    _textArray = nil;
//    _titleArray = nil;
//}



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






/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
