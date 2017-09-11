//
//  MyAttentionSeperateTopicViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/6.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "MyAttentionSeperateTopicViewController.h"
#import "AttentionTopicCell.h"
#import "SVPullToRefresh.h"
#import "AttentionContentsModel.h"
#import "MyUserInfoManager.h"
#import "QADetailViewController.h"
#import "OutWebViewController.h"
#import "TimeShareArticleNoCommentCell.h"
#import "TimeNoImageNoCommentCell.h"
#import "TimeOneImageHeightNoCommentCell.h"
#import "TimeTwoImageNoCommentCell.h"
#import "TimeThreeImageNoCommentCell.h"
#import "NewUserMainPageViewController.h"
#import "ToUserManager.h"
#import "FarmerCircleViewController.h"
#import "CircleIfJoinManager.h"
#import "YQWebDetailViewController.h"
#import "ShareArticleManager.h"
#import "HZPhotoGroup.h"
#import "HZPhotoItem.h"

NSString * const AttentionTopicShareArticleCellIdentifier = @"AttentionTopicShareArticleNoCommentCellIdentifier";
NSString * const AttentionTopicNoImageCellIdentifier = @"AttentionTopicNoImageCellIdentifier";
NSString * const AttentionTopicOneImageCellIdentifier = @"AttentionTopicOneImageCellIdentifier";
NSString * const AttentionTopicTwoImageCellIdentifier = @"AttentionTopicTwoImageNoCommentCellIdentifier";
NSString * const AttentionTopicThreeImageCellIdentifier = @"AttentionTopicThreeImageNoCommentCellIdentifier";

static NSString* AttentionTopicCellIdentifier = @"AttentionTopicTableViewCellIdentifier";

@interface MyAttentionSeperateTopicViewController ()

{
    
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;
    
}

@property (nonatomic, copy)NSString * goodType;
@property (copy, nonatomic) NSString * linkUrl;

@end

@implementation MyAttentionSeperateTopicViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
    self.tableView.backgroundColor  = [UIColor whiteColor];
    self.dataArray = [[NSMutableArray alloc] init];
//    [self initializeData];
    [self initializePageSubviews];
    self.title = @"关注的动态";

    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.edgesForExtendedLayout = 0;
    
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

    
    
}

- (void)tryAgainButton:(id )sender {
    
    [self initializePageSubviews];
    
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;
    [MobClick endLogPageView:@"MyAttentionSeperateTopicViewController"];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
    // 隐藏导航下的线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [MobClick beginLogPageView:@"MyAttentionSeperateTopicViewController"];

}


#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
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

- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    
    self.requestParas = @{@"userId":_userId,
                          @"attentionType":@"0",
                          @"token":[MyUserInfoManager shareInstance].token,
                          @"page":@(currPage),
                          @"ownerId":[MyUserInfoManager shareInstance].userId,
                          isLoadingMoreKey:@(isLoadingMore)
                          
                          };
    self.requestURL = LKB_Attention_Contents_Url;


    
    
    
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
    
    if ([request.url isEqualToString:LKB_Attention_Contents_Url]) {
        AttentionContentsModel *groupModel = (AttentionContentsModel *)parserObject;
        
        NSLog(@"========%@===============",groupModel.data);
        if (!request.isLoadingMore) {
            if(groupModel.data)
            {
                _dataArray = [NSMutableArray arrayWithArray:groupModel.data];
            }
        } else {
            if (_dataArray.count< groupModel.num) {
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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray.count == 0) {
        return 1;
    }
    else {
        
        return self.dataArray.count;

    }
    
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 69;
    
    if (indexPath.row< _dataArray.count) {
        
        AttentionContentsListModel *attentionModel = (AttentionContentsListModel *)_dataArray[indexPath.row];
        NSLog(@"=================================%@",attentionModel.imageInfo);

        
        if (attentionModel.coverList.count == 1) {
            if (attentionModel.imageInfo == nil) {
                
                _oneImageHeight = 228;
                _oneImageWidth = 228;
            }
            else {
                _oneImageWidth = [[attentionModel.imageInfo valueForKey:@"width"] floatValue];
                _oneImageHeight = [[attentionModel.imageInfo valueForKey:@"height"] floatValue];
            }
        }
        
        
        if (attentionModel.coverList.count == 0 || (_oneImageHeight >0 && _oneImageHeight <171)||(_oneImageWidth >0 && _oneImageWidth <171) ) {
            // 分享
            if (attentionModel.shareUrl != nil) {
                // 分享
//                return 200;
                return [TimeShareArticleNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    
                    TimeShareArticleNoCommentCell *cell = (TimeShareArticleNoCommentCell *)sourceCell;
                    
                    // 配置数据
                    
                    [cell configAttentionTopicShareArticleCellTimeNewDynamicDetailModel:attentionModel];
                    
                } cache:^NSDictionary *{
                    
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", attentionModel.type,attentionModel.topicId],kHYBCacheStateKey : @"expanded",
                             
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             
                             };
                    
                }];
                
                
            }
            else  {
                
//                return 200;
                return [TimeNoImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeNoImageNoCommentCell *cell = (TimeNoImageNoCommentCell *)sourceCell;
                    
                     //配置数据
                    
                    [cell configAttentionTopicNoImageDetailModel:attentionModel];
                    
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", attentionModel.type,attentionModel.topicId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
            }
            
        }

        
        
        
        if (attentionModel.coverList.count == 1  && _oneImageHeight >171 &&_oneImageWidth >171) {
            // 一图
//            return 100;
            return [TimeOneImageHeightNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                TimeOneImageHeightNoCommentCell *cell = (TimeOneImageHeightNoCommentCell *)sourceCell;
                 // 配置数据
                [cell configAttentionTopicOneImageDetailModel:attentionModel];
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", attentionModel.type,attentionModel.topicId],kHYBCacheStateKey : @"expanded",
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                         
                         };
            }];
        }
        
        
        
        
        
        else if (attentionModel.coverList.count == 2) {
            // 两张图片
//            return 200;
            return [TimeTwoImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                TimeTwoImageNoCommentCell *cell = (TimeTwoImageNoCommentCell *)sourceCell;
                 // 配置数据
                [cell configAttentionTopicTwoImageCellTimeNewDynamicDetailModel:attentionModel];
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", attentionModel.type,attentionModel.topicId],kHYBCacheStateKey : @"expanded",
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                         };
            }];
        }
        
        
        
        
        else {
            // 三张图片
            
//            return 200;
            return [TimeThreeImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                TimeThreeImageNoCommentCell *cell = (TimeThreeImageNoCommentCell *)sourceCell;
                
                 //配置数据
                
                [cell configAttentionTopicThreeImageCellTimeNewDynamicDetailModel:attentionModel];
                
            } cache:^NSDictionary *{
                
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", attentionModel.type,attentionModel.topicId],kHYBCacheStateKey : @"expanded",
                         
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         
                         kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                         
                         };
                
            }];
        }
        
        
        
        
        
        
        
        
    }

    else {
        
        return KDeviceHeight - 64;
    }
    
        
        
    


}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString *CELLNONE = @"CELLNONE";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
        [cell setBackgroundColor:[UIColor whiteColor]];
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"no-content-yet"]];
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );
        
        [cell addSubview:loadingImage];
        return cell;
    }
    
    
    if (indexPath.row < _dataArray.count) {
        
        
        NSLog(@"/////////////////<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<%@",_dataArray);
        
//        NewDynamicDetailModel *insight = (NewDynamicDetailModel *)_dataArray[indexPath.row ];
        AttentionContentsListModel *insight = (AttentionContentsListModel *)_dataArray[indexPath.row];

        if (insight.coverList.count == 1) {
            //                NSError *error;
            NSLog(@"--------------------%@",insight.objectId);
            NSLog(@"--------------------%@",insight.imageInfo);
            
            if (insight.imageInfo == nil) {
                
                _oneImageHeight = 228;
                _oneImageWidth = 228;
            }
            else {
                
                _oneImageWidth = [[insight.imageInfo valueForKey:@"width"] floatValue];
                _oneImageHeight = [[insight.imageInfo valueForKey:@"height"] floatValue];
                
                
            }
        }
        
        
        if (insight.coverList.count == 0 || (_oneImageHeight >0 && _oneImageHeight <171)||(_oneImageWidth >0 && _oneImageWidth <171)) {
            
            // 分享
            if (insight.shareUrl !=nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:AttentionTopicShareArticleCellIdentifier];
                if (!cell) {
                    
                    cell = [[TimeShareArticleNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:AttentionTopicShareArticleCellIdentifier];
                }
                
                TimeShareArticleNoCommentCell *tbCell = (TimeShareArticleNoCommentCell *)cell;
                
                [tbCell configAttentionTopicShareArticleCellTimeNewDynamicDetailModel:insight];
                [tbCell ShareArticleNoCommenthandlerButtonAction:^(NSInteger clickIndex) {
                    
                    if (clickIndex == 1)  {
                        
                        NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                        peopleVC.type = @"2";
                        peopleVC.toUserId = insight.userId;
                        if (![insight.userId isEqual:[MyUserInfoManager shareInstance].userId]) {
                            [ToUserManager shareInstance].userName = insight.userName;
                        }
                        peopleVC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:peopleVC animated:YES];
                        
                    }
                    if (clickIndex == 3) {
                        
                        FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
                        farmerVC.type = @"1";
                        
                        NSString *str = [NSString stringWithFormat:@"circle%@",insight.groupId];
                        
                        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                        //
                        NSString *passWord = [ user objectForKey:str];
                        if (!passWord) {
                            farmerVC.ifJion = insight.isJoin;
                            [CircleIfJoinManager shareInstance].ifJoin = insight.isJoin;
                            
                        }
                        else
                        {
                            farmerVC.ifJion = passWord;
                            [CircleIfJoinManager shareInstance].ifJoin = passWord;
                            
                        }
                        farmerVC.circleId = insight.groupId;
                        farmerVC.toUserId = [MyUserInfoManager shareInstance].userId;
                        farmerVC.mytitle = insight.groupName;
                        farmerVC.type= @"1";
                        
                        farmerVC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:farmerVC animated:YES];
                    }
                    if (clickIndex == 7) {
                        
                        if ([insight.shareUrl rangeOfString:@"jianjie"].location != NSNotFound) {
                            
                            NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/"];
                            
                            NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                            
                            
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,str] ;
                            
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            
                            outSideWeb.VcType = @"2";
                            outSideWeb.rightButtonType = @"1";
                            outSideWeb.sendMessageType = @"1";
                            outSideWeb.circleDetailId = str;
                            
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.shareTitle;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;
                            outSideWeb.shareImage = insight.shareImage;
                            [ShareArticleManager shareInstance].shareType = @"1";
                            NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            outSideWeb.squareType = @"1";
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                            
                        }
                        else if ([insight.shareUrl rangeOfString:@"huodong"].location != NSNotFound) {
                            NSString *huodong = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/"];
                            
                            NSString * str = [insight.shareUrl substringFromIndex: huodong.length];
                            
                            //                                    _linkUrl = [NSString stringWithFormat:@"%@",insight.shareUrl];
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/activity/%@",LKB_WSSERVICE_HTTP,str];
                            
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            
                            outSideWeb.VcType = @"7";
                            outSideWeb.rightButtonType = @"1";
                            outSideWeb.circleDetailId = str;
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.shareTitle;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;
                            outSideWeb.shareImage = insight.shareImage;
                            [ShareArticleManager shareInstance].shareType = @"1";
                            NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            outSideWeb.squareType = @"1";
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                            
                            
                        }
                        else {
                            
                            
                            YQWebDetailViewController* webDetailVC = [[YQWebDetailViewController alloc] init];
                            webDetailVC.urlStr = insight.shareUrl;
                            webDetailVC.mytitle = insight.shareTitle;
                            webDetailVC.coverUrl = insight.shareImage;
                            webDetailVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:webDetailVC animated:YES];
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                }];
                
                [tbCell setNeedsUpdateConstraints];
                [tbCell updateConstraintsIfNeeded];
                
                
            }
            
            else {
                
                //无图
                cell = [tableView dequeueReusableCellWithIdentifier:AttentionTopicNoImageCellIdentifier];
                if (!cell) {
                    cell = [[TimeNoImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:AttentionTopicNoImageCellIdentifier];
                }
                TimeNoImageNoCommentCell *tbCell = (TimeNoImageNoCommentCell *)cell;
                
                [tbCell configAttentionTopicNoImageDetailModel:insight];
                
                [tbCell handlerButtonAction:^(NSInteger clickIndex) {
                    if (clickIndex == 1)  {
                        
                        NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                        peopleVC.type = @"2";
                        peopleVC.toUserId = insight.userId;
                        if (![insight.userId isEqual:[MyUserInfoManager shareInstance].userId]) {
                            [ToUserManager shareInstance].userName = insight.userName;
                            
                        }
                        
                        
                        peopleVC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:peopleVC animated:YES];
                    }
                    if (clickIndex == 3) {
                        FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
                        farmerVC.type = @"1";
                        NSString *str = [NSString stringWithFormat:@"circle%@",insight.groupId];
                        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                        NSString *passWord = [ user objectForKey:str];
                        if (!passWord) {
                            farmerVC.ifJion = insight.isJoin;
                            [CircleIfJoinManager shareInstance].ifJoin = insight.isJoin;
                            
                        }
                        else
                        {
                            farmerVC.ifJion = passWord;
                            [CircleIfJoinManager shareInstance].ifJoin = passWord;
                            
                        }
                        farmerVC.circleId = insight.groupId;
                        farmerVC.toUserId = [MyUserInfoManager shareInstance].userId;
                        farmerVC.mytitle = insight.groupName;
                        farmerVC.type= @"1";
                        
                        farmerVC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:farmerVC animated:YES];
                    }
                    
                }];
                
                [tbCell setNeedsUpdateConstraints];
                [tbCell updateConstraintsIfNeeded];
            }
        }
        
        
        else if (insight.coverList.count == 1 ) {
            
            // 一图
            cell = [tableView dequeueReusableCellWithIdentifier:AttentionTopicOneImageCellIdentifier];
            if (!cell) {
                
                cell = [[TimeOneImageHeightNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                              reuseIdentifier:AttentionTopicOneImageCellIdentifier];
            }
            
            TimeOneImageHeightNoCommentCell *tbCell = (TimeOneImageHeightNoCommentCell *)cell;
            
            [tbCell configAttentionTopicOneImageDetailModel:insight];
            [tbCell OneImageHeightNoCommenthandlerButtonAction:^(NSInteger clickIndex) {
                
                if (clickIndex == 1)  {
                    
                    NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                    peopleVC.type = @"2";
                    peopleVC.toUserId = insight.userId;
                    if (![insight.userId isEqual:[MyUserInfoManager shareInstance].userId]) {
                        [ToUserManager shareInstance].userName = insight.userName;
                        
                    }
                    
                    
                    peopleVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:peopleVC animated:YES];
                    
                }
                if (clickIndex == 3) {
                    
                    FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
                    farmerVC.type = @"1";
                    
                    NSString *str = [NSString stringWithFormat:@"circle%@",insight.groupId];
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    NSString *passWord = [ user objectForKey:str];
                    if (!passWord) {
                        farmerVC.ifJion = insight.isJoin;
                        [CircleIfJoinManager shareInstance].ifJoin = insight.isJoin;
                        
                    }
                    else
                    {
                        farmerVC.ifJion = passWord;
                        [CircleIfJoinManager shareInstance].ifJoin = passWord;
                        
                    }
                    
                    NSLog(@"------------------------------------------%@",insight.isJoin);
                    farmerVC.circleId = insight.groupId;
                    farmerVC.toUserId = [MyUserInfoManager shareInstance].userId;
                    farmerVC.mytitle = insight.groupName;
                    farmerVC.type= @"1";
                    
                    farmerVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:farmerVC animated:YES];
                }
            }];
            
            if (tbCell.coverListImage.subviews.count>0) {
                HZPhotoGroup *photoGroup = tbCell.coverListImage.subviews[0];
                [photoGroup removeFromSuperview];
            }
            
            
            HZPhotoGroup *photoGroup = [[HZPhotoGroup alloc] init];
            
            NSMutableArray *temp = [NSMutableArray array];
            //                    NSString *cover = [NSString stringWithFormat:@"%@?imageMogr2/gravity/Center/thumbnail/!456x342r/crop/456x/interlace/1/format/jpg",[insight.images lkbImageUrlAllCover]];
            NSString *cover = [NSString stringWithFormat:@"%@?imageView2/1/w/228/h/228",[insight.images lkbImageUrlAllCover]];
            
            NSArray *srcStringArray = [NSArray arrayWithObject:cover];
            
            NSLog(@"===============================%@",srcStringArray);
            [srcStringArray enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
                HZPhotoItem *item = [[HZPhotoItem alloc] init];
                item.thumbnail_pic = src;
                [temp addObject:item];
            }];
            
            
            photoGroup.photoItemArray = [temp copy];
            photoGroup.oneImageHeight = _oneImageHeight;
            photoGroup.oneImageWidth = _oneImageWidth;
            
            [tbCell.coverListImage addSubview:photoGroup];
            
            
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
        
        else if (insight.coverList.count == 2) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:AttentionTopicTwoImageCellIdentifier];
            if (!cell) {
                
                cell = [[TimeTwoImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                        reuseIdentifier:AttentionTopicTwoImageCellIdentifier];
            }
            
            TimeTwoImageNoCommentCell *tbCell = (TimeTwoImageNoCommentCell *)cell;
            
            [tbCell configAttentionTopicTwoImageCellTimeNewDynamicDetailModel:insight];
            [tbCell TwoImageNoCommenthandlerButtonAction:^(NSInteger clickIndex) {
                if (clickIndex == 1)  {
                    
                    NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                    peopleVC.type = @"2";
                    peopleVC.toUserId = insight.userId;
                    if (![insight.userId isEqual:[MyUserInfoManager shareInstance].userId]) {
                        [ToUserManager shareInstance].userName = insight.userName;
                        
                    }
                    
                    
                    
                    peopleVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:peopleVC animated:YES];
                    
                }
                if (clickIndex == 3) {
                    
                    FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
                    farmerVC.type = @"1";
                    
                    NSString *str = [NSString stringWithFormat:@"circle%@",insight.groupId];
                    
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    //
                    NSString *passWord = [ user objectForKey:str];
                    
                    
                    
                    if (!passWord) {
                        farmerVC.ifJion = insight.isJoin;
                        [CircleIfJoinManager shareInstance].ifJoin = insight.isJoin;
                        
                    }
                    else
                    {
                        farmerVC.ifJion = passWord;
                        [CircleIfJoinManager shareInstance].ifJoin = passWord;
                        
                    }
                    farmerVC.circleId = insight.groupId;
                    farmerVC.toUserId = [MyUserInfoManager shareInstance].userId;
                    farmerVC.mytitle = insight.groupName;
                    farmerVC.type= @"1";
                    
                    farmerVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:farmerVC animated:YES];
                }
                
            }];
            if (tbCell.coverListImage.subviews.count>0) {
                HZPhotoGroup *photoGroup = tbCell.coverListImage.subviews[0];
                [photoGroup removeFromSuperview];
            }
            
            
            HZPhotoGroup *photoGroup = [[HZPhotoGroup alloc] init];
            
            NSMutableArray *temp = [NSMutableArray array];
            NSArray *imagesstr = [insight.images componentsSeparatedByString:@","];
            NSMutableArray *srcStringArray = [NSMutableArray array];
            for (NSString *str in imagesstr) {
                
                NSString *cover = [NSString stringWithFormat:@"%@?imageView2/1/w/228/h/228",[str lkbImageUrlAllCover]];
                
                [srcStringArray addObject:cover];
            }
            NSLog(@"===============================%@",srcStringArray);
            [srcStringArray enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
                HZPhotoItem *item = [[HZPhotoItem alloc] init];
                item.thumbnail_pic = src;
                [temp addObject:item];
            }];
            
            photoGroup.photoItemArray = [temp copy];
            [tbCell.coverListImage addSubview:photoGroup];
            
            
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
            
        }
        
        else if (insight.coverList.count == 3) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:AttentionTopicThreeImageCellIdentifier];
            if (!cell) {
                
                cell = [[TimeThreeImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:AttentionTopicThreeImageCellIdentifier];
            }
            
            TimeThreeImageNoCommentCell *tbCell = (TimeThreeImageNoCommentCell *)cell;
            
            [tbCell configAttentionTopicThreeImageCellTimeNewDynamicDetailModel:insight];
            [tbCell ThreeImageNoCommenthandlerButtonAction:^(NSInteger clickIndex) {
                
                if (clickIndex == 1)  {
                    
                    NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                    peopleVC.type = @"2";
                    peopleVC.toUserId = insight.userId;
                    
                    if (![insight.userId isEqual:[MyUserInfoManager shareInstance].userId]) {
                        [ToUserManager shareInstance].userName = insight.userName;
                    }
                    
                    
                    peopleVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:peopleVC animated:YES];
                    
                }
                if (clickIndex == 3) {
                    
                    FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
                    farmerVC.type = @"1";
                    
                    NSString *str = [NSString stringWithFormat:@"circle%@",insight.groupId];
                    
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    //
                    NSString *passWord = [ user objectForKey:str];
                    if (!passWord) {
                        farmerVC.ifJion = insight.isJoin;
                        [CircleIfJoinManager shareInstance].ifJoin = insight.isJoin;
                        
                    }
                    else
                    {
                        farmerVC.ifJion = passWord;
                        [CircleIfJoinManager shareInstance].ifJoin = passWord;
                        
                    }
                    farmerVC.circleId = insight.groupId;
                    farmerVC.toUserId = [MyUserInfoManager shareInstance].userId;
                    farmerVC.mytitle = insight.groupName;
                    farmerVC.type= @"1";
                    
                    farmerVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:farmerVC animated:YES];
                }
            }];
            if (tbCell.coverListImage.subviews.count>0) {
                HZPhotoGroup *photoGroup = tbCell.coverListImage.subviews[0];
                [photoGroup removeFromSuperview];
            }
            
            
            HZPhotoGroup *photoGroup = [[HZPhotoGroup alloc] init];
            
            NSMutableArray *temp = [NSMutableArray array];
            NSArray *imagesstr = [insight.images componentsSeparatedByString:@","];
            NSMutableArray *srcStringArray = [NSMutableArray array];
            for (NSString *str in imagesstr) {
                
                NSString *cover = [NSString stringWithFormat:@"%@?imageView2/1/w/228/h/228",[str lkbImageUrlAllCover]];
                
                [srcStringArray addObject:cover];
            }
            NSLog(@"===============================%@",srcStringArray);
            [srcStringArray enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
                HZPhotoItem *item = [[HZPhotoItem alloc] init];
                item.thumbnail_pic = src;
                [temp addObject:item];
            }];
            
            photoGroup.photoItemArray = [temp copy];
            [tbCell.coverListImage addSubview:photoGroup];
            
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
            
        }

        
        
        
        
        
        
    }
    return cell;



//    AttentionTopicCell *simplescell = [tableView dequeueReusableCellWithIdentifier:AttentionTopicCellIdentifier];
//    if (indexPath.row < self.dataArray.count) {
//
//        AttentionContentsListModel *attentionModel = (AttentionContentsListModel *)_dataArray[indexPath.row];
//
//        [simplescell configAttentionTopicTableCellWithGoodModel:attentionModel];
//
//        [simplescell setNeedsUpdateConstraints];
//        [simplescell updateConstraintsIfNeeded];
//
//
//    }
//    return simplescell;

//    if (indexPath.row< _dataArray.count) {
//
//        AttentionContentsListModel *attentionModel = (AttentionContentsListModel *)_dataArray[indexPath.row];
//        NSLog(@"=================================%@",attentionModel.imageInfo);
//
//
//        if (attentionModel.coverList.count == 1) {
//            if (attentionModel.imageInfo == nil) {
//
//                _oneImageHeight = 228;
//                _oneImageWidth = 228;
//            }
//            else {
//                _oneImageWidth = [[attentionModel.imageInfo valueForKey:@"width"] floatValue];
//                _oneImageHeight = [[attentionModel.imageInfo valueForKey:@"height"] floatValue];
//            }
//        }
//
//
//        if (attentionModel.coverList.count == 0 || (_oneImageHeight >0 && _oneImageHeight <171)||(_oneImageWidth >0 && _oneImageWidth <171) ) {
//            // 分享
//            if (attentionModel.shareUrl != nil) {
//                // 分享
//                //                return 200;
//                return [TimeShareArticleNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
//                    
//                    //                        TimeShareArticleNoCommentCell *cell = (TimeShareArticleNoCommentCell *)sourceCell;
//                    
//                    //                        // 配置数据
//                    
//                    //                        [cell configTimeShareArticleNoCommentCellTimeNewDynamicDetailModel:attentionModel];
//                    
//                } cache:^NSDictionary *{
//                    
//                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", attentionModel.type,attentionModel.topicId],kHYBCacheStateKey : @"expanded",
//                             
//                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
//                             
//                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
//                             
//                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
//                             
//                             };
//                    
//                }];
//                
//                
//            }
//            else  {
//                
//                //                return 200;
//                return [TimeNoImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
//                    //                    TimeNoImageNoCommentCell *cell = (TimeNoImageNoCommentCell *)sourceCell;
//                    
//                    // 配置数据
//                    
//                    //                        [cell configTimeNoImageNoCommentTimeNewDynamicDetailModel:insight];
//                    
//                } cache:^NSDictionary *{
//                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", attentionModel.type,attentionModel.topicId],kHYBCacheStateKey : @"expanded",
//                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
//                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
//                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
//                             };
//                }];
//            }
//            
//        }
//        
//        
//        
//        
//        if (attentionModel.coverList.count == 1  && _oneImageHeight >171 &&_oneImageWidth >171) {
//            // 一图
//            //            return 100;
//            return [TimeOneImageHeightNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
//                //                TimeOneImageHeightNoCommentCell *cell = (TimeOneImageHeightNoCommentCell *)sourceCell;
//                // 配置数据
//                //                        [cell configTimeOneImageHeightNoCommentCellTimeNewDynamicDetailModel:insight];
//            } cache:^NSDictionary *{
//                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", attentionModel.type,attentionModel.topicId],kHYBCacheStateKey : @"expanded",
//                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
//                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
//                         kHYBRecalculateForStateKey : @(YES) // 标识重新更新
//                         
//                         };
//            }];
//        }
//        
//        
//        
//        
//        
//        else if (attentionModel.coverList.count == 2) {
//            // 两张图片
//            //            return 200;
//            return [TimeTwoImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
//                //                TimeTwoImageNoCommentCell *cell = (TimeTwoImageNoCommentCell *)sourceCell;
//                // 配置数据
//                //                        [cell configTimeTwoImageNoCommentCellTimeNewDynamicDetailModel:insight];
//            } cache:^NSDictionary *{
//                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", attentionModel.type,attentionModel.topicId],kHYBCacheStateKey : @"expanded",
//                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
//                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
//                         kHYBRecalculateForStateKey : @(YES) // 标识重新更新
//                         };
//            }];
//        }
//        
//        
//        
//        
//        else {
//            // 三张图片
//            
//            //            return 200;
//            return [TimeThreeImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
//                //                    TimeThreeImageNoCommentCell *cell = (TimeThreeImageNoCommentCell *)sourceCell;
//                
//                // 配置数据
//                
//                //                    [cell configTimeThreeImageNoCommentCellTimeNewDynamicDetailModel:insight];
//                
//            } cache:^NSDictionary *{
//                
//                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", attentionModel.type,attentionModel.topicId],kHYBCacheStateKey : @"expanded",
//                         
//                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
//                         
//                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
//                         
//                         kHYBRecalculateForStateKey : @(YES) // 标识重新更新
//                         
//                         };
//                
//            }];
//        }
//        
//        
//        
//        
//        
//        
//        
//        
//    }
    

    

}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArray.count) {
        
        
        AttentionContentsListModel *attentionModel = (AttentionContentsListModel *)_dataArray[indexPath.row];
        
//        if (_controllerType == 1) {
//            
//            TopicDetaillViewController *TopicVC = [[TopicDetaillViewController alloc] init];
//            TopicVC.topicId = attentionModel.topicId;
//            [self.navigationController pushViewController:TopicVC animated:YES];
//
//        }
//        else {
//            QADetailViewController *BlogVC = [[QADetailViewController alloc] init];
//            BlogVC.questionId = attentionModel.questionId;
//            
//            [self.navigationController pushViewController:BlogVC animated:YES];
//
//        }
        
        

//        NewDynamicModel *newDynamicModel = (NewDynamicModel *)_dataArray[indexPath.row];
//        QADetailViewController *qadetailVC = [[QADetailViewController alloc] init];
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//        [formatter setDateStyle:NSDateFormatterMediumStyle];
//        [formatter setTimeStyle:NSDateFormatterShortStyle];
//        [formatter setDateFormat:@"YYYY-MM-dd"];
//        NSString*strrr1=newDynamicModel.addTime;
//        NSTimeInterval time=[strrr1 doubleValue]/1000;
//        NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//        
//        NSString *confromTimespStr = [formatter stringFromDate:detaildate];
//        
//        
//        qadetailVC.timeStr = confromTimespStr;
//        //            qadetailVC.questionDesc = newDynamicModel.questionDesc;
//        qadetailVC.autherName = newDynamicModel.userName;
//        qadetailVC.questionId = newDynamicModel.questionId;
//        qadetailVC.questionUserId = newDynamicModel.userId;
//        qadetailVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:qadetailVC animated:YES];
        
        NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,attentionModel.topicId,attentionModel.groupId];
        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        
        outSideWeb.sendMessageType = @"2";
        outSideWeb.rightButtonType = @"2";
        outSideWeb.VcType = @"1";// 圈子动态
        outSideWeb.urlStr =linkUrl;
        outSideWeb.htmlStr = linkUrl;
        outSideWeb.circleId = attentionModel.groupId;
        outSideWeb.circleDetailId = attentionModel.topicId;
        outSideWeb.objectId = attentionModel.topicId;
        
//        outSideWeb.mytitle = attentionModel.;
        outSideWeb.describle = attentionModel.topicSummary;
//        outSideWeb.userAvatar = insight.userAvatar;
//        outSideWeb.isAttention = insight.isAttention;
        outSideWeb.commendVcType = @"1";
        outSideWeb.groupName = attentionModel.groupName;
        
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];

        

    }
    
    
}

#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor cyanColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[AttentionTopicCell class] forCellReuseIdentifier:AttentionTopicCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}




#pragma mark - Page subviews
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
