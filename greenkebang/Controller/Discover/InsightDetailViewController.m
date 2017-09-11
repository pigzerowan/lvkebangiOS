//
//  InsightDetailViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 9/24/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "InsightDetailViewController.h"
#import "CustomView.h"
#import "SVPullToRefresh.h"
#import "ReplyModel.h"
#import <UIImageView+WebCache.h>
#import "GTMNSString+HTML.h"
#import "UILabel+StringFrame.h"
#import "MyUserInfoManager.h"
#import "InsightDetailModel.h"
#import "InsightReplistViewController.h"
#import "UIView+TYAlertView.h"
#import "UMSocial.h"
#import "NewShareActionView.h"
//#import "WebImgScrollView.h"
#import "UIImageView+EMWebCache.h"
#import <UIImageView+WebCache.h>
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "WFBottomBarView.h"
#import "WFWebImageShowView.h"
#import "UserGroupViewController.h"
#import "ContactsViewController.h"
#import "PeopleViewController.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"
#import "ColumnListViewController.h"
#import "ReportViewController.h"
@interface InsightDetailViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate,WFBottomBarDelegate,UIScrollViewDelegate,WFWebViewDelegate,NewShareActionViewDelegete>
{
    WFBottomBarView     *_detailBottomView;
    UIView              *_containerView;
    int  _lastPosition;
    InsightDetailChildModel *insightDetailModel;
}

@property (strong, nonatomic) UIView *topicHeaderView;
@property (strong, nonatomic) UIView *myView;
@property (assign, nonatomic) int myWebViewHeight;
@property (nonatomic, strong) UIView* webBrowserView;
@property (nonatomic, strong) UIButton *replyListBtn;
@property (nonatomic, strong) NSString *addTime;
@property(nonatomic,strong)NSMutableArray *myImgArray;
@property (nonatomic, strong) UIButton *reportButton;
@property(nonatomic,assign)BOOL isStar;
@property(nonatomic,assign)BOOL isCollection;
@property(nonatomic,assign)BOOL isShare;

@property(nonatomic,strong)TYAlertController *alertController;


@end

@implementation InsightDetailViewController

- (void)viewDidLoad {
    
}
#pragma mark - View factory
- (void)configUI{
    
    //    if (!_containerView) {
    
    _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_containerView];
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.userInteractionEnabled = YES;
    
    //    }
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    _lastPosition = 0;
    [self configUI];
    [self configBottomUI];
    
    self.title  = @"专栏详情";
    insightDetailModel.havehold = NO;
    insightDetailModel.haveup = NO;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 30, 10, 20, 20)];
    // 三个点
    [rightBtn setImage:[UIImage imageNamed:@"nav_spot_nor"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    
    self.requestParas = @{@"insightId":_topicId,
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token]
                          };
    self.requestURL = LKB_Insight_Detail_Url;
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [_replyListBtn removeFromSuperview];
}

-(void)backToMain
{
    if ([_pushTipe isEqualToString:@"1"]) {
        AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate showUserTabBarViewController];
    }else
    {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)pushtoRelist:(id)sender
{
    InsightReplistViewController *ReplistVC = [[InsightReplistViewController alloc] init];
    ReplistVC.blogId = _topicId;
    ;
    [self.navigationController pushViewController:ReplistVC animated:YES];
    
}
-(void)initializePageSubviews
{
    _topicHeaderView = [[UIView alloc]init];
    _topicHeaderView.backgroundColor = [UIColor whiteColor];
    _topicHeaderView.userInteractionEnabled = YES;
    UILabel *topicDescView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    // label获取字符串
    topicDescView.text = _InsightTitle;
    topicDescView.textColor = [UIColor blackColor];
    topicDescView.font = [UIFont systemFontOfSize:18];
    CGSize size =   [topicDescView boundingRectWithSize:CGSizeMake(kDeviceWidth-10, 0)];
    
    topicDescView.numberOfLines = 0;
    
    [topicDescView setFrame:CGRectMake(10, 10, size.width, size.height)];
    topicDescView.text = _InsightTitle;
    
    
    // 名字
    NSString *nameString = [[NSString alloc]initWithFormat:@"%@的专栏",_autherName];
    UIButton *nameButton = [[UIButton alloc]init];
    //    UILabel *nameLabel = [[UILabel alloc]init];
    CGSize nameSize = [nameString sizeWithFont:nameButton.font constrainedToSize:CGSizeMake(MAXFLOAT, 25)];
    nameButton.frame = CGRectMake(10, size.height +30, nameSize.width, 10) ;
    
    //    nameButton .titleLabel.textAlignment = NSTextAlignmentLeft;
    nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [nameButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [nameButton.titleLabel sizeToFit];
    [nameButton setTitleColor:UIColorWithRGBA(194, 139, 83, 1) forState:UIControlStateNormal];
    nameButton.tag =3000;
    [nameButton setTitle:nameString forState:UIControlStateNormal];
    [nameButton addTarget:self action:@selector(nameButton:)
         forControlEvents:UIControlEventTouchUpInside];
    
    
    // 时间
    NSString *timeString = [NSString stringWithFormat:@"·%@",_addTime];
    UILabel *timeLabel = [[UILabel alloc]init];
    CGSize timeSize = [timeString sizeWithFont:timeLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 25)];
    timeLabel.frame = CGRectMake(nameSize.width , size.height +30, timeSize.width, 10);
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.text = timeString;
    
    
    // 举报
    _reportButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 60 , size.height +10, 50,50)];
    _reportButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_reportButton setTitleColor:[UIColor grayColor] forState:0];
    if ([_isReport isEqualToString:@"1"]) {
        [_reportButton setTitle:@"举报" forState:UIControlStateNormal];
        [_reportButton addTarget:self action:@selector(reportButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [_reportButton setTitle:@"已举报" forState:UIControlStateNormal];
        
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, size.height+50, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = UIColorWithRGBA(237, 238, 239, 1);
    
    [_topicHeaderView addSubview:nameButton];
    [_topicHeaderView addSubview:timeLabel];
    [_topicHeaderView addSubview:_reportButton];
    
    [_topicHeaderView addSubview:lineView];
    [_topicHeaderView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, size.height+50)];
    [_topicHeaderView addSubview:topicDescView];
    
    
    _mywebView = [[WFWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
    _mywebView.webDelegate = self;
    _mywebView.scrollView.delegate = self;
    _mywebView.userInteractionEnabled = YES;
    _mywebView.scrollView.userInteractionEnabled = YES;
    _mywebView.allowsInlineMediaPlayback = YES;
    
    [self.mywebView.scrollView addSubview:self.topicHeaderView];
    self.webBrowserView = self.mywebView.scrollView.subviews[0];
    //      [_mywebView.scrollView addSubview:_topicHeaderView];
    [self.mywebView addSubview:self.topicHeaderView];
    
    CGRect frame = self.webBrowserView.frame;
    frame.origin.y = CGRectGetMaxY(self.topicHeaderView.frame);
    self.webBrowserView.frame = frame;
    [self.topicHeaderView sendSubviewToBack:self.mywebView];
    _mywebView.backgroundColor = [UIColor whiteColor];
    [_mywebView loadHTMLString:_htmlss baseURL:nil];
    
    [_containerView addSubview:_mywebView];
}


// 名字点击
- (void)nameButton:(id)sender {
    
    // 专栏详情
    ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
    
    ColumnListViewVC.featureId = _featureId;
    
    
    [self.navigationController pushViewController:ColumnListViewVC animated:YES];
    
    
}

// 举报点击
- (void)reportButton:(id)sender {
    
    ReportViewController *reportVC = [[ReportViewController alloc]init];
    reportVC.objId = _topicId;
    reportVC.reportType = @"1";
    [self.navigationController pushViewController:reportVC animated:YES];
    
}



#pragma mark UIGestureRecognizerClick

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    
    return YES;
    
}

#pragma mark - Navigation
- (void)didShareBarButtonItemAction:(id)sender
{
    [MyUserInfoManager shareInstance].shaImage = @"";
    [MyUserInfoManager shareInstance].shaTitle = _InsightTitle;
    [MyUserInfoManager shareInstance].shaDes = [self filterHTML:_htmlss];;
    
    [MyUserInfoManager shareInstance].shaUrl = [NSString stringWithFormat:@"http://www.greentechplace.com/jianjie/%@?mobileType=%@",_topicId,@"2"];
    
    [MyUserInfoManager shareInstance].shareType = @"1";
    
    
    ShareModel* shareData = [[ShareModel alloc] init];
    shareData.title = _InsightTitle;
    shareData.shareText = _htmlss;
    shareData.imgUrl = @"";
    
    shareData.url = [NSString stringWithFormat:@"http://112.124.96.181:8099/mobile/app/insight/insight-info/%@",_topicId];
    
    [NewShareActionView showShareMenuWithAlertView:self
                                             title:ActivityShareTitle
                                         shareData:shareData
                                    selectedHandle:^(NSInteger index, NSString* name){
                                    }];
    
    NewShareActionView *share = [[NewShareActionView alloc]init];
    share.layer.cornerRadius = 10;

    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:share preferredStyle:TYAlertControllerStyleAlert];
    
    alertController.backgoundTapDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}







-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
    if (errorMessage) {
        return;
    }
    if ([request.url isEqualToString:LKB_Insight_Detail_Url]) {
        InsightDetailModel*  model = (InsightDetailModel *)parserObject;
        insightDetailModel = model.data;
        _isReport = model.data.isReport;
        _collNum = model.data.collectNum;
        _starNum = model.data.starNum;
        _shareNum= model.data.shareNum;
        if ([insightDetailModel.isCollection isEqualToString:@"0"]) {
            _isCollection = YES;
        }else
        {
            _isCollection = NO;
        }
        
        
        if ([model.isStar isEqualToString:@"0"]) {
            _isStar = YES;
        }else
        {
            _isStar = NO;
        }
        if ([_isReport isEqualToString:@"0"]) {
            
            [_reportButton setTitle:@"已举报" forState:UIControlStateNormal];
        }
        else {
            [_reportButton setTitle:@"举报" forState:UIControlStateNormal];
            
        }
        
        
        
        NSString *strnomal = insightDetailModel.content;
        NSString *str = [strnomal gtm_stringByUnescapingFromHTML];
        NSString *str2 = [str stringByReplacingOccurrencesOfString:@"/static/" withString:@"http://www.lvkebang.cn/static/"];
        
        
        _htmlss = [NSMutableString stringWithString:str2];
        _topicId =insightDetailModel.insightId;
        _createBy =insightDetailModel.featureName;
        // 时间设置
        
        NSDate *createDate = [NSDate dateFormJavaTimestamp:insightDetailModel.pubDate];
        _addTime = [createDate timeAgo];
        
        _InsightTitle =insightDetailModel.title;
        _autherName =insightDetailModel.userName;
        _featureId = insightDetailModel.featureId;
        [self refreshBottomUI];
        
        if (_autherName==nil) {
            self.requestParas = @{@"insightId":_topicId,
                                  @"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"token":[[MyUserInfoManager shareInstance]token]
                                  };
            self.requestURL = LKB_Insight_Detail_Url;
        }else
        {
            [self initializePageSubviews];
        }
    }
    
    if ([request.url isEqualToString:LKB_Insight_Reply_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
            
        }
    }
    if ([request.url isEqualToString:LKB_Common_Star_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        if ([replymodel.success isEqualToString:@"1"]) {
            
        }
    }
    if ([request.url isEqualToString:LKB_Common_Cancel_Star_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
            
        }
    }
    if ([request.url isEqualToString:LKB_Common_Collection_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
            
        }
    }
    if ([request.url isEqualToString:LKB_Common_Cancel_Collection_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
            
        }
    }
    if ([request.url isEqualToString:LKB_Share_Num_Url]) {
        
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
            
        }
    }
    
    
    
    
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


#pragma mark - WFWebViewDelegate -
- (void)clickActionOnHyperlink:(NSString *)linkUrl{
    
    
}


- (void)clickActionOnImage:(NSString *)imageUrl{
    
    
    if (imageUrl) {
        __block WFWebImageShowView *showImageView = [[WFWebImageShowView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight - 50) imageUrl:imageUrl];
        
        [showImageView show:[[UIApplication sharedApplication] keyWindow] didFinish:^{
            [showImageView removeFromSuperview];
            showImageView = nil;
            
        }];
    }
    
}



-(void)hideButtomView:(__autoreleasing id *)sender
{
    
    [UIView animateWithDuration:0.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [_detailBottomView setFrame:CGRectMake(0, KDeviceHeight - 50.f, kDeviceWidth, 50.f)];
    } completion:^(BOOL finished) {
        
    }];
}


-(void)sendeHeight:(float)height
{
    NSLog(@"高度是多少%f",height);
    
    
}




- (void)selectBtn:(UIButton *)button
{
    switch (button.tag - kBottomTag){
        case 0:
        {
            if (_isCollection) {
                self.requestParas = @{@"ucObjId":_topicId,
                                      @"userId":[[MyUserInfoManager shareInstance]userId],
                                      @"token":[[MyUserInfoManager shareInstance]token],
                                      };
                self.requestURL = LKB_Common_Cancel_Collection_Url;
                _isCollection = NO;
                
                int str = [_collNum intValue];
                _collNum = [NSString stringWithFormat:@"%d",str -1];
                _detailBottomView.canCollection = _isCollection;
                _detailBottomView.collNum = _collNum;// 点赞数
            }
            else {
                self.requestParas = @{@"ucObjId":_topicId,
                                      @"userId":[[MyUserInfoManager shareInstance]userId],
                                      @"token":[[MyUserInfoManager shareInstance]token],
                                      };
                self.requestURL = LKB_Common_Collection_Url;
                _isCollection = YES;
                
                int str = [_collNum intValue];
                _collNum = [NSString stringWithFormat:@"%d",str +1];
                _detailBottomView.canCollection = _isCollection;
                _detailBottomView.collNum = _collNum;// 点赞数
            }
            break;
        }
        case 1:
        {
            if (_isStar) {
                
                self.requestParas = @{@"objectId":_topicId,
                                      @"userId":[[MyUserInfoManager shareInstance]userId],
                                      @"token":[[MyUserInfoManager shareInstance]token],
                                      @"objectType":@"0"
                                      };
                self.requestURL = LKB_Common_Cancel_Star_Url;
                
                _isStar = NO;
                int str = [_starNum intValue];
                _starNum = [NSString stringWithFormat:@"%d",str -1];
                _detailBottomView.nextArrowsEnable = _isStar;
                _detailBottomView.voteNum = _starNum;// 点赞数
            }
            else
            {
                
                self.requestParas = @{@"objectId":_topicId,
                                      @"userId":[[MyUserInfoManager shareInstance]userId],
                                      @"token":[[MyUserInfoManager shareInstance]token],
                                      @"objectType":@"0"
                                      };
                self.requestURL = LKB_Common_Star_Url;
                
                _isStar = YES;
                int str = [_starNum intValue];
                _starNum = [NSString stringWithFormat:@"%d",str +1];
                _detailBottomView.nextArrowsEnable = _isStar;
                _detailBottomView.voteNum = _starNum;// 点赞数
            }
            break;
        }
        case 2:
        {
            
            InsightReplistViewController *ReplistVC = [[InsightReplistViewController alloc] init];
            ReplistVC.blogId = _topicId;
            ;
            [self.navigationController pushViewController:ReplistVC animated:YES];
            break;
        }
        case 3:
        {
            
            
            self.requestParas = @{@"insightId":_topicId,
                                  @"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"token":[[MyUserInfoManager shareInstance]token],
                                  
                                  };
            self.requestURL = LKB_Share_Num_Url;
            
            
            int str = [_shareNum intValue];
            _shareNum = [NSString stringWithFormat:@"%d",str +1];
            _detailBottomView.canShare = _isShare;
            _detailBottomView.shareNum = _shareNum;// 点赞数
            
            [MyUserInfoManager shareInstance].shaImage = @"";
            [MyUserInfoManager shareInstance].shaTitle = _InsightTitle;
            [MyUserInfoManager shareInstance].shaDes = _htmlss;
            [MyUserInfoManager shareInstance].shaUrl = [NSString stringWithFormat:@"http://www.greentechplace.com/jianjie/%@?mobileType=%@",_topicId,@"2"];
            
            ShareModel* shareData = [[ShareModel alloc] init];
            shareData.title = _InsightTitle;
            shareData.shareText = _htmlss;
            shareData.imgUrl = @"";
            shareData.url = [NSString stringWithFormat:@"http://112.124.96.181:8099/mobile/app/insight/insight-info/%@",_topicId];
            
            NewShareActionView *newshare = [[NewShareActionView alloc]init];
            
            newshare.delegate = self;
            newshare.layer.cornerRadius = 10;

            
            [NewShareActionView showShareMenuWithAlertView:self
                                                     title:ActivityShareTitle
                                                 shareData:shareData
                                            selectedHandle:^(NSInteger index, NSString* name){
                                                
                                                
                                            }];
            
            _alertController = [TYAlertController alertControllerWithAlertView:newshare preferredStyle:TYAlertControllerStyleAlert];
            
            _alertController.backgoundTapDismissEnable = YES;
            [self presentViewController:_alertController animated:YES completion:nil];
            break;
        }
            
        case 4:
        {
            
            break;
        }
        default:
            break;
    }
}


- (void)newShareActionView:(NewShareActionView *)UserHeaderView didatterntion:(NSInteger)index
{
    NSLog(@"点击了群组");
    
    if (index==0) {
        [_alertController dismissViewControllerAnimated:YES];
        UserGroupViewController *shareTogroupView = [[UserGroupViewController alloc]init];
        shareTogroupView.title = @"我的群组";
        shareTogroupView.shareDes =[NSString stringWithFormat: @"分享见解：<a href='http://www.lvkebang.cn/jianjie/%@'>【%@】</a>",_topicId,_InsightTitle];
        shareTogroupView.ifshare = @"2";
        
        
        NSArray *views = [self.view subviews];
        for (UIView *view in views) {
            [view removeFromSuperview];
        }
        shareTogroupView.therquestUrl = [[MyUserInfoManager shareInstance]userId];
        [self.navigationController pushViewController:shareTogroupView animated:YES];
    }
    if (index == 1) {
        [_alertController dismissViewControllerAnimated:YES];
        
        PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
        peopleVC.requestUrl = LKB_Attention_Users_Url;
        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
        
        peopleVC.hidesBottomBarWhenPushed = YES;
        peopleVC.title = @"我的好友";
        peopleVC.VCType = @"1";

        peopleVC.shareDes =[NSString stringWithFormat: @"分享见解：<a href='http://www.lvkebang.cn/jianjie/%@'>【%@】</a>",_topicId,_InsightTitle];
        peopleVC.ifshare = @"2";
        
        NSArray *views = [self.view subviews];
        for (UIView *view in views) {
            [view removeFromSuperview];
        }
        
        
        [self.navigationController pushViewController:peopleVC animated:YES];
        
    }
    
    
    if (index==2) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _InsightTitle;
        extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_topicId];;
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_InsightTitle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    if (index==3) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _InsightTitle;
        extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_topicId];;
        [[UMSocialControllerService defaultControllerService] setShareText:_InsightTitle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    if (index==4) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _InsightTitle;
        
        extConfig.sinaData.shareText =[NSString stringWithFormat:@"%@http://www.lvkebang.cn/jianjie/%@",_InsightTitle,_topicId];
        [[UMSocialControllerService defaultControllerService] setShareText:_InsightTitle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
    }
    if (index==5) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _InsightTitle;
        
        extConfig.tencentData.shareText = _InsightTitle;
        extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_topicId];
        
        [[UMSocialControllerService defaultControllerService] setShareText:_InsightTitle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    if (index==6) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _InsightTitle;
        extConfig.qqData.shareText = _InsightTitle;
        extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_topicId];
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_InsightTitle shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
}




- (void)configBottomUI{
    
    _detailBottomView = [[WFBottomBarView alloc] initWithFrame:CGRectMake(0, KDeviceHeight - 50.f, kDeviceWidth, 50.f)];
    _detailBottomView.delegate = self;
    [self.view  addSubview:_detailBottomView];
}


- (void)refreshBottomUI{
    
    _detailBottomView.canCollection =_isCollection;
    _detailBottomView.nextArrowsEnable = _isStar;
    _detailBottomView.canShare = _isShare;
    
    _detailBottomView.collNum = insightDetailModel.collectNum;// 收藏数
    _detailBottomView.voteNum = insightDetailModel.starNum;// 点赞数
    _detailBottomView.shareNum = insightDetailModel.shareNum;// 分享数
    _detailBottomView.commentNum = insightDetailModel.replyNum;// 评论数
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 delay: 0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_detailBottomView setFrame:CGRectMake(0, KDeviceHeight, kDeviceWidth, 50.f)];
    } completion:^(BOOL finished) {
        
    }];
}









@end
