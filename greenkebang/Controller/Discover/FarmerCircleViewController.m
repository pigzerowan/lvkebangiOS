//
//  FarmerCircleViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 7/19/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "FarmerCircleViewController.h"

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
#import "WFDetailController.h"
#import "OutWebViewController.h"
#import "AFNetworking.h"
#import "DiscoverPublishQuestionViewController.h"
#import "NewShareActionView.h"
#import "TYAlertController.h"
#import "UserGroupViewController.h"
#import "UMSocial.h"
#import "PeopleViewController.h"
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
#import "AgricultureCircleHeaderView.h"
#import "CircleInforViewController.h"
#import "CirclePeopleViewController.h"
#import "HFStretchableTableHeaderView.h"
#import "CircleIfJoinManager.h"
#import "NewUserMainPageViewController.h"
#import "TimeShareArticleNoCommentCell.h"
#import "TimeShareArticleWithCommentCell.h"
#import "TimeShareArticleWithOneCommentCell.h"
#import "ShareArticleManager.h"
#import "YQWebDetailViewController.h"
#define CLICK_LIKE 10003
#define CANCEL_LIKE 10004

static CGFloat kImageOriginHight =210;

NSString * const FarmerNomorlCellIdentifier = @"TimeNomorlCell";
NSString * const FarmerWithNoImageDetailCellIdentifier = @"TimeWithNoImageDetail";
NSString * const FarmerNoImageButWithDetailCellIdentifier = @"TimeWithNoImageButDetail";
NSString * const FarmerNoImageNoDetailCellIdentifier = @"NoImageNoDetailCellIdentifier";
NSString * const FarmerTimeCreatGroupCellIdentifier = @"TimeCreatGroupCellIdentifier";
NSString * const FarmerImageButNoDetailCellIdentifier = @"ImageButNoDetailCellIdentifier";
NSString * const FarmerCoulmmNoImageCellIdentifier = @"CoulmmNoImageCellIdentifier";

NSString * const FarmerNoImageNoCommentCellIdentifier = @"FarmerNoImageNoCommentDetail";
NSString * const FarmerNoImageWithCommentCellIdentifier = @"FarmerNoImageWithCommentDetail";
NSString * const FarmerNoImageWithMoreCommentCellIdentifier = @"FarmerNoImageWithMoreCommentDetail";
NSString * const FarmerNoImageWithOneCommentCellIdentifier = @"FarmerNoImageWithOneCommentDetail";
NSString * const FarmerOneImageNoCommentCellIdentifier = @"FarmerOneImageNoCommentIdentifier";
NSString * const FarmerOneImageHeightNoCommentCellIdentifier = @"FarmerOneImageHeightNoCommentIdentifier";

NSString * const FarmerOneImageWithOneCommentCellIdentifier = @"FarmerOneImageWithOneCommentIdentifier";
NSString * const FarmerOneImageHeightWithOneCommentCellIdentifier = @"FarmerOneImageHeightWithOneCommentIdentifier";

NSString * const FarmerOneImageWithCommentCellIdentifier = @"FarmerOneImageWithCommentIdentifier";NSString * const FarmerOneImageHeightWithCommentCellIdentifier = @"FarmerOneImageHeightWithCommentIdentifier";
NSString * const FarmerOneImageLongWithCommentCellIdentifier = @"FarmerOneImageLongWithCommentIdentifier";

NSString * const FarmerOneImageWithMoreCommentCellIdentifier = @"FarmerOneImageWithMoreCommentIdentifier";
NSString * const FarmerOneImageHeightWithMoreCommentCellIdentifier = @"FarmerOneImageHeightWithMoreCommentIdentifier";

NSString * const FarmerTwoImageNoCommentCellIdentifier = @"FarmerTwoImageNoCommentIdentifier";
NSString * const FarmerTwoImageWithOneCommentCellIdentifier = @"FarmerTwoImageWithOneCommentIdentifier";
NSString * const FarmerTwoImageWithCommentCellIdentifier = @"FarmerTwoImageWithCommentIdentifier";
NSString * const FarmerTwoImageWithMoreCommentCellIdentifier = @"FarmerTwoImageWithMoreCommentIdentifier";
NSString * const FarmerThreeImageNoCommentCellIdentifier = @"FarmerThreeImageNoCommentCellIdentifier";
NSString * const FarmerThreeImageWithOneCommentCellIdentifier = @"FarmerThreeImageWithOneCommentCellIdentifier";
NSString * const FarmerThreeImageWithCommentCellIdentifier = @"FarmerThreeImageWithCommentCellIdentifier";
NSString * const FarmerThreeImageWithMoreCommentCellIdentifier = @"FarmerThreeImageWithMoreCommentCellIdentifier";
NSString * const FarmerCollecttionViewCellIdentifier = @"FarmerCollecttionViewCellIdentifier";
NSString * const FarmerShareArticleNoCommentCellIdentifier = @"FarmerShareArticleNoCommentCellIdentifier";
NSString * const FarmerShareArticleWithCommentCellIdentifier = @"FarmerShareArticleWithCommentCellIdentifier";
NSString * const FarmerShareArticleWithOneCommentCellIdentifier = @"FarmerShareArticleWithOneCommentCellIdentifier";



static NSString* FarmerKKCellIdentifier = @"TimeTableViewCellIdentifier";
static NSString* FarmerAutoLayoutDefautCellIdentifier = @"AutoLayoutDefautCellIdentifier";
@interface FarmerCircleViewController ()<UITableViewDelegate,UITableViewDataSource,HorizontalMenuDelegate,NewShareActionViewDelegete,UIGestureRecognizerDelegate>
{
    NSString *timeType;
    UIView *perfectionDegreeView;
    UIView *publishView ;
    NSString *jsonStr;
    int _lastPosition;
    UIImageView *headerImage;
    UIButton *joinBtn;
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
@property (copy, nonatomic) NSString * linkUrl;
@property(nonatomic,strong)AgricultureCircleHeaderView *circleHeaderView;
@property (nonatomic,strong)HFStretchableTableHeaderView *stretchHeaderView;
@property(nonatomic, strong)NSString *circleCover;
@property(nonatomic, strong)NSString *objectId;
@property(nonatomic, strong)NSString *groupId;

@property(nonatomic, strong)NSString *shareUrl;




@end




@implementation FarmerCircleViewController
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
    _memberArr = [NSArray array];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [MyUserInfoManager shareInstance].touchtoCircle = @"1";
    //    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [[EaseMob sharedInstance].chatManager setApnsNickname:[[MyUserInfoManager shareInstance]userName]];
    [self initializeData];
    [self initializePageSubviews];
    
    
    timeType = @"0";
    
//    self.title = _mytitle;
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 20)];
    
    titleLabel.text = _mytitle;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 30, 10, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"topmenubtn_black"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(setUpButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationController.navigationBar addSubview:_setUpButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    // 左键按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    //加入
    joinBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 100, 10, 60, 20)];
//    [joinBtn setImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];
    [joinBtn setTitle:@"加入" forState:UIControlStateNormal];
    [joinBtn setTitleColor:CCCUIColorFromHex(0x333333) forState:UIControlStateNormal];
    joinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    
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


#pragma UIGestureRecognizerDelegate


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    
    return YES;
    
}











//设置跟随滚动的滑动试图
-(void)followRollingScrollView:(UIView *)scrollView
{
    self.scrollView = scrollView;
    
    self.panGesture = [[UIPanGestureRecognizer alloc] init];
    self.panGesture.delegate=self;
    self.panGesture.minimumNumberOfTouches = 1;
//    [self.panGesture addTarget:self action:@selector(handlePanGesture:)];
    [self.scrollView addGestureRecognizer:self.panGesture];
    
    self.overLay = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    self.overLay.alpha=0;
    self.overLay.backgroundColor=self.navigationController.navigationBar.barTintColor;
    [self.navigationController.navigationBar addSubview:self.overLay];
    [self.navigationController.navigationBar bringSubviewToFront:self.overLay];
    
}


#pragma mark - 手势调用函数
-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:[self.scrollView superview]];
    
    //    NSLog(@"%f",translation.y);
    //    CGFloat detai = self.lastContentset - translation.y;
    //显示
    if (translation.y >= 5) {
        if (self.isHidden) {
            
            self.overLay.alpha=0;
            CGRect navBarFrame=NavBarFrame;
            CGRect scrollViewFrame=self.scrollView.frame;
            
            navBarFrame.origin.y = 20;
            scrollViewFrame.origin.y += 44;
            scrollViewFrame.size.height -= 44;
            
            [UIView animateWithDuration:0.2 animations:^{
                NavBarFrame = navBarFrame;
                self.scrollView.frame=scrollViewFrame;
                //                if ([self.scrollView isKindOfClass:[UIScrollView class]]) {
                //                    UIScrollView *scrollView=(UIScrollView *)self.scrollView;
                //                    scrollView.contentOffset=CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+44);
                //                }else if ([self.scrollView isKindOfClass:[UIWebView class]]){
                //                    UIWebView *webView=(UIWebView *)self.scrollView;
                //                    webView.scrollView.contentOffset=CGPointMake(webView.scrollView.contentOffset.x, webView.scrollView.contentOffset.y+44);
                //                }
            }];
            self.isHidden= NO;
        }
    }
    
    //隐藏
    if (translation.y <= -20) {
        if (!self.isHidden) {
            CGRect frame =NavBarFrame;
            CGRect scrollViewFrame=self.scrollView.frame;
            frame.origin.y = -24;
            scrollViewFrame.origin.y -= 44;
            scrollViewFrame.size.height += 44;
            
            [UIView animateWithDuration:0.2 animations:^{
                NavBarFrame = frame;
                self.scrollView.frame=scrollViewFrame;
                //                if ([self.scrollView isKindOfClass:[UIScrollView class]]) {
                //                    UIScrollView *scrollView=(UIScrollView *)self.scrollView;
                //                    scrollView.contentOffset=CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y-44);
                //                }else if ([self.scrollView isKindOfClass:[UIWebView class]]){
                //                    UIWebView *webView=(UIWebView *)self.scrollView;
                //                    webView.scrollView.contentOffset=CGPointMake(webView.scrollView.contentOffset.x, webView.scrollView.contentOffset.y-44);
                //                }
                
                
            } completion:^(BOOL finished) {
                self.overLay.alpha=1;
            }];
            self.isHidden=NO;
        }
    }
    
    
    
}


-(void)joinBtn
{
    
    self.requestParas = @{@"groupId":_circleId,
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token]
                          };
    self.requestURL = LKB_Group_Join_Url;


}



-(void)backToMain
{
    [self.navigationController.navigationBar setClipsToBounds:NO];
    self.navigationController.navigationBar.alpha=1;
    [self.overLay removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


// 右键详情界面
-(void)setUpButton:(id)sender
{
    CircleInforViewController * circleInforVC = [[CircleInforViewController alloc]init];
    circleInforVC.circleId = _circleId;
    
    [self.navigationController pushViewController:circleInforVC animated:YES];
}

-(ZFActionSheet *)actionSheet
{
    if (!_actionSheet) {
        _actionSheet = [ZFActionSheet actionSheetWithTitle:@"请选择你的操作" confirms:@[@"举报"] cancel:@"取消" style:ZFActionSheetStyleDefault];
        _actionSheet.delegate = self;
        
    }
    return _actionSheet;
}

-(ZFActionSheet *)actionshare
{
    if (!_actionshare) {
        _actionshare = [ZFActionSheet actionSheetWithTitle:@"请选择你的操作" confirms:@[@"分享",@"退出"] cancel:@"取消" style:ZFActionSheetStyleDefault];
        _actionshare.delegate = self;
        _actionshare.tag = 100023;
    }
    return _actionshare;
}



#pragma mark - ZFActionSheetDelegate
- (void)clickAction:(ZFActionSheet *)actionSheet atIndex:(NSUInteger)index
{
    NSLog(@"选中了 %zd",index);
    
    
    if (actionSheet.tag==100023) {
        if (index==1) {
            self.requestParas = @{@"groupId":_circleId,
                                  @"userId":[MyUserInfoManager shareInstance].userId,
                                  @"token":[MyUserInfoManager shareInstance].token
                                  };
            self.requestURL = LKB_Group_Logout_Url;
            
        }else
        {
            // 分享
            [self shareView];
        }
        
        
    }
    else
    {
        
        if (index==1) {
            
            // 删除
            
//            self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
//                                  @"topicId":_reportObject,
//                                  @"token":[[MyUserInfoManager shareInstance]token],
//                                  };
//            
//            self.requestURL = LKB_Delete_Topic_Url;
            
            
            
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
}

- (void)shareView {
    
    if (_mytitle==nil) {
        _mytitle= @"圈子详情";
    }
    if (_describle==nil) {
        _describle= @"点击查看详情";
    }
    if (_groupAvatar==nil) {
        _groupAvatar= @" ";
    }
    
    
    
    
    if (_shareType == nil ) {
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
    else if ([_shareType isEqualToString:@"1"]) {
        
        _urlStr = [NSString stringWithFormat:@"http://www.lvkebang.cn/quan/%@", _circleId];
        _shareCover = [NSString stringWithFormat:@"http://imagetest.lvkebang.cn/static/group_header/%@",_groupAvatar];
        
        
        NSDictionary *shaDic = @{@"cover":_shareCover,
                                 @"userId":[[MyUserInfoManager shareInstance]userId],
                                 @"description":_intrioduceStr,
                                 @"title":_mytitle,
                                 @"circleId":_circleId,
                                 @"linkUrl":_urlStr,
                                 @"shareType":@"1",
                                 //                             @"featureId":_circleDetailId
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
        peopleVC.VCType = @"1";

        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
        peopleVC.questionId = _circleId;
        
        if ([_shareType isEqualToString:@"1"]) {
            
            peopleVC.shareType = @"1";

        }else if ([_shareType isEqualToString:@"2"]) {
            
            peopleVC.shareType = @"2";

        }else {
            peopleVC.shareType = _shareType;

            
        }
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
        if ([_shareType isEqualToString:@"2"]) {
            
            extConfig.wechatSessionData.url  = _urlStr;

        }else {
            extConfig.wechatSessionData.url  = _shareUrl;

            
        }

        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    // 微信朋友圈
    if (index==3) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        if ([_shareType isEqualToString:@"2"]) {
            
            extConfig.wechatTimelineData.url  = _urlStr;;
            
        }else {
            extConfig.wechatTimelineData.url  = _shareUrl;
            
            
        }

        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // 新浪
    if (index==4) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        //
        extConfig.sinaData.shareText =_describle;
        
        //        extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_topicId];
        
        
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
    }
    // 空间
    if (index==5) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _mytitle;
        
        extConfig.tencentData.shareText = _describle;
        if ([_shareType isEqualToString:@"2"]) {
            
            extConfig.qzoneData.url  = _urlStr;;
            
        }else {
            extConfig.qzoneData.url  = _shareUrl;
            
            
        }

        
        
        
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
        if ([_shareType isEqualToString:@"2"]) {
            
            extConfig.qqData.url  = _urlStr;;
            
        }else {
            extConfig.qqData.url  = _shareUrl;
            
            
        }

        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_describle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
    
    
}



-(void)pushtoAttention:(id)sender
{
    SelectedRecommendViewController *attentionVC = [[SelectedRecommendViewController alloc]init];
    attentionVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:attentionVC animated:YES];
}




- (void)viewWillAppear:(BOOL)animated
{
    
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@"push" forKey:@"FarmerCircleViewController"];
    [pushJudge synchronize];
    
    
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    self.navigationController.navigationBar.alpha=0;

    self.edgesForExtendedLayout = 0;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationController.navigationBar.translucent = NO;
    
//    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    if (![[CircleIfJoinManager shareInstance].ifJoin isEqualToString:_ifJion]) {
        
        if ([_ifJion isEqualToString:@"1"]) {
            
            // 未加入
            joinBtn.hidden = YES;
        }
        else {
            joinBtn.hidden = NO;
            
            
        }

        
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
            footerVew.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
            footerVew.textLabel.text=@"没有更多数据了哦..";
            self.tableView.tableFooterView = footerVew;
            self.tableView.tableFooterView.hidden = YES;
        }

        
    }
    
    [ShareArticleManager shareInstance].shareType = nil;
    [MobClick beginLogPageView:@"FarmerCircleViewController"];

    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController.navigationBar setClipsToBounds:NO];
    self.navigationController.navigationBar.alpha=1;;
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    joinBtn.hidden = YES;
    [MobClick endLogPageView:@"FarmerCircleViewController"];

    
}


- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.alpha=1;;

    joinBtn.hidden = YES;

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
    
    
    self.requestParas = @{@"userId":_toUserId,
                          @"groupId":_circleId,
                          @"page":@(currPage),
                          @"ownerId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    
    self.requestURL =  LKB_Circle_Topic_Url;
    
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
            
            self.navigationController.navigationBar.alpha = 1;

            
            [self.tableView removeFromSuperview];
            
            [publishView removeFromSuperview];
            [joinBtn removeFromSuperview];
            WithoutInternetImage.hidden = NO;
            tryAgainButton.hidden = NO;
            
        }

        return;
    }
    
    if ([request.url isEqualToString:LKB_ALL_DYNAMIC]||[request.url isEqualToString:LKB_ALL_DYNAMIC_Question]||[request.url isEqualToString:LKB_ALL_DYNAMIC_Insight]||[request.url isEqualToString:LKB_ALL_DYNAMIC_Topic]||[request.url isEqualToString:LKB_ALL_allDynamics]||[request.url isEqualToString:LKB_Circle_Topic_Url]) {
        
        
        NewTimeDynamicModel *topicModel = (NewTimeDynamicModel *)parserObject;
//        if ([MyUserInfoManager shareInstance].avatar == nil) {
//            [MyUserInfoManager shareInstance].avatar = @"defualt_normal.png";
//        }
        
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:topicModel.data];
            
            [_circleHeaderView configAgricultureCircleHeaderViewWithModel:topicModel];
            [headerImage sd_setImageWithURL:[[topicModel.object valueForKey:@"groupAvatar"] lkbImageUrl5] placeholderImage:YQNormalPlaceImage];


        }else {
            [_dataArray addObjectsFromArray:topicModel.data];
        }
        
        
        [self.tableView reloadData];
        
        _ifJion = [topicModel.object valueForKey:@"isJoin"];
        _intrioduceStr = [topicModel.object valueForKey:@"groupDesc"];
        _memberNum = [topicModel.object valueForKey:@"memberNum"];
        
        _memberArr =[topicModel.object valueForKey:@"avatars"] ;
        
        [CircleIfJoinManager shareInstance].ifJoin = _ifJion;

        
        if (topicModel.data.count == 0) {
            //             self.tableView.showsInfiniteScrolling = NO;
            self.tableView.tableFooterView.hidden = NO;
            [self.tableView.infiniteScrollingView endScrollAnimating];
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            [self.tableView.infiniteScrollingView beginScrollAnimating];
        }
        
        
    }
    
    if ([request.url isEqualToString:LKB_Group_Join_Url]) {
        LKBBaseModel *baseModel = (LKBBaseModel *)parserObject;
        
        NSLog(@"========================================%@",baseModel.msg);
        NSLog(@"========================================%@",baseModel.success);

        if ([baseModel.success isEqualToString:@"1"]) {
            
        
            _ifJion = @"0";
            joinBtn.hidden = YES;
            
            [CircleIfJoinManager shareInstance].ifJoin = _ifJion;
            
            
            [self initializePageSubviews];
            
        }

        
    }
    
    if(self.requestURL == LKB_Group_List_Url)
    {
        GroupModel *groupModel = (GroupModel *)parserObject;
        
        NSLog(@"========%@===============",parserObject);
        if (!request.isLoadingMore) {
            NSLog(@"群组是怎么回事······%@·····",groupModel.data);
            if(groupModel.data.count!=0&&groupModel!=nil)
            {
                _groupArray = [NSMutableArray arrayWithArray:groupModel.data];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                // 1秒后异步执行这里的代码...
                
                
                for (int i=0; i<_groupArray.count; i++) {
                    GroupDetailModel *findPeoleModel = (GroupDetailModel *)_groupArray[i];
                    
                    if (findPeoleModel.easyMobId==nil) {
                        findPeoleModel.easyMobId = @"100000008888";
                    }
                    
                    
                    NSUserDefaults *userDefault = [[NSUserDefaults alloc]init];
                    
                    NSDictionary *mydic = @{@"userName":findPeoleModel.groupName,
                                            @"groupAvatar":findPeoleModel.groupAvatar,
                                            @"groupId":findPeoleModel.groupId
                                            };
                    NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
                    [userDefault setObject:dic  forKey:findPeoleModel.easyMobId];
                }
                
            });
            
            
        }
        
    }
    
    
    
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
    
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    else {
        
        return 0;
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<_dataArray.count) {
        NewDynamicDetailModel *model =self.dataArray[indexPath.row];
        
        NSLog(@"--------------------%lu",(unsigned long)model.coverList.count);

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

            
            else if (model.replyList.count == 0) {
                
                return [TimeNoImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeNoImageNoCommentCell *cell = (TimeNoImageNoCommentCell *)sourceCell;
                    // 配置数据
                    [cell configFarmerNoImageNoCommentTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
            }
            else if (model.replyList.count == 1) {
                
                return [TimeNoImageWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeNoImageWithOneCommentCell *cell = (TimeNoImageWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configFarmerNoImageWithOneCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
            }
            else {
                return [TimeNoImageWithCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeNoImageWithCommentCell *cell = (TimeNoImageWithCommentCell *)sourceCell;
                    // 配置数据
                    
                    [cell configFarmerNoImageWithCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
            }
            
        }
        else if (model.coverList.count == 1 && _oneImageWidth >171&& _oneImageHeight >171) {
            
            // 一图无评论
            if (model.replyList.count == 0)  {
                
                return [TimeOneImageHeightNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeOneImageHeightNoCommentCell *cell = (TimeOneImageHeightNoCommentCell *)sourceCell;
                    // 配置数据
                    [cell configFarmerOneImageHeightNoCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
                
            }
            // 一张图一条评论
            else if (model.replyList.count == 1) {
                
                
                return [TimeOneImageHeightWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeOneImageHeightWithOneCommentCell *cell = (TimeOneImageHeightWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configFarmerOneImageHeightWithOneCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
                
                
            }
            else {
                // 一张图两条
                return [TimeOneImageHeightWithCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeOneImageHeightWithCommentCell *cell = (TimeOneImageHeightWithCommentCell *)sourceCell;
                    // 配置数据
                    [cell configFarmerOneImageHeightWithCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
            }
            
        }
        else if (model.coverList.count == 2) {
            
            if (model.replyList.count == 0)   {
                
                return [TimeTwoImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeTwoImageNoCommentCell *cell = (TimeTwoImageNoCommentCell *)sourceCell;
                    // 配置数据
                    [cell configFarmerTwoImageNoCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
            }
            else if (model.replyList.count == 1) {
                
                return [TimeTwoImageWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeTwoImageWithOneCommentCell *cell = (TimeTwoImageWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configFarmerTwoImageWithOneCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
            }
            else {
                return [TimeTwoImageWithCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeTwoImageWithCommentCell *cell = (TimeTwoImageWithCommentCell *)sourceCell;
                    // 配置数据
                    [cell configFarmerTwoImageWithCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
            }
        }
        else  {
            
            if (model.replyList.count == 0) {
                return [TimeThreeImageNoCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeThreeImageNoCommentCell *cell = (TimeThreeImageNoCommentCell *)sourceCell;
                    // 配置数据
                    [cell configFarmerThreeImageNoCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
            }
            else if  (model.replyList.count == 1) {
                return [TimeThreeImageWithOneCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                    TimeThreeImageWithOneCommentCell *cell = (TimeThreeImageWithOneCommentCell *)sourceCell;
                    // 配置数据
                    [cell configFarmerThreeImageWithOneCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
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
                    [cell configFarmerThreeImageWithCommentCellTimeNewDynamicDetailModel:model];
                } cache:^NSDictionary *{
                    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%@-%@", model.type,model.objectId],
                             kHYBCacheStateKey : @"expanded",
                             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                             kHYBRecalculateForStateKey : @(YES) // 标识重新更新
                             };
                }];
                
            }
            
        }
    }
    else {
        
        return 400;
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
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
//{
//    
//    CATransition *animation = [CATransition animation];
//    animation.type = kCATransitionFromBottom;
//    animation.subtype = kCATransitionFromBottom;
//    animation.duration = 0.5;
//    [publishView.layer addAnimation:animation forKey:nil];
//    
//    publishView.hidden = YES;
//}
//
//
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionMoveIn;
        animation.subtype = kCATransitionFromBottom;
//        animation.duration = 0.2;
        [publishView.layer addAnimation:animation forKey:nil];
        

        publishView.hidden = NO;
        
    });
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.navigationBar.alpha=scrollView.contentOffset.y/200;
    
    if ( scrollView.contentOffset.y < 30  ) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.alpha=0;

        
    }
    else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        self.navigationController.navigationBar.alpha=scrollView.contentOffset.y/200;


    }
    
    
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 25) {
        _lastPosition = currentPostion;
        // 向上滑
        if (currentPostion == 0){
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                
//                CATransition *animation = [CATransition animation];
//                animation.type = kCATransitionMoveIn;
//                animation.subtype = kCATransitionFromBottom;
////                animation.duration = 0.2;
//                [publishView.layer addAnimation:animation forKey:nil];

                publishView.hidden = NO;
                
            });

            
            
        }else {
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                
//                    CATransition *animation = [CATransition animation];
//                    animation.type = kCATransitionMoveIn;
//                    animation.subtype = kCATransitionFromTop;
////                    animation.duration = 0.2;
//                    [publishView.layer addAnimation:animation forKey:nil];
                
                    publishView.hidden = YES;
                
            });

            

        }


    }
    else if (_lastPosition - currentPostion > 25)
    {
        _lastPosition = currentPostion;
        
        
        // 向下滑
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
//            CATransition *animation = [CATransition animation];
//            animation.type = kCATransitionMoveIn;
//            animation.subtype = kCATransitionFromBottom;
////            animation.duration = 0.2;
//            [publishView.layer addAnimation:animation forKey:nil];

            publishView.hidden = NO;
            
        });
    }
    
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
    
    
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CELLNONE = @"CELLNONE";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.textLabel.text = @"";
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
        if (indexPath.row < self.dataArray.count) {
            
            NewDynamicDetailModel *insight = (NewDynamicDetailModel *)_dataArray[indexPath.row];
            
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

            
            
            
            
            
            NSLog(@"-------------------------------------%lu",(unsigned long)insight.coverList.count);
            
            if (insight.coverList.count == 0  || (_oneImageWidth >0 && _oneImageWidth <171) || (_oneImageHeight >0 && _oneImageHeight <171) ) {
                
                
                if (insight.shareUrl !=nil) {
                    
                    if (insight.replyList.count == 0) {
                        
                        cell = [tableView dequeueReusableCellWithIdentifier:FarmerShareArticleNoCommentCellIdentifier];
                        if (!cell) {
                            
                            cell = [[TimeShareArticleNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                        reuseIdentifier:FarmerShareArticleNoCommentCellIdentifier];
                        }
                        
                        TimeShareArticleNoCommentCell *tbCell = (TimeShareArticleNoCommentCell *)cell;
                        
                        [tbCell configFarmerShareArticleNoCommentCellTimeNewDynamicDetailModel:insight];
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
                        
                        cell = [tableView dequeueReusableCellWithIdentifier:FarmerShareArticleWithOneCommentCellIdentifier];
                        if (!cell) {
                            
                            cell = [[TimeShareArticleWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                             reuseIdentifier:FarmerShareArticleWithOneCommentCellIdentifier];
                        }
                        
                        TimeShareArticleWithOneCommentCell *tbCell = (TimeShareArticleWithOneCommentCell *)cell;
                        
                        [tbCell configFarmerShareArticleWithOneCommentCellTimeNewDynamicDetailModel:insight];
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
                        cell = [tableView dequeueReusableCellWithIdentifier:FarmerShareArticleWithCommentCellIdentifier];
                        if (!cell) {
                            
                            cell = [[TimeShareArticleWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                          reuseIdentifier:FarmerShareArticleWithCommentCellIdentifier];
                        }
                        
                        TimeShareArticleWithCommentCell *tbCell = (TimeShareArticleWithCommentCell *)cell;
                        
                        [tbCell configFarmerShareArticleWithCommentCellTimeNewDynamicDetailModel:insight];
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
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerNoImageNoCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeNoImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                               reuseIdentifier:FarmerNoImageNoCommentCellIdentifier];
                    }
                    
                    TimeNoImageNoCommentCell *tbCell = (TimeNoImageNoCommentCell *)cell;
                    
                    [tbCell configFarmerNoImageNoCommentTimeNewDynamicDetailModel:insight];
                    [tbCell handlerButtonAction:^(NSInteger clickIndex) {
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
                    // 无图一条评论
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerNoImageWithOneCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeNoImageWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                    reuseIdentifier:FarmerNoImageWithOneCommentCellIdentifier];
                    }
                    
                    TimeNoImageWithOneCommentCell *tbCell = (TimeNoImageWithOneCommentCell *)cell;
                    
                    [tbCell configFarmerNoImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell NoImageWithOnehandlerButtonAction:^(NSInteger clickIndex) {
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
                            outSideWeb.squareType = @"1";
                            
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
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerNoImageWithCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeNoImageWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                 reuseIdentifier:FarmerNoImageWithCommentCellIdentifier];
                    }
                    
                    TimeNoImageWithCommentCell *tbCell = (TimeNoImageWithCommentCell *)cell;
                    
                    [tbCell configFarmerNoImageWithCommentCellTimeNewDynamicDetailModel:insight];
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
            else if (insight.coverList.count == 1 && _oneImageWidth > 171 && _oneImageHeight> 171) {
                if (insight.replyList.count == 0) {
                    // 一图无评论
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerOneImageHeightNoCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeOneImageHeightNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                      reuseIdentifier:FarmerOneImageHeightNoCommentCellIdentifier];
                    }
                    
                    TimeOneImageHeightNoCommentCell *tbCell = (TimeOneImageHeightNoCommentCell *)cell;
                    
                    [tbCell configFarmerOneImageHeightNoCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell OneImageHeightNoCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        
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
                    //                    NSString *cover = [NSString stringWithFormat:@"%@?%@",[insight.images lkbImageUrlAllCover],@"imageMogr2/gravity/Center/thumbnail/!456x342r/crop/456x/interlace/1/format/jpg"];
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
                    // 一图一评论
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerOneImageHeightWithOneCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeOneImageHeightWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                           reuseIdentifier:FarmerOneImageHeightWithOneCommentCellIdentifier];
                    }
                    
                    TimeOneImageHeightWithOneCommentCell *tbCell = (TimeOneImageHeightWithOneCommentCell *)cell;
                    
                    [tbCell configFarmerOneImageHeightWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell OneImageHeightWithOneCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        
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
                    // 一图两评论
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerOneImageHeightWithCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeOneImageHeightWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                        reuseIdentifier:FarmerOneImageHeightWithCommentCellIdentifier];
                    }
                    
                    TimeOneImageHeightWithCommentCell *tbCell = (TimeOneImageHeightWithCommentCell *)cell;
                    
                    [tbCell configFarmerOneImageHeightWithCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell OneImageHeightWithCommenthandlerButtonAction:^(NSInteger clickIndex) {
                        
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
            else if  (insight.coverList.count == 2) {
                
                if (insight.replyList.count == 0) {
                    // 两图无评论
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerTwoImageNoCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeTwoImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:FarmerTwoImageNoCommentCellIdentifier];
                    }
                    
                    TimeTwoImageNoCommentCell *tbCell = (TimeTwoImageNoCommentCell *)cell;
                    
                    [tbCell configFarmerTwoImageNoCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell TwoImageNoCommenthandlerButtonAction:^(NSInteger clickIndex) {
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
                    // 两图一评论
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerTwoImageWithOneCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeTwoImageWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                     reuseIdentifier:FarmerTwoImageWithOneCommentCellIdentifier];
                    }
                    
                    TimeTwoImageWithOneCommentCell *tbCell = (TimeTwoImageWithOneCommentCell *)cell;
                    
                    [tbCell configFarmerTwoImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell TwoImageWithOneCommenthandlerButtonAction:^(NSInteger clickIndex) {
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
                    // 两图两评论
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerTwoImageWithCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeTwoImageWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                  reuseIdentifier:FarmerTwoImageWithCommentCellIdentifier];
                    }
                    
                    TimeTwoImageWithCommentCell *tbCell = (TimeTwoImageWithCommentCell *)cell;
                    
                    [tbCell configFarmerTwoImageWithCommentCellTimeNewDynamicDetailModel:insight];
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
                    // 三图无评论
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerThreeImageNoCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeThreeImageNoCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                  reuseIdentifier:FarmerThreeImageNoCommentCellIdentifier];
                    }
                    
                    TimeThreeImageNoCommentCell *tbCell = (TimeThreeImageNoCommentCell *)cell;
                    
                    [tbCell configFarmerThreeImageNoCommentCellTimeNewDynamicDetailModel:insight];
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
                    // 三图一评论
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerThreeImageWithOneCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeThreeImageWithOneCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                       reuseIdentifier:FarmerThreeImageWithOneCommentCellIdentifier];
                    }
                    
                    TimeThreeImageWithOneCommentCell *tbCell = (TimeThreeImageWithOneCommentCell *)cell;
                    
                    [tbCell configFarmerThreeImageWithOneCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell ThreeImageWithOneCommenthandlerButtonAction:^(NSInteger clickIndex) {
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
                    // 三图俩评论
                    cell = [tableView dequeueReusableCellWithIdentifier:FarmerThreeImageWithCommentCellIdentifier];
                    if (!cell) {
                        
                        cell = [[TimeThreeImageWithCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                    reuseIdentifier:FarmerThreeImageWithCommentCellIdentifier];
                    }
                    
                    TimeThreeImageWithCommentCell *tbCell = (TimeThreeImageWithCommentCell *)cell;
                    
                    [tbCell configFarmerThreeImageWithCommentCellTimeNewDynamicDetailModel:insight];
                    [tbCell ThreeImageWithCommenthandlerButtonAction :^(NSInteger clickIndex) {
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

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NewDynamicDetailModel *insight = (NewDynamicDetailModel *)_dataArray[indexPath.row];
    
    if (insight.objectId != nil) {
        
        _linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@",LKB_WSSERVICE_HTTP,insight.objectId];
        
        NSString *strmy = [_linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:strmy];
        
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
        
        outSideWeb.sendMessageType = @"2";
        outSideWeb.rightButtonType = @"2";
        outSideWeb.VcType = @"1";// 圈子动态
        outSideWeb. urlStr =_linkUrl;
        outSideWeb.htmlStr = _linkUrl;
        outSideWeb.circleId = insight.groupId;// 圈id
        outSideWeb.circleDetailId = insight.objectId;// 圈详情id
        outSideWeb.objectId = insight.objectId;// 圈详情id
        
        outSideWeb.mytitle = insight.title;
        outSideWeb.describle = insight.summary;
        outSideWeb.userAvatar = insight.userAvatar;
        outSideWeb.isAttention = insight.isAttention;
        outSideWeb.commendVcType = @"1";// 评论一级页面
        outSideWeb.groupAvatar = insight.cover;
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

#pragma mark 获取并保存cookie到userDefaults
- (void)getAndSaveCookie
{
    
    NSURL *url = [NSURL URLWithString:_linkUrl];
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    outSideWeb.sendMessageType = @"2";
    outSideWeb.rightButtonType = @"2";
    outSideWeb.VcType = @"1";
    
    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];
    
}


#pragma mark 再取出保存的cookie重新设置cookie
- (void)setCoookie
{
    NSLog(@"============再取出保存的cookie重新设置cookie===============");
    //取出保存的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //对取出的cookie进行反归档处理
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"cookie"]];
    
    if (cookies) {
        NSLog(@"有cookie");
        //设置cookie
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (id cookie in cookies) {
            [cookieStorage setCookie:(NSHTTPCookie *)cookie];
        }
    }else{
        NSLog(@"无cookie");
    }
    
    //打印cookie，检测是否成功设置了cookie
    NSArray *cookiesA = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookiesA) {
        NSLog(@"setCookie: %@", cookie);
        
        
        OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:_linkUrl];
        outSideWeb.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outSideWeb animated:YES];
    }
    NSLog(@"\n");
}





#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
    
    
    
    headerImage= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kImageOriginHight )];
    headerImage.contentMode = UIViewContentModeScaleAspectFill;
    headerImage.clipsToBounds = YES;
    
    _circleHeaderView = [[AgricultureCircleHeaderView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 305)];
    [_circleHeaderView handlerButtonAction:^(NSInteger clickIndex) {
        
        if (clickIndex == 1) {
            // 返回键
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (clickIndex == 2) {
            // 头像
            NSLog(@"头像");
            CircleInforViewController * circleInforVC = [[CircleInforViewController alloc]init];
            
            NSLog(@"====================%@",_groupAvatar);
            NSLog(@"====================%@",_memberArr);
            circleInforVC.circleId = _circleId;
            

            
            [self.navigationController pushViewController:circleInforVC animated:YES];
            
        }
        if (clickIndex == 3) {
            // top键
            NSLog(@"top键");
            CircleInforViewController * circleInforVC = [[CircleInforViewController alloc]init];
            circleInforVC.circleId = _circleId;
            
            [self.navigationController pushViewController:circleInforVC animated:YES];
            
        }
        if (clickIndex == 4) {
            // 加入
            self.requestParas = @{@"groupId":_circleId,
                                  @"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"token":[[MyUserInfoManager shareInstance]token]
                                  };
            self.requestURL = LKB_Group_Join_Url;
            
        }
        if (clickIndex == 5) {
            // 圈简介
            NSLog(@"圈简介");
            if ([_ifJion isEqualToString:@"1"]) {
                // 圈简介未加入
                CircleInforViewController * circleInforVC = [[CircleInforViewController alloc]init];
                circleInforVC.circleId = _circleId;
                circleInforVC.hidesBottomBarWhenPushed = YES;

                [self.navigationController pushViewController:circleInforVC animated:YES];
                
                
            }else {
                // 圈好友 加入
                CirclePeopleViewController * circlePeopleVC = [[CirclePeopleViewController alloc]init];
                circlePeopleVC.groupId = _circleId;
                circlePeopleVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:circlePeopleVC animated:YES];
                
                
            }
            
        }
        if (clickIndex == 6) {
            // 分享
            NSLog(@"分享");
            _shareType = @"1";
            [self shareView];
            
        }
    }];
    
    
    
    self.stretchHeaderView = [HFStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self.tableView withView:headerImage subViews:_circleHeaderView];

    
    publishView = [[UIView alloc]init];
    publishView.frame =CGRectMake(kDeviceWidth - 79, KDeviceHeight-64 - 17, 65, 65);
    publishView.layer.masksToBounds = NO;
    publishView.layer.shadowColor = CCColorFromRGBA(0, 0, 0, 0.1).CGColor;
    publishView.layer.shadowOffset = CGSizeMake(0.0f, -0.5f);
    publishView.layer.shadowOpacity = 0.5f;
    
    UIButton * publishLable = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 65, 65)];
    publishLable.imageView.frame = publishLable.bounds;
    publishLable.hidden = NO;
    [publishLable setImage:[UIImage imageNamed:@"CirlePublish"]forState:UIControlStateNormal];
    [publishLable addTarget:self action:@selector(topublishCircle:) forControlEvents:UIControlEventTouchUpInside];
    [publishView addSubview:publishLable];
    
    [self.view addSubview:publishView];
    
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 38, 31, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"topmenubtn"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(setUpButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightBtn];
    
    
    
    // 左键按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 31, 22, 22)];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_write_nor"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    
    if ([[CircleIfJoinManager shareInstance].ifJoin isEqualToString:_ifJion]) {
        
        if ([_ifJion isEqualToString:@"1"]) {
            
            // 未加入
            joinBtn.hidden = NO;
        }
        else {
            joinBtn.hidden = YES;
            
            
        }
    }
    
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
        footerVew.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        footerVew.textLabel.text=@"已经到底了";
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = YES;
    }





    
    
}

-(void)topublishCircle:(id)sender
{
    if ([_ifJion isEqualToString:@"1"]) {
        // 未加入
        
        [self ShowProgressHUDwithMessage:@"加入圈子即可发布动态"];

    }
    else {
        
        DiscoverPublishQuestionViewController * publishVC = [[DiscoverPublishQuestionViewController alloc]init];
        publishVC.VCType = @"2";
        publishVC.groupId = _circleId;
        
        publishVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:publishVC animated:YES];

    }
    
    
    
    
}

-(void)tojionCircle:(id)sender
{
    
    self.requestParas = @{@"groupId":_circleId,
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token]
                          };
    self.requestURL = LKB_Group_Join_Url;
}




#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FarmerKKCellIdentifier];
        _tableView.scrollsToTop = YES;
        _tableView.tableHeaderView = _circleHeaderView;
        _tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundColor =CCCUIColorFromHex(0xf7f7f7);
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
