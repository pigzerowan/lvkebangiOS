
//
//  NewTimeViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 1/12/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "NewTimeViewController.h"
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
#import <UIImageView+WebCache.h>
#import "TimeOneImageHeightNoCommentCell.h"
#import "TimeOneImageHeightWithOneCommentCell.h"
#import "TimeOneImageHeightWithCommentCell.h"
#import "FileHelpers.h"
#import "HZPhotoGroup.h"
#import "HZPhotoItem.h"
#import "CircleIfJoinManager.h"
#import "NewUserMainPageViewController.h"
#import "DiscoverCircleRootViewController.h"
#import "TYAlertController+BlurEffects.h"
#import "NewShareActionView.h"
#import "TYAlertController.h"
#include "UMSocial.h"
#import "PeopleViewController.h"
#import "NewShareToViewController.h"
#import "TimeShareArticleNoCommentCell.h"
#import "TimeShareArticleWithCommentCell.h"
#import "TimeShareArticleWithOneCommentCell.h"
#import "ShareArticleManager.h"
#import "YQWebDetailViewController.h"
#import "GoodNoticeCell.h"
#import "PushGoodNewsViewController.h"
#import "ToUserManager.h"
#import "LoginHomeViewController.h"
#import "LKBBaseNavigationController.h"
#import "MTVersionHelper.h"

#define CLICK_LIKE 10003
#define CANCEL_LIKE 10004


NSString * const TimeNomorlCellIdentifier = @"TimeNomorlCell";
NSString * const TimeNoImageNoCommentCellIdentifier = @"TimeNoImageNoCommentDetail";
NSString * const TimeNoImageWithCommentCellIdentifier = @"TimeNoImageWithCommentDetail";
NSString * const TimeNoImageWithOneCommentCellIdentifier = @"TimeNoImageWithOneCommentDetail";
NSString * const TimeOneImageHeightNoCommentCellIdentifier = @"TimeOneImageHeightNoCommentIdentifier";
NSString * const TimeOneImageHeightWithOneCommentCellIdentifier = @"TimeOneImageHeightWithOneCommentIdentifier";
NSString * const TimeOneImageHeightWithCommentCellIdentifier = @"TimeOneImageHeightWithCommentIdentifier";
NSString * const TimeTwoImageNoCommentCellIdentifier = @"TimeTwoImageNoCommentIdentifier";
NSString * const TimeTwoImageWithOneCommentCellIdentifier = @"TimeTwoImageWithOneCommentIdentifier";
NSString * const TimeTwoImageWithCommentCellIdentifier = @"TimeTwoImageWithCommentIdentifier";
NSString * const TimeThreeImageNoCommentCellIdentifier = @"TimeThreeImageNoCommentCellIdentifier";
NSString * const TimeThreeImageWithOneCommentCellIdentifier = @"TimeThreeImageWithOneCommentCellIdentifier";
NSString * const TimeThreeImageWithCommentCellIdentifier = @"TimeThreeImageWithCommentCellIdentifier";
NSString * const TimeShareArticleNoCommentCellIdentifier = @"TimeShareArticleNoCommentCellIdentifier";
NSString * const TimeShareArticleWithCommentCellIdentifier = @"TimeShareArticleWithCommentCellIdentifier";
NSString * const TimeShareArticleWithOneCommentCellIdentifier = @"TimeShareArticleWithOneCommentCellIdentifier";
NSString * const TimeGoodNoticeCellIdentifier = @"TimeGoodNoticeCellIdentifier";


static NSString* KKCellIdentifier = @"TimeTableViewCellIdentifier";
static NSString* AutoLayoutDefautCellIdentifier = @"AutoLayoutDefautCellIdentifier";
@interface NewTimeViewController ()<UITableViewDelegate,UITableViewDataSource,HorizontalMenuDelegate,UICollectionViewDataSource,UICollectionViewDelegate,NewShareActionViewDelegete>
{
    NSString *timeType;
    UIView *perfectionDegreeView;
    NSInteger currPage;
    NSString *jsonStr;
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;

}
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic) UICollectionView *mycollectionView;
@property (strong, nonatomic) NSMutableArray *groupArray;
@property (strong, nonatomic) UIButton *publishButton;
@property (assign, nonatomic) NSInteger sectionIdex;
@property (copy, nonatomic) NSString* reportType;
@property (copy, nonatomic) NSString* reportObject;
@property (copy, nonatomic)NSIndexSet *GroupIndexSet;
@property (strong, nonatomic) UIImage* oneImage;
@property (strong, nonatomic) UIScrollView * headerScrollView;
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
@property(nonatomic,strong) NSDictionary * DicOfNsnotification;


@end

@implementation NewTimeViewController
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
    _oneImage = [[UIImage alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.view.backgroundColor =[UIColor whiteColor];
    
    NSLog(@"=======xxxx==========%@=====",[[MyUserInfoManager shareInstance]userId]);
    NSLog(@"=======xxxx==========%@=====",[GeTuiSdk clientId]);
    NSLog(@"=======xxxx==========%@=====",[[MyUserInfoManager shareInstance]token]);
    
    if ([GeTuiSdk clientId]) {
        NSDictionary *IDdic =  @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                 @"uid":    [GeTuiSdk clientId],
                                 @"token":[[MyUserInfoManager shareInstance]token]
                                 };
        
        
        
        [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_common_addUid_Url parameters:IDdic success:^(id parserObject) {
            
            NSLog(@"绑定成功b");
            
        } failure:^(NSString *errorMessage) {
            
            [self ShowProgressHUDwithMessage:errorMessage];
        }];

    }

    
    timeType = @"0";
    
    [[EaseMob sharedInstance].chatManager setApnsNickname:[[MyUserInfoManager shareInstance]userName]];
    
    self.edgesForExtendedLayout = 0;
    
//    [self initializeData];
    
    

    
    [self initializePageSubviews];

    


    
    
    //获取通知中心单例对象
    NSNotificationCenter * noticeCenter = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [noticeCenter addObserver:self selector:@selector(noticeCenter:) name:@"PushGoodMessage" object:nil];
    
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

-(void)noticeCenter:(NSNotification *)sender{
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    
    NSArray *myArray = [userDefault arrayForKey:@"theGoodArr"];
    
    
    
    NSLog(@"===============%@",myArray);
    
    NSLog(@"========================================%lu",(unsigned long)myArray.count);
    
    
    NSLog(@"《《《》》》》》》》》》》》》》》》》》%@",sender.userInfo);
    
    for (NSString * key in sender.userInfo) {
        
        
        NSRange range = [key rangeOfString:@"payloadMsg:"]; //现获取要截取的字符串位置
        NSString * result = [key substringFromIndex:range.location]; //截取字符串
        
        NSString *dicStr = [result substringFromIndex:11];
        
        NSData *data = [dicStr dataUsingEncoding:NSUTF8StringEncoding];
        
        _DicOfNsnotification = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"/////////////////<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<%@",_DicOfNsnotification);
        
        NSDictionary *DicOfNsnotificationDic = [NSDictionary dictionaryWithDictionary:[_DicOfNsnotification valueForKey:@"object"]];
        
        
        
        NSArray * birdtemp = [NSArray arrayWithObjects:[_DicOfNsnotification valueForKey:@"object"]  , nil];
        
        NSLog(@"/////////////////<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<%@",birdtemp);
        NSLog(@"/////////////////<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<%@",_dataArray);
        
        
        NSLog(@"/////////////////<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<%lu",(unsigned long)_dataArray.count);
        
        
        NSString *KeyStr = [NSString stringWithFormat:@"New%@",[MyUserInfoManager shareInstance].userId];
        
        NSString * dataArrayStr =[userDefault objectForKey:KeyStr]; // 是否读取
        
        NSString * noticeType = [NSString stringWithFormat:@"LoginHomeViewController"];
        NSString *LoginHomeStr = [userDefault objectForKey:noticeType];
        
        NSLog(@"=======================%@",LoginHomeStr);// 是否是第一次登录
        NSLog(@"=======================%@",dataArrayStr);// 是否读取了
        
        
        // 如果是第一次登录
        if ([LoginHomeStr isEqualToString:@"isNewLogin"]) {
            
            // 未读的状态
            if ([dataArrayStr isEqualToString:@"isUnRead"]) {
                
                NewDynamicDetailModel *model = _dataArray[0] ;
                [model updateWithDictionary:birdtemp];
                
                NSMutableArray *updateNewArr = [[userDefault objectForKey:@"isNewLoginModel"]mutableCopy];
                
                NSLog(@"=======================%@",updateNewArr);// 数组里面的
                
                for (NSDictionary *updateNewDict in updateNewArr) {
                    
                    if ( ![[updateNewDict valueForKey:@"objId"] isEqual:[DicOfNsnotificationDic valueForKey:@"objId"]] && ![[updateNewDict valueForKey:@"userId"]isEqual:[DicOfNsnotificationDic valueForKey:@"userId"]] ) {
                        
                        [updateNewArr addObject:DicOfNsnotificationDic];
                        
                        [userDefault setObject:updateNewArr forKey:@"isNewLoginModel"];
                    }
                    
                    
                }
                
                
            }
            // 第一次一条消息
            else {
                
                NewDynamicDetailModel *Newmodel = [[NewDynamicDetailModel alloc]initWithDic:birdtemp];
                [_dataArray insertObject:Newmodel atIndex:0];
                
                
                NSMutableArray *NewmodelArr = [NSMutableArray arrayWithObject:DicOfNsnotificationDic];
                
                [userDefault setObject:NewmodelArr forKey:@"isNewLoginModel"];
                [userDefault setObject:@"isUnRead" forKey:KeyStr];
                
                
            }
            
            
        }
        // 不是第一次登录
        else {
            
            // 未读的状态
            if ([dataArrayStr isEqualToString:@"isUnRead"]) {
                
                NewDynamicDetailModel *model = _dataArray[0] ;
                [model updateWithDictionary:birdtemp];
                
                NSMutableArray *updateArr = [[userDefault objectForKey:@"theGoodArr"]mutableCopy];
                
                [updateArr addObject:DicOfNsnotificationDic];
                
                
                [userDefault setObject:updateArr forKey:@"theGoodArr"];
                
                
                
            }
            // 消息已经读取过了
            else {
                
                NewDynamicDetailModel *Newmodel = [[NewDynamicDetailModel alloc]initWithDic:birdtemp];
                [_dataArray insertObject:Newmodel atIndex:0];
                
                
                NSMutableArray *myArray = [NSMutableArray arrayWithObject:DicOfNsnotificationDic];
                
                [userDefault setObject:myArray forKey:@"theGoodArr"];
                
                [userDefault setObject:@"isUnRead" forKey:KeyStr];
                
                
            }
            
            
            
            
        }
        
        
        [_tableView reloadData];
        
        
        
        /*
         {
         msg = "\U70b9\U8d5e\U901a\U77e5";
         noticeName = "\U70b9\U8d5e\U901a\U77e5";
         noticeType = 5;
         object =     {
         avatar = "2016-08-20_s1PIqUUa.png";
         inviteAnswerNum = 0;
         noticeContent = "";
         objId = 960;
         objType = 1;
         userId = 128;
         userName = "\U5c0f\U82b1";
         };
         type = 0;
         }
         */
        
        
        
    }
    /*
     {
     "taskId=OSL-1229_jLjRlY278s68obEENJX2C3,messageId:0e95d2cf2aa947afa45a6b99d690643f,payloadMsg:{\n\t\"msg\":\"\U70b9\U8d5e\U901a\U77e5\",\n\t\"noticeName\":\"\U70b9\U8d5e\U901a\U77e5\",\n\t\"noticeType\":5,\n\t\"object\":{\n\t\t\"avatar\":\"2016-08-20_s1PIqUUa.png\",\n\t\t\"inviteAnswerNum\":0,\n\t\t\"noticeContent\":\"\",\n\t\t\"objId\":943,\n\t\t\"objType\":\"1\",\n\t\t\"userId\":128,\n\t\t\"userName\":\"\U5c0f\U82b1\"\n\t},\n\t\"type\":0\n}" = msg;
     }
     */
    
}



-(ZFActionSheet *)actionSheet
{
    if (!_actionSheet) {
        _actionSheet = [ZFActionSheet actionSheetWithTitle:@"请选择你的操作" confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
        _actionSheet.delegate = self;
    }
    return _actionSheet;
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
        
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_sectionIdex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
//        [_tableView deleteSections:[NSIndexSet indexSetWithIndex:_sectionIdex]  withRowAnimation:UITableViewRowAnimationNone];
        
        
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




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setBarTintColor:CCCUIColorFromHex(0x323436)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [ShareArticleManager shareInstance].shareType = nil;

    [MobClick beginLogPageView:@"NewTimeViewController"];
    


}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"NewTimeViewController"];
    _DicOfNsnotification = nil;
    


}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -fetchDataWithIsLoadingMore
- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    
    currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        
        currPage = 1;
        
        
        __block NewTimeViewController/*主控制器*/ *weakSelf = self;
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [weakSelf delayMethod];
        });
        
    }
    else {
        ++currPage;
        if (currPage == 1) {
            currPage = 1 +currPage;
        }
    }
    NSLog(@"=========%@=======",[[MyUserInfoManager shareInstance]userId]);
    NSLog(@"=========%@=======",[[MyUserInfoManager shareInstance]token]);
    
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"page":@(currPage),
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    
    self.RequestPostWithChcheURL = _toRequestURL;
//    self.requestURL = _toRequestURL;
    

    
    NSLog(@"=================%ld",(long)currPage);
    
    
    
}

-(void)delayMethod
{
    self.requestParas =  @{@"userId":[[MyUserInfoManager shareInstance]userId],
                           @"ownerId":[[MyUserInfoManager shareInstance]userId],
                           @"token":[[MyUserInfoManager shareInstance]token]};
    
    NSLog(@"==============zheg===%@=",self.requestParas);
    
    self.RequestPostWithChcheURL = LKB_ALLGroup_List_Url;
    
}

-(void)logout
{
    
    
    [[YQUser usr]doLoginOut];
    
    LoginHomeViewController *loginRootVC = [[LoginHomeViewController alloc]init];
    LKBBaseNavigationController* loginNav = [[LKBBaseNavigationController alloc] initWithRootViewController:loginRootVC];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error && info) {
            
            NSLog(@"退出成功");
        }
    } onQueue:nil];
    
    AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.window setRootViewController:loginNav];
}



- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
    if (!request.isLoadingMore) {
        
        [self.tableView.pullToRefreshView stopAnimating];
    } else {
        
        [self.tableView.infiniteScrollingView stopAnimating];
        
    }
    
    NSLog(@"==========================%@",errorMessage);
    
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        
        if ([errorMessage isEqualToString:@"该用户未通过验证！"]) {
            
           [XHToast showTopWithText:@"未通过安全验证，请重新登录" topOffset:60.0];
            [self logout];
            
            
        }
        if ([errorMessage isEqualToString:@"没有网络，连接失败"]) {
            
            if (_dataArray.count == 0) {
                
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
    
    if ([request.url isEqualToString:LKB_ALL_DYNAMIC]||[request.url isEqualToString:LKB_ALL_DYNAMIC_Question]||[request.url isEqualToString:LKB_ALL_DYNAMIC_Insight]||[request.url isEqualToString:LKB_ALL_DYNAMIC_Topic]||[request.url isEqualToString:LKB_ALL_allDynamics]) {
        NewTimeDynamicModel *topicModel = (NewTimeDynamicModel *)parserObject;
        
        NSLog(@"++++++++++++++++++++++++++++++%@",[topicModel.data valueForKey:@"coverList"]);
        NSLog(@"++++++++++++++++++++++++++++++%@",[topicModel.data valueForKey:@"imageInfo"]);
        
        NSLog(@"++++++++++++++++++++++++++++++%lu",(unsigned long)_dataArray.count);

        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *KeyStr = [NSString stringWithFormat:@"New%@",[MyUserInfoManager shareInstance].userId];
        
        if (!request.isLoadingMore) {
            
            
            NSString * noticeType = [NSString stringWithFormat:@"LoginHomeViewController"];
            
            NSString *str = [userDefaults objectForKey:noticeType];
            
            NSLog(@"------------------------------%@",str);
            // 是否是第一次登录
            if ([str isEqualToString:@"isNewLogin"]) {
                
                
                NSArray *isNewLoginModelArray = [userDefaults objectForKey:@"isNewLoginModel"];
                
                NSLog(@"=========================%@",isNewLoginModelArray);
                // 第一次登录是否有通知 无通知
                if (isNewLoginModelArray == nil) {
                    
                    _dataArray = [NSMutableArray arrayWithArray:topicModel.data];
                    
                    
                }
                else {
                    // 有通知
                    _dataArray = [NSMutableArray arrayWithArray:topicModel.data];
                    
                    NewDynamicDetailModel *Newmodel = [[NewDynamicDetailModel alloc]initWithDic:isNewLoginModelArray];
                    
                    [_dataArray insertObject:Newmodel atIndex:0];
                    
                    // 第一次登录数据标注成未读的状态
                    [userDefaults setObject:@"isUnRead" forKey:KeyStr];
                    
                    
                    //                    NSMutableArray *haveUnReadArr = [NSMutableArray arrayWithArray:_dataArray];
                    
                    //                    [userDefaults setObject:haveUnReadArr forKey:@"haveUnReadArr"];
                    
                    
                    //                    NSLog(@"=======================%@",[userDefaults objectForKey:@"haveUnReadArr"]);
                    
                    NSString * isNewLoginStr =[userDefaults objectForKey:KeyStr];
                    
                    NSLog(@"=======================%@",isNewLoginStr);
                    
                    
                }
                
            }
            else {
                
                
                
                //                NSString *tempString = [_dataArray componentsJoinedByString:@","];
                
                
                NSString * isUnReadStr =[userDefaults objectForKey:KeyStr];
                NSLog(@"=======================%@",isUnReadStr);
                
                if ([isUnReadStr isEqualToString:@"isUnRead"]) {
                    
                    _dataArray = [NSMutableArray arrayWithArray:topicModel.data];
                    
                    NSArray *theGoodArrModelArray = [userDefaults objectForKey:@"theGoodArr"];
                    
                    NSLog(@"=========================%@",theGoodArrModelArray);
                    
                    
                    NewDynamicDetailModel *Newmodel = [[NewDynamicDetailModel alloc]initWithDic:theGoodArrModelArray];
                    
                    [_dataArray insertObject:Newmodel atIndex:0];
                    
                    NSLog(@"=========================%lu",(unsigned long)_dataArray.count);
                    
                    
                }
                else {
                    
                    _dataArray = [NSMutableArray arrayWithArray:topicModel.data];
                    
                }
                
                
            }
            
        }else {
            
            
            
            //            NSString *tempString = [_dataArray componentsJoinedByString:@","];
            //            [userDefaults setObject:@"isUnRead" forKey:tempString];
            
            
            NSString * str =[userDefaults objectForKey:KeyStr];
            
            NSLog(@"=======================%@",str);
            
            [_dataArray addObjectsFromArray:topicModel.data];
            
            
            if (str) {
                if ([str isEqualToString:@"isUnRead"])  {
                    
                    
                    
                    NSString *NewtempString = [_dataArray componentsJoinedByString:@","];
                    
                    [userDefaults setObject:@"isUnRead" forKey:NewtempString];
                    
                    NSString * Newstr =[userDefaults objectForKey:NewtempString];
                    
                    NSLog(@"=======================%@",Newstr);
                    
                }

            }
            
            
            
            
            
            
        }
        
        
        NSLog(@"/////////////////<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<%@",_dataArray);
        
        
        
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
    
    
    
    if(self.requestURL ==LKB_ALLGroup_List_Url)
    {
        
        GroupModel *groupModel = (GroupModel *)parserObject;
        
        NSLog(@"========%@===============",parserObject);
        
        NSLog(@"++++++++++++++++++++++++++++++%@",[groupModel.data valueForKey:@"groupName"]);

        if (!request.isLoadingMore ) {
            
            NSLog(@"群组是怎么回事······%@·····",groupModel.data);
            
            if (_groupArray.count == 0) {
                
                if(groupModel.data.count!=0&&groupModel!=nil)
                {
                    
                    _groupArray = [NSMutableArray arrayWithArray:groupModel.data];
                }
                
                
                for (int i = 0; i < _groupArray.count; i++) {
                    
                    if (i < 10) {
                        
                        GroupDetailModel *model = (GroupDetailModel *)_groupArray[i];
                        
                        UIImageView * CirleImageView =[[UIImageView alloc]initWithFrame:CGRectMake(16+i*80, 18, 48,48)];
                        CirleImageView.layer.masksToBounds = YES;
                        CirleImageView.layer.cornerRadius = 24;
                        
                        
                        NSLog(@"===========================%@",model.groupAvatar);
                        if (i < 9) {
                            [CirleImageView sd_setImageWithURL:[model.groupAvatar lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
                            
                        }
                        else {
                            CirleImageView.image = [UIImage imageNamed:@"all_icon"];
                            [CirleImageView setImage:[UIImage imageNamed:@"all_icon"]];
                            
                        }
                        
                        UILabel * CirleNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(12+i*80, 76, 60,20)];
                        CirleNameLabel.font = [UIFont systemFontOfSize:12];
                        CirleNameLabel.backgroundColor = [UIColor whiteColor];
                        if (i < 9) {
                            CirleNameLabel.text = model.groupName;
                            
                        }
                        else {
                            
                            CirleNameLabel.text = @"全部";
                            
                        }
                        
                        CirleNameLabel.textColor = CCCUIColorFromHex(0x333333);
                        CirleNameLabel.textAlignment = NSTextAlignmentCenter;
                        
                        UIButton *circleButton= [[UIButton alloc]initWithFrame:CGRectMake(16+i*80, 0, 60,104)];
                        circleButton.backgroundColor = [UIColor clearColor];
                        circleButton.clipsToBounds = YES;
                        
                        [circleButton addTarget:self action:@selector(circleButton:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        if (i < 9) {
                            
                            circleButton.tag = [model.groupId integerValue];

                        }
                        else {
                            
                            circleButton.tag = 1002;

                        }
                        
                        
                        
                        [_headerScrollView addSubview:CirleImageView];
                        [_headerScrollView addSubview:CirleNameLabel];
                        [_headerScrollView addSubview:circleButton];
                        
                    }
                    
                    _headerScrollView.contentSize = CGSizeMake(10 *80 , 104);


                }
                    
                

            }
            
        }
    }
    
    
    
}

- (void)tryAgainButton:(id )sender {
    
    [self initializePageSubviews];
    
}


- (void)circleButton:(id )sender {
    
    
    NSString *str = [NSString stringWithFormat: @"%ld",(long)[sender tag]];
    
    
    
    for (int i = 0; i < _groupArray.count; i++) {
        
        GroupDetailModel *model = (GroupDetailModel *)_groupArray[i];
        
        if ([str isEqualToString:model.groupId]) {

                FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
                farmerVC.type = @"1";
            
                NSString *str = [NSString stringWithFormat:@"circle%@",model.groupId];
            
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            
                NSString *passWord = [ user objectForKey:str];
            
            
                NSLog(@"===========%@======",model.isJoin);
                NSLog(@"===========%@======",model.groupAvatar);
            
                if (!passWord) {
                    farmerVC.ifJion = model.isJoin;
                    [CircleIfJoinManager shareInstance].ifJoin = model.isJoin;
            
                }
                else
                {
                    farmerVC.ifJion = passWord;
                    [CircleIfJoinManager shareInstance].ifJoin = model.isJoin;
            
                }
                farmerVC.circleId = model.groupId;
                farmerVC.groupAvatar = model.groupAvatar;
                farmerVC.toUserId = [MyUserInfoManager shareInstance].userId;
                farmerVC.mytitle = model.groupName;
            farmerVC.type= @"1";
            
                farmerVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:farmerVC animated:YES];

        }
        
    }
    
    
    if ([str isEqualToString:@"1002"]) {
        
        DiscoverCircleRootViewController * activityVC = [[DiscoverCircleRootViewController alloc]init];
        activityVC.showNavBar = YES;
        activityVC.type =@"2";
        
        activityVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:activityVC animated:YES];

    }
}






- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 109)];
        backView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        
        _headerScrollView = [[UIScrollView alloc] init];
        _headerScrollView.backgroundColor = [UIColor whiteColor];
        _headerScrollView.frame = CGRectMake(0, 0, kDeviceWidth, 104);
        _headerScrollView.showsHorizontalScrollIndicator = NO;
        _headerScrollView.showsVerticalScrollIndicator =NO;

        _headerScrollView.bounces = NO;
        _headerScrollView.alwaysBounceHorizontal = YES;
        _headerScrollView.alwaysBounceVertical = NO;
        
        
        
        if (_groupArray !=nil) {
            for (int i = 0; i < _groupArray.count; i++) {
                
                if (i < 10) {
                    
                    GroupDetailModel *model = (GroupDetailModel *)_groupArray[i];
                    
                    
                    
                    
                    UIImageView * CirleImageView =[[UIImageView alloc]initWithFrame:CGRectMake(16+i*80, 18, 48,48)];
                    CirleImageView.layer.masksToBounds = YES;
                    CirleImageView.layer.cornerRadius = 24;
                    
                    if (i < 9) {
                        [CirleImageView sd_setImageWithURL:[model.groupAvatar lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];

                    }
                    else {
                        CirleImageView.image = [UIImage imageNamed:@"all_icon"];
                        [CirleImageView setImage:[UIImage imageNamed:@"all_icon"]];
                        
                    }
                    
                    
                    UILabel * CirleNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(12+i*80, 76, 60,20)];
                    CirleNameLabel.font = [UIFont systemFontOfSize:12];
                    
                    CirleNameLabel.backgroundColor = [UIColor whiteColor];
                    if (i < 9) {
                        CirleNameLabel.text = model.groupName;

                    }
                    else {
                        
                        CirleNameLabel.text = @"全部";

                    }
                    
                    CirleNameLabel.textColor = CCCUIColorFromHex(0x333333);
                    CirleNameLabel.textAlignment = NSTextAlignmentCenter;
                    
                    UIButton *circleButton= [[UIButton alloc]initWithFrame:CGRectMake(16+i*80, 0, 60,104)];
                    circleButton.backgroundColor = [UIColor clearColor];
                    circleButton.clipsToBounds = YES;
                    
                    [circleButton addTarget:self action:@selector(circleButton:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    if (i < 9) {
                        
                        circleButton.tag = [model.groupId integerValue];
                        
                    }
                    else {
                        
                        circleButton.tag = 1002;
                        
                    }
                    
                    
                    [_headerScrollView addSubview:CirleImageView];
                    [_headerScrollView addSubview:CirleNameLabel];
                    [_headerScrollView addSubview:circleButton];
                    
                }
            }
            _headerScrollView.contentSize = CGSizeMake(10 *80 , 104);
            
            
        }
        
        else {
            
            for (int i = 0; i < 5; i++) {
                
                UIImageView * CirleImageView =[[UIImageView alloc]initWithFrame:CGRectMake(16+i*80, 18, 48,48)];
                CirleImageView.backgroundColor = CCCUIColorFromHex(0xf2f3f8);
                CirleImageView.layer.masksToBounds = YES;
                CirleImageView.layer.cornerRadius = 24;
                
                UILabel * CirleNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(12+i*80, 76, 60,20)];
                
                CirleNameLabel.backgroundColor = CCCUIColorFromHex(0xf2f3f8);

                [_headerScrollView addSubview:CirleImageView];
                [_headerScrollView addSubview:CirleNameLabel];

                
            }

            
            _headerScrollView.contentSize = CGSizeMake(5 *80 , 104);

        }
        
        
        


        [backView addSubview:_headerScrollView];

        return backView;
        
    }
    else {
        UIView* footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor infosBackViewColor];
        return footerView;
        
    }
}


- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray.count==0) {
        
        return 1;
    }else
    {
        
        return self.dataArray.count;

    }
    
    
    
}


- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 109;
    }
    else {
        
        return 10;
    }
}


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row< _dataArray.count) {
        
        NewDynamicDetailModel * insight = _dataArray[indexPath.row ];
        NSLog(@"=================================%@",insight);

        NSLog(@"=================================%lu",(unsigned long)insight.coverList.count);
        NSLog(@"=================================%lu",(unsigned long)insight.replyList.count);
        NSLog(@"=================================%@",insight.objectId);
        NSLog(@"=================================%@",insight.imageInfo);
        
        
        if (insight.coverList.count == 1) {
            if (insight.imageInfo == nil) {
                
                _oneImageHeight = 228;
                _oneImageWidth = 228;
            }
            else {
                
                _oneImageWidth = [[insight.imageInfo valueForKey:@"width"] floatValue];
                _oneImageHeight = [[insight.imageInfo valueForKey:@"height"] floatValue];
                
                
            }
            
        }
        if (insight.coverList.count == 0 || (_oneImageHeight >0 && _oneImageHeight <171)||(_oneImageWidth >0 && _oneImageWidth <171) ) {
            // 分享
            if (insight.shareUrl != nil) {
                // 分享无评论
                if (insight.replyList.count == 0) {
                    return [TimeShareArticleNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                        TimeShareArticleNoCommentCell *cell = (TimeShareArticleNoCommentCell *)sourceCell;
                        // 配置数据
                        [cell configTimeShareArticleNoCommentCellTimeNewDynamicDetailModel:insight];
                    } cache:^NSDictionary *{
                        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
                                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                                 kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                                 };
                    }];
                    
                }
                else if  (insight.replyList.count == 1) {
                    return [TimeShareArticleWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                        TimeShareArticleWithOneCommentCell *cell = (TimeShareArticleWithOneCommentCell *)sourceCell;
                        // 配置数据
                        [cell configTimeShareArticleWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    } cache:^NSDictionary *{
                        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
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
                        [cell configTimeShareArticleWithCommentCellTimeNewDynamicDetailModel:insight];
                    } cache:^NSDictionary *{
                        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
                                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                                 kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                                 };
                    }];
                    
                }
            }
            
            // 无图无评论
            else if (insight.replyList.count == 0) {
                
                
//                NSLog(@"=================================%@",insight.objectId);

                if (insight.objectId == nil) {
                    
                    return 73;
                    
                    
                }
                else {
                    
                    return [TimeNoImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                        
                        TimeNoImageNoCommentCell *cell = (TimeNoImageNoCommentCell *)sourceCell;
                        // 配置数据
                        [cell configTimeNoImageNoCommentTimeNewDynamicDetailModel:insight];
                        
                    } cache:^NSDictionary *{
                        
                        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
                                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                                 kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                                 
                                 };
                    }];
 
                }
                
            }
            // 无图一条评论
            else if (insight.replyList.count == 1) {
                return [TimeNoImageWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeNoImageWithOneCommentCell *cell = (TimeNoImageWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeNoImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    
                } cache:^NSDictionary *{
                    
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
            }
            // 无图两条评论
            else  {
                return [TimeNoImageWithCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeNoImageWithCommentCell *cell = (TimeNoImageWithCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeNoImageWithCommentCellTimeNewDynamicDetailModel:insight];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
            }
            
            

        }
        
        if (insight.coverList.count == 1  && _oneImageHeight >171 &&_oneImageWidth >171) {
            // 一图无评论
            if (insight.replyList.count == 0)  {
                return [TimeOneImageHeightNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeOneImageHeightNoCommentCell *cell = (TimeOneImageHeightNoCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeOneImageHeightNoCommentCellTimeNewDynamicDetailModel:insight];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             
                             };
                }];
            }
            // 一张图一条评论
            else if (insight.replyList.count == 1 ) {
                return [TimeOneImageHeightWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeOneImageHeightWithOneCommentCell *cell = (TimeOneImageHeightWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeOneImageHeightWithOneCommentCellTimeNewDynamicDetailModel:insight];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
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
                    [cell configTimeOneImageHeightWithCommentCellTimeNewDynamicDetailModel:insight];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             
                             };
                    
                }];
            }
        }
        
        
        else if (insight.coverList.count == 2) {
            // 两张图片无评论
            if (insight.replyList.count == 0)   {
                return [TimeTwoImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeTwoImageNoCommentCell *cell = (TimeTwoImageNoCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeTwoImageNoCommentCellTimeNewDynamicDetailModel:insight];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
            }
            // 两张图片一条评论
            else if (insight.replyList.count == 1) {
                return [TimeTwoImageWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeTwoImageWithOneCommentCell *cell = (TimeTwoImageWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeTwoImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    
                } cache:^NSDictionary *{
                    
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
                             
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
                    [cell configTimeTwoImageWithCommentCellTimeNewDynamicDetailModel:insight];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
            }
        }
        else {
            // 三张图片无评论
            if (insight.replyList.count == 0) {
                return [TimeThreeImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeThreeImageNoCommentCell *cell = (TimeThreeImageNoCommentCell *)sourceCell;
                    
                    // 配置数据
                    
                    [cell configTimeThreeImageNoCommentCellTimeNewDynamicDetailModel:insight];
                    
                } cache:^NSDictionary *{
                    
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
                             
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             
                             };
                    
                }];

            }
            // 三张图片一评论
            else if  (insight.replyList.count == 1) {
                return [TimeThreeImageWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeThreeImageWithOneCommentCell *cell = (TimeThreeImageWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configTimeThreeImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
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
                    [cell configTimeThreeImageWithCommentCellTimeNewDynamicDetailModel:insight];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", insight.type,insight.objectId],kHYBCacheStateKey : @"expanded",
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
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CELLNONE = @"CELLNONE";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"New-circle_load"]];
        
        loadingImage.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight -104 -64);
        
        [cell addSubview:loadingImage];
        
        return cell;
    }
    
    
        if (indexPath.row < _dataArray.count) {
            
            
            NSLog(@"/////////////////<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<%@",_dataArray);

            NewDynamicDetailModel *insight = (NewDynamicDetailModel *)_dataArray[indexPath.row ];
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
                        
                        cell = [tableView dequeueReusableCellWithIdentifier:TimeShareArticleNoCommentCellIdentifier];
                        if (!cell) {
                            
                            cell = [[TimeShareArticleNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                        reuseIdentifier:TimeShareArticleNoCommentCellIdentifier];
                        }
                        
                        TimeShareArticleNoCommentCell *tbCell = (TimeShareArticleNoCommentCell *)cell;
                        
                        [tbCell configTimeShareArticleNoCommentCellTimeNewDynamicDetailModel:insight];
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
                                else if ([insight.shareUrl rangeOfString:@".html"].location != NSNotFound) {
                                    _shareType = @"8";

                                    
                                }


                                [self shareView];
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
                        
                        cell = [tableView dequeueReusableCellWithIdentifier:TimeShareArticleWithOneCommentCellIdentifier];
                        if (!cell) {
                            
                            cell = [[TimeShareArticleWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                             reuseIdentifier:TimeShareArticleWithOneCommentCellIdentifier];
                        }
                        
                        TimeShareArticleWithOneCommentCell *tbCell = (TimeShareArticleWithOneCommentCell *)cell;
                        
                        [tbCell configTimeShareArticleWithOneCommentCellTimeNewDynamicDetailModel:insight];
                        [tbCell ShareArticleWithOneCommenthandlerButtonAction:^(NSInteger clickIndex) {
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
                                if (![[[insight.replyList objectAtIndex:0] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                    [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:0] objectForKey:@"userName"];
                                    
                                }

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
                                _objectId = insight.objectId;
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
                                else if ([insight.shareUrl rangeOfString:@".html"].location != NSNotFound) {
                                    _shareType = @"8";
                                    
                                    
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
                        cell = [tableView dequeueReusableCellWithIdentifier:TimeShareArticleWithCommentCellIdentifier];
                        if (!cell) {
                            
                            cell = [[TimeShareArticleWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                          reuseIdentifier:TimeShareArticleWithCommentCellIdentifier];
                        }
                        
                        TimeShareArticleWithCommentCell *tbCell = (TimeShareArticleWithCommentCell *)cell;
                        
                        [tbCell configTimeShareArticleWithCommentCellTimeNewDynamicDetailModel:insight];
                        [tbCell ShareArticleWithCommenthandlerButtonAction:^(NSInteger clickIndex) {
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
                                if (![[[insight.replyList objectAtIndex:0] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                    [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:0] objectForKey:@"userName"];
                                    
                                }

                                peopleVC.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:peopleVC animated:YES];
                            }
                            if (clickIndex == 5) {
                                
                                NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                                peopleVC.type = @"2";
                                peopleVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
                                if (![[[insight.replyList objectAtIndex:1] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                    [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:1] objectForKey:@"userName"];
                                    
                                }


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
                                _objectId = insight.objectId;
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
                                else if ([insight.shareUrl rangeOfString:@".html"].location != NSNotFound) {
                                    _shareType = @"8";
                                    
                                    
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
                    
                    
                    if (insight.objectId == nil) {
                        cell = [tableView dequeueReusableCellWithIdentifier:TimeGoodNoticeCellIdentifier];
                        if (!cell) {
                            
                            cell = [[GoodNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                         reuseIdentifier:TimeGoodNoticeCellIdentifier];
                        }
                        
                        GoodNoticeCell *tbCell = (GoodNoticeCell *)cell;
                        [tbCell configTimeGoodNoticeCellTimeNewDynamicDetailModel:insight];
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        
                        NSString *KeyStr = [NSString stringWithFormat:@"New%@",[MyUserInfoManager shareInstance].userId];
                        
                        [userDefaults setObject:@"isUnRead" forKey:KeyStr];
                        
                        
                        tbCell.selectionStyle = UITableViewCellSelectionStyleNone;
                        [tbCell setNeedsUpdateConstraints];
                        [tbCell updateConstraintsIfNeeded];
                        
                        
                        
//                        [userDefaults setObject:@"isUnRead" forKey:[MyUserInfoManager shareInstance].userId];


//                        tbCell.selectionStyle = UITableViewCellSelectionStyleNone;
//                        [tbCell setNeedsUpdateConstraints];
//                        [tbCell updateConstraintsIfNeeded];

                        
                        
                        
                        
                    }
                    else {
                        
                        // 无图无评论
                        cell = [tableView dequeueReusableCellWithIdentifier:TimeNoImageNoCommentCellIdentifier];
                        if (!cell) {
                            cell = [[TimeNoImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                   reuseIdentifier:TimeNoImageNoCommentCellIdentifier];
                        }
                        TimeNoImageNoCommentCell *tbCell = (TimeNoImageNoCommentCell *)cell;
                        
                        [tbCell configTimeNoImageNoCommentTimeNewDynamicDetailModel:insight];
                        
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
                    
                    
                    
                }
                else if (insight.replyList.count == 1) {
                    //无图一条评论
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeNoImageWithOneCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeNoImageWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                    reuseIdentifier:TimeNoImageWithOneCommentCellIdentifier];
                    }
                    
                    TimeNoImageWithOneCommentCell *tbCell = (TimeNoImageWithOneCommentCell *)cell;
                    
                    [tbCell configTimeNoImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell NoImageWithOnehandlerButtonAction:^(NSInteger clickIndex) {
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
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                            peopleVC.hidesBottomBarWhenPushed = YES;
                            
                            if (![[[insight.replyList objectAtIndex:0] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:0] objectForKey:@"userName"];
                                
                            }

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
                    // 无图两条评论
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeNoImageWithCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeNoImageWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                 reuseIdentifier:TimeNoImageWithCommentCellIdentifier];
                    }
                    
                    TimeNoImageWithCommentCell *tbCell = (TimeNoImageWithCommentCell *)cell;
                    
                    [tbCell configTimeNoImageWithCommentCellTimeNewDynamicDetailModel:insight];
                    
                    [tbCell NoImageWithCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        
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
                            
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:0] objectForKey:@"userId"];
                            if (![[[insight.replyList objectAtIndex:0] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:0] objectForKey:@"userName"];
                                
                            }


                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 5) {
                            
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
                            if (![[[insight.replyList objectAtIndex:1] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:1] objectForKey:@"userName"];
                                
                            }

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
            else if (insight.coverList.count == 1 ) {
                
                // 一图无评论
                if (insight.replyList.count == 0) {
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeOneImageHeightNoCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeOneImageHeightNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                      reuseIdentifier:TimeOneImageHeightNoCommentCellIdentifier];
                    }
                    
                    TimeOneImageHeightNoCommentCell *tbCell = (TimeOneImageHeightNoCommentCell *)cell;
                    
                    [tbCell configTimeOneImageHeightNoCommentCellTimeNewDynamicDetailModel:insight];
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
                            
                            NSLog(@"------------------------------------------%@",insight.isJoin);
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
                                //                                self.requestURL = LKB_Common_Star_Url;
                                [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Common_Star_Url parameters:jiaoyiDic success:^(id parserObject) {
                                    
                                    NSLog(@"******%@",parserObject);
                                } failure:^(NSString *errorMessage) {
                                    
                                    //                                    [self ShowProgressHfUDwithMessage:errorMessage];
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
                else if (insight.replyList.count == 1) {
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeOneImageHeightWithOneCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeOneImageHeightWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                           reuseIdentifier:TimeOneImageHeightWithOneCommentCellIdentifier];
                    }
                    
                    TimeOneImageHeightWithOneCommentCell *tbCell = (TimeOneImageHeightWithOneCommentCell *)cell;
                    
                    [tbCell configTimeOneImageHeightWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell OneImageHeightWithOneCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        
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
                            NSLog(@"------------------------------------------%@",insight.isJoin);

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
                            
                            if (![[[insight.replyList objectAtIndex:0] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:0] objectForKey:@"userName"];
                                
                            }

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
                                    
                                    //                                        [self ShowProgressHUDwithMessage:errorMessage];
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
                else {
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeOneImageHeightWithCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeOneImageHeightWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                        reuseIdentifier:TimeOneImageHeightWithCommentCellIdentifier];
                    }
                    
                    TimeOneImageHeightWithCommentCell *tbCell = (TimeOneImageHeightWithCommentCell *)cell;
                    
                    [tbCell configTimeOneImageHeightWithCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell OneImageHeightWithCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        
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
                            if (![[[insight.replyList objectAtIndex:0] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:0] objectForKey:@"userName"];
                                
                            }

                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 5) {
                            
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
                            if (![[[insight.replyList objectAtIndex:1] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:1] objectForKey:@"userName"];
                                
                            }

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
                        
                        //                        NSString *cover = [NSString stringWithFormat:@"%@?imageMogr2/gravity/Center/thumbnail/!456x342r/crop/456x/interlace/1/format/jpg",[str lkbImageUrlAllCover]];
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
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeTwoImageNoCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeTwoImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:TimeTwoImageNoCommentCellIdentifier];
                    }
                    
                    TimeTwoImageNoCommentCell *tbCell = (TimeTwoImageNoCommentCell *)cell;
                    
                    [tbCell configTimeTwoImageNoCommentCellTimeNewDynamicDetailModel:insight];
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
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeTwoImageWithOneCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeTwoImageWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                     reuseIdentifier:TimeTwoImageWithOneCommentCellIdentifier];
                    }
                    
                    TimeTwoImageWithOneCommentCell *tbCell = (TimeTwoImageWithOneCommentCell *)cell;
                    
                    [tbCell configTimeTwoImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell TwoImageWithOneCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        
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
                            if (![[[insight.replyList objectAtIndex:0] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:0] objectForKey:@"userName"];
                                
                            }

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
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeTwoImageWithCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeTwoImageWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                  reuseIdentifier:TimeTwoImageWithCommentCellIdentifier];
                    }
                    
                    TimeTwoImageWithCommentCell *tbCell = (TimeTwoImageWithCommentCell *)cell;
                    
                    [tbCell configTimeTwoImageWithCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell TwoImageWithCommenthandlerButtonAction:^(NSInteger clickIndex) {
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
                            if (![[[insight.replyList objectAtIndex:0] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:0] objectForKey:@"userName"];
                                
                            }

                            peopleVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:peopleVC animated:YES];
                        }
                        if (clickIndex == 5) {
                            
                            NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                            peopleVC.type = @"2";
                            peopleVC.toUserId = [[insight.replyList objectAtIndex:1] objectForKey:@"userId"];
                            if (![[[insight.replyList objectAtIndex:1] objectForKey:@"userId"] isEqual:[MyUserInfoManager shareInstance].userId]) {
                                [ToUserManager shareInstance].userName = [[insight.replyList objectAtIndex:1] objectForKey:@"userName"];
                                
                            }

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
            else if (insight.coverList.count == 3) {
                
                if (insight.replyList.count == 0) {
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeThreeImageNoCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeThreeImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                  reuseIdentifier:TimeThreeImageNoCommentCellIdentifier];
                    }
                    
                    TimeThreeImageNoCommentCell *tbCell = (TimeThreeImageNoCommentCell *)cell;
                    
                    [tbCell configTimeThreeImageNoCommentCellTimeNewDynamicDetailModel:insight];
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
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeThreeImageWithOneCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeThreeImageWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                       reuseIdentifier:TimeThreeImageWithOneCommentCellIdentifier];
                    }
                    
                    TimeThreeImageWithOneCommentCell *tbCell = (TimeThreeImageWithOneCommentCell *)cell;
                    
                    [tbCell configTimeThreeImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell ThreeImageWithOneCommenthandlerButtonAction:^(NSInteger clickIndex) {
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
                    cell = [tableView dequeueReusableCellWithIdentifier:TimeThreeImageWithCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeThreeImageWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                    reuseIdentifier:TimeThreeImageWithCommentCellIdentifier];
                    }
                    
                    TimeThreeImageWithCommentCell *tbCell = (TimeThreeImageWithCommentCell *)cell;
                    
                    [tbCell configTimeThreeImageWithCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell ThreeImageWithCommenthandlerButtonAction:^(NSInteger clickIndex) {
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
            
            else {
                
                
                NSLog(@"9999999999999999999");
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
    
    
    NSLog(@"==============================%@", _objectId);
    
    
    
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
                                 @"fromLable":@"专栏",
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
    
    NSData* shareCoverData = [_shareCover dataUsingEncoding:NSUTF8StringEncoding];
    
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
//        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:shareCoverData socialUIDelegate:nil];

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
        
        
        NewDynamicDetailModel *insight = (NewDynamicDetailModel *)_dataArray[indexPath.row]
        ;
        
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
            outSideWeb.pushType =@"2222";
            outSideWeb.toUserId = insight.userId;
            
            
            
            NSLog(@",,,,,,,,,,,,<<<<<<<<<<<<<<<<<<<<<<<<%@",outSideWeb.groupName);
            
            outSideWeb.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:outSideWeb animated:YES];

        }
        else {
            
            [_dataArray removeObject:_dataArray[0]];
            
            
            
            PushGoodNewsViewController *pushVC = [[PushGoodNewsViewController alloc]init];
            
            pushVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:pushVC animated:YES];

            
            [tableView reloadData];

            
            
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
        footerVew.textLabel.text=@"已经到底了";
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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KKCellIdentifier];
        _tableView.backgroundColor =CCCUIColorFromHex(0xf7f7f7);
        _tableView.alwaysBounceVertical = YES;
        //        _tableView.estimatedRowHeight = 300;
        
    }
    return _tableView;
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



- (void)reloadCellHeightForModel:(NewDynamicDetailModel *)model atIndexPath:(NSIndexPath *)indexPath{
    
    model.shouldUpdateCache = YES;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}



@end
