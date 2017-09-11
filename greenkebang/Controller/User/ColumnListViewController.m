//
//  ColumnListViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 1/25/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "ColumnListViewController.h"
#import "MyUserInfoManager.h"
#import "ColumnListModel.h"
#import "SVPullToRefresh.h"
#import "ColumnWithImageCell.h"
#import "ColumnWithOutImageCell.h"
#import "UIImageView+EMWebCache.h"
#import "InsightDetailViewController.h"
#import "ColumnAttentionModel.h"
#import "CreateColumnViewController.h"
#import "SetUpColumnManager.h"
#import "ColumnInfoMation.h"
#import "OutWebViewController.h"
#import "MyFeatureIdManager.h"
//#import "UITableViewCell+HYBMasonryAutoCellHeight.h"

//#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
//#import "LKBPrefixHeader.pch"
NSString * const ColumnWithImageCellIdentifier = @"ColumnWithImageCell";
NSString * const ColumnWithOutImageCellIdentifier = @"ColumnWithOutImageCell";
static NSString* CellIdentifier = @"CellIdentifier";
@interface ColumnListViewController () <UITableViewDataSource,UITableViewDelegate>

{
    UIImageView *myImage;
    UIImageView *navBarHairlineImageView;
    UIImageView * loadingImage;
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;

}

@property (nonatomic, strong) UIView *headerView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *ColumnNameLable;
@property (nonatomic, strong) UIButton *attentionBtn;

@end

@implementation ColumnListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = _featureName;
    
    
   
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
//    self.dataArray = [[NSMutableArray alloc] init];

    
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

    
    
    if (_featureId == nil) {
        
        
        
        // 网络连接失败
        
        WithoutInternetImage.hidden = NO ;
        tryAgainButton.hidden = NO;
        
//        [MBProgressHUD showMessag:@"连上网络，返回试试~" toView:self.view];


        
        
        
    }else {
        
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"featureId":_featureId,
                              @"token":[[MyUserInfoManager shareInstance]token],
                              };
        
        self.requestURL = LKB_ColumnInfo_Url;
        
        [self initializePageSubviews];
        
        
        
    }

    
    
    
    NSLog(@"------------------------------------%@",_featureDesc);
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setUpColumn)];
    
    if ([_themUrl isEqualToString:[MyUserInfoManager shareInstance].userId]) {
        self.navigationItem.rightBarButtonItem = right;

    }
    
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

    // Do any additional setup after loading the view, typically from a nib.
}





- (void)tryAgainButton:(id )sender {
    
    if (_featureId == nil) {
        
        // 网络连接失败
        
        WithoutInternetImage.hidden = NO ;
        tryAgainButton.hidden = NO;
        
    } else {
        
        [self initializePageSubviews];

    }

    
    
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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    if (_featureId == nil) {
        self.navigationController.navigationBar.alpha=1;

    }
    else {
        
        self.navigationController.navigationBar.alpha=0;

    }
    navBarHairlineImageView.hidden = YES;

    
    // ColumnListViewController
    [MobClick beginLogPageView:@"ColumnListViewController"];

}

-(void)viewWillDisappear:(BOOL)animated
{
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationController.navigationBar setClipsToBounds:NO];
    self.navigationController.navigationBar.alpha=1;
    navBarHairlineImageView.hidden = NO;

    [MobClick endLogPageView:@"ColumnListViewController"];
    
    

}



- (void)setUpColumn {
    
    // 设置专栏  
    CreateColumnViewController *createVC = [[CreateColumnViewController alloc]init];
    createVC.featureId = _featureId;
    createVC.featureAvatar = _featureAvatar;
    
    [SetUpColumnManager shareInstance].featureAvatar = _featureAvatar;
//    [SetUpColumnManager shareInstance].featureAvatar = _featureAvatar ;
//    createVC.featureAvatar = _featureAvatar;
    
    NSLog(@"-------------------------------------%@",_featureAvatar);
    NSLog(@"<<<<<<<<-------------------------------------%@",[SetUpColumnManager shareInstance].featureAvatar);

    createVC.type = @"1";
    [self.navigationController pushViewController:createVC animated:YES];
}
-(void)backToMain
{
    self.navigationController.navigationBar.alpha=1;
    [self.navigationController popViewControllerAnimated:YES];
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



#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
    
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 214.5)];
    _headerView.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 214.5)];
    
    backImage.image = [UIImage imageNamed:@"background4"];
    
    
    
    
    
    UIButton *navBackBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 31, 22, 22)];
    [navBackBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [navBackBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 31, kDeviceWidth, 16)];
    titleLabel.textColor = CCCUIColorFromHex(0x333431);
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"专栏";
    
    
    UIImageView *myBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2 - 30 , 64,60, 60)];
    myBackImage.backgroundColor = [UIColor whiteColor];
    myBackImage.layer.masksToBounds = YES;
    myBackImage.layer.cornerRadius  = 30;
    
    
    
    myImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2 - 29 , 65,58, 58)];
    myImage.layer.masksToBounds = YES;
    myImage.layer.cornerRadius  = 29;
    myImage.backgroundColor = [UIColor whiteColor];

    
    _attentionBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth / 2 - 35,163, 70, 30)];
    
    [_attentionBtn addTarget:self action:@selector(attentionWhichColumn:) forControlEvents:UIControlEventTouchUpInside];
    _attentionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    if ([_ifAttention isEqual:@"1"]) {
        
        [_attentionBtn setImage:[UIImage imageNamed:@"Concern"] forState:UIControlStateNormal];
        
        
        
    }
    else {
        
        [_attentionBtn setImage:[UIImage imageNamed:@"HasBeenConcerned"] forState:UIControlStateNormal];
        
    }


    
    [_headerView addSubview:backImage];
    [_headerView addSubview:myBackImage];
    [_headerView addSubview:myImage];
    [_headerView addSubview:titleLabel];
    [_headerView addSubview:navBackBtn];
    [_headerView addSubview:_attentionBtn];
    
    _tableView.tableHeaderView = _headerView;
    
    
    
    _ColumnNameLable = [[UILabel alloc]initWithFrame:CGRectMake(80, 134 , kDeviceWidth-150, 14)];
    _ColumnNameLable.textColor = CCCUIColorFromHex(0x333333);
    _ColumnNameLable.textAlignment = NSTextAlignmentCenter;
    _ColumnNameLable.font = [UIFont systemFontOfSize:14];
    [_headerView addSubview:_ColumnNameLable];
    
 
    
    
    
    
    __weak __typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    self.tableView.showsInfiniteScrolling = YES;
    [self.tableView triggerPullToRefresh];
    
    if (self.dataArray.count == 0) {
        //                LoveTableFooterView *footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        //                footerVew.addFriendBlock = ^(){
        //                    NSLog(@"addFriendClicked");
        //                };
        //                self.tableView.tableFooterView = footerVew;
    }
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
    
    if (_featureId != nil) {
        
        self.requestParas = @{@"featureId":_featureId,
                              @"userId":[[MyUserInfoManager shareInstance]userId],
                              @"page":@(currPage),
                              @"token":[[MyUserInfoManager shareInstance]token],
                              isLoadingMoreKey:@(isLoadingMore)
                              };
        
        self.requestURL = LKB_ColumnInfo_List_Url;

    }
    
}


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
        
        
        NSLog(@"=================%@",errorMessage);
        
        if ([errorMessage isEqualToString:@"没有网络，连接失败"]) {
            [self.tableView removeFromSuperview];
            
            self.navigationController.navigationBar.alpha= 1;
            WithoutInternetImage.hidden = NO;
            tryAgainButton.hidden = NO;
        }

        
        

        
        return;
    }
    if ([request.url isEqualToString:LKB_ColumnInfo_Url]) {
        ColumnInfoMation *groupModel = (ColumnInfoMation *)parserObject;
        
        _ifAttention = groupModel.data.ifAttention;
        
        NSLog(@"*--------------------%@",_ifAttention);
        
        if ([_ifAttention isEqual:@"1"]) {
            
            [_attentionBtn setImage:[UIImage imageNamed:@"Concern"] forState:UIControlStateNormal];
            
            
            
        }
        else {
            
            [_attentionBtn setImage:[UIImage imageNamed:@"HasBeenConcerned"] forState:UIControlStateNormal];
            
        }

        
        if ([groupModel.data.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
            _attentionBtn.hidden = YES;
        }
        
        _ColumnNameLable.text = groupModel.data.featureName;
        
        _featureDesc =groupModel.data.featureDesc;
        _featureAvatar = groupModel.data.featureAvatar;
        
        [myImage sd_setImageWithURL:[_featureAvatar lkbImageUrl8] placeholderImage:YQNormalPlaceImage];

        
        NSLog(@"-------------------------------------%@",_featureAvatar);

        
        
        //    [self.view addSubview:_headerView];
        

        
    }

    
    if ([request.url isEqualToString:LKB_ColumnInfo_List_Url]) {
        ColumnListModel *groupModel = (ColumnListModel *)parserObject;
        
        NSLog(@"========%@===============",parserObject);
        
        if (!request.isLoadingMore) {
            if(groupModel.data)
            {
                _dataArray = [NSMutableArray arrayWithArray:groupModel.data];
                
                
            }
        } else {
            if (_dataArray.count<groupModel.num) {
                [_dataArray addObjectsFromArray:groupModel.data];
            }
            
        }
        
        [self.tableView reloadData];

        
        if (_dataArray.count ==  0) {
            
            
            _ifHaveData = @"1";
        }
        
        [self.tableView reloadData];


        if (groupModel.data.count == 0) {
            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
        }
        
    }
    if ([request.url isEqualToString:LKB_ColumnInfo_Attention_Url]) {
//        UserInforModel *userInfor = (UserInforModel *)parserObject;
        ColumnAttentionModel *columnInfor = (ColumnAttentionModel *)parserObject;
        NSLog(@"=======%@========",columnInfor.msg);
        
        [self ShowProgressHUDwithMessage:columnInfor.msg];
        
         
    }
    if ([request.url isEqualToString:LKB_ColumnInfo_Cancel_Attention_Url]) {
        //        UserInforModel *userInfor = (UserInforModel *)parserObject;
        LKBBaseModel *baseModel= (LKBBaseModel *)parserObject;
        if ([baseModel.success isEqualToString:@"1"]) {
            [self ShowProgressHUDwithMessage:baseModel.msg];

        }
        
        
        
    }
}

-(void)attentionWhichColumn:(id)sender
{
    if ([_attentionBtn.imageView.image isEqual:[UIImage imageNamed:@"Concern"]]) {
        
        [_attentionBtn setImage:[UIImage imageNamed:@"HasBeenConcerned"] forState:UIControlStateNormal];
        
        self.requestParas = @{@"featureId":_featureId,// 专栏Id
                              @"userId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token],
                              };
        
        self.requestURL = LKB_ColumnInfo_Attention_Url;


    }
    else {
        
        [_attentionBtn setImage:[UIImage imageNamed:@"Concern"] forState:UIControlStateNormal];
        self.requestParas = @{@"featureId":_featureId,// 专栏Id
                              @"userId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token],
                              };
        
        self.requestURL = LKB_ColumnInfo_Cancel_Attention_Url;


    }
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.navigationBar.alpha=scrollView.contentOffset.y/200;
    
    if ( scrollView.contentOffset.y < 30  ) {
        
        self.navigationController.navigationBar.alpha=0;
        
        
    }
    else {
        self.navigationController.navigationBar.alpha=scrollView.contentOffset.y/200;
        
        
    }
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray.count == 0 ) {
        return 1;
        
    }
    else {
        return self.dataArray.count;

    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row< _dataArray.count) {
        
        SingelColumnModel *model =self.dataArray[indexPath.row];
        if ([NSStrUtil isEmptyOrNull:model.cover]) {
            
            
            return [ColumnWithOutImageCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                ColumnWithOutImageCell *cell = (ColumnWithOutImageCell *)sourceCell;
                // 配置数据
                [cell configSingelColumnNoImageTableCellWithGoodModel:model];
                
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"ColumnList%@", model.featureId],kHYBCacheStateKey : @"expanded",
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         kHYBRecalculateForStateKey : @(NO) // 标识不重新更新
                         };
            }];
            
            
            
            
        }
        else
        {
            return [ColumnWithImageCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                ColumnWithImageCell *cell = (ColumnWithImageCell *)sourceCell;
                // 配置数据
                [cell configSingelColumnTableCellWithGoodModel:model];
                
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"ColumnList%@",model.insightId],kHYBCacheStateKey : @"expanded",
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                         };
            }];
            
        }

        
    }
    else {
        
        return KDeviceHeight - 214.5 ;
    }

    
    
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}



- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CELLNONE = @"CELLNONE";
    
    UITableViewCell *cell;
    
    NSLog(@"=======================%lu",(unsigned long)_dataArray.count);
    NSLog(@"=======================%@",_dataArray);

    
    
    if (_dataArray.count == 0  ) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        loadingImage = [[UIImageView alloc]init];
        
        if ([_ifHaveData isEqualToString:@"1"]) {
            
            loadingImage.image = [UIImage imageNamed:@"No-column-posted"];
            loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );


        }
        else {
            
            loadingImage.image = [UIImage imageNamed:@"Column_load"];
            loadingImage.frame = CGRectMake(0 , 0, kDeviceWidth, KDeviceHeight -214.5 -64 );

        }
        [cell addSubview:loadingImage];

        return cell;
    }
    
    
    if (indexPath.row < self.dataArray.count) {
        
        SingelColumnModel *insight = (SingelColumnModel *)_dataArray[indexPath.row];
        if ([NSStrUtil isEmptyOrNull:insight.cover]) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:ColumnWithOutImageCellIdentifier];
//            if (!cell) {
//                cell = [[ColumnWithOutImageCell alloc] initWithHeight:150 reuseIdentifier:ColumnWithOutImageCellIdentifier];
//            }
            if (!cell) {
                cell = [[ColumnWithOutImageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:ColumnWithOutImageCellIdentifier];
            }

            ColumnWithOutImageCell *tbCell = (ColumnWithOutImageCell *)cell;
            [tbCell configSingelColumnNoImageTableCellWithGoodModel:insight];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
            
        }
        else
        {
            cell = [tableView dequeueReusableCellWithIdentifier:ColumnWithImageCellIdentifier];
//            if (!cell) {
//                cell = [[ColumnWithImageCell alloc] initWithHeight:200 reuseIdentifier:ColumnWithImageCellIdentifier];
//            }
            if (!cell) {
                cell = [[ColumnWithImageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:ColumnWithImageCellIdentifier];
            }

            ColumnWithImageCell *tbCell = (ColumnWithImageCell *)cell;
            [tbCell configSingelColumnTableCellWithGoodModel:insight];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SingelColumnModel *insight = (SingelColumnModel *)_dataArray[indexPath.row];
    
//    InsightDetailViewController *InsightVC = [[InsightDetailViewController alloc] init];
//    InsightVC.topicId =insight.insightId ;
//    [self.navigationController pushViewController:InsightVC animated:YES];
    
    // @"http://192.168.1.199:8082/app/detail/insight/%@"
    NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,insight.insightId] ;
    
    NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];
    
   
    
    
    
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    outSideWeb.sendMessageType = @"1";
    outSideWeb.rightButtonType = @"2";
    outSideWeb.VcType = @"2";
    outSideWeb.featureId = insight.featureId;// 专栏id
    outSideWeb.circleDetailId = insight.insightId;// 文章Id
    outSideWeb.objectId = insight.insightId;// 文章Id
    outSideWeb.mytitle = insight.title;
    outSideWeb.replyNum = insight.replyNum;
    outSideWeb.couAvatar = insight.featureAvatar;
    outSideWeb.commendVcType = @"1";
    outSideWeb.isCollect = insight.isCollect;
    outSideWeb.groupAvatar = insight.cover;
    //        outSideWeb.isAttention = insight.isAttention;
    
    NSLog(@"----------------------------%@",outSideWeb.groupAvatar);
    
    NSLog(@"----------------------------%@",outSideWeb.couAvatar);

    
    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];
    

}


#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
