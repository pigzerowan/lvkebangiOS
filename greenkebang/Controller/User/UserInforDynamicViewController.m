//
//  UserInforDynamicViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/11/15.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforDynamicViewController.h"
#import "SVPullToRefresh.h"
#import "MyUserInfoManager.h"
#import "DynamicNoImageCell.h"
#import "DynamicOneImageCell.h"
#import "UserInforDynamicModel.h"
#import "LKBPrefixHeader.pch"
#import "HZPhotoGroup.h"
#import "HZPhotoItem.h"
#import "FarmerCircleViewController.h"
#import "CircleIfJoinManager.h"
#import "OutWebViewController.h"
#import "LoveTableFooterView.h"
#import "DynamicShareCell.h"
#import "ShareArticleManager.h"
#import "YQWebDetailViewController.h"
#import <UIImageView+WebCache.h>

NSString * const UserInforDynamicNoImageCellIdentifier = @"UserInforDynamicNoImageCellIdentifier";
NSString * const UserInforDynamicWithImageCellIdentifier = @"UserInforDynamicWithImageCellIdentifier";
NSString * const UserInforDynamicShareCellIdentifier = @"UserInforDynamicShareCellIdentifier";

static NSString* UserInforCellIdentifier = @"UserInforDynamicCellIdentifier";

@interface UserInforDynamicViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;

}


@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (copy, nonatomic) NSString * linkUrl;


@end

@implementation UserInforDynamicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self initializePageSubviews];
    self.dataArray = [[NSMutableArray alloc] init];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
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
    [MobClick endLogPageView:@"UserInforDynamicViewController"];
    
//     [[[SDWebImageManager sharedManager] imageCache] clearDisk];

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
    
    [MobClick beginLogPageView:@"UserInforDynamicViewController"];

}


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
    self.tableView.showsInfiniteScrolling = NO;
    [self.tableView triggerPullToRefresh];
    
    if (self.dataArray.count == 0) {
        
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        footerVew.textLabel.text=@"已经到底了";
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = YES;
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
    
    
    self.requestParas =  @{@"userId":_toUserId,
                           @"ownerId":[[MyUserInfoManager shareInstance]userId],
                           @"page":@(currPage),
                           @"token":[[MyUserInfoManager shareInstance]token],
                           isLoadingMoreKey:@(isLoadingMore)};
    self.requestURL = LKB_UserInfor_dynamic_Url;
    
    
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UserInforCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}





#pragma mark - UITableViewDataSource
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UserInforCellIdentifier];
//
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:UserInforCellIdentifier];
//        
//
//    }
    
    static NSString *CELLNONE = @"UserInforCELLNONE";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"no-content-yet"]];
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );
        
        [cell addSubview:loadingImage];

        return cell;
    }

    if (indexPath.row < self.dataArray.count) {
        
        UserDynamicModelIntroduceModel *insight = (UserDynamicModelIntroduceModel *)_dataArray[indexPath.row];
        
        
        NSLog(@"===================%lu",(unsigned long)insight.coverList.count);
        
        
        if (insight.coverList.count == 0) {
            
            if (insight.shareUrl !=nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:UserInforDynamicShareCellIdentifier];
                if (!cell) {
                    cell = [[DynamicShareCell alloc] initWithStyle:UITableViewCellStyleDefault                                                                               reuseIdentifier:UserInforDynamicShareCellIdentifier];
                    
                }
                
                DynamicShareCell *simplescell = (DynamicShareCell *)cell;
                [simplescell handlerButtonAction:^(NSInteger clickIndex) {
                    if (clickIndex == 1) {
                        //圈名称
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
                    if (clickIndex == 2) {
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
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/activity/%@",LKB_WSSERVICE_HTTP,str];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.VcType = @"7";
                            outSideWeb.rightButtonType = @"1";
                            outSideWeb.circleDetailId = str;
                            outSideWeb.shareType = @"3";
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
                [simplescell configUserInforDynamicShareModel:insight];
                [simplescell setNeedsUpdateConstraints];
                [simplescell updateConstraintsIfNeeded];
                
 
                
            }else {
            
                cell = [tableView dequeueReusableCellWithIdentifier:UserInforDynamicNoImageCellIdentifier];
                
                if (!cell) {
                    cell = [[DynamicNoImageCell alloc] initWithStyle:UITableViewCellStyleDefault                                                                                 reuseIdentifier:UserInforDynamicNoImageCellIdentifier];
                    
                }
                
                DynamicNoImageCell *simplescell = (DynamicNoImageCell *)cell;
                [simplescell handlerButtonAction:^(NSInteger clickIndex) {
                    if (clickIndex == 1) {
                        //圈名称
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
                [simplescell configUserInforDynamicNoImageModel:insight];
                [simplescell setNeedsUpdateConstraints];
                [simplescell updateConstraintsIfNeeded];
            }
        
            
        }
        else {

            cell = [tableView dequeueReusableCellWithIdentifier:UserInforDynamicWithImageCellIdentifier];
            
            if (!cell) {
                cell = [[DynamicOneImageCell alloc] initWithStyle:UITableViewCellStyleDefault                                                                          reuseIdentifier:UserInforDynamicWithImageCellIdentifier];
            }
            DynamicOneImageCell *simplescell = (DynamicOneImageCell *)cell;
            [simplescell configUserInforDynamicOneImageModel:insight];
            [simplescell handlerButtonAction:^(NSInteger clickIndex) {
                if (clickIndex == 1) {
                    //圈名称
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
            if (simplescell.coverListImage.subviews.count>0) {
                HZPhotoGroup *photoGroup = simplescell.coverListImage.subviews[0];
                
                [photoGroup removeFromSuperview];
                
            }
            HZPhotoGroup *photoGroup = [[HZPhotoGroup alloc] init];
            
            photoGroup.type = @"2";
            
            NSMutableArray *temp = [NSMutableArray array];
            
            
            
            NSArray *imagesstr = [insight.images componentsSeparatedByString:@","];
            
            NSMutableArray *srcStringArray = [NSMutableArray array];
            
            for (NSString *str in imagesstr) {
                
                
                
                NSString *cover = [NSString stringWithFormat:@"%@?imageView2/1/w/200/h/200",[str lkbImageUrlAllCover]];
                
                [srcStringArray addObject:cover];
                
            }
            
            NSLog(@"===============================%@",srcStringArray);
            
            
            
            [srcStringArray enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
                
                HZPhotoItem *item = [[HZPhotoItem alloc] init];
                
                item.thumbnail_pic = src;
                
                [temp addObject:item];
                
            }];
            
            
            
            
            
            photoGroup.photoItemArray = [temp copy];
            
            
            
            [simplescell.coverListImage addSubview:photoGroup];
            [simplescell setNeedsUpdateConstraints];
            [simplescell updateConstraintsIfNeeded];
            

            
        }
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_dataArray.count == 0) {
        
        return 1;

    }
    else {
        return self.dataArray.count ;

    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row<_dataArray.count) {
        UserDynamicModelIntroduceModel *model =self.dataArray[indexPath.row];
        
        NSLog(@"==================%lu",(unsigned long)model.coverList.count);
        
        
        if (model.coverList.count == 0 ) {
            
            if (model.shareUrl != nil) {
                return [DynamicShareCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    DynamicShareCell *cell = (DynamicShareCell *)sourceCell;
                    // 配置数据
                    [cell configUserInforDynamicShareModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"999%@-%@",model.groupId,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                             };
                }];

            }
            
            else {
            
                
                return [DynamicNoImageCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    DynamicNoImageCell *cell = (DynamicNoImageCell *)sourceCell;
                    // 配置数据
                    [cell configUserInforDynamicNoImageModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"999%@-%@",model.groupId,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                             };
                }];

            }
        }
        else {
        
            return [DynamicOneImageCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                DynamicOneImageCell *cell = (DynamicOneImageCell *)sourceCell;
                // 配置数据
                [cell configUserInforDynamicOneImageModel:model];
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"999%@-%@", model.groupId,model.objectId],
                         kHYBCacheStateKey : @"expanded",
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                         };
            }];
//            return 200;

            
        }
    
        
    }else {
        
        return 300;
    }
    
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < self.dataArray.count) {
        UserDynamicModelIntroduceModel *insight =self.dataArray[indexPath.row];
        
        NSString * linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
        NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:strmy];
        
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        outSideWeb.sendMessageType = @"2";
        outSideWeb.rightButtonType = @"2";
        outSideWeb.VcType = @"1";
        outSideWeb.urlStr = linkUrl;
        outSideWeb.circleId = insight.groupId;
        outSideWeb.circleDetailId = insight.objectId;
        outSideWeb.shareType = @"2";
        outSideWeb.mytitle = insight.title;
        outSideWeb.describle = insight.summary;
        outSideWeb.userAvatar = insight.userAvatar;
        outSideWeb.groupAvatar = insight.cover;
        outSideWeb.commendVcType = @"1";
        outSideWeb.isAttention = insight.isAttention;
        outSideWeb.groupName = insight.groupName;
        
        outSideWeb.toUserId = _toUserId;
        

        
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];
        
    }
    
    
    
    //    }

    
    
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (!request.isLoadingMore) {
        [self.tableView.pullToRefreshView stopAnimating];
    }
    else {
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
    
    if ([request.url isEqualToString:LKB_UserInfor_dynamic_Url]) {
        
        UserInforDynamicModel *useInforModel = (UserInforDynamicModel *)parserObject;
        
        if (!request.isLoadingMore) {
            
            if(useInforModel.data)
            {
                _dataArray= [NSMutableArray arrayWithArray:useInforModel.data];
            }
            
        }else {
            [_dataArray addObjectsFromArray:useInforModel.data];
        }
        [_tableView  reloadData];
        if (useInforModel.data.count == 0) {
            _tableView.tableFooterView.hidden = NO;
            [_tableView.infiniteScrollingView endScrollAnimating];
        } else {
            _tableView.showsInfiniteScrolling = YES;
            [_tableView.infiniteScrollingView beginScrollAnimating];
            //               [_allTableView.pullToRefreshView stopAnimating];
            
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    
}













@end
