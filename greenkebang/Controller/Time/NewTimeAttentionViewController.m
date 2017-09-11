//
//  NewTimeAttentionViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/9/9.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "NewTimeAttentionViewController.h"
#import "TimeTableViewCell.h"
#import "SVPullToRefresh.h"
#import "NewTimeDynamicModel.h"
#import "InsightDetailViewController.h"
#import "DiscoverTableViewCell.h"
#import "MyUserInfoManager.h"
#import "NewTimeTableViewCell.h"
#import "NoImageDetailCell.h"
#import "NoImageButWithDetailCell.h"
#import "QADetailViewController.h"
#import "NoImageNoDetailCell.h"
#import "TimeCreatGroupCell.h"
#import "ImageButNoDetailCell.h"
#import "AutoLayoutDefautCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "HorizontalMenu.h"
#import "ReportViewController.h"
#import "CoulmmNoImageCell.h"
#import "LoveTableFooterView.h"
#import "GeTuiSdk.h"
#import "OutWebViewController.h"
#import "SelectedRecommendViewController.h"
#import "TimeNoImageNoCommentCell.h"
#import "TimeNoImageWithCommentCell.h"
#import "TimeTwoImageNoCommentCell.h"
#import "TimeTwoImageWithCommentCell.h"
#import "TimeThreeImageNoCommentCell.h"
#import "TimeThreeImageWithCommentCell.h"
#import "TimeNoImageWithOneCommentCell.h"
#import "TimeTwoImageWithOneCommentCell.h"
#import "TimeThreeImageWithOneCommentCell.h"
#import "TimeAllDynamicCirleCollectionCell.h"
#import "FarmerCircleViewController.h"
#import "UserRootViewController.h"
#import "TimeOneImageHeightNoCommentCell.h"
#import "TimeOneImageHeightWithOneCommentCell.h"
#import "TimeOneImageHeightWithCommentCell.h"
#import "FileHelpers.h"
#import "HZPhotoGroup.h"
#import "HZPhotoItem.h"
#import "CircleIfJoinManager.h"
#import "NewUserMainPageViewController.h"
#import "NewShareToViewController.h"
#import "TYAlertController+BlurEffects.h"
#import "NewShareActionView.h"
#import "TYAlertController.h"
#include "UMSocial.h"
#import "PeopleViewController.h"
#import "TimeShareArticleNoCommentCell.h"
#import "TimeShareArticleWithCommentCell.h"
#import "TimeShareArticleWithOneCommentCell.h"
#import "ShareArticleManager.h"
#import "YQWebDetailViewController.h"
#define CLICK_LIKE 10003
#define CANCEL_LIKE 10004
//NSString * const TimeNomorlCellIdentifier = @"TimeNomorlCell";
NSString * const TimeAttNoImageNoCommentCellIdentifier = @"TimeAttNoImageNoCommentDetail";
NSString * const TimeAttNoImageWithCommentCellIdentifier = @"TimeAttNoImageWithCommentDetail";
NSString * const TimeAttNoImageWithOneCommentCellIdentifier = @"TimeAttNoImageWithOneCommentDetail";
NSString * const TimeAttOneImageHeightNoCommentCellIdentifier = @"TimeAttOneImageHeightNoCommentIdentifier";
NSString * const TimeAttOneImageHeightWithOneCommentCellIdentifier = @"TimeAttOneImageHeightWithOneCommentIdentifier";
NSString * const TimeAttOneImageHeightWithCommentCellIdentifier = @"TimeAttOneImageHeightWithCommentIdentifier";
NSString * const TimeAttTwoImageNoCommentCellIdentifier = @"TimeAttTwoImageNoCommentIdentifier";
NSString * const TimeAttTwoImageWithOneCommentCellIdentifier = @"TimeAttTwoImageWithOneCommentIdentifier";
NSString * const TimeAttTwoImageWithCommentCellIdentifier = @"TimeAttTwoImageWithCommentIdentifier";
NSString * const TimeAttThreeImageNoCommentCellIdentifier = @"TimeAttThreeImageNoCommentCellIdentifier";
NSString * const TimeAttThreeImageWithOneCommentCellIdentifier = @"TimeAttThreeImageWithOneCommentCellIdentifier";
NSString * const TimeAttThreeImageWithCommentCellIdentifier = @"TimeAttThreeImageWithCommentCellIdentifier";
NSString * const TimeAttShareArticleNoCommentCellIdentifier = @"TimeAttShareArticleNoCommentCellIdentifier";
NSString * const TimeAttShareArticleWithCommentCellIdentifier = @"TimeAttShareArticleWithCommentCellIdentifier";
NSString * const TimeAttShareArticleWithOneCommentCellIdentifier = @"TimeAttShareArticleWithOneCommentCellIdentifier";


static NSString* KKAttCellIdentifier = @"TimeAttTableViewCellIdentifier";
static NSString* AttAutoLayoutDefautCellIdentifier = @"AttAutoLayoutDefautCellIdentifier";
@interface NewTimeAttentionViewController ()<UITableViewDelegate,UITableViewDataSource,HorizontalMenuDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSString *timeType;
    UIView *perfectionDegreeView;
    NSString *jsonStr;
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;

}

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic) NSMutableArray *groupArray;
@property (strong, nonatomic) UIButton *publishButton;
@property (assign, nonatomic) NSInteger sectionIdex;
@property (copy, nonatomic) NSString* reportType;
@property (copy, nonatomic) NSString* reportObject;
@property (copy, nonatomic)NewDynamicDetailModel *Goupinsight;
@property (copy, nonatomic)NSIndexSet *GroupIndexSet;
@property(nonatomic,strong)TYAlertController *alertController;
@property(nonatomic, strong)NSString *urlStr;
@property(nonatomic, strong)NSString *shareCover;
@property(nonatomic, strong)NSString *circleCover;
@property(nonatomic, strong)NSString *objectId;
@property(nonatomic, strong)NSString *groupId;
@property(nonatomic, strong)NSString *mytitle;
@property(nonatomic, strong)NSString *describle;
@property(nonatomic, strong)NSString *shareType;
@property(nonatomic, strong)NSString *shareUrl;






@end
@implementation NewTimeAttentionViewController
#pragma mark - Life cycle

- (instancetype)init
{
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}


#pragma mark - Page subviews

- (void)initializeData
{
    _groupArray = [NSMutableArray array];
    self.dataArray = [[NSMutableArray alloc] init];
}



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    timeType = @"0";
    [self initializeData];
    
    [self initializePageSubviews];
    
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



- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBarTintColor:CCCUIColorFromHex(0x323436)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [ShareArticleManager shareInstance].shareType = nil;
    [MobClick beginLogPageView:@"NewTimeAttentionViewController"];

    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"NewTimeAttentionViewController"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
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
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"page":@(currPage),
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    self.RequestPostWithChcheURL = LKB_ALL_DYNAMIC;
}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject errorMessage:(NSString *)errorMessage
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
        
        if ([errorMessage isEqualToString:@"暂无数据！"]) {
            
            
            [self.tableView removeFromSuperview];
            
            WithoutInternetImage.image = [UIImage imageNamed:@"no-content-yet"];
            WithoutInternetImage.hidden = NO;
            tryAgainButton.hidden = YES;

        }

        
        return;
    }
    
    if ([request.url isEqualToString:LKB_ALL_DYNAMIC]||[request.url isEqualToString:LKB_ALL_DYNAMIC_Question]||[request.url isEqualToString:LKB_ALL_DYNAMIC_Insight]||[request.url isEqualToString:LKB_ALL_DYNAMIC_Topic]||[request.url isEqualToString:LKB_ALL_allDynamics]) {
        
        NewTimeDynamicModel *topicModel = (NewTimeDynamicModel *)parserObject;
//        if ([MyUserInfoManager shareInstance].avatar == nil) {
            [MyUserInfoManager shareInstance].avatar = @"defualt_normal.png";
//        }
        
        
        
        NSLog(@"++++++++++++++++++++++++++++++%@",[topicModel.data valueForKey:@"summary"]);


        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:topicModel.data];
        }else {
            [_dataArray addObjectsFromArray:topicModel.data];
        }
        

        [self.tableView reloadData];
        if (topicModel.data.count == 0) {
            //             self.tableView.showsInfiniteScrolling = NO;
            self.tableView.tableFooterView.hidden = NO;
            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
        }
    }
    
    
    

}


- (void)tryAgainButton:(id )sender {
    
    [self initializePageSubviews];
    
}


//异步加载图片
- (UIImage *)LoadImage:(NSDictionary*)aDic{
    
    NSLog(@"--------------------------%@",aDic);
    //    NSURL *aURL=[NSURL URLWithString:[aDic objectForKey:@"featureAvatar"]];
    NSURL *aURL = [aDic objectForKey:@"AllCover"];
    
    NSData *data=[NSData dataWithContentsOfURL:aURL];
    if (data == nil) {
        return nil;
    }
    UIImage *image=[UIImage imageWithData:data];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager createFileAtPath:pathForURL(aURL) contents:data attributes:nil];
    return image;
}



- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView* footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor infosBackViewColor];
    return footerView;
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
    
}

#pragma mark - Table view data source
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
    if (self.dataArray.count == 0) {
        
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
    if (indexPath.row<_dataArray.count) {
        NewDynamicDetailModel *model =self.dataArray[indexPath.row];
        
        if (model.coverList.count == 1) {
            if (model.imageInfo == nil) {
                
                _oneImageHeight = 228;
                _oneImageWidth = 228;
            }
            else {
                
                _oneImageWidth = [[model.imageInfo valueForKey:@"width"] floatValue];
                _oneImageHeight = [[model.imageInfo valueForKey:@"height"] floatValue];
                
                
            }
            
        }
        if (model.coverList.count == 0 || (_oneImageHeight >0 && _oneImageHeight <171)||(_oneImageWidth >0 && _oneImageWidth <171) ) {

            // 分享
            if (model.shareUrl != nil) {
                // 分享无评论
                if (model.replyList.count == 0) {
                    return [TimeShareArticleNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                        TimeShareArticleNoCommentCell *cell = (TimeShareArticleNoCommentCell *)sourceCell;
                        // 配置数据
                        [cell configTimeShareArticleNoCommentCellTimeNewDynamicDetailModel:model];
                    } cache:^NSDictionary *{
                        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                                 kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                                 };
                    }];
                    
                }
                else if  (model.replyList.count == 1) {
                    return [TimeShareArticleWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                        TimeShareArticleWithOneCommentCell *cell = (TimeShareArticleWithOneCommentCell *)sourceCell;
                        // 配置数据
                        [cell configTimeShareArticleWithOneCommentCellTimeNewDynamicDetailModel:model];
                    } cache:^NSDictionary *{
                        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                                 kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                                 };
                    }];
                    
                }
                
                else {
                    return [TimeShareArticleWithCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                        TimeShareArticleWithCommentCell *cell = (TimeShareArticleWithCommentCell *)sourceCell;
                        // 配置数据
                        [cell configTimeShareArticleWithCommentCellTimeNewDynamicDetailModel:model];
                    } cache:^NSDictionary *{
                        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                                 kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                                 };
                    }];
                    
                }
            }
            // 无图无评论
            else if (model.replyList.count == 0) {
                
                return [TimeNoImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    
                    TimeNoImageNoCommentCell *cell = (TimeNoImageNoCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeNoImageNoCommentTimeNewDynamicDetailModel:model];
                    
                } cache:^NSDictionary *{
                    
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             
                             };
                }];
                
            }
            // 无图一条评论
            else if (model.replyList.count == 1) {
                return [TimeNoImageWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeNoImageWithOneCommentCell *cell = (TimeNoImageWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeNoImageWithOneCommentCellTimeNewDynamicDetailModel:model];
                    
                } cache:^NSDictionary *{
                    
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
            }
            // 无图两条评论
            else {
                return [TimeNoImageWithCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeNoImageWithCommentCell *cell = (TimeNoImageWithCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeNoImageWithCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
            }
        }
        
        if (model.coverList.count == 1  && _oneImageHeight >171 &&_oneImageWidth >171) {
            // 一图无评论
            if (model.replyList.count == 0)  {
                return [TimeOneImageHeightNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeOneImageHeightNoCommentCell *cell = (TimeOneImageHeightNoCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeOneImageHeightNoCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             
                             };
                }];
            }
            // 一张图一条评论
            else if (model.replyList.count == 1 ) {
                return [TimeOneImageHeightWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeOneImageHeightWithOneCommentCell *cell = (TimeOneImageHeightWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeOneImageHeightWithOneCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
            }
            // 一张图两条
            else {
                return [TimeOneImageHeightWithCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeOneImageHeightWithCommentCell *cell = (TimeOneImageHeightWithCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeOneImageHeightWithCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             
                             };
                    
                }];
            }
        }
        
        
        else if (model.coverList.count == 2) {
            // 两张图片无评论
            if (model.replyList.count == 0)   {
                return [TimeTwoImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeTwoImageNoCommentCell *cell = (TimeTwoImageNoCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeTwoImageNoCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
            }
            // 两张图片一条评论
            else if (model.replyList.count == 1) {
                return [TimeTwoImageWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeTwoImageWithOneCommentCell *cell = (TimeTwoImageWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeTwoImageWithOneCommentCellTimeNewDynamicDetailModel:model];
                    
                } cache:^NSDictionary *{
                    
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             
                             };
                    
                }];
                
            }
            // 两张图片两条评论
            else {
                return [TimeTwoImageWithCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeTwoImageWithCommentCell *cell = (TimeTwoImageWithCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeTwoImageWithCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
            }
        }
        else {
            // 三张图片无评论
            if (model.replyList.count == 0) {
                return [TimeThreeImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeThreeImageNoCommentCell *cell = (TimeThreeImageNoCommentCell *)sourceCell;
                    
                    // 配置数据
                    
                    [cell configTimeThreeImageNoCommentCellTimeNewDynamicDetailModel:model];
                    
                } cache:^NSDictionary *{
                    
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             
                             };
                    
                }];
                
            }
            // 三张图片一评论
            else if  (model.replyList.count == 1) {
                return [TimeThreeImageWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeThreeImageWithOneCommentCell *cell = (TimeThreeImageWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeThreeImageWithOneCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             
                             };
                    
                }];
            }
            
            else {
                return [TimeThreeImageWithCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeThreeImageWithCommentCell *cell = (TimeThreeImageWithCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeThreeImageWithCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             
                             };
                    
                }];
            }
        }
    }
    else {
        
        return KDeviceHeight -104 -64;
    }
}

-(void)pushToDiscover:(id)sender
{
    self.tabBarController.selectedIndex=1;
}



- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    
    return CGFLOAT_MIN;
}

#pragma mark - ZFActionSheetDelegate
- (void)clickAction:(ZFActionSheet *)actionSheet atIndex:(NSUInteger)index
{
    NSLog(@"选中了 %zd",index);
    
    if (index==1) {
        
        // 删除
//        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
//                              @"topicId":_reportObject,
//                              @"token":[[MyUserInfoManager shareInstance]token],
//                              };
//
//        self.requestURL = LKB_Delete_Topic_Url;
        NSDictionary *jiaoyiDic = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                    @"topicId":_reportObject,
                                    @"token":[[MyUserInfoManager shareInstance]token],
                                    };
        [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Delete_Topic_Url parameters:jiaoyiDic success:^(id parserObject) {
            
            NSLog(@"******%@",parserObject);
        } failure:^(NSString *errorMessage) {
            
            //                                    [self ShowProgressHUDwithMessage:errorMessage];
        }];
        
        [_dataArray removeObjectAtIndex:_sectionIdex];
        [_tableView deleteSections:[NSIndexSet indexSetWithIndex:_sectionIdex]  withRowAnimation:UITableViewRowAnimationNone];
        
        
        [_tableView reloadData];


        
    }else
    {
        ReportViewController *reportVC = [[ReportViewController alloc]init];
        reportVC.objId =_reportObject ;
        reportVC.reportType = _reportType;
        reportVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:reportVC animated:YES];
        
    }
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString *CELLNONE = @"CELLNONE";
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView * loadingImage = [[UIImageView alloc]init];
        
        
        loadingImage.image = [UIImage imageNamed:@"New-circle_load"];
        loadingImage.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight -104 -64);
        
        [cell addSubview:loadingImage];

        return cell;
        
    }
        if (indexPath.row < self.dataArray.count) {
            
            NewDynamicDetailModel *insight = (NewDynamicDetailModel *)_dataArray[indexPath.row];
            NSLog(@"-------------------------------------%@",insight.type);
            NSLog(@"-------------------------------------%@",insight.summary);

            
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
                
                if (insight.shareUrl !=nil) {
                    
                    if (insight.replyList.count == 0) {
                        
                        cell = [tableView dequeueReusableCellWithIdentifier:TimeAttShareArticleNoCommentCellIdentifier];
                        if (!cell) {
                            
                            cell = [[TimeShareArticleNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                        reuseIdentifier:TimeAttShareArticleNoCommentCellIdentifier];
                        }
                        
                        TimeShareArticleNoCommentCell *tbCell = (TimeShareArticleNoCommentCell *)cell;
                        
                        [tbCell configTimeShareArticleNoCommentCellTimeNewDynamicDetailModel:insight];
                        [tbCell ShareArticleNoCommenthandlerButtonAction:^(NSInteger clickIndex) {
                            
                            if (clickIndex == 1)  {
                                
                                NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                                peopleVC.type = @"2";
                                peopleVC.toUserId = insight.userId;
                                peopleVC.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:peopleVC animated:YES];
                                
                            }
                            if (clickIndex == 2) {
                                
                                _sectionIdex = indexPath.row;
                                
                                _reportType = insight.type;
                                _reportObject = insight.objectId;
                                
                                if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                    _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                                }
                                else {
                                    _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                                }
                                
                                _actionSheet.delegate = self;
                                [_actionSheet showInView:self.view.window];
                                
                                
                                NSLog(@"点击了按钮");
                                
                                
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
                            if (clickIndex == 4) {
                                // 点赞
                                if ([insight.isStar isEqualToString:@"1"]) {
                                    tbCell.goodBtn.tag = CLICK_LIKE;
                                    NSDictionary *jiaoyiDic = @{
                                                                @"objectId":insight.objectId,
                                                                @"objectType":@"4",
                                                                @"userId":[[MyUserInfoManager shareInstance]userId],
                                                                @"token":[[MyUserInfoManager shareInstance]token]
                                                                };
                                    [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                        
                                        NSLog(@"******%@",parserObject);
                                    } failure:^(NSString *errorMessage) {
                                        
                                        //                                    [self ShowProgressHUDwithMessage:errorMessage];
                                    }];
                                    insight.isStar = @"0";
                                    NSLog(@"=========================%@",insight.userAvatars);
                                    NSLog(@"=========================%@",insight.starNum);
                                    
                                    NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                    [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                    
                                    
                                    
                                    int i;
                                    int ivalue = [insight.starNum intValue];
                                    i =  ivalue +1;
                                    
                                    insight.starNum = [NSString stringWithFormat:@"%d",i];
                                    NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                    messageModel.starNum = insight.starNum;
                                    
                                    messageModel.userAvatars = [arr copy];
                                    NSLog(@"=========================%@",messageModel.userAvatars);
                                    
                                    [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                                }
                                else {
                                    
                                    [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                    tbCell.goodBtn.tag = CANCEL_LIKE;
                                    
                                    NSDictionary *jiaoyiDic = @{
                                                                @"objectId":insight.objectId,                                                                @"objectType":@"4",                                                            @"userId":[[MyUserInfoManager shareInstance]userId],                                                                @"token":[[MyUserInfoManager shareInstance]token]
                                                                };
                                    [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                        
                                        NSLog(@"******%@",parserObject);
                                    } failure:^(NSString *errorMessage) {
                                        
                                    }];
                                    insight.isStar = @"1";
                                    
                                    NSLog(@"=========================%@",insight.userAvatars);
                                    
                                    NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                    [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                    int i;
                                    int ivalue = [insight.starNum intValue];
                                    i =  ivalue -1;
                                    
                                    NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                    
                                    messageModel.isStar = @"1";
                                    messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                    
                                    messageModel.userAvatars = [arr copy];
                                    NSLog(@"=========================%@",messageModel.userAvatars);
                                    
                                    [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                                    
                                }
                                
                            }
                            if (clickIndex == 5) {
                                // 评论
                                _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                                NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                
                                NSURL *url = [NSURL URLWithString:strmy];
                                OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                                outSideWeb.sendMessageType = @"2";
                                outSideWeb.rightButtonType = @"2";
                                outSideWeb.VcType = @"1";
                                outSideWeb.urlStr = _linkUrl;
                                outSideWeb.circleId = insight.groupId;
                                outSideWeb.circleDetailId = insight.objectId;
                                outSideWeb.shareType = @"2";
                                outSideWeb.mytitle = insight.title;
                                outSideWeb.describle = insight.summary;
                                outSideWeb.userAvatar = insight.userAvatar;
                                outSideWeb.groupAvatar = insight.cover;
                                outSideWeb.commendVcType = @"1";
                                outSideWeb.isAttention = insight.isAttention;
                                outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                                outSideWeb.squareType = @"1";
                                
                                outSideWeb.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:outSideWeb animated:YES];
                                
                            }
                            if (clickIndex == 6) {
                                _circleCover = insight.cover;
                                _groupId = insight.groupId;
                                _describle = insight.summary;
                                _shareUrl = insight.shareUrl;
                                _mytitle = insight.shareTitle;
                                _shareCover = insight.shareImage;
                                
                                if ([insight.shareUrl rangeOfString:@"jianjie"].location != NSNotFound) {
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/"];
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    _objectId = str;
                                    _shareType = @"4";
                                }
                                else if ([insight.shareUrl rangeOfString:@"huodong"].location != NSNotFound) {
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/"];
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    _objectId = str;
                                    _shareType = @"3";
                                    
                                }
                                else if ([insight.shareUrl rangeOfString:@"chuhe"].location != NSNotFound) {
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/"];
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    _objectId = str;
                                    _shareType = @"6";
                                }
                                [self shareView];
                            }
                            if (clickIndex == 7) {
                                
                                if ([insight.shareUrl rangeOfString:@"jianjie"].location != NSNotFound) {
                                    
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/"];
                                    
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    
                                    //                                    _linkUrl = [NSString stringWithFormat:@"%@",insight.shareUrl];
                                    
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
                                    _shareType = @"3";
                                    
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
                    else if (insight.replyList.count == 1) {
                        
                        cell = [tableView dequeueReusableCellWithIdentifier:TimeAttShareArticleWithOneCommentCellIdentifier];
                        if (!cell) {
                            
                            cell = [[TimeShareArticleWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                             reuseIdentifier:TimeAttShareArticleWithOneCommentCellIdentifier];
                        }
                        
                        TimeShareArticleWithOneCommentCell *tbCell = (TimeShareArticleWithOneCommentCell *)cell;
                        
                        [tbCell configTimeShareArticleWithOneCommentCellTimeNewDynamicDetailModel:insight];
                        [tbCell ShareArticleWithOneCommenthandlerButtonAction:^(NSInteger clickIndex) {
                            if (clickIndex == 1)  {
                                
                                NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                                peopleVC.type = @"2";
                                peopleVC.toUserId = insight.userId;
                                peopleVC.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:peopleVC animated:YES];
                                
                            }
                            if (clickIndex == 2) {
                                
                                _sectionIdex = indexPath.row;
                                
                                _reportType = insight.type;
                                _reportObject = insight.objectId;
                                
                                if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                    _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                                }
                                else {
                                    _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                                }
                                
                                _actionSheet.delegate = self;
                                [_actionSheet showInView:self.view.window];
                                
                                
                                NSLog(@"点击了按钮");
                                
                                
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
                            if (clickIndex == 4) {
                                
                                NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                                peopleVC.type = @"2";
                                peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                                peopleVC.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:peopleVC animated:YES];
                            }
                            if (clickIndex == 5) {
                                // 点赞
                                if ([insight.isStar isEqualToString:@"1"]) {
                                    tbCell.goodBtn.tag = CLICK_LIKE;
                                    NSDictionary *jiaoyiDic = @{
                                                                @"objectId":insight.objectId,
                                                                @"objectType":@"4",
                                                                @"userId":[[MyUserInfoManager shareInstance]userId],
                                                                @"token":[[MyUserInfoManager shareInstance]token]
                                                                };
                                    [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                        
                                        NSLog(@"******%@",parserObject);
                                    } failure:^(NSString *errorMessage) {
                                        
                                    }];
                                    insight.isStar = @"0";
                                    NSLog(@"=========================%@",insight.userAvatars);
                                    NSLog(@"=========================%@",insight.starNum);
                                    
                                    NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                    [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                    
                                    
                                    
                                    int i;
                                    int ivalue = [insight.starNum intValue];
                                    i =  ivalue +1;
                                    
                                    insight.starNum = [NSString stringWithFormat:@"%d",i];
                                    NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                    messageModel.starNum = insight.starNum;
                                    
                                    messageModel.userAvatars = [arr copy];
                                    NSLog(@"=========================%@",messageModel.userAvatars);
                                    
                                    [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                                }
                                else {
                                    
                                    [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                    tbCell.goodBtn.tag = CANCEL_LIKE;
                                    
                                    NSDictionary *jiaoyiDic = @{
                                                                @"objectId":insight.objectId,
                                                                @"objectType":@"4",
                                                                @"userId":[[MyUserInfoManager shareInstance]userId],
                                                                @"token":[[MyUserInfoManager shareInstance]token]
                                                                };
                                    [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                        
                                        NSLog(@"******%@",parserObject);
                                    } failure:^(NSString *errorMessage) {
                                        
                                        //                                    [self ShowProgressHUDwithMessage:errorMessage];
                                    }];
                                    insight.isStar = @"1";
                                    
                                    NSLog(@"=========================%@",insight.userAvatars);
                                    
                                    NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                    [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                    int i;
                                    int ivalue = [insight.starNum intValue];
                                    i =  ivalue -1;
                                    
                                    NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                    
                                    messageModel.isStar = @"1";
                                    messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                    
                                    messageModel.userAvatars = [arr copy];
                                    NSLog(@"=========================%@",messageModel.userAvatars);
                                    
                                    [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                                    
                                }
                                
                            }
                            if (clickIndex == 6) {
                                // 评论
                                _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                                NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                
                                NSURL *url = [NSURL URLWithString:strmy];
                                OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                                outSideWeb.sendMessageType = @"2";
                                outSideWeb.rightButtonType = @"2";
                                outSideWeb.VcType = @"1";
                                outSideWeb.urlStr = _linkUrl;
                                outSideWeb.circleId = insight.groupId;
                                outSideWeb.circleDetailId = insight.objectId;
                                outSideWeb.shareType = @"2";
                                outSideWeb.mytitle = insight.title;
                                outSideWeb.describle = insight.summary;
                                outSideWeb.userAvatar = insight.userAvatar;
                                outSideWeb.groupAvatar = insight.cover;
                                outSideWeb.commendVcType = @"1";
                                outSideWeb.isAttention = insight.isAttention;
                                outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                                
                                outSideWeb.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:outSideWeb animated:YES];
                            }
                            if (clickIndex == 7) {
                                _circleCover = insight.cover;
                                _groupId = insight.groupId;
                                _describle = insight.summary;
                                _shareUrl = insight.shareUrl;
                                _mytitle = insight.shareTitle;
                                _shareCover = insight.shareImage;
                                
                                if ([insight.shareUrl rangeOfString:@"jianjie"].location != NSNotFound) {
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/"];
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    _objectId = str;
                                    _shareType = @"4";
                                }
                                else if ([insight.shareUrl rangeOfString:@"huodong"].location != NSNotFound) {
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/"];
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    _objectId = str;
                                    _shareType = @"3";
                                    
                                }
                                else if ([insight.shareUrl rangeOfString:@"chuhe"].location != NSNotFound) {
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/"];
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    _objectId = str;
                                    _shareType = @"6";
                                }
                                [self shareView];
                            }
                            
                            if (clickIndex == 8) {
                                
                                if ([insight.shareUrl rangeOfString:@"jianjie"].location != NSNotFound) {
                                    
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/"];
                                    
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    
                                    //                                    _linkUrl = [NSString stringWithFormat:@"%@",insight.shareUrl];
                                    
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
                                    _shareType = @"3";
                                    
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
                        cell = [tableView dequeueReusableCellWithIdentifier:TimeAttShareArticleWithCommentCellIdentifier];
                        if (!cell) {
                            
                            cell = [[TimeShareArticleWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                          reuseIdentifier:TimeAttShareArticleWithCommentCellIdentifier];
                        }
                        
                        TimeShareArticleWithCommentCell *tbCell = (TimeShareArticleWithCommentCell *)cell;
                        
                        [tbCell configTimeShareArticleWithCommentCellTimeNewDynamicDetailModel:insight];
                        [tbCell ShareArticleWithCommenthandlerButtonAction:^(NSInteger clickIndex) {
                            if (clickIndex == 1)  {
                                
                                NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                                peopleVC.type = @"2";
                                peopleVC.toUserId = insight.userId;
                                peopleVC.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:peopleVC animated:YES];
                                
                            }
                            if (clickIndex == 2) {
                                
                                _sectionIdex = indexPath.row;
                                
                                _reportType = insight.type;
                                _reportObject = insight.objectId;
                                
                                if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                    _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                                }
                                else {
                                    _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                                }
                                
                                _actionSheet.delegate = self;
                                [_actionSheet showInView:self.view.window];
                                
                                
                                NSLog(@"点击了按钮");
                                
                                
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
                            if (clickIndex == 4) {
                                
                                NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                                peopleVC.type = @"2";
                                peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                                peopleVC.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:peopleVC animated:YES];
                            }
                            if (clickIndex == 5) {
                                
                                NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                                peopleVC.type = @"2";
                                peopleVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
                                peopleVC.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:peopleVC animated:YES];
                            }
                            if (clickIndex == 6) {
                                // 点赞
                                if ([insight.isStar isEqualToString:@"1"]) {
                                    tbCell.goodBtn.tag = CLICK_LIKE;
                                    NSDictionary *jiaoyiDic = @{
                                                                @"objectId":insight.objectId,
                                                                @"objectType":@"4",
                                                                @"userId":[[MyUserInfoManager shareInstance]userId],
                                                                @"token":[[MyUserInfoManager shareInstance]token]
                                                                };
                                    //                                self.requestURL = LKB_Common_Star_Url;
                                    [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                        
                                        NSLog(@"******%@",parserObject);
                                    } failure:^(NSString *errorMessage) {
                                        
                                        //                                    [self ShowProgressHUDwithMessage:errorMessage];
                                    }];
                                    insight.isStar = @"0";
                                    NSLog(@"=========================%@",insight.userAvatars);
                                    NSLog(@"=========================%@",insight.starNum);
                                    
                                    NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                    [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                    
                                    
                                    
                                    int i;
                                    int ivalue = [insight.starNum intValue];
                                    i =  ivalue +1;
                                    
                                    insight.starNum = [NSString stringWithFormat:@"%d",i];
                                    NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                    messageModel.starNum = insight.starNum;
                                    
                                    messageModel.userAvatars = [arr copy];
                                    NSLog(@"=========================%@",messageModel.userAvatars);
                                    
                                    [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                                }
                                else {
                                    
                                    [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                    tbCell.goodBtn.tag = CANCEL_LIKE;
                                    
                                    NSDictionary *jiaoyiDic = @{
                                                                @"objectId":insight.objectId,
                                                                @"objectType":@"4",
                                                                @"userId":[[MyUserInfoManager shareInstance]userId],
                                                                @"token":[[MyUserInfoManager shareInstance]token]
                                                                };
                                    [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                        
                                        NSLog(@"******%@",parserObject);
                                    } failure:^(NSString *errorMessage) {
                                        
                                        //                                    [self ShowProgressHUDwithMessage:errorMessage];
                                    }];
                                    insight.isStar = @"1";
                                    
                                    NSLog(@"=========================%@",insight.userAvatars);
                                    
                                    NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                    [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                    int i;
                                    int ivalue = [insight.starNum intValue];
                                    i =  ivalue -1;
                                    
                                    NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                    
                                    messageModel.isStar = @"1";
                                    messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                    
                                    messageModel.userAvatars = [arr copy];
                                    NSLog(@"=========================%@",messageModel.userAvatars);
                                    
                                    [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                                    
                                }
                                
                                
                            }
                            if (clickIndex == 7) {
                                // 评论
                                _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                                NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                
                                NSURL *url = [NSURL URLWithString:strmy];
                                OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                                outSideWeb.sendMessageType = @"2";
                                outSideWeb.rightButtonType = @"2";
                                outSideWeb.VcType = @"1";
                                outSideWeb.urlStr = _linkUrl;
                                outSideWeb.circleId = insight.groupId;
                                outSideWeb.circleDetailId = insight.objectId;
                                outSideWeb.shareType = @"2";
                                outSideWeb.mytitle = insight.title;
                                outSideWeb.describle = insight.summary;
                                outSideWeb.userAvatar = insight.userAvatar;
                                outSideWeb.groupAvatar = insight.cover;
                                outSideWeb.commendVcType = @"1";
                                outSideWeb.isAttention = insight.isAttention;
                                outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                                
                                outSideWeb.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:outSideWeb animated:YES];
                            }
                            if (clickIndex == 8) {
                                _circleCover = insight.cover;
                                _groupId = insight.groupId;
                                _describle = insight.summary;
                                _shareUrl = insight.shareUrl;
                                _mytitle = insight.shareTitle;
                                _shareCover = insight.shareImage;
                                
                                if ([insight.shareUrl rangeOfString:@"jianjie"].location != NSNotFound) {
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/"];
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    _objectId = str;
                                    _shareType = @"4";
                                }
                                else if ([insight.shareUrl rangeOfString:@"huodong"].location != NSNotFound) {
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/huodong/"];
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    _objectId = str;
                                    _shareType = @"3";
                                    
                                }
                                else if ([insight.shareUrl rangeOfString:@"chuhe"].location != NSNotFound) {
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/chuhe/"];
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    _objectId = str;
                                    _shareType = @"6";
                                }
                                [self shareView];
                            }
                            
                            if (clickIndex == 9) {
                                
                                if ([insight.shareUrl rangeOfString:@"jianjie"].location != NSNotFound) {
                                    
                                    NSString *jianjie = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/"];
                                    
                                    NSString * str = [insight.shareUrl substringFromIndex: jianjie.length];
                                    
                                    //                                    _linkUrl = [NSString stringWithFormat:@"%@",insight.shareUrl];
                                    
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
                                    _shareType = @"3";
                                    
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
                }

                
                
                
                
               else if (insight.replyList.count == 0) {
                    // 无图无评论
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttNoImageNoCommentCellIdentifier];
                    
                    if (!cell) {
                        cell = [[TimeNoImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                
                                                               reuseIdentifier:TimeAttNoImageNoCommentCellIdentifier];
                    }
                    TimeNoImageNoCommentCell *tbCell = (TimeNoImageNoCommentCell *)cell;
                    [tbCell configTimeNoImageNoCommentTimeNewDynamicDetailModel:insight];
                    [tbCell handlerButtonAction:^(NSInteger clickIndex) {
                        if (clickIndex == 1)  {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 2) {
                            _sectionIdex = indexPath.row;
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
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
                        if (clickIndex == 4) {
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            
                        }
                        if (clickIndex == 5) {
                            // 评论
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.circleDetailId = insight.objectId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.title;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            outSideWeb.squareType = @"1";
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                        }
                        if (clickIndex == 6) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
                        }

                        
                    }];
                    [tbCell setNeedsUpdateConstraints];
                    
                    [tbCell updateConstraintsIfNeeded];
                    
                }
                
                else if (insight.replyList.count == 1) {
                    // 无图一评论
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttNoImageWithOneCommentCellIdentifier];
                    if (!cell) {
                        cell = [[TimeNoImageWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault                                                                reuseIdentifier:TimeAttNoImageWithOneCommentCellIdentifier];
                        
                    }
                    TimeNoImageWithOneCommentCell *tbCell = (TimeNoImageWithOneCommentCell *)cell;
                    [tbCell configTimeNoImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    
                    [tbCell NoImageWithOnehandlerButtonAction:^(NSInteger clickIndex) {
                        if (clickIndex == 1)  {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        
                        if (clickIndex == 2) {
                            _sectionIdex = indexPath.row;
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
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
                        
                        if (clickIndex == 4) {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        
                        if (clickIndex == 5) {
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            
                        }
                        if (clickIndex == 6) {
                            // 评论
                            
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            
                            
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
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
                            
                            
                            NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                        }
                        if (clickIndex == 7) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
                        }

                    }];
                    [tbCell setNeedsUpdateConstraints];
                    [tbCell updateConstraintsIfNeeded];
                }
                
                else {
                    // 无图两评论
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttNoImageWithCommentCellIdentifier];
                    if (!cell) {
                        cell = [[TimeNoImageWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                 reuseIdentifier:TimeAttNoImageWithCommentCellIdentifier];
                    }
                    TimeNoImageWithCommentCell *tbCell = (TimeNoImageWithCommentCell *)cell;
                    [tbCell configTimeNoImageWithCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell NoImageWithCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        if (clickIndex == 1)  {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                            
                        }
                        if (clickIndex == 2) {
                            _sectionIdex = indexPath.row;
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
                            
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
                        if (clickIndex == 4) {
                            
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 5) {
                            
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 6) {
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                        }
                        if (clickIndex == 7) {
                            // 评论
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.circleDetailId = insight.objectId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.title;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                            
                        }
                        if (clickIndex == 8) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
                        }

                    }];
                    [tbCell setNeedsUpdateConstraints];
                    [tbCell updateConstraintsIfNeeded];
                    
                }
            }
            else if (insight.coverList.count == 1) {
                if (insight.replyList.count == 0) {
                    // 一图无评论
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttOneImageHeightNoCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeOneImageHeightNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                      reuseIdentifier:TimeAttOneImageHeightNoCommentCellIdentifier];
                    }
                    
                    TimeOneImageHeightNoCommentCell *tbCell = (TimeOneImageHeightNoCommentCell *)cell;
                    [tbCell configTimeOneImageHeightNoCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell OneImageHeightNoCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        if (clickIndex == 1)  {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 2) {
                            _sectionIdex = indexPath.row;
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
                            
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
                        if (clickIndex == 4) {
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            
                        }
                        if (clickIndex == 5) {
                            // 评论
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.circleDetailId = insight.objectId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.title;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            outSideWeb.squareType = @"1";
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                        }
                        if (clickIndex == 6) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
                        }

                        
                    }];
                    
                    if (tbCell.coverListImage.subviews.count>0) {
                        HZPhotoGroup *photoGroup = tbCell.coverListImage.subviews[0];
                        [photoGroup removeFromSuperview];
                    }
                    
                    HZPhotoGroup *photoGroup = [[HZPhotoGroup alloc] init];
                    
                    NSMutableArray *temp = [NSMutableArray array];
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
                else if (insight.replyList.count == 1) {
                    //一图一评论
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttOneImageHeightWithOneCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeOneImageHeightWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                           reuseIdentifier:TimeAttOneImageHeightWithOneCommentCellIdentifier];
                    }
                    
                    TimeOneImageHeightWithOneCommentCell *tbCell = (TimeOneImageHeightWithOneCommentCell *)cell;
                    
                    [tbCell configTimeOneImageHeightWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell OneImageHeightWithOneCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        
                        if (clickIndex == 1)  {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 2) {
                            _sectionIdex = indexPath.row;
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
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
                        if (clickIndex == 4) {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 5) {
                            // 点赞
                            
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                        }
                        if (clickIndex == 6) {
                            // 评论
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.circleDetailId = insight.objectId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.title;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                        }
                        if (clickIndex == 7) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
                        }

                    }];
                    
                    if (tbCell.coverListImage.subviews.count>0) {
                        HZPhotoGroup *photoGroup = tbCell.coverListImage.subviews[0];
                        [photoGroup removeFromSuperview];
                    }
                    
                    
                    HZPhotoGroup *photoGroup = [[HZPhotoGroup alloc] init];
                    
                    NSMutableArray *temp = [NSMutableArray array];
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
                else {
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttOneImageHeightWithCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeOneImageHeightWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                        reuseIdentifier:TimeAttOneImageHeightWithCommentCellIdentifier];
                    }
                    
                    TimeOneImageHeightWithCommentCell *tbCell = (TimeOneImageHeightWithCommentCell *)cell;
                    [tbCell configTimeOneImageHeightWithCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell OneImageHeightWithCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        
                        if (clickIndex == 1)  {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                            
                        }
                        if (clickIndex == 2) {
                            
                            _sectionIdex = indexPath.row;
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
                            
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
                        if (clickIndex == 4) {
                            
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 5) {
                            
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 6) {
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                        }
                        if (clickIndex == 7) {
                            // 评论
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.circleDetailId = insight.objectId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.title;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                        }
                        if (clickIndex == 8) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
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
                    photoGroup.oneImageHeight = _oneImageHeight;
                    photoGroup.oneImageWidth = _oneImageWidth;
                    
                    [tbCell.coverListImage addSubview:photoGroup];
                    
                    [tbCell setNeedsUpdateConstraints];
                    [tbCell updateConstraintsIfNeeded];
                }
                
            }
            
            else if (insight.coverList.count == 2) {
                if (insight.replyList.count == 0) {
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttTwoImageNoCommentCellIdentifier];
                    if (!cell) {
                        cell = [[TimeTwoImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault                                                            reuseIdentifier:TimeAttTwoImageNoCommentCellIdentifier];
                    }
                    
                    TimeTwoImageNoCommentCell *tbCell = (TimeTwoImageNoCommentCell *)cell;
                    [tbCell configTimeTwoImageNoCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell TwoImageNoCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        
                        if (clickIndex == 1)  {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        
                        if (clickIndex == 2) {
                            _sectionIdex = indexPath.row;
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
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
                        if (clickIndex == 4) {
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            
                        }
                        if (clickIndex == 5) {
                            // 评论
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.circleDetailId = insight.objectId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.title;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            outSideWeb.squareType = @"1";
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                            
                        }
                        if (clickIndex == 6) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
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
                
                else if (insight.replyList.count == 1) {
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttTwoImageWithOneCommentCellIdentifier];
                    
                    if (!cell) {
                        cell = [[TimeTwoImageWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:TimeAttTwoImageWithOneCommentCellIdentifier];
                        
                    }
                    TimeTwoImageWithOneCommentCell *tbCell = (TimeTwoImageWithOneCommentCell *)cell;
                    [tbCell configTimeTwoImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell TwoImageWithOneCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        if (clickIndex == 1)  {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        
                        if (clickIndex == 2) {
                            _sectionIdex = indexPath.row;
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
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
                        if (clickIndex == 4) {
                            
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 5) {
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                        }
                        if (clickIndex == 6) {
                            // 评论
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.circleDetailId = insight.objectId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.title;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                        }
                        if (clickIndex == 7) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
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
                else {
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttTwoImageWithCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeTwoImageWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                  reuseIdentifier:TimeAttTwoImageWithCommentCellIdentifier];
                    }
                    
                    TimeTwoImageWithCommentCell *tbCell = (TimeTwoImageWithCommentCell *)cell;
                    [tbCell configTimeTwoImageWithCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell TwoImageWithCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        if (clickIndex == 1)  {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                            
                        }
                        if (clickIndex == 2) {
                            
                            _sectionIdex = indexPath.row;
                            
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
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
                        if (clickIndex == 4) {
                            
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 5) {
                            
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 6) {
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            
                        }
                        if (clickIndex == 7) {
                            // 评论
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.circleDetailId = insight.objectId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.title;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                        }
                        if (clickIndex == 8) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
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
            
            else{
                if (insight.replyList.count == 0) {
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttThreeImageNoCommentCellIdentifier];
                    if (!cell) {
                        cell = [[TimeThreeImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TimeAttThreeImageNoCommentCellIdentifier];
                        
                    }
                    TimeThreeImageNoCommentCell *tbCell = (TimeThreeImageNoCommentCell *)cell;
                    [tbCell configTimeThreeImageNoCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell ThreeImageNoCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        if (clickIndex == 1)  {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        
                        if (clickIndex == 2) {
                            _sectionIdex = indexPath.row;
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
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
                        
                        if (clickIndex == 4) {
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            
                        }
                        if (clickIndex == 5) {
                            // 评论
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.circleDetailId = insight.objectId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.title;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            outSideWeb.squareType = @"1";
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                            
                        }
                        if (clickIndex == 6) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
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
                else if (insight.replyList.count == 1) {
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttThreeImageWithOneCommentCellIdentifier];
                    if (!cell) {
                        cell = [[TimeThreeImageWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault                                                                   reuseIdentifier:TimeAttThreeImageWithOneCommentCellIdentifier];
                    }
                    TimeThreeImageWithOneCommentCell *tbCell = (TimeThreeImageWithOneCommentCell *)cell;
                    [tbCell configTimeThreeImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell ThreeImageWithOneCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        if (clickIndex == 1)  {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 2) {
                            _sectionIdex = indexPath.row;
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
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
                        if (clickIndex == 4) {
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 5) {
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            
                        }
                        if (clickIndex == 6) {
                            // 评论
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.circleDetailId = insight.objectId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.title;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                        }
                        if (clickIndex == 7) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
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
                else {
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeAttThreeImageWithCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeThreeImageWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                    reuseIdentifier:TimeAttThreeImageWithCommentCellIdentifier];
                    }
                    
                    TimeThreeImageWithCommentCell *tbCell = (TimeThreeImageWithCommentCell *)cell;
                    
                    [tbCell configTimeThreeImageWithCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell ThreeImageWithCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        
                        if (clickIndex == 1)  {
                            
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = insight.userId;
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = insight.userId;
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                            
                        }
                        if (clickIndex == 2) {
                            
                            _sectionIdex = indexPath.row;
                            
                            _reportType = insight.type;
                            _reportObject = insight.objectId;
                            
                            if ([insight.userId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报",@"删除"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            else {
                                _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
                            }
                            _actionSheet.delegate = self;
                            [_actionSheet showInView:self.view.window];
                            NSLog(@"点击了按钮");
                            
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
                        if (clickIndex == 4) {
                            
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 5) {
                            
//                            UserRootViewController *userVC = [[UserRootViewController alloc]init];
//                            userVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
//                            userVC.type = @"2";
//                            
//                            userVC.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:userVC animated:YES];
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 6) {
                            _StartsectionIdex = indexPath.row;
                            _type = @"2";
                            // 点赞
                            if ([insight.isStar isEqualToString:@"1"]) {
                                tbCell.goodBtn.tag = CLICK_LIKE;
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                insight.isStar = @"0";
                                NSLog(@"=========================%@",insight.userAvatars);
                                NSLog(@"=========================%@",insight.starNum);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr addObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue +1;
                                
                                insight.starNum = [NSString stringWithFormat:@"%d",i];
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                messageModel.starNum = insight.starNum;
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            else {
                                
                                [tbCell.goodImageView setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
                                tbCell.goodBtn.tag = CANCEL_LIKE;
                                
                                NSDictionary *jiaoyiDic = @{
                                                            @"objectId":insight.objectId,
                                                            @"objectType":@"4",
                                                            @"userId":[[MyUserInfoManager shareInstance]userId],
                                                            @"token":[[MyUserInfoManager shareInstance]token]
                                                            };
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Cancel_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                [self ShowProgressHUDwithMessage:errorMessage];
                                }];
                                
                                insight.isStar = @"1";
                                
                                NSLog(@"=========================%@",insight.userAvatars);
                                
                                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:insight.userAvatars];
                                [arr removeObject:[MyUserInfoManager shareInstance].avatar];
                                int i;
                                int ivalue = [insight.starNum intValue];
                                i =  ivalue -1;
                                
                                NewDynamicDetailModel *messageModel = [self.dataArray objectAtIndex:indexPath.row];
                                
                                messageModel.isStar = @"1";
                                messageModel.starNum = [NSString stringWithFormat:@"%d",i];
                                
                                messageModel.userAvatars = [arr copy];
                                NSLog(@"=========================%@",messageModel.userAvatars);
                                
                                [self reloadCellHeightForModel:messageModel atIndexPath:indexPath];
                            }
                            
                            
                        }
                        if (clickIndex == 7) {
                            // 评论
                            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
                            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:strmy];
                            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                            outSideWeb.sendMessageType = @"2";
                            outSideWeb.rightButtonType = @"2";
                            outSideWeb.VcType = @"1";
                            outSideWeb.urlStr = _linkUrl;
                            outSideWeb.circleId = insight.groupId;
                            outSideWeb.circleDetailId = insight.objectId;
                            outSideWeb.shareType = @"2";
                            outSideWeb.mytitle = insight.title;
                            outSideWeb.describle = insight.summary;
                            outSideWeb.userAvatar = insight.userAvatar;
                            outSideWeb.groupAvatar = insight.cover;
                            outSideWeb.commendVcType = @"1";
                            outSideWeb.isAttention = insight.isAttention;
                            outSideWeb.groupName = insight.groupName;                          NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
                            
                            outSideWeb.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:outSideWeb animated:YES];
                        }
                        if (clickIndex == 8) {
                            _circleCover = insight.cover;
                            _objectId = insight.objectId;
                            _groupId = insight.groupId;
                            _describle = insight.summary;
                            [self shareView];
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
        }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
}

- (void)shareView {
    
    if (_mytitle==nil) {
        _mytitle= @"圈子详情";
    }
    if (_describle==nil) {
        _describle= @"点击查看详情";
    }
    if (_circleCover==nil) {
        _circleCover= @" ";
    }
    
    
    
    
    if (_shareType == nil) {
        _shareType = @"2";
    }
    
    if ([_shareType isEqualToString:@"2"]) {
        
        _urlStr = [NSString stringWithFormat:@"http://www.lvkebang.cn/qunzu/huati/%@",_objectId];
        
        _shareCover = [NSString stringWithFormat:@"http://imagetest.lvkebang.cn/static/group_topic/%@",_circleCover];
        NSDictionary *shaDic = @{@"cover":_shareCover,
                                 @"userId":[[MyUserInfoManager shareInstance]userId],
                                 @"description":_describle,
                                 @"title":_mytitle,
                                 @"circleId":_groupId,
                                 @"linkUrl":_urlStr,
                                 @"shareType":_shareType,
                                 @"featureId":_objectId,
                                 @"fromLable":@"绿科邦新农圈",
                                 };
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shaDic options:NSJSONWritingPrettyPrinted error:nil];
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    else if ([_shareType isEqualToString:@"8"]) {
        
        NSDictionary *shaDic = @{@"cover":_shareCover,
                                 @"userId":[[MyUserInfoManager shareInstance]userId],
                                 @"title":_mytitle,
                                 @"linkUrl":_shareUrl,
                                 @"shareType":@"8",
                                 
                                 };
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shaDic options:NSJSONWritingPrettyPrinted error:nil];
        
        
        
        jsonStr=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
    }

    else {
        NSDictionary *shaDic = @{@"cover":_shareCover,
                                 @"userId":[[MyUserInfoManager shareInstance]userId],
                                 @"description":_describle,
                                 @"title":_mytitle,
                                 @"circleId":_groupId,
                                 @"linkUrl":_shareUrl,
                                 @"shareType":_shareType,
                                 @"featureId":_objectId,
                                 @"fromLable":@"绿科邦新农圈",
                                 //                                 @"columnId":_featureId,
                                 //                                 @"columnAvatar":_shareColumnAvatar,
                                 //                                 @"replyNum":_replyNum,
                                 
                                 };
        
        
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shaDic options:NSJSONWritingPrettyPrinted error:nil];
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        
        
        
    }
    
    
    NewShareActionView *newshare = [[NewShareActionView alloc]init];
    newshare.delegate = self;
    newshare.layer.cornerRadius = 10;
    
    _alertController = [TYAlertController alertControllerWithAlertView:newshare preferredStyle:TYAlertControllerStyleAlert];
    _alertController.backgoundTapDismissEnable = YES;
    [self presentViewController:_alertController animated:YES completion:nil];
    
}


- (void)newShareActionView:(NewShareActionView *)UserHeaderView didatterntion:(NSInteger)index
{
    NSLog(@"点击了群组");
    
    if (index == 1) {
        [_alertController dismissViewControllerAnimated:YES];
        
        PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
        peopleVC.shareDes = jsonStr;
        peopleVC.requestUrl = LKB_Attention_Users_Url;
        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
        peopleVC.questionId = _objectId;
        peopleVC.VCType = @"1";

        peopleVC.shareType = @"1";
        peopleVC.hidesBottomBarWhenPushed = YES;
        peopleVC.title = @"我的好友";
        peopleVC.ifshare = @"3";
        
        [self.navigationController pushViewController:peopleVC animated:YES];
        
        
    }
    // 微信
    if (index == 2) {
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        extConfig.wechatSessionData.url  = _shareUrl;
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    // 微信朋友圈
    if (index==3) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        extConfig.wechatTimelineData.url  = _shareUrl;;
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // 新浪
    if (index==4) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        extConfig.sinaData.shareText =_describle;
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
    }
    // 空间
    if (index==5) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        extConfig.tencentData.shareText = _describle;
        extConfig.qzoneData.url  = _shareUrl;
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // QQ
    if (index==6) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        
        extConfig.title = _mytitle;
        extConfig.qqData.shareText = _describle;
        extConfig.qqData.url  = _shareUrl;
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
    
    
}








- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    _publishButton.hidden = YES;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArray.count) {
        NewDynamicDetailModel *insight = (NewDynamicDetailModel *)_dataArray[indexPath.row];
        
        if (insight.objectId != nil) {
            _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,insight.objectId, insight.groupId];
            NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:strmy];
            OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
            outSideWeb.sendMessageType = @"2";
            outSideWeb.rightButtonType = @"2";
            outSideWeb.VcType = @"1";
            outSideWeb.urlStr = _linkUrl;
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
            NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
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
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        footerVew.textLabel.text=@"没有更多数据了哦..";
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = YES;
        
    }
}

#pragma mark - Getters & Setters

- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KKAttCellIdentifier];
        _tableView.backgroundColor =CCCUIColorFromHex(0xf7f7f7);
    }
    
    return _tableView;
    
}

- (void)reloadCellHeightForModel:(NewDynamicDetailModel *)model atIndexPath:(NSIndexPath *)indexPath{
    model.shouldUpdateCache = YES;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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






@end
