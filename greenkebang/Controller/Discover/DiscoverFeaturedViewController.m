//
//  DiscoverFeaturedViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 2017/3/3.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import "DiscoverFeaturedViewController.h"
#import "SDCycleScrollView.h"
#import "BannerModel.h"
#import "MyUserInfoManager.h"
#import "OutWebViewController.h"
#import "ShareArticleManager.h"
#import "YQWebDetailViewController.h"
#import "SVPullToRefresh.h"
#import "LoveTableFooterView.h"
#import "ColumnListModel.h"
#import "ColumnWithImageCell.h"
#import "ColumnWithOutImageCell.h"
#import "FindFeaturesModel.h"
#import "DiscoverAllArticViewController.h"
#import "ColumnListViewController.h"
static NSString* featuredCellIdentifier = @"DiscoverFeaturedCellIdentifier";
NSString * const DiscoverFeaturedWithImageCellIdentifier = @"DiscoverFeaturedWithImageCell";
NSString * const DiscoverFeaturedWithOutImageCellIdentifier = @"DiscoverFeaturedWithOutImageCell";


@interface DiscoverFeaturedViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;

}

@property (strong, nonatomic) UITableView* tableView;

@property (strong, nonatomic) SDCycleScrollView* cycleScrollView;
@property(strong,nonatomic)NSMutableArray *bannerArray;
@property (strong, nonatomic) NSArray *classArray;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) NSMutableArray* dataArray;




@end

@implementation DiscoverFeaturedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _bannerArray = [NSMutableArray array];
    _classArray = [NSMutableArray array];
    self.dataArray = [[NSMutableArray alloc] init];


//    _classArray = @[@"新农圈",@"绿科秀",@"专栏",@"交易系统"];

    
    
    __block DiscoverFeaturedViewController/*主控制器*/ *weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [weakSelf delayMethod];
    });

    
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



    
    [self initializePageSubviews];

    // Do any additional setup after loading the view.
}
- (void)tryAgainButton:(id )sender {
    
    [self initializePageSubviews];
    
}


-(void)delayMethod
{
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token]
                          
                          
                          };
    self.RequestPostWithChcheURL = LKB_Find_Features_Url;
    
}


#pragma mark - Private methods
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"DiscoverFeaturedViewController"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [ShareArticleManager shareInstance].shareType = nil;
    [MobClick beginLogPageView:@"DiscoverFeaturedViewController"];
    
    
}




#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
    
    
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token]
                          
                          
                          };
    self.RequestPostWithChcheURL = LKB_ALL_FIND_COVER;

    
    _headerView = [[UIView alloc]init];
    _headerView.backgroundColor = [UIColor whiteColor];
    if (iPhone5) {
        
        _headerView.frame = CGRectMake(0, 0, kDeviceWidth, 356);
        
    }
    else if (iPhone6p) {
        
        _headerView.frame = CGRectMake(0, 0, kDeviceWidth, 398);
        
    }
    else {
        _headerView.frame = CGRectMake(0, 0, kDeviceWidth, 381);
    }

    
    if (iPhone5) {
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth, 143) imageURLsGroup:_bannerArray];
        
        
        
    }
    else if (iPhone6p) {
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth, 185) imageURLsGroup:_bannerArray];
        
    }
    else {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth, 168) imageURLsGroup:_bannerArray];
    }
    _cycleScrollView.backgroundColor = CCCUIColorFromHex(0xf2f3f8);

    
    _cycleScrollView.delegate = self;
    
    
    for (int i = 0; i < 8; i++) {
        NSInteger page =i / 2;
        NSInteger index = i % 2; // 0 1
        UIImageView * CirleImageView =[[UIImageView alloc]init];
        if (iPhone5) {
            
            CirleImageView.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21, index *(50 +40) + 182 , 50,50);

            
        }
        else if (iPhone6p) {
            
            CirleImageView.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21 , index *(50 + (224 - 50 *2) /3) + 224 , 50,50);

            
        }
        else {
            
            CirleImageView.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21 , index *(50 +26) + 207 , 50,50);

        }

        
        CirleImageView.backgroundColor = CCCUIColorFromHex(0xf2f3f8);
        CirleImageView.layer.masksToBounds = YES;
        CirleImageView.layer.cornerRadius = 24;
        
        

        
        [_headerView addSubview:CirleImageView];
        
        
        
        
    }
    
    UIImageView * lineView = [[UIImageView alloc]init];
    
    if (iPhone5) {
        
        lineView.frame = CGRectMake(14, 152, 2, 12.5);
        
        
    }
    else if (iPhone6p) {
        
        lineView.frame = CGRectMake(14, 194, 2, 12.5);
        
    }
    else {
        
        lineView.frame = CGRectMake(14, 177, 2, 12.5);
        
        
    }
    lineView.image = [UIImage imageNamed:@"rectangle_style"];
    
    UILabel * authorColunm = [[UILabel alloc]init];
    if (iPhone5) {
        
        authorColunm.frame = CGRectMake(22, 152, 60, 12);
        
        
    }
    else if (iPhone6p) {
        
        authorColunm.frame = CGRectMake(22, 194, 60, 12);
        
    }
    else {
        
        authorColunm.frame = CGRectMake(22, 177, 60, 12);
        
        
    }
    authorColunm.text = @"名家专栏";
    authorColunm.textColor = CCCUIColorFromHex(0x555555);
    authorColunm.font = [UIFont systemFontOfSize:12];
    
    
    UIButton * moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    if (iPhone5) {
        
        moreButton.frame = CGRectMake(kDeviceWidth -14  -45, 152, 80, 20);
        
        
    }
    else if (iPhone6p) {
        
        moreButton.frame = CGRectMake(kDeviceWidth -14  -45, 194, 80, 20);
        
    }
    else {
        
        moreButton.frame = CGRectMake(kDeviceWidth -14  -45, 177, 80, 20);
        
        
    }
    
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [moreButton setTintColor:CCCUIColorFromHex(0xa1a1a1)];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [moreButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
    [moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
    [moreButton addTarget:self action:@selector(moreButton:) forControlEvents:UIControlEventTouchUpInside];
    
    

    for (int i = 0; i < 8 ; i++) {
        
        
        NSInteger page =i / 2;
        NSInteger index = i % 2; // 0 1
        UIImageView * CirleImageView =[[UIImageView alloc]init];
        if (iPhone5) {
            
            CirleImageView.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21, index *(50 +40) + 182 , 50,50);
            
            
        }
        else if (iPhone6p) {
            
            CirleImageView.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21 , index *(50 + (224 - 50 *2) /3) + 224 , 50,50);
            
            
        }
        else {
            
            CirleImageView.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21 , index *(50 +26) + 207 , 50,50);
            
        }
        
        
        CirleImageView.backgroundColor = CCCUIColorFromHex(0xf2f3f8);;
        CirleImageView.layer.masksToBounds = YES;
        CirleImageView.layer.cornerRadius = 24;
        
        
        UILabel * CirleNameLabel =[[UILabel alloc]init];
        if (iPhone5) {
            
            CirleNameLabel.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21  , index *(50 +41) +245  , 50,13);
            
        }
        else if (iPhone6p) {
            
            CirleNameLabel.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21  , index *(50 + 41 )+287 , 50,13);
            
        }
        else {
            
            CirleNameLabel.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21 , index *(50 +26) + 260,50,13);
            
        }
        CirleNameLabel.backgroundColor = CCCUIColorFromHex(0xf2f3f8);
        
        
        [_headerView addSubview:CirleImageView];
        [_headerView addSubview:CirleNameLabel];
        
        
        
    }

    


    [_headerView addSubview:lineView];
    [_headerView addSubview:authorColunm];
    [_headerView addSubview:moreButton];
    [_headerView addSubview:_cycleScrollView];

    _tableView.tableHeaderView = _headerView;
    
    
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
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        footerVew.textLabel.text=@"没有更多数据了哦..";
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = YES;
        
    }


    
}

// 更多
-(void)moreButton:(id)sender {
    
    DiscoverAllArticViewController *timeQAVC =[[DiscoverAllArticViewController alloc] init];
    timeQAVC.VCtype = @"1";
    timeQAVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:timeQAVC animated:YES];
}

// 名家专栏
-(void)circleButton:(id)sender {
    
    NSString *str = [NSString stringWithFormat: @"%ld",(long)[sender tag]];
    
    ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
    ColumnListViewVC.title = @"专栏";
    ColumnListViewVC.featureId = str ;
    ColumnListViewVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ColumnListViewVC animated:YES];


}




#pragma mark -fetchDataWithIsLoadingMore
- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    }
    else {
        ++currPage;
    }
    self.requestParas = @{
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"page":@(currPage),
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    
    self.RequestPostWithChcheURL = LKB_ColumnInfo_List_Url;
    
}




#pragma mark -SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView*)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    BannerDetailModel* simpleGood = _bannerArray[index];
    
    NSLog(@"=========================%@",simpleGood);
    
    
    NSString* urlStr = [NSString stringWithFormat:@"%@%@",@"http://www.lvkebang.cn",simpleGood.coverLink];
    
    
    
    if ([urlStr rangeOfString:@"jianjie"].location!=NSNotFound ) {
        //        simpleGood *topic = (NewInsightModel *)_dataArray[indexPath.row];
        NSArray *strarray = [urlStr componentsSeparatedByString:@".h"];
        NSString *str = strarray[0];
        
        NSArray *strarray2 = [str componentsSeparatedByString:@"e/"];
        NSString *idStr = strarray2[1];
        
        NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,idStr] ;
        
        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        outSideWeb.sendMessageType = @"1";
        outSideWeb.rightButtonType = @"2";
        outSideWeb.VcType = @"2";// 专栏
        outSideWeb.circleDetailId = idStr;// 文章Id
        outSideWeb.replyNum = simpleGood.replyNum;
        outSideWeb.featureId = simpleGood.featureId;
        outSideWeb.couAvatar = simpleGood.featureAvatar;
        outSideWeb.mytitle = simpleGood.title;
        outSideWeb.groupAvatar = simpleGood.cover;
        
        [ShareArticleManager shareInstance].shareType = @"1";
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];
        
    }
    else  if ([urlStr rangeOfString:@"wenda"].location!=NSNotFound ) {
        
        
        
    }
    else  if ([urlStr rangeOfString:@"huati"].location!=NSNotFound ) {
        
    }
    else  if ([urlStr rangeOfString:@"huodong"].location!=NSNotFound ) {
        
        NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/"];
        NSString * idStr = [urlStr substringFromIndex: jianjie.length];
        NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/activity/%@",LKB_WSSERVICE_HTTP,idStr];
        
        
        
        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        //    outSideWeb.sendMessageType = @"2";
        outSideWeb.rightButtonType = @"1";
        //    outSideWeb.objectId = attentionModel.myId;
        //    outSideWeb.isAttention = insight.isAttention;
        outSideWeb.VcType = @"7";
        outSideWeb.circleDetailId = idStr;
        outSideWeb.mytitle = @"活动详情";
        //        outSideWeb.columnAvatar = attentionModel.img;
        [ShareArticleManager shareInstance].shareType = @"1";
        
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];
        
    }
    
    
    else
    {
        YQWebDetailViewController* webDetailVC = [[YQWebDetailViewController alloc] init];
        webDetailVC.urlStr = urlStr;
        webDetailVC.mytitle = simpleGood.title;
        webDetailVC.coverUrl = simpleGood.coverUrl;
        webDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webDetailVC animated:YES];
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
        
        if ([errorMessage isEqualToString:@"没有网络，连接失败"]) {
            
            if (_dataArray .count == 0) {
                
                [self.tableView removeFromSuperview];
                
                WithoutInternetImage.hidden = NO;
                tryAgainButton.hidden = NO;
            }
            else {
                
                WithoutInternetImage.hidden = YES;
                tryAgainButton.hidden = YES;
                
            }
            
            
        }

        return;
    }
    
    if ([request.url isEqualToString:LKB_ALL_FIND_COVER]) {
        BannerModel *groupModel = (BannerModel *)parserObject;
        
        
        NSLog(@"----------------------------------------------%@",groupModel.data);
        
        NSArray *bannerArray = [NSMutableArray arrayWithArray:groupModel.data];
        
        for ( int i=0; i<bannerArray.count; i++) {
            BannerDetailModel *model = (BannerDetailModel *)bannerArray[i];
            [_bannerArray addObject:model];
        }
        _cycleScrollView.imageURLsGroup =_bannerArray;
        //        [self.tableView reloadData];
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
        if (groupModel.data.count == 0) {
            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
        }
        
    }
    
    if ([request.url isEqualToString:LKB_Find_Features_Url]) {

        FindFeaturesModel *groupModel = (FindFeaturesModel *)parserObject;
        
        NSLog(@"========%@===============",parserObject);
        
        NSLog(@"++++++++++++++++++++++++++++++%@",[groupModel.data valueForKey:@"title"]);
        
        if (!request.isLoadingMore ) {
            
            NSLog(@"群组是怎么回事······%@·····",groupModel.data);
            
            if (_classArray.count == 0) {
                
                if(groupModel.data.count!=0&&groupModel!=nil)
                {
                    
                    _classArray = [NSMutableArray arrayWithArray:groupModel.data];
                }
                
                for (int i = 0; i < _classArray.count; i++) {
                    
                    FeaturesDetailModel *model = (FeaturesDetailModel *)_classArray[i];
                    
                    NSInteger page =i / 2;
                    NSInteger index = i % 2; // 0 1
                    UIImageView * CirleImageView =[[UIImageView alloc]init];
                    if (iPhone5) {
                        
                        CirleImageView.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21, index *(50 +40) + 182 , 50,50);
                        
                        
                    }
                    else if (iPhone6p) {
                        
                        CirleImageView.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21 , index *(50 + (224 - 50 *2) /3) + 224 , 50,50);
                        
                        
                    }
                    else {
                        
                        CirleImageView.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21 , index *(50 +26) + 207 , 50,50);
                        
                    }
                    
                    
                    CirleImageView.backgroundColor = [UIColor whiteColor];
                    CirleImageView.layer.masksToBounds = YES;
                    CirleImageView.layer.cornerRadius = 24;
                    
                    [CirleImageView sd_setImageWithURL:[model.cover lkbImageUrl8] placeholderImage:YQNormalBackGroundPlaceImage];
                    
                    
                    UILabel * CirleNameLabel =[[UILabel alloc]init];
                    if (iPhone5) {
                        
                        CirleNameLabel.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21  , index *(50 +41) +245  , 50,13);
                        
                    }
                    else if (iPhone6p) {
                        
                        CirleNameLabel.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21  , index *(50 + 41 )+287 , 50,13);
                        
                    }
                    else {
                        
                        CirleNameLabel.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21 , index *(50 +26) + 260,50,13);
                        
                    }
                    CirleNameLabel.backgroundColor = [UIColor whiteColor];
                    
                    CirleNameLabel.font = [UIFont systemFontOfSize:13];
                    CirleNameLabel.text = model.title;
                    CirleNameLabel.textColor = CCCUIColorFromHex(0x333333);
                    CirleNameLabel.textAlignment = NSTextAlignmentCenter;
                    UIButton *circleButton= [[UIButton alloc]init ];
                    if (iPhone5) {
                        
                        circleButton.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21  , index *(50 + 60) +182  , 60,76);
                        
                    }
                    else if (iPhone6p) {
                        
                        circleButton.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21  , index *(50 + 41 )+224 , 60,76);
                        
                    }
                    else {
                        
                        circleButton.frame =CGRectMake(page*(50 +  (kDeviceWidth - 42 - 50 * 4 )/3 ) +21 , index *(50 +36) + 195,60,76);
                        
                        
                    }
                    circleButton.backgroundColor = [UIColor clearColor];
                    circleButton.clipsToBounds = YES;
                    [circleButton addTarget:self action:@selector(circleButton:) forControlEvents:UIControlEventTouchUpInside];
                    
                    circleButton.tag = [model.objectId integerValue];
                    
                    
                    [_headerView addSubview:CirleImageView];
                    [_headerView addSubview:CirleNameLabel];
                    [_headerView addSubview:circleButton];
                    
                    
                    
                }
                
                
            }
        }

        
        
    }


    
    
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    if (_dataArray.count==0) {
        return 1;
    }else
    {
        return 1;
    }

}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count +1;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (iPhone5) {
        return 10;
    }
    else {
        
        
        return 15;
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row< _dataArray.count) {
        
        if (indexPath.row == 0) {
            
            return 31;
        }
        else {
            
            
            SingelColumnModel *model =self.dataArray[indexPath.row -1];
            if ([NSStrUtil isEmptyOrNull:model.cover]) {
                
                //        return 100;
                
                return [ColumnWithOutImageCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    ColumnWithOutImageCell *cell = (ColumnWithOutImageCell *)sourceCell;
                    // 配置数据
                    [cell configColumnArticleListNoImageTableCellWithGoodModel:model];
                    
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"ColumnArticle%@", model.insightId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(NO) // 标识不重新更新
                             };
                }];
                
                
                
                
            }
            else
            {
                //        return 120;
                return [ColumnWithImageCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    ColumnWithImageCell *cell = (ColumnWithImageCell *)sourceCell;
                    // 配置数据
                    [cell configColumnArticleListTableCellWithGoodModel:model];
                    
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"ColumnArticle%@", model.insightId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(NO) // 标识重新更新
                             };
                }];
                
            }
            
        }
    }
    else {
        
        return KDeviceHeight - 381 - 64;
    }
    

}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
//    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:featuredCellIdentifier];
//    //    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    if (cell==nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:featuredCellIdentifier];
//    }
//    else{
//        // 避免cell重叠
//        while ([cell.contentView.subviews lastObject] != nil) {
//            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
//    }
    
    static NSString *CELLNONE = @"CELLNONE";

    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:featuredCellIdentifier];
        [cell setBackgroundColor:[UIColor whiteColor]];
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Find_load"]];
        
        loadingImage.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight - 381 - 64);
        
        [cell addSubview:loadingImage];
        return cell;
    }

    
    
    if (indexPath.row  < self.dataArray.count +1 ) {
        if (indexPath.row == 0) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:CELLNONE];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:CELLNONE];
                
            }else{
                    // 避免cell重叠
                    while ([cell.contentView.subviews lastObject] != nil) {
                        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
                    }
                }


//            cell.backgroundColor = [UIColor cyanColor];
            
            UIImageView * lineView = [[UIImageView alloc]init];
            
            lineView.frame = CGRectMake(14, 10, 2, 12.5);
            lineView.image = [UIImage imageNamed:@"rectangle_style"];
            
            UILabel * authorColunm = [[UILabel alloc]init];
            authorColunm.frame = CGRectMake(22, 10, 60, 12);
            authorColunm.text = @"精选文章";
            authorColunm.textColor = CCCUIColorFromHex(0x555555);
            authorColunm.font = [UIFont systemFontOfSize:12];

            [cell.contentView addSubview:lineView];
            [cell.contentView addSubview:authorColunm];
            
            
        }
        else {
            
            SingelColumnModel *insight = (SingelColumnModel *)_dataArray[indexPath.row - 1];
            if ([NSStrUtil isEmptyOrNull:insight.cover]) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:DiscoverFeaturedWithOutImageCellIdentifier];
                if (!cell) {
                    cell = [[ColumnWithOutImageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                         reuseIdentifier:DiscoverFeaturedWithOutImageCellIdentifier];
                    
                }
                
                ColumnWithOutImageCell *tbCell = (ColumnWithOutImageCell *)cell;
                [tbCell configColumnArticleListNoImageTableCellWithGoodModel:insight];
                [tbCell setNeedsUpdateConstraints];
                [tbCell updateConstraintsIfNeeded];
                
            }
            else
            {
                cell = [tableView dequeueReusableCellWithIdentifier:DiscoverFeaturedWithImageCellIdentifier];
                if (!cell) {
                    cell = [[ColumnWithImageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                      reuseIdentifier:DiscoverFeaturedWithImageCellIdentifier];
                }
                
                ColumnWithImageCell *tbCell = (ColumnWithImageCell *)cell;
                [tbCell configColumnArticleListTableCellWithGoodModel:insight];
                [tbCell setNeedsUpdateConstraints];
                [tbCell updateConstraintsIfNeeded];
            }

            
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SingelColumnModel *insight = (SingelColumnModel *)_dataArray[indexPath.row - 1];
    
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
        _tableView.backgroundColor =CCCUIColorFromHex(0xf7f7f7);

//        _tableView.backgroundColor = CCCUIColorFromHex(0xffffff);
        _tableView.rowHeight = 140;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:featuredCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    return _tableView;
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
