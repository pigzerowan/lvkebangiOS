//
//  UserGroupViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 9/21/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "UserGroupViewController.h"
#import "GroupModel.h"
#import "SVPullToRefresh.h"
#import "GroupTableViewCell.h"
#import "ChatViewController.h"
#import "MyUserInfoManager.h"
#import "MBProgressHUD+Add.h"
#import "LoveTableFooterView.h"
#import "FarmerCircleViewController.h"
#import "AttentionCell.h"
#import "CircleIfJoinManager.h"

static NSString* CellIdentifier = @"FindPepleTableViewCellIdentifier";

@interface UserGroupViewController ()<ChatViewControllerDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation UserGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor =  [UIColor whiteColor];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    //    [self initializeData];
    [self initializePageSubviews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    
    if ([_ifgrouptype isEqualToString:@"1"]) {
        self.requestParas =  @{@"userId":[MyUserInfoManager shareInstance].userId,
                               @"page":@(currPage),
                               @"token":[[MyUserInfoManager shareInstance]token],
                               isLoadingMoreKey:@(isLoadingMore)};
    }else
    {
        
        self.requestParas =  @{@"userId":_therquestUrl,
                               @"ownerId":[[MyUserInfoManager shareInstance]userId],
                               @"page":@(currPage),
                               @"token":[[MyUserInfoManager shareInstance]token],
                               isLoadingMoreKey:@(isLoadingMore)};
    }
    
    self.requestURL = self.circlerquestUrl;
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (!request.isLoadingMore) {
        [self.collectionView.pullToRefreshView stopAnimating];
    }
        else {
        [self.collectionView.infiniteScrollingView stopAnimating];
    }
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    
    if ([request.url isEqualToString:LKB_MyGroup_List_Url]||[request.url isEqualToString:LKB_ALLGroup_List_Url]) {
        GroupModel *groupModel = (GroupModel *)parserObject;
        
        NSLog(@"========%@===============",parserObject);
        
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:groupModel.data];
        }else {
            [_dataArray addObjectsFromArray:groupModel.data];
        }
        
        [self.collectionView reloadData];
        if (groupModel.data.count == 0) {
            
            [self.collectionView.infiniteScrollingView endScrollAnimating];
        } else {
            self.collectionView.showsInfiniteScrolling = YES;
            [self.collectionView.infiniteScrollingView beginScrollAnimating];
        }
    }
    
    
    if ([request.url isEqualToString:LKB_ShareColumn_ToGroup_Url]) {
        
        
        LKBBaseModel * base = (LKBBaseModel *)parserObject;
        
        NSLog(@"6666666666666666666666666^^^^^^^^^^^^^^^^^^^^^^^^^^^^%@",base.msg);
    }
    
    if ([request.url isEqualToString:LKB_ShareQuestion_ToGroup_Url]) {
        
        LKBBaseModel * base = (LKBBaseModel *)parserObject;
        
        NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<^^^^^^^^^^^^^^^^^^^^^^^^^^^^%@",base.msg);
    }
}
//#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
//{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//    return self.dataArray.count+1;
//}
//- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 1;
//}
//- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 55;
//}
//
//- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
//{
//    return CGFLOAT_MIN;
//}
//- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    GroupTableViewCell* simplescell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (indexPath.row < self.dataArray.count) {
//        GroupDetailModel *findPeoleModel = (GroupDetailModel *)_dataArray[indexPath.row];
//        
//        NSUserDefaults *userDefault = [[NSUserDefaults alloc]init];
//        
//        
//        if (findPeoleModel.easyMobId==nil) {
//            findPeoleModel.easyMobId = @"100000008888";
//        }
//        
//        NSLog(@"-----------------------------%@",findPeoleModel.groupName);
//        NSLog(@"-----------------------------%@",findPeoleModel.groupAvatar);
//        NSLog(@"-----------------------------%@",findPeoleModel.groupId);
//        
//        
//        NSDictionary *mydic = @{@"userName":findPeoleModel.groupName,
//                                @"groupAvatar":findPeoleModel.groupAvatar,
//                                @"groupId":findPeoleModel.groupId
//                                };
//        NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
//        [userDefault setObject:dic  forKey:findPeoleModel.easyMobId];
//        
//        [simplescell configUserInforGroupCellWithModel:findPeoleModel];
//        [simplescell setNeedsUpdateConstraints];
//        [simplescell updateConstraintsIfNeeded];
//    }
//    
//    else
//    {
//        
//        UITableViewCell*mycell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxxxxxxxx"];
//        
//        
//        UIView* footerVew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 60)];
//        
//        UIImageView *myImg = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-80, 17, 14.5, 14.5)];
//        myImg.image = [UIImage imageNamed:@"findcircle"];
//        [mycell addSubview:myImg];
//        
//        UILabel *myLable = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2-100+40, 10, 200, 30)];
//        
//        myLable.text=@"寻找更多感兴趣的圈子";
//        myLable.font = [UIFont systemFontOfSize:14];
//        myLable.textColor = CCCUIColorFromHex(0x999999);
//        [mycell addSubview:myLable];
//        
//        mycell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return mycell;
//        
//    }
//    
//    
//    
//    return simplescell;
//}
//- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    if (indexPath.row < self.dataArray.count) {
//        self.hidesBottomBarWhenPushed=YES;
//        GroupDetailModel *findPeoleModel = (GroupDetailModel *)_dataArray[indexPath.row];
//        
//        _easyMobId = findPeoleModel.easyMobId;
//        _groupName =findPeoleModel.groupName;
//        _groupId = findPeoleModel.groupId;
//        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:findPeoleModel.easyMobId isGroup:YES];
//        if ([_ifshare isEqualToString:@"2"]) {
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否分享到这里" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            
//            [alert show];
//        }
//        else {
//            //
//            
//            FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
//            NSString *str = [NSString stringWithFormat:@"circle%@",findPeoleModel.groupId];
//            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//            NSString *passWord = [ user objectForKey:str];
//            if (!passWord) {
//                farmerVC.ifJion = findPeoleModel.isJoin;
//            }
//            else
//            {
//                farmerVC.ifJion = passWord;
//            }
//            farmerVC.circleId = findPeoleModel.groupId;
//            farmerVC.groupAvatar = findPeoleModel.groupAvatar;
//            farmerVC.toUserId = [MyUserInfoManager shareInstance].userId;
//            farmerVC.mytitle = findPeoleModel.groupName;
//            farmerVC.type = @"1";
//            farmerVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:farmerVC animated:YES];
//            
//        }
//    }
//    
//    else
//    {
//        [_topageDelegate turnTopage:1];
//    }
//    
//    
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:_easyMobId isGroup:YES];
        [chatVC sendTextMessage:_shareDes];
        chatVC.delelgate  = self;
        
        chatVC.title = _groupName;
        chatVC.groupId = _groupId;
        [self.navigationController pushViewController:chatVC animated:YES];
        self.hidesBottomBarWhenPushed=YES;
        
        
    }
}





#pragma mark - Page subviews
- (void)initializePageSubviews
{
    self.dataArray = [[NSMutableArray alloc] init];
        [self.view addSubview:self.collectionView];
//    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    [self.collectionView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    self.collectionView.showsInfiniteScrolling = NO;
    [self.collectionView triggerPullToRefresh];
    
}

-(void)handlePanFrom:(id)sender
{
    [_topageDelegate turnTopage:1];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    //
    [MobClick beginLogPageView:@"UserGroupViewController"];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"UserGroupViewController"];
}



#pragma mark - Page subviews
- (void)initializeData
{
    self.dataArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        [self.dataArray addObject:[NSNull null]];
    }
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


- (void)ShowProgressHUDwithMessage:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.dimBackground = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count+1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    AttentionCell* simplescell = (AttentionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                                    forIndexPath:indexPath];

    if (indexPath.row < _dataArray.count) {
        
        GroupDetailModel *findPeoleModel = (GroupDetailModel *)_dataArray[indexPath.row];


        NSUserDefaults *userDefault = [[NSUserDefaults alloc]init];


        if (findPeoleModel.easyMobId==nil) {
            findPeoleModel.easyMobId = @"100000008888";
        }

        NSLog(@"-----------------------------%@",findPeoleModel.groupName);
        NSLog(@"-----------------------------%@",findPeoleModel.groupAvatar);
        NSLog(@"-----------------------------%@",findPeoleModel.groupId);


        NSDictionary *mydic = @{@"userName":findPeoleModel.groupName,
                                @"groupAvatar":findPeoleModel.groupAvatar,
                                @"groupId":findPeoleModel.groupId
                                };
        NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
        [userDefault setObject:dic  forKey:findPeoleModel.easyMobId];

        [simplescell configDiscoveryCircleCellWithModel:findPeoleModel];
        






    }else
    {
        
        simplescell.passLabel.hidden = YES;
        simplescell.goodsImageView.image = [UIImage imageNamed:@"addCircle"];
        simplescell.backImageView.hidden = YES;
        
        simplescell.nameLabel.hidden = YES;

        
    }
    


    return simplescell;
}
#pragma mark - CHTCollectionViewDelegateWaterfallLayout
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.dataArray.count) {
        GroupDetailModel *findPeoleModel = (GroupDetailModel *)_dataArray[indexPath.row];
        if ([findPeoleModel.passStatus isEqualToString:@"1"]) {
            
            FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
            NSString *str = [NSString stringWithFormat:@"circle%@",findPeoleModel.groupId];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *passWord = [ user objectForKey:str];
            if (!passWord) {
                farmerVC.ifJion = findPeoleModel.isJoin;
                [CircleIfJoinManager shareInstance].ifJoin = findPeoleModel.isJoin;

                
            }
            else
            {
                farmerVC.ifJion = passWord;
                [CircleIfJoinManager shareInstance].ifJoin = passWord;

            }
            farmerVC.circleId = findPeoleModel.groupId;
            farmerVC.groupAvatar = findPeoleModel.groupAvatar;
            farmerVC.toUserId = [MyUserInfoManager shareInstance].userId;
            farmerVC.mytitle = findPeoleModel.groupName;
            farmerVC.type = @"1";
            farmerVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:farmerVC animated:YES];

        }

    }
        else
    {

       [_topageDelegate turnTopage:1];

    }

}
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    if (iPhone5) {
        // 146
        return CGSizeMake((kDeviceWidth-90)/3, 90);

    }
    else if (iPhone6p){
        //234
        return CGSizeMake((kDeviceWidth-180)/3, 90);

    }
    else {
        // 195
        return CGSizeMake((kDeviceWidth-150)/3, 90);

    }
}



- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
//    return 40.0f;
    if (iPhone5) {
        // 47
        return 18;
    }
    else if (iPhone6p) {
        // 70
        return 35;
    }
    else {
        // 60
        return 30;
    }
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
//    return 20.0f;
    if (iPhone5) {
        return 26;
    }
    else {
        // 32
        return 32;
    }
}
#pragma mark - Getters & Setters
- (UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        if (iPhone5) {
            layout.sectionInset = UIEdgeInsetsMake(20, 26, 0, 26);
        }
        else if (iPhone6p) {
            layout.sectionInset = UIEdgeInsetsMake(26, 47, 0, 47);
        }
        else {
            layout.sectionInset = UIEdgeInsetsMake(26, 37.5, 0, 37.5);
        }

        if (iPhone5) {
            layout.minimumLineSpacing = 26;
        }
        else {
            layout.minimumLineSpacing = 28;
        }

//        layout.minimumInteritemSpacing = 45;
        if (iPhone5) {
            layout.minimumInteritemSpacing = 47;
        }
        else if (iPhone6p) {
            layout.minimumInteritemSpacing = 70;
        }
        else {
            layout.minimumInteritemSpacing = 60;
        }
//        layout.itemSize = CGSizeMake(90, 110);//宽高


        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//        _collectionView.contentSize = CGSizeMake(kDeviceWidth, KDeviceHeight *2);
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.alwaysBounceVertical = YES;//当UICollectionView不够一页的时候 下拉的时候都不会触发UIScrollVIew的scrollViewDidScroll代理方法 下拉刷新控件基本都是基于scrollViewDidScroll代理方法来进行操作  所以在创建UICollectionView的时候添加 //垂直方向遇到边框是否总是反弹

        [_collectionView registerClass:[AttentionCell class]
            forCellWithReuseIdentifier:CellIdentifier];

    }
    return _collectionView;
}
@end
