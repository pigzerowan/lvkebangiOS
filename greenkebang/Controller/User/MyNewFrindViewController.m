//
//  MyNewFrindViewController.m
//  youqu
//
//  Created by 郑渊文 on 8/11/15.
//  Copyright (c) 2015 youqu. All rights reserved.
//

#import "MyNewFrindViewController.h"
#import "MyfriendTableViewCell.h"
#import "SVPullToRefresh.h"
#import "PeopleTableViewCell.h"
#import "pinyin.h"
#import "ChineseString.h"
#import <UIImageView+WebCache.h>
#import "ChineseToPinyin.h"
//#import "AddMyFrindViewController.h"
#import "BaseViewController.h"
//#import "MyFriendFirstPageViewController.h
static NSString* MyfriendCellIdentifier = @"MyfriendCellIdentifier";

@interface MyNewFrindViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *myLoveFriendArray;
//    NSMutableArray *stringsToSort;
    
    NSMutableArray *arr;
    NSMutableArray *arr1;
    NSMutableArray *arr2;
    NSMutableArray *arr3;
    NSMutableArray *arr4;
    NSMutableArray *arr5;
    NSMutableArray *arr6;
    NSMutableArray *arr7;
    NSMutableArray *arr8;
    NSMutableArray *arr9;
    NSMutableArray *arr10;
    NSMutableArray *arr11;
    NSMutableArray *arr12;
    NSMutableArray *arr13;
    NSMutableArray *arr14;
    NSMutableArray *arr15;
    NSMutableArray *arr16;
    NSMutableArray *arr17;
    NSMutableArray *arr18;
    NSMutableArray *arr19;
    NSMutableArray *arr20;
    NSMutableArray *arr21;
    NSMutableArray *arr22;
    NSMutableArray *arr23;
    NSMutableArray *arr24;
    NSMutableArray *arr25;
    NSMutableArray *arr26;
    NSMutableArray * recipes;
    
}
@property(nonatomic,strong)NSArray *key;
@property(nonatomic,strong)UITableView *myFriendTabView;
@property(nonatomic,strong)NSMutableArray *myFriendArray;
@property(nonatomic,strong)NSMutableArray *stringsToSort;
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic,strong)NSArray * searchResults;
@property(nonatomic,strong)NSMutableArray * frinedModelArray;
@property(nonatomic,strong)NSMutableDictionary * userInfoDic;

@end

@implementation MyNewFrindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"我的好友";
    
      [self initializePageSubviews];
    _frinedModelArray= [[NSMutableArray alloc]init];
    _userInfoDic= [[NSMutableDictionary alloc]init];
    _stringsToSort = [[NSMutableArray alloc]init];
    myLoveFriendArray=[[NSMutableArray alloc]init];
    arr26=[[NSMutableArray alloc]init];
    arr=[[NSMutableArray alloc]init];
    arr1=[[NSMutableArray alloc]init];
    arr2=[[NSMutableArray alloc]init];
    arr3=[[NSMutableArray alloc]init];
    arr4=[[NSMutableArray alloc]init];
    arr5=[[NSMutableArray alloc]init];
    arr6=[[NSMutableArray alloc]init];
    arr7=[[NSMutableArray alloc]init];
    arr8=[[NSMutableArray alloc]init];
    arr9=[[NSMutableArray alloc]init];
    arr10=[[NSMutableArray alloc]init];
    arr11=[[NSMutableArray alloc]init];
    arr12=[[NSMutableArray alloc]init];
    arr13=[[NSMutableArray alloc]init];
    arr14=[[NSMutableArray alloc]init];
    arr15=[[NSMutableArray alloc]init];
    arr16=[[NSMutableArray alloc]init];
    arr17=[[NSMutableArray alloc]init];
    arr18=[[NSMutableArray alloc]init];
    arr19=[[NSMutableArray alloc]init];
    arr20=[[NSMutableArray alloc]init];
    arr21=[[NSMutableArray alloc]init];
    arr22=[[NSMutableArray alloc]init];
    arr23=[[NSMutableArray alloc]init];
    arr24=[[NSMutableArray alloc]init];
    arr25=[[NSMutableArray alloc]init];
    _dic=[[NSMutableDictionary alloc]init];
    

//    _stringsToSort=[NSMutableArray arrayWithObjects:
//                   @"张三",
//                   @"李四",
//                   @"王二麻子",
//                   @"郑xx",
//                   @"徐xx",
//                   @"乔布斯",
//                   @"武松",
//                   @"陈xx",
//                   @"肖xx",
//                   @"李理",
//                   @"鸣人",
//                   @"佐助",
//                   @"张三",
//                   @"李四",
//                   @"王二麻子",
//                   @"郑ddd",
//                   @"徐dd",
//                   @"乔d斯",
//                   @"武松22",
//                   @"陈x2x",
//                   @"肖x的x",
//                   @"李理2",
//                   @"鸣人3",
//                   @"佐助d",
//                   @"爸爸",
//                   @"妈妈",
//                   @"阿哥",
//                   @"大爷",
//                   @"额",
//                   @"Fuck",
//                   @"哥哥",
//                   @"哈林",
//                   @"撸jj",
//                   @"欧巴",
//                   nil];
    
    
//    
//       NSMutableArray *chineseStringsArray=[NSMutableArray array];
//    for(int i=0;i<[_stringsToSort count];i++){
//        ChineseString *chineseString=[[ChineseString alloc]init];
//        
//        model.contactName=[NSString stringWithString:[_stringsToSort objectAtIndex:i]];
//        
//        if(chineseString.string==nil){
//            chineseString.string=@"";
//        }
//        
//        if(![chineseString.string isEqualToString:@""]){
//            NSString *pinYinResult=[NSString string];
//            for(int j=0;j<chineseString.string.length;j++){
//                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
//                
//                pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
//            }
//            chineseString.pinYin=pinYinResult;
//        }else{
//            chineseString.pinYin=@"";
//        }
//        [chineseStringsArray addObject:chineseString];
//    }
//    
//    //:按照拼音首字母对这些Strings进行排序
//    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
//    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
//    
//
//    [myLoveFriendArray addObject:@"我的群组"];
//    //Step3
//    NSLog(@"\n\n\n按照拼音首字母后的NSString数组");
//    for(int i=0;i<[chineseStringsArray count];i++){
//        //BOOL yy=YES;
//        ChineseString *chineseString=[chineseStringsArray objectAtIndex:i];
//        // NSLog(@"原String:%@----拼音首字母String:%@",chineseString.string,chineseString.pinYin);
//        NSString *str=[NSString stringWithFormat:@"%@",chineseString.pinYin];
//        NSString *s=[str substringToIndex:1];
//    
//        if ([myLoveFriendArray count]==0) {
//            [_dic removeObjectForKey:@"☆"];
//        }
//        else
//        {
//            [_dic setValue:myLoveFriendArray forKey:@"☆"];
//        }
//
//        
//        if ([s isEqualToString:@"A"]) {
//            [arr addObject:chineseString.string];
//        }
//        if ([arr count]==0) {
//            [_dic removeObjectForKey:@"A"];
//        }
//        else
//        {
//            [_dic setValue:arr forKey:@"A"];
//        }
//        
//        if ([s isEqualToString:@"B"]) {
//            [arr1 addObject:chineseString.string];
//        }
//        if ([arr1 count]==0) {
//            [_dic removeObjectForKey:@"B"];
//        }
//        else
//        {
//            [_dic setValue:arr1 forKey:@"B"];
//        }
//        
//        if ([s isEqualToString:@"C"]) {
//            [arr2 addObject:chineseString.string];
//        }
//        if ([arr2 count]==0) {
//            [_dic removeObjectForKey:@"C"];
//        }
//        else
//        {
//            [_dic setValue:arr2 forKey:@"C"];
//        }
//        
//        if ([s isEqualToString:@"D"]) {
//            [arr3 addObject:chineseString.string];
//        }
//        if ([arr3 count]==0) {
//            [_dic removeObjectForKey:@"D"];
//        }
//        else
//        {
//            [_dic setValue:arr3 forKey:@"D"];
//        }
//        
//        if ([s isEqualToString:@"E"]) {
//            [arr4 addObject:chineseString.string];
//        }
//        if ([arr4 count]==0) {
//            [_dic removeObjectForKey:@"E"];
//        }
//        else
//        {
//            [_dic setValue:arr4 forKey:@"E"];
//        }
//        
//        if ([s isEqualToString:@"F"]) {
//            [arr5 addObject:chineseString.string];
//        }
//        if ([arr5 count]==0) {
//            [_dic removeObjectForKey:@"F"];
//        }
//        else
//        {
//            [_dic setValue:arr5 forKey:@"F"];
//        }
//        
//        if ([s isEqualToString:@"G"]) {
//            [arr6 addObject:chineseString.string];
//        }
//        if ([arr6 count]==0) {
//            [_dic removeObjectForKey:@"G"];
//        }
//        else
//        {
//            [_dic setValue:arr6 forKey:@"G"];
//        }
//        
//        if ([s isEqualToString:@"H"]) {
//            [arr7 addObject:chineseString.string];
//        }
//        if ([arr7 count]==0) {
//            [_dic removeObjectForKey:@"H"];
//        }
//        else
//        {
//            [_dic setValue:arr7 forKey:@"H"];
//        }
//        
//        if ([s isEqualToString:@"I"]) {
//            [arr8 addObject:chineseString.string];
//        }
//        if ([arr8 count]==0) {
//            [_dic removeObjectForKey:@"I"];
//        }
//        else
//        {
//            [_dic setValue:arr8 forKey:@"I"];
//        }
//        
//        if ([s isEqualToString:@"J"]) {
//            [arr9 addObject:chineseString.string];
//        }
//        if ([arr9 count]==0) {
//            [_dic removeObjectForKey:@"J"];
//        }
//        else
//        {
//            [_dic setValue:arr9 forKey:@"J"];
//        }
//        
//        if ([s isEqualToString:@"K"]) {
//            [arr10 addObject:chineseString.string];
//        }
//        if ([arr10 count]==0) {
//            [_dic removeObjectForKey:@"K"];
//        }
//        else
//        {
//            [_dic setValue:arr10 forKey:@"K"];
//        }
//        
//        if ([s isEqualToString:@"L"]) {
//            [arr11 addObject:chineseString.string];
//        }
//        if ([arr11 count]==0) {
//            [_dic removeObjectForKey:@"L"];
//        }
//        else
//        {
//            [_dic setValue:arr11 forKey:@"L"];
//        }
//        
//        if ([s isEqualToString:@"M"]) {
//            [arr12 addObject:chineseString.string];
//        }
//        if ([arr12 count]==0) {
//            [_dic removeObjectForKey:@"M"];
//        }
//        else
//        {
//            [_dic setValue:arr12 forKey:@"M"];
//        }
//        
//        if ([s isEqualToString:@"N"]) {
//            [arr13 addObject:chineseString.string];
//        }
//        if ([arr13 count]==0) {
//            [_dic removeObjectForKey:@"N"];
//        }
//        else
//        {
//            [_dic setValue:arr13 forKey:@"N"];
//        }
//        
//        if ([s isEqualToString:@"O"]) {
//            [arr14 addObject:chineseString.string];
//        }
//        if ([arr14 count]==0) {
//            [_dic removeObjectForKey:@"O"];
//        }
//        else
//        {
//            [_dic setValue:arr14 forKey:@"O"];
//        }
//        
//        if ([s isEqualToString:@"P"]) {
//            [arr15 addObject:chineseString.string];
//        }
//        if ([arr15 count]==0) {
//            [_dic removeObjectForKey:@"P"];
//        }
//        else
//        {
//            [_dic setValue:arr15 forKey:@"P"];
//        }
//        
//        if ([s isEqualToString:@"Q"]) {
//            [arr16 addObject:chineseString.string];
//        }
//        if ([arr16 count]==0) {
//            [_dic removeObjectForKey:@"Q"];
//        }
//        else
//        {
//            [_dic setValue:arr16 forKey:@"Q"];
//        }
//        
//        if ([s isEqualToString:@"R"]) {
//            [arr17 addObject:chineseString.string];
//        }
//        if ([arr17 count]==0) {
//            [_dic removeObjectForKey:@"R"];
//        }
//        else
//        {
//            [_dic setValue:arr17 forKey:@"R"];
//        }
//        
//        if ([s isEqualToString:@"S"]) {
//            [arr18 addObject:chineseString.string];
//        }
//        if ([arr18 count]==0) {
//            [_dic removeObjectForKey:@"S"];
//        }
//        else
//        {
//            [_dic setValue:arr18 forKey:@"S"];
//        }
//        
//        if ([s isEqualToString:@"T"]) {
//            [arr19 addObject:chineseString.string];
//        }
//        if ([arr19 count]==0) {
//            [_dic removeObjectForKey:@"T"];
//        }
//        else
//        {
//            [_dic setValue:arr19 forKey:@"T"];
//        }
//        
//        if ([s isEqualToString:@"U"]) {
//            [arr20 addObject:chineseString.string];
//        }
//        if ([arr20 count]==0) {
//            [_dic removeObjectForKey:@"U"];
//        }
//        else
//        {
//            [_dic setValue:arr20 forKey:@"U"];
//        }
//        
//        if ([s isEqualToString:@"V"]) {
//            [arr21 addObject:chineseString.string];
//        }
//        if ([arr21 count]==0) {
//            [_dic removeObjectForKey:@"V"];
//        }
//        else
//        {
//            [_dic setValue:arr21 forKey:@"V"];
//        }
//        
//        if ([s isEqualToString:@"W"]) {
//            [arr22 addObject:chineseString.string];
//        }
//        if ([arr22 count]==0) {
//            [_dic removeObjectForKey:@"W"];
//        }
//        else
//        {
//            [_dic setValue:arr22 forKey:@"W"];
//        }
//        
//        if ([s isEqualToString:@"X"]) {
//            [arr23 addObject:chineseString.string];
//        }
//        if ([arr23 count]==0) {
//            [_dic removeObjectForKey:@"X"];
//        }
//        else
//        {
//            [_dic setValue:arr23 forKey:@"X"];
//        }
//        
//        if ([s isEqualToString:@"Y"]) {
//            [arr24 addObject:chineseString.string];
//        }
//        if ([arr24 count]==0) {
//            [_dic removeObjectForKey:@"Y"];
//        }
//        else
//        {
//            [_dic setValue:arr24 forKey:@"Y"];
//        }
//        if ([s isEqualToString:@"Z"]) {
//            [arr25 addObject:chineseString.string];
//        }
//        if ([arr25 count]==0) {
//            [_dic removeObjectForKey:@"Z"];
//        }
//        else
//        {
//            [_dic setValue:arr25 forKey:@"Z"];
//        }
//        
//    }
//    if (_myFriendArray.count!=0) {
//        
//        NSMutableArray *toTalKeyArray = [[NSMutableArray alloc]init];
//        NSArray *keyArray = [[_dic allKeys]sortedArrayUsingSelector:@selector(compare:)];
//        [toTalKeyArray addObjectsFromArray:keyArray];
//        [toTalKeyArray removeLastObject];
//        NSString *myLove = [keyArray objectAtIndex:keyArray.count-1];
//        [toTalKeyArray insertObject:myLove atIndex:0];
//        
//        _key=toTalKeyArray;
//    }
   
    
    
    
//    [[dic allKeys]sortedArrayUsingSelector:@selector(compare:)];
    [self.myFriendTabView reloadData];
    _myFriendArray = [NSMutableArray array];
//    _myFriendArray = [NSMutableArray arrayWithObjects:@"个人资料",@"密码重置",@"清理缓存",@"关于友趣", nil];
    self.title = @"我的好友";
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//
    
  
//    [self initSubViews];
    
    

    // Do any additional setup after loading the view.
}


#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Getters & Setters
- (UITableView*)myFriendTabView
{
    if (!_myFriendTabView) {
        _myFriendTabView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _myFriendTabView.delegate = self;
        _myFriendTabView.dataSource = self;
        _myFriendTabView.backgroundColor = [UIColor whiteColor];
        _myFriendTabView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_myFriendTabView registerClass:[PeopleTableViewCell class] forCellReuseIdentifier:MyfriendCellIdentifier];
    }
    return _myFriendTabView;
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    _searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
    
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        NSUInteger sec=[indexPath section];
        NSUInteger row=[indexPath row];
        NSString *key1=[_key objectAtIndex:sec];
        NSArray *name=[_dic objectForKey:key1];
    PeopleTableViewCell *myCell = (PeopleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyfriendCellIdentifier];
    if (myCell==nil) {
        myCell=[[PeopleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyfriendCellIdentifier];
    }
    myCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section < self.myFriendArray.count) {
        
        friendDetailModel *model = (friendDetailModel *)_myFriendArray[indexPath.row];
            if (tableView == self.searchDisplayController.searchResultsTableView) {
                myCell.nameLable.text = [_searchResults objectAtIndex:indexPath.row];
                if ([model.userName isEqualToString:[_searchResults objectAtIndex:indexPath.row]]) {
//                    [myCell configFriendCellWithModel:model];
                }
//
            }
                else {
                    friendDetailModel *model = (friendDetailModel *)_myFriendArray[indexPath.row];
                    NSLog(@"xxxxxxxxxxxxxxxxxxxxxxxx%@",model.userName);
                    
                    for (int i = 0; i<_myFriendArray.count; i++) {
                        while ([model.userName isEqualToString:[name objectAtIndex:row]]) {
                            [myCell configFriendCellWithModel:model];
                        }
                    }
//                    if ([model.contactName isEqualToString:[name objectAtIndex:row]]) {
//                        [myCell configFriendCellWithModel:model];
//                    }

                myCell.nameLable.text = [name objectAtIndex:row];
//              [myCell configFriendCellWithModel:model];
            }
        
        
        
        
            [myCell setNeedsUpdateConstraints];
            [myCell updateConstraintsIfNeeded];
    }

    
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        myCell.nameLable.text = [searchResults objectAtIndex:indexPath.row];
//        [myCell configPeopleCellWithModel:nil];
//    } else {
//        myCell.nameLable.text = [name objectAtIndex:row];
//        [myCell configPeopleCellWithModel:nil];
//    }
//    [myCell setNeedsUpdateConstraints];
//    [myCell updateConstraintsIfNeeded];

    return myCell;
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
    self.requestParas = @{@"userId":@(30),
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)};
    self.requestURL = LKB_Attention_All_Url;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!isLoadingMore) {
//            [self.myFriendTabView.pullToRefreshView stopAnimating];
//        }
//        else {
//            //            [self.dataArray addObject:[NSNull null]];
//            [self.myFriendTabView.infiniteScrollingView stopAnimating];
//        }
//        [self.myFriendTabView reloadData];
//    });
    
}


//- (NSMutableArray *)sortDataArray:(NSArray *)dataArray
//{
//    //建立索引的核心
//    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
//    
//    [self.sectionTitles removeAllObjects];
//    [self.sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
//    
//    //返回27，是a－z和＃
//    NSInteger highSection = [self.sectionTitles count];
//    //tableView 会被分成27个section
//    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
//    for (int i = 0; i <= highSection; i++) {
//        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
//        [sortedArray addObject:sectionArray];
//    }
//    
//    //名字分section
//    for (friendDetailModel *buddy in dataArray) {
//        //getuseName是实现中文拼音检索的核心，见NameIndex类
//        NSLog(@"*******************=============%@",[[UserProfileManager sharedInstance] getNickNameWithUsername:buddy.userName]);
//        NSString *firstLetter = [ChineseToPinyin pinyinFromChineseString:[[UserProfileManager sharedInstance] getNickNameWithUsername:buddy.userName]];
//        NSInteger section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
//        
//        NSMutableArray *array = [sortedArray objectAtIndex:section];
//        [array addObject:buddy];
//    }
//    
//    //每个section内的数组排序
//    for (int i = 0; i < [sortedArray count]; i++) {
//        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(friendDetailModel *obj1, friendDetailModel *obj2) {
//            NSString *firstLetter1 = [ChineseToPinyin pinyinFromChineseString:[[UserProfileManager sharedInstance] getNickNameWithUsername:obj1.userName]];
//            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
//            
//            NSString *firstLetter2 = [ChineseToPinyin pinyinFromChineseString:[[UserProfileManager sharedInstance] getNickNameWithUsername:obj2.userName]];
//            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
//            
//            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
//        }];
//        
//        
//        [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
//    }
//    
//    return sortedArray;
//}



- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (!request.isLoadingMore) {
        [self.myFriendTabView.pullToRefreshView stopAnimating];
    } else {
        [self.myFriendTabView.infiniteScrollingView stopAnimating];
    }
    
    if (errorMessage) {
       [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    if ([request.url isEqualToString:LKB_Attention_All_Url]) {
        FriendModel *friendsmodel = (FriendModel *)parserObject;
        if (!request.isLoadingMore) {
            _myFriendArray = [NSMutableArray arrayWithArray:friendsmodel.data];
            
  

            [_myFriendTabView reloadData];

            
        } else {
            [_myFriendArray addObjectsFromArray:friendsmodel.data];
        }
        [self.myFriendTabView reloadData];
        if (friendsmodel.data.count == 0) {
            [self.myFriendTabView.infiniteScrollingView endScrollAnimating];
        } else {
            self.myFriendTabView.showsInfiniteScrolling = YES;
            [self.myFriendTabView.infiniteScrollingView beginScrollAnimating];
            
        }
        
        for (int i=0; i<_myFriendArray.count;i++) {
            friendDetailModel *model = (friendDetailModel *)_myFriendArray[i];
            [_stringsToSort addObject:model.userName];
            
//            [[NSUserDefaults standardUserDefaults] setObject:model forKey:_stringsToSort[i]];
//
            [_userInfoDic setValue:model forKey:_stringsToSort[i]];
            NSLog(@"===========_userInfoDic===========%@",_userInfoDic);
        }
        
        
        NSMutableArray *chineseStringsArray=[NSMutableArray array];
        for(int i=0;i<[_stringsToSort count];i++){
            ChineseString *chineseString=[[ChineseString alloc]init];
            chineseString.string=[NSString stringWithString:[_stringsToSort objectAtIndex:i]];
            
            if(chineseString.string==nil){
                chineseString.string=@"";
            }
            
            if(![chineseString.string isEqualToString:@""]){
                NSString *pinYinResult=[NSString string];
                for(int j=0;j<chineseString.string.length;j++){
                    NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                    
                    pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                chineseString.pinYin=pinYinResult;
            }else{
                chineseString.pinYin=@"";
            }
            [chineseStringsArray addObject:chineseString];
//            
//            for (int i=0;i <_myFriendArray.count; i++) {
//                NSDictionary* test = [[NSDictionary alloc]init];
//                
//                NSArray* keys = [test allKeys];
//                for (NSString* chineseString in keys) {
//                    [test valueForKey:chineseString];
//                }
//                NSLog(@"======================%@",test);
//            }
        }
        
        //:按照拼音首字母对这些Strings进行排序
        NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
        [chineseStringsArray sortUsingDescriptors:sortDescriptors];
        
        
        [myLoveFriendArray addObject:@"我的群组"];
        //Step3
        NSLog(@"\n\n\n按照拼音首字母后的NSString数组");
        for(int i=0;i<[chineseStringsArray count];i++){
            //BOOL yy=YES;
            ChineseString *chineseString=[chineseStringsArray objectAtIndex:i];
//            [_userInfoDic setValue:model forKey:_stringsToSort[i]];
            friendDetailModel *model =[_userInfoDic valueForKey:chineseString.string];
            // NSLog(@"原String:%@----拼音首字母String:%@",chineseString.string,chineseString.pinYin);
            NSString *str=[NSString stringWithFormat:@"%@",chineseString.pinYin];
            NSString *s=[str substringToIndex:1];
            
            if ([myLoveFriendArray count]==0) {
                [_dic removeObjectForKey:@"☆"];
            }
            else
            {
                [_dic setValue:myLoveFriendArray forKey:@"☆"];
            }
            
            
            if ([s isEqualToString:@"A"]) {
                [arr addObject:model.userName];
                NSLog(@"==================%@",model.userName);
            }
            NSLog(@"==========arr============%@",arr);
            if ([arr count]==0) {
                [_dic removeObjectForKey:@"A"];
            }
            else
            {
                [_dic setValue:model.userName forKey:@"A"];
            }
            
            if ([s isEqualToString:@"B"]) {
                [arr1 addObject:model.userName];
            }
            if ([arr1 count]==0) {
                [_dic removeObjectForKey:@"B"];
            }
            else
            {
                [_dic setValue:arr1 forKey:@"B"];
            }
             NSLog(@"==========arr1============%@",arr1);
            
            if ([s isEqualToString:@"C"]) {
                [arr2 addObject:model.userName];
            }
            if ([arr2 count]==0) {
                [_dic removeObjectForKey:@"C"];
            }
            else
            {
                [_dic setValue:arr2 forKey:@"C"];
            }
            
            if ([s isEqualToString:@"D"]) {
                [arr3 addObject:model.userName];
            }
            if ([arr3 count]==0) {
                [_dic removeObjectForKey:@"D"];
            }
            else
            {
                [_dic setValue:arr3 forKey:@"D"];
            }
            
            if ([s isEqualToString:@"E"]) {
                [arr4 addObject:model.userName];
            }
            if ([arr4 count]==0) {
                [_dic removeObjectForKey:@"E"];
            }
            else
            {
                [_dic setValue:arr4 forKey:@"E"];
            }
            
            if ([s isEqualToString:@"F"]) {
                [arr5 addObject:model.userName];
            }
            if ([arr5 count]==0) {
                [_dic removeObjectForKey:@"F"];
            }
            else
            {
                [_dic setValue:arr5 forKey:@"F"];
            }
            
            if ([s isEqualToString:@"G"]) {
                [arr6 addObject:model.userName];
            }
            if ([arr6 count]==0) {
                [_dic removeObjectForKey:@"G"];
            }
            else
            {
                [_dic setValue:arr6 forKey:@"G"];
            }
            
            if ([s isEqualToString:@"H"]) {
                [arr7 addObject:model.userName];
            }
            if ([arr7 count]==0) {
                [_dic removeObjectForKey:@"H"];
            }
            else
            {
                [_dic setValue:arr7 forKey:@"H"];
            }
            
            if ([s isEqualToString:@"I"]) {
                [arr8 addObject:model.userName];
            }
            if ([arr8 count]==0) {
                [_dic removeObjectForKey:@"I"];
            }
            else
            {
                [_dic setValue:arr8 forKey:@"I"];
            }
            
            if ([s isEqualToString:@"J"]) {
                [arr9 addObject:model.userName];
            }
            if ([arr9 count]==0) {
                [_dic removeObjectForKey:@"J"];
            }
            else
            {
                [_dic setValue:arr9 forKey:@"J"];
            }
            
            if ([s isEqualToString:@"K"]) {
                [arr10 addObject:model.userName];
            }
            if ([arr10 count]==0) {
                [_dic removeObjectForKey:@"K"];
            }
            else
            {
                [_dic setValue:arr10 forKey:@"K"];
            }
            
            if ([s isEqualToString:@"L"]) {
                [arr11 addObject:model.userName];
            }
            if ([arr11 count]==0) {
                [_dic removeObjectForKey:@"L"];
            }
            else
            {
                [_dic setValue:arr11 forKey:@"L"];
            }
            
            if ([s isEqualToString:@"M"]) {
                [arr12 addObject:model.userName];
            }
            if ([arr12 count]==0) {
                [_dic removeObjectForKey:@"M"];
            }
            else
            {
                [_dic setValue:arr12 forKey:@"M"];
            }
            
            if ([s isEqualToString:@"N"]) {
                [arr13 addObject:model.userName];
            }
            if ([arr13 count]==0) {
                [_dic removeObjectForKey:@"N"];
            }
            else
            {
                [_dic setValue:arr13 forKey:@"N"];
            }
            
            if ([s isEqualToString:@"O"]) {
                [arr14 addObject:model.userName];
            }
            if ([arr14 count]==0) {
                [_dic removeObjectForKey:@"O"];
            }
            else
            {
                [_dic setValue:arr14 forKey:@"O"];
            }
            
            if ([s isEqualToString:@"P"]) {
                [arr15 addObject:model.userName];
            }
            if ([arr15 count]==0) {
                [_dic removeObjectForKey:@"P"];
            }
            else
            {
                [_dic setValue:arr15 forKey:@"P"];
            }
            
            if ([s isEqualToString:@"Q"]) {
                [arr16 addObject:model.userName];
            }
            if ([arr16 count]==0) {
                [_dic removeObjectForKey:@"Q"];
            }
            else
            {
                [_dic setValue:arr16 forKey:@"Q"];
            }
            
            if ([s isEqualToString:@"R"]) {
                [arr17 addObject:model.userName];
            }
            if ([arr17 count]==0) {
                [_dic removeObjectForKey:@"R"];
            }
            else
            {
                [_dic setValue:arr17 forKey:@"R"];
            }
            
            if ([s isEqualToString:@"S"]) {
                [arr18 addObject:model.userName];
            }
            if ([arr18 count]==0) {
                [_dic removeObjectForKey:@"S"];
            }
            else
            {
                [_dic setValue:arr18 forKey:@"S"];
            }
            
            if ([s isEqualToString:@"T"]) {
                [arr19 addObject:model.userName];
            }
            if ([arr19 count]==0) {
                [_dic removeObjectForKey:@"T"];
            }
            else
            {
                [_dic setValue:arr19 forKey:@"T"];
            }
            
            if ([s isEqualToString:@"U"]) {
                [arr20 addObject:model.userName];
            }
            if ([arr20 count]==0) {
                [_dic removeObjectForKey:@"U"];
            }
            else
            {
                [_dic setValue:arr20 forKey:@"U"];
            }
            
            if ([s isEqualToString:@"V"]) {
                [arr21 addObject:model.userName];
            }
            if ([arr21 count]==0) {
                [_dic removeObjectForKey:@"V"];
            }
            else
            {
                [_dic setValue:arr21 forKey:@"V"];
            }
            
            if ([s isEqualToString:@"W"]) {
                [arr22 addObject:model.userName];
            }
            if ([arr22 count]==0) {
                [_dic removeObjectForKey:@"W"];
            }
            else
            {
                [_dic setValue:arr22 forKey:@"W"];
            }
            
            if ([s isEqualToString:@"X"]) {
                [arr23 addObject:model.userName];
            }
            if ([arr23 count]==0) {
                [_dic removeObjectForKey:@"X"];
            }
            else
            {
                [_dic setValue:arr23 forKey:@"X"];
            }
            
            if ([s isEqualToString:@"Y"]) {
                [arr24 addObject:model.userName];
            }
            if ([arr24 count]==0) {
                [_dic removeObjectForKey:@"Y"];
            }
            else
            {
                [_dic setValue:arr24 forKey:@"Y"];
            }
            if ([s isEqualToString:@"Z"]) {
                [arr25 addObject:model.userName];
            }
            if ([arr25 count]==0) {
                [_dic removeObjectForKey:@"Z"];
            }
            else
            {
                [_dic setValue:arr25 forKey:@"Z"];
            }
            
        }
        if (_myFriendArray.count!=0) {
            
            NSMutableArray *toTalKeyArray = [[NSMutableArray alloc]init];
            NSArray *keyArray = [[_dic allKeys]sortedArrayUsingSelector:@selector(compare:)];
            [toTalKeyArray addObjectsFromArray:keyArray];
            [toTalKeyArray removeLastObject];
            NSString *myLove = [keyArray objectAtIndex:keyArray.count-1];
            [toTalKeyArray insertObject:myLove atIndex:0];
            
            _key = toTalKeyArray;
        }

        [self.myFriendTabView reloadData];
        NSLog(@"*******************我的朋友**%@",_stringsToSort);

    }
}


#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.view addSubview:self.myFriendTabView];

    __weak __typeof(self) weakSelf = self;
    [self.myFriendTabView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [self.myFriendTabView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    self.myFriendTabView.showsInfiniteScrolling = YES;
    [self.myFriendTabView triggerPullToRefresh];
    
    if (self.myFriendArray.count == 0) {
        //        LoveTableFooterView *footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        //        footerVew.addFriendBlock = ^(){
        //            NSLog(@"addFriendClicked");
        //        };
        //        self.tableView.tableFooterView = footerVew;
    }
}


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    MyFriendFirstPageViewController *myFriendVC = [[MyFriendFirstPageViewController alloc] init];
//    [self.navigationController pushViewController:myFriendVC animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_searchResults count];
        
    }
    else
    {
        NSString *str1=[_key objectAtIndex:section];
        NSArray *aa=[_dic objectForKey:str1];
        return [aa count];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
    return 1;
    
    } else {
    return [_key count];
    
}
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 30;
    }
    return 10;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }

    else
    {
        if (section==0) {
            return @"我的群组";
        }
        NSString *kk=[_key objectAtIndex:section];
        return kk;
    }
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _key;
}


#pragma mark - Page subviews
- (void)initializeData
{
    self.myFriendArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        [self.myFriendArray addObject:[NSNull null]];
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
