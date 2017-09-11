//
//  NewUserMainPageViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 11/14/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "NewUserMainPageViewController.h"
#import "TLDisplayView.h"
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
#import "UIImage+ImageEffects.h"
#import "PeopleViewController.h"
#import "NewUserCenterModel.h"
#import "ChatViewController.h"
#import "ToUserManager.h"
#import "UMSocial.h"
#import "TYAlertController.h"
#import "NewShareActionView.h"
#import "UserInforDynamicViewController.h"
#import "UserInforGroupViewController.h"
#import "ColumnListViewController.h"
#import "MyFeatureIdManager.h"
static CGFloat const startH = 0;
//NSString * const ColumnWithImageCellIdentifier = @"ColumnWithImageCell";
//NSString * const ColumnWithOutImageCellIdentifier = @"ColumnWithOutImageCell";
static NSString* CellIdentifier = @"CellIdentifier";
@interface NewUserMainPageViewController () <TLDisplayViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,NewShareActionViewDelegete,ChatViewControllerDelegate>
{
    insightFeatureModel*insightModel;
    NewUserCenterDetailModel *model;
    NSString *jsonStr;
    UIImageView *navBarHairlineImageView;
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;


}

@property (nonatomic, strong) TLDisplayView *displayView;
@property (nonatomic, strong) UIView *headerView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *ColumnNameLable;
@property (nonatomic, strong) UIButton *attentionBtn;
@property(nonatomic,strong)UIImageView *backimage;//背景图

@property (nonatomic, strong)UIButton *beAttentionedButton;
@property (nonatomic, strong)UILabel *nameLable;
@property (nonatomic, strong)UIImageView *myImage;
@property (nonatomic, strong)UIImageView *sourceImage;
@property (nonatomic, strong)UIImage *lastImage;
@property (nonatomic, strong)UIVisualEffectView * visualEffectView; //毛玻璃效果
@property (nonatomic, strong)UIView * blurImageBackView;// 毛玻璃上面的黑色

@property (nonatomic, copy)NSString *topicImages;
@property (nonatomic, copy)NSString *groupAvatars;
@property (nonatomic, copy)NSString *avatar;
@property (nonatomic, copy)NSString *ifshow;
@property (nonatomic, assign)NSInteger dynamicNum;

@property (nonatomic, weak) UIView *navBarView;
@property(nonatomic,strong)TYAlertController *alertController;
@property(nonatomic,strong)UIView *bottomView;

@end

@implementation NewUserMainPageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _ifshow = @"0";

    self.tableView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    self.dataArray = [[NSMutableArray alloc] init];
    
    self.edgesForExtendedLayout = 0;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 30, 10, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"bottom_icon_share_nor"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationController.navigationBar addSubview:_setUpButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    // 左键按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

   
       // Do any additional setup after loading the view, typically from a nib.
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
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


}



- (void)tryAgainButton:(id )sender {
    
    [self initializePageSubviews];
    
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



- (void)attentionBtn:(id)sender {
    
    

    PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
    peopleVC.requestUrl = LKB_Attention_Users_Url;
    peopleVC.VCType = @"1";
    peopleVC.hidesBottomBarWhenPushed = YES;
    if ([_type isEqualToString:@"2"] || ![_toUserId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
        peopleVC.title = @"ta关注的人";
        peopleVC.userId = _toUserId;
        
    }
    else {
        peopleVC.title = @"我的关注";
        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
        
    }
    [self.navigationController.navigationBar setClipsToBounds:NO];
    self.navigationController.navigationBar.alpha=1;
    [self.navigationController pushViewController:peopleVC animated:YES];

    
    
    
}

- (void)fansButton:(id)sender {
    
 
    PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
    peopleVC.requestUrl = LKB_Attention_All_Fans_Url;
    peopleVC.VCType = @"2";
    if ([_type isEqualToString:@"2"]|| ![_toUserId isEqualToString:[MyUserInfoManager shareInstance].userId]) {
        peopleVC.title = @"关注ta的人";
        peopleVC.userId = _toUserId;
        
    }
    else {
        peopleVC.title = @"我的粉丝";
        peopleVC.userId = [MyUserInfoManager shareInstance].userId;
        peopleVC.hidesBottomBarWhenPushed = YES;
        
    }
    [self.navigationController.navigationBar setClipsToBounds:NO];
    self.navigationController.navigationBar.alpha=1;
    
        [self.navigationController pushViewController:peopleVC animated:YES];


}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setClipsToBounds:NO];
    self.navigationController.navigationBar.alpha=1;
    navBarHairlineImageView.hidden = NO;
    [MobClick endLogPageView:@"NewUserMainPageViewController"];

}



-(void)viewWillAppear:(BOOL)animated
{
    
    // 隐藏导航下的线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    

    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
//    self.edgesForExtendedLayout = 0;
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    self.navigationController.navigationBar.alpha=0;
    navBarHairlineImageView.hidden = YES;
    [MobClick beginLogPageView:@"NewUserMainPageViewController"];

}

-(void)backToMain
{
//    [self.navigationController.navigationBar setClipsToBounds:NO];
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
    
    
    
    [_myImage setImage:[UIImage imageNamed:@"default.png"]];
    
    [_sourceImage setImage:[UIImage imageNamed:@"default.png"]];
    _lastImage = [_sourceImage.image applyDarkEffect];
    
    [self.backimage setImage:_lastImage];
    
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/2+190)  ];
    _myImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-50, kDeviceWidth/2-50, 100, 100)];
    //    [myImage sd_setImageWithURL:[_featureAvatar lkbImageUrl8] placeholderImage:YQNormalPlaceImage];
    
    
    _myImage.layer.cornerRadius = _myImage.frame.size.width / 2;
    _myImage.clipsToBounds = YES;
    //    _myImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[[MyUserInfoManager shareInstance].avatar lkbImageUrl4]]] ;
    
    [_myImage setImage:[UIImage imageNamed:@"default.png"]];
    //    myImage.backgroundColor = [UIColor redColor];
    _myImage.layer.borderWidth = 2.0f;
    _myImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _headerView.backgroundColor = [UIColor whiteColor];
    
    
    self.backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/2)];
    
    
    //        _sourceImage.image
    UIImage *bgImg  = [UIImage imageNamed:@"default.png"]   ;
    
    
    _lastImage = [bgImg applyDarkEffect];
    
    self.backimage.image = _lastImage;
    self.backimage.userInteractionEnabled = YES;
    
    [_headerView addSubview:self.backimage];
    
    [_headerView addSubview:_myImage];
    
    
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2-105, kDeviceWidth/2+50+30, 200, 40)];
    
    _nameLable.text = @"名字";
    _nameLable.font = [UIFont systemFontOfSize:24];
    _nameLable.textAlignment  = NSTextAlignmentCenter;
    [_headerView addSubview:_nameLable];
    
    _beAttentionedButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth/2+30, kDeviceWidth/2+50+70, 80, 30)];
    _beAttentionedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_beAttentionedButton setTitle:@"粉丝" forState:UIControlStateNormal];
    _beAttentionedButton.titleLabel.font = [UIFont systemFontOfSize:16];
    //    beAttentionedButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    _beAttentionedButton.backgroundColor = [UIColor clearColor];
    [_beAttentionedButton setTitleColor:CCCUIColorFromHex(0x22a941) forState:UIControlStateNormal];
    [_beAttentionedButton addTarget:self action:@selector(fansButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _attentionBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth/2-110, kDeviceWidth/2+50+70, 80, 30)];
    //    attentionBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    _attentionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _attentionBtn.backgroundColor = [UIColor clearColor];
    [_attentionBtn setTitleColor:CCCUIColorFromHex(0x22a941) forState:UIControlStateNormal];
    [_attentionBtn addTarget:self action:@selector(attentionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView addSubview:_beAttentionedButton];
    [_headerView addSubview:_attentionBtn];
    
    
    _describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, kDeviceWidth/2+50+100, kDeviceWidth-60, 30)];
    _describeLabel.text = @"个人资料";
    
    _describeLabel.textAlignment = NSTextAlignmentCenter;
    [_describeLabel setTextColor:CCCUIColorFromHex(0x999999)];
    
    _describeLabel.userInteractionEnabled=YES;
    
    [_headerView addSubview:_describeLabel];
    
    _tableView.tableHeaderView = _headerView;
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 31, 22, 22)];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    _attentionButton = [[UIButton alloc]initWithFrame:CGRectMake(0, KDeviceHeight-50 , kDeviceWidth /2, 50)];
//    _attentionButton.alpha = 0.95;
    _attentionButton.backgroundColor = [UIColor whiteColor];
    _attentionButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    _attentionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    _chatButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth /2, KDeviceHeight -50, kDeviceWidth /2 , 50)];
    _chatButton.backgroundColor = [UIColor whiteColor];
//    _chatButton.alpha = 0.95;
    _chatButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_chatButton addTarget:self action:@selector(chatButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, KDeviceHeight -50 , kDeviceWidth, 50)];
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_bottomView.bounds];
    _bottomView.layer.masksToBounds = NO;
    //        _bottomView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _bottomView.layer.shadowColor = CCColorFromRGBA(0, 0, 0, 0.1).CGColor;
    _bottomView.layer.shadowOffset = CGSizeMake(0.0f, -0.5f);
    _bottomView.layer.shadowOpacity = 0.5f;
    _bottomView.layer.shadowPath = shadowPath.CGPath;
    
    _bottomView.backgroundColor = [UIColor clearColor];


    
    [_attentionButton addTarget:self action:@selector(attentionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([_type isEqualToString:@"2"] ) {
        
        
        NSString * str = [NSString stringWithFormat:@"%@",_toUserId];
        
        if (![str isEqualToString:[MyUserInfoManager shareInstance].userId]) {
            [self.view addSubview:_bottomView];
//            [self.bottomView addSubview:_chatButton];
//            [self.bottomView addSubview:_attentionButton];
            
            [self.view addSubview:_chatButton];
            [self.view addSubview:_attentionButton];

        }
    }

    self.requestParas = @{@"ownerId":[[MyUserInfoManager shareInstance]userId],
                          @"userId":_toUserId,
                          @"token":[[MyUserInfoManager shareInstance]token],
                          };
    
    self.requestURL = LKB_Usercenterpersonal_Url;

    [self.tableView triggerPullToRefresh];
    
    if (self.dataArray.count == 0) {

    }
}


-(UIView *)bottomView
{
    if (!_bottomView) {
//        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, KDeviceHeight -50 , kDeviceWidth, 50)];
//        
//        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_bottomView.bounds];
//        _bottomView.layer.masksToBounds = NO;
//        //        _bottomView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//        _bottomView.layer.shadowColor = CCColorFromRGBA(0, 0, 0, 0.1).CGColor;
//        _bottomView.layer.shadowOffset = CGSizeMake(0.0f, -0.5f);
//        _bottomView.layer.shadowOpacity = 0.5f;
//        _bottomView.layer.shadowPath = shadowPath.CGPath;
//        
//        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    
    return _bottomView;
}


- (void)chatButton:(id)sender {
    
    
    if ([_ifAttention isEqualToString:@"1"]) {
        // 未关注
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请先关注哦~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else {
        
        NSString *toUserIdStr = [NSString stringWithFormat:@"%@",_toUserId];
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:toUserIdStr isGroup:NO];
        chatVC.title = _toUserName;
        
        chatVC.delelgate = self;
        [self.navigationController pushViewController:chatVC animated:YES];
        
    }
    
    
    
    
    
}



// 关注
- (void)attentionButton:(id)sender {
    
    
    if ([_attentionButton.titleLabel.text isEqualToString:@"关注"]) {
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"attentedUser":_toUserId,
                              @"token":[MyUserInfoManager shareInstance].token
                              };
        self.requestURL = LKB_Attention_User_Url;
        
    }
    else {
        self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                              @"attentedUser":_toUserId,
                              @"token":[MyUserInfoManager shareInstance].token
                              };
        self.requestURL = LKB_UnAttention_User_Url;
        
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
    
    self.requestParas = @{@"ownerId":[[MyUserInfoManager shareInstance]userId],
                          @"userId":_toUserId,
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    
    self.requestURL = LKB_Usercenterpersonal_Url;

    
}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
//    if (!request.isLoadingMore) {
//        [self.tableView.pullToRefreshView stopAnimating];
//    }
//        else {
//        [self.tableView.infiniteScrollingView stopAnimating];
//    }
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        
        if ([errorMessage isEqualToString:@"程序异常"]) {
            [self backToMain];
        }
        if ([errorMessage isEqualToString:@"没有网络，连接失败"]) {
            
            
            [self.tableView removeFromSuperview];
            self.navigationController.navigationBar.alpha=1;
            WithoutInternetImage.hidden = NO;
            tryAgainButton.hidden = NO;
            
            
        }

        
        
        
        return;
    }
    if ([request.url isEqualToString:LKB_Usercenterpersonal_Url]) {
        
         NewUserCenterModel *userCenterModel = (NewUserCenterModel *)parserObject;
         model =userCenterModel.data;
        NSLog(@"%@",model.attentionNum);
        _groupAvatars = model.groupAvatars;
        _topicImages = model.topicImages;
        insightModel = model.insightFeature;
        _avatar = model.avatar;
        _ifAttention = model.ifAttention;
        _toUserName = model.userName;
        _userAvatar = model.avatar;
        _dynamicNum = model.dynamicNum;
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 20)];
        
        titleLabel.text = model.userName;
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = titleLabel;

        
         [_myImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[_avatar lkbImageUrl4]]]];
        
         [_sourceImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[_avatar lkbImageUrl4]]]];
//          _lastImage = [_sourceImage.image applyDarkEffect];
        
        [self.backimage setImage:_lastImage];
        // 简介的高度
        CGSize remarkSize = [model.remark boundingRectWithSize:CGSizeMake(kDeviceWidth-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;

        if (model.remark ==nil) {
            _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/2+135 + 28)  ];

        }else {
            
            if (remarkSize.height > 28) {
                
                _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/2+135 + 28 + 30 +28)  ];

            }else {
                
                _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/2+135 + remarkSize.height +28+28)  ];

            }
            

        }
        _myImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-50, kDeviceWidth/2-50,100, 100)];
        //    [myImage sd_setImageWithURL:[_featureAvatar lkbImageUrl8] placeholderImage:YQNormalPlaceImage];
        UIView *headerBackView = [[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-52, kDeviceWidth/2-52 ,104, 104)];
        
        headerBackView.backgroundColor =[UIColor whiteColor];
        headerBackView.layer.cornerRadius = headerBackView.frame.size.width / 2;

        
        
        _myImage.layer.cornerRadius = _myImage.frame.size.width / 2;
        _myImage.clipsToBounds = YES;
        //    _myImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[[MyUserInfoManager shareInstance].avatar lkbImageUrl4]]] ;
        
        [_myImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[_avatar lkbImageUrl4]]]];
        //    myImage.backgroundColor = [UIColor redColor];
//        _myImage.layer.borderWidth = 2.0f;
//        _myImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _headerView.backgroundColor = [UIColor whiteColor];
        
        
        //    UIBezierPath*path;
        //    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        //    shapeLayer = [CAShapeLayer layer];
        //    shapeLayer.path           = path.CGPath;
        //    CAShapeLayer *borderLayer=[CAShapeLayer layer];
        //    borderLayer.path    =   path.CGPath;
        //    borderLayer.fillColor  = [UIColor whiteColor].CGColor;
        //    borderLayer.strokeColor    = [UIColor whiteColor].CGColor;
        //    borderLayer.lineWidth      = 2;
        //    borderLayer.frame=myImage.bounds;
        //
        //    myImage.layer.mask = shapeLayer;
        //    [myImage.layer addSublayer:borderLayer];
        //
        
        self.backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/2)];
        
        
//        _sourceImage.image
        _lastImage  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[_avatar lkbImageUrl4]]]   ;
//        _lastImage = [bgImg applyDarkEffect];
        
        self.backimage.image =_lastImage ;
        self.backimage.userInteractionEnabled = YES;
        
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _visualEffectView.frame = _backimage.frame;
        _blurImageBackView = [[UIView alloc]init];
        _blurImageBackView.backgroundColor = [UIColor blackColor];
        _blurImageBackView.frame = _backimage.frame;
        _blurImageBackView.alpha = 0.1;

        
        [_headerView addSubview:self.backimage];
        [_backimage addSubview:_visualEffectView];
        [_backimage addSubview:_blurImageBackView];
        [_headerView addSubview:headerBackView];
        [_headerView addSubview:_myImage];
        
        
        _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(14, kDeviceWidth/2+50+23.5,kDeviceWidth -28, 40)];
        
        _nameLable.text = @"那年青春我们正好";
        _nameLable.font = [UIFont systemFontOfSize:24];
        _nameLable.textAlignment  = NSTextAlignmentCenter;
        [_headerView addSubview:_nameLable];
        
        // 粉丝
        _beAttentionedButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth/2 + 44 , kDeviceWidth/2+50+62, model.fansNum.length + 80, 30)];
        _beAttentionedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _beAttentionedButton.titleLabel.font = [UIFont systemFontOfSize:16];
        //    beAttentionedButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _beAttentionedButton.backgroundColor = [UIColor clearColor];
        [_beAttentionedButton setTitleColor:CCCUIColorFromHex(0x22a941) forState:UIControlStateNormal];
        [_beAttentionedButton addTarget:self action:@selector(fansButton:) forControlEvents:UIControlEventTouchUpInside];
        
        // 关注
        _attentionBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth/2-44 - model.attentionNum.length - 44 , kDeviceWidth/2+50+62, model.attentionNum.length + 60, 30)];
        //    attentionBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _attentionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _attentionBtn.backgroundColor = [UIColor clearColor];
        [_attentionBtn setTitleColor:CCCUIColorFromHex(0x22a941) forState:UIControlStateNormal];
        [_attentionBtn addTarget:self action:@selector(attentionBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [_headerView addSubview:_beAttentionedButton];
        [_headerView addSubview:_attentionBtn];
        
        
        if (remarkSize.height > 28) {
            
//            _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/2+135 + 30 + 32.5 +28)  ];
            _describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, kDeviceWidth/2+135+28, kDeviceWidth-60, 28)];

            
        }else {
            
//            _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/2+135 + remarkSize.height + 32.5 +28)  ];
            _describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, kDeviceWidth/2+135+28, kDeviceWidth-60, remarkSize.height)];

            
        }

        _describeLabel.text = @"今天你对我爱理不理，明天我让你gao";
        
        _describeLabel.textAlignment = NSTextAlignmentCenter;
        [_describeLabel setTextColor:CCCUIColorFromHex(0x999999)];
        _describeLabel.font = [UIFont systemFontOfSize:14];
        _describeLabel.userInteractionEnabled=YES;
        
        [_headerView addSubview:_describeLabel];
        
        _tableView.tableHeaderView = _headerView;
        
        

        
        if (remarkSize.height > 30) {
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
            tap.cancelsTouchesInView = NO;
            
            [_describeLabel addGestureRecognizer:tap];

        }

        
        
        // 左键按钮
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 31, 22, 22)];
        [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"nav_back_write_nor"] forState:UIControlStateNormal];
        [self.view addSubview:backBtn];
        
        
//        if ([_type isEqualToString:@"2"]) {
        
            //分享按钮
            _shareButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 38, 31, 22, 22)];
            [_shareButton setImage:[UIImage imageNamed:@"icon_share_write_nor"] forState:UIControlStateNormal];
            [_shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
            //    [self.navigationController.navigationBar addSubview:_setUpButton];
            [self.view addSubview:_shareButton];

//        }
        


        
        
         [_attentionBtn setTitle:[NSString stringWithFormat:@"%@ %@",@"关注",model.attentionNum] forState:UIControlStateNormal];
        
        [_beAttentionedButton setTitle:[NSString stringWithFormat:@"%@ %@",@"粉丝",model.fansNum] forState:UIControlStateNormal];
        
        [_nameLable setText:model.userName];
        
        
        [_describeLabel setText:model.remark];
        
        // 未关注
        if ([_ifAttention isEqualToString:@"1"]) {
            
            [_attentionButton setTitle:@"关注" forState:UIControlStateNormal];
            [_attentionButton setTitleColor:CCCUIColorFromHex(0x22a941) forState:UIControlStateNormal];
            _attentionButton.titleEdgeInsets = UIEdgeInsetsMake(0, _attentionButton.titleLabel.bounds.size.width, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
            [_attentionButton setImage:[UIImage imageNamed:@"profile_icon_follow_nor"] forState:UIControlStateNormal];
            _attentionButton.imageEdgeInsets = UIEdgeInsetsMake(10,_attentionButton.titleLabel.bounds.size.width  ,10,_attentionButton.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
            
            [_chatButton setTitle:@"私信" forState:UIControlStateNormal];
            [_chatButton setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
            _chatButton.titleEdgeInsets = UIEdgeInsetsMake(0, _chatButton.titleLabel.bounds.size.width , 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
            [_chatButton setImage:[UIImage imageNamed:@"profile_icon_letter_dis"] forState:UIControlStateNormal];
            _chatButton.imageEdgeInsets = UIEdgeInsetsMake(10,_chatButton.titleLabel.bounds.size.width ,10,_chatButton.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
            
            
            
        }
        else {
            
            
            [_attentionButton setTitle:@"取消关注" forState:UIControlStateNormal];
            [_attentionButton setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
            _attentionButton.titleEdgeInsets = UIEdgeInsetsMake(0, _attentionButton.titleLabel.bounds.size.width, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
            [_attentionButton setImage:[UIImage imageNamed:@"profile_icon_unfollow_nor"] forState:UIControlStateNormal];
            _attentionButton.imageEdgeInsets = UIEdgeInsetsMake(10,_attentionButton.titleLabel.bounds.size.width ,10,_attentionButton.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
            
            [_chatButton setTitle:@"私信" forState:UIControlStateNormal];
            [_chatButton setTitleColor:CCCUIColorFromHex(0x22a941) forState:UIControlStateNormal];
            _chatButton.titleEdgeInsets = UIEdgeInsetsMake(0, _chatButton.titleLabel.bounds.size.width, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
            [_chatButton setImage:[UIImage imageNamed:@"profile_icon_letter_nor"] forState:UIControlStateNormal];
            _chatButton.imageEdgeInsets = UIEdgeInsetsMake(10,_chatButton.titleLabel.bounds.size.width,10,_chatButton.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
            
        }

        
        [_tableView reloadData];
        
    }
    
    if ([request.url isEqualToString:LKB_Attention_User_Url]) {
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        //        [self ShowProgressHUDwithMessage:Model.msg];
        
        [_attentionButton setTitle:@"取消关注" forState:UIControlStateNormal];
        [_attentionButton setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
        _attentionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, _attentionButton.titleLabel.bounds.size.width);//设置title在button上的位置（上top，左left，下bottom，右right）
        [_attentionButton setImage:[UIImage imageNamed:@"profile_icon_unfollow_nor"] forState:UIControlStateNormal];
        _attentionButton.imageEdgeInsets = UIEdgeInsetsMake(10,10,10,_attentionButton.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
        
        [_chatButton setTitle:@"私信" forState:UIControlStateNormal];
        [_chatButton setTitleColor:CCCUIColorFromHex(0x22a941) forState:UIControlStateNormal];
        _chatButton.titleEdgeInsets = UIEdgeInsetsMake(0,10, 0, _chatButton.titleLabel.bounds.size.width);//设置title在button上的位置（上top，左left，下bottom，右right）
        [_chatButton setImage:[UIImage imageNamed:@"profile_icon_letter_nor"] forState:UIControlStateNormal];
        _chatButton.imageEdgeInsets = UIEdgeInsetsMake(10,0,10,_chatButton.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素

        
        _ifAttention = @"0";
        
        
    }
    
    if ([request.url isEqualToString:LKB_UnAttention_User_Url]) {
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        //        [self ShowProgressHUDwithMessage:Model.msg];
        
        [_attentionButton setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionButton setTitleColor:CCCUIColorFromHex(0x22a941) forState:UIControlStateNormal];
        _attentionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10 , 0, _attentionButton.titleLabel.bounds.size.width);//设置title在button上的位置（上top，左left，下bottom，右right）
        [_attentionButton setImage:[UIImage imageNamed:@"profile_icon_follow_nor"] forState:UIControlStateNormal];
        _attentionButton.imageEdgeInsets = UIEdgeInsetsMake(10,10 ,10,_attentionButton.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
        
        [_chatButton setTitle:@"私信" forState:UIControlStateNormal];
        [_chatButton setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
        _chatButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, _chatButton.titleLabel.bounds.size.width);//设置title在button上的位置（上top，左left，下bottom，右right）
        [_chatButton setImage:[UIImage imageNamed:@"profile_icon_letter_dis"] forState:UIControlStateNormal];
        _chatButton.imageEdgeInsets = UIEdgeInsetsMake(10,0 ,10,_chatButton.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
        
        _ifAttention = @"1";
        
    }

}

// 分享
- (void)shareButton:(id)sender {
    
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该功能暂未开放，点其他的试试~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alert show];
    
    [self shareView];
    
}

- (void)shareView {
    
    _urlStr = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@", _toUserId];
    _shareCover = [NSString stringWithFormat:@"http://imagetest.lvkebang.cn/static/user_header/%@",_userAvatar];
    
    if (_userInforRemark == nil) {
        _userInforRemark = @"";
    }
    
    
    NSDictionary *shaDic = @{@"cover":_shareCover,
                             @"userId":[[MyUserInfoManager shareInstance]userId],
                             @"description":_userInforRemark,
                             @"title":_toUserName,
                             @"toUserId":_toUserId,
                             @"linkUrl":_urlStr,
                             @"shareType":@"7",
                             //                             @"featureId":_circleDetailId
                             @"fromLable":@"来自个人名片",                             };
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:shaDic options:NSJSONWritingPrettyPrinted error:nil];
    
    jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
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
        peopleVC.shareType = @"7";
        peopleVC.hidesBottomBarWhenPushed = YES;
        peopleVC.title = @"我的好友";
        peopleVC.ifshare = @"3";
        [self.navigationController pushViewController:peopleVC animated:YES];
        
        
    }
    
    // 微信好友
    if (index == 2) {
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _toUserName;
        
        
        NSLog(@"---------------------------------%@",_toUserId);
        
        extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@",_toUserId];;
        
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_userInforRemark shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
    // 微信朋友圈
    if (index==3) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _toUserName;
        
        NSLog(@"---------------------------------%@",_toUserId);
        
        extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@",_toUserId];;
        [[UMSocialControllerService defaultControllerService] setShareText:_userInforRemark shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // 新浪
    if (index==4) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _toUserName;
        
        extConfig.sinaData.shareText =_userInforRemark;
        
        //        extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_topicId];
        
        
        extConfig.sinaData.shareText  = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@",_toUserId];;
        [[UMSocialControllerService defaultControllerService] setShareText:_userInforRemark shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
    }
    // 空间
    if (index==5) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _toUserName;
        
        extConfig.tencentData.shareText = _userInforRemark;
        
        //        extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huati/%@",_objectId];
        
        extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@",_toUserId];;
        [[UMSocialControllerService defaultControllerService] setShareText:_userInforRemark shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    // QQ
    if (index==6) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        
        extConfig.title = _toUserName;
        extConfig.qqData.shareText = _userInforRemark;
        
        //        extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/huati/%@",_objectId];
        
        
        extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/yonghu/%@",_toUserId];;
        
        [[UMSocialControllerService defaultControllerService] setShareText:_userInforRemark shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
    
    
}




-(void)tapView:(UITapGestureRecognizer *)recognizer
{
    
    if ([_ifshow isEqualToString:@"0"]) {
        _ifshow = @"1";
        [_describeLabel setNumberOfLines:0];
        
        
        //    [_describeLabel setBackgroundColor: [UIColor redColor]];
        NSString *titleContent =_describeLabel.text;
        _describeLabel.text = titleContent;
        _describeLabel.numberOfLines = 0;//多行显示，计算高度
        CGSize titleSize = [titleContent boundingRectWithSize:CGSizeMake(kDeviceWidth-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        
        
        [UIView animateWithDuration:0.3 // 动画时长
                         animations:^{
                             // code
                             
                             [_describeLabel setFrame:CGRectMake(30, kDeviceWidth/2+50+100, kDeviceWidth-60, titleSize.height+30)];
                             
                             
                             [_headerView setFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/2+190+titleSize.height)];
                             _tableView.tableHeaderView = _headerView;

                             [_tableView reloadData];


                         }];

    }
    
    else
    {
        _ifshow = @"0";
//        NSString *titleContent =_describeLabel.text;
//        _describeLabel.text = titleContent;
//        _describeLabel.numberOfLines = 1;//多行显示，计算高度
//        CGSize titleSize = [titleContent boundingRectWithSize:CGSizeMake(kDeviceWidth-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        
        
        [UIView animateWithDuration:0.3 // 动画时长
                         animations:^{
                             // code
                             
                             [_describeLabel setFrame:CGRectMake(30, kDeviceWidth/2+160, kDeviceWidth-60, 28)];
                             
                             
                             [_headerView setFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/2+223)];
                             _tableView.tableHeaderView = _headerView;
                             [_tableView reloadData];

                         }];
        

    }
    
  
    
}


-(void)cofigSubviews
{
    [self.view addSubview:_tableView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row==3) {
        return 123;
    }
    if (indexPath.row==2) {
        return 75;
    }else
    {
    return 119;
    }
    
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}



- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CELLNONE = @"CELLNONE";
    

    


    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
    [cell setBackgroundColor:[UIColor whiteColor]];
    if (indexPath.row==0) {
        UILabel *dongTaiLable = [[UILabel alloc]initWithFrame:CGRectMake(14, 18, 50, 16)];
        dongTaiLable.textAlignment = NSTextAlignmentLeft;
        dongTaiLable.text = @"动态";
        [dongTaiLable setTextColor:CCCUIColorFromHex(0x333333)];
        dongTaiLable.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:dongTaiLable];
        
        UIImageView *rightImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27,71,6, 10.5)];
        rightImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        
        [cell.contentView addSubview:rightImage];
        UIView *lineView  = [[UIView alloc]initWithFrame:CGRectMake(14,118,kDeviceWidth - 30, 0.5)];
        lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
        [cell.contentView addSubview:lineView];

        
        NSArray *array = [_topicImages componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
        NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
        
        int number;
        if (array.count>4) {
            number = 4;
        }else
        {
            for (NSString *str in array) {
                if ([str isEqualToString:@""]) {
                    _dynamicNum = 0;
                    
                }
                else {
                    
                    number = array.count;
                }
            }
            
            
        }
        
        if (_dynamicNum == 0 ) {
            UILabel *noDongtaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 51, 200, 50)];
            noDongtaiLabel.text = @"暂时没有动态";
            noDongtaiLabel.textAlignment = NSTextAlignmentLeft;
            noDongtaiLabel.textColor = CCCUIColorFromHex(0x999999);
            noDongtaiLabel.font = [UIFont systemFontOfSize:14];

            [cell addSubview:noDongtaiLabel];

        }
        else {
            
            for (int i = 0; i < number; i++) {
                
                UIImageView *dongtaiImge = [[UIImageView alloc]initWithFrame:CGRectMake(14+i*64, 51, 50, 50)];
                dongtaiImge.clipsToBounds = YES;
                dongtaiImge.contentMode = UIViewContentModeScaleAspectFill;

                [dongtaiImge sd_setImageWithURL:[array[i] lkbImageUrlAllCover] placeholderImage:YQNormalBackGroundPlaceImage];
                
                
                [cell addSubview:dongtaiImge];
            }

        }
        
        
    }
    if (indexPath.row==1) {
        UILabel *circleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 18, 50, 16)];
        circleLabel.text = @"圈子";
        circleLabel.textAlignment = NSTextAlignmentLeft;
        [circleLabel setTextColor:CCCUIColorFromHex(0x333333)];
        circleLabel.font = [UIFont systemFontOfSize:16];
        [cell addSubview:circleLabel];
        UIImageView *rightImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27,71,6, 10.5)];
        rightImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        
        [cell addSubview:rightImage];
        UIView *lineView  = [[UIView alloc]initWithFrame:CGRectMake(14,118,kDeviceWidth - 30, 0.5)];
        lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
        [cell.contentView addSubview:lineView];


        
        
        NSArray *array = [_groupAvatars componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
        NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
        
        int number;
        if (array.count>4) {
            number = 4;
        }else
        {
            number = array.count;
        }
        
        if (_groupAvatars == nil || [_groupAvatars isEqualToString:@""]) {
            UILabel *noCircleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 60, 200, 50)];
            noCircleLabel.text = @"暂时没有动态";
            noCircleLabel.textColor = CCCUIColorFromHex(0x999999);
            noCircleLabel.font = [UIFont systemFontOfSize:14];
            
            [cell addSubview:noCircleLabel];

        }
        else {
            
            for (int i = 0; i < number; i++) {
                
                UIImageView *circleImage = [[UIImageView alloc]initWithFrame:CGRectMake(14+i*64, 51, 50, 50)];
                circleImage.layer.cornerRadius = circleImage.frame.size.width / 2;
                circleImage.clipsToBounds = YES;
                circleImage.contentMode = UIViewContentModeScaleAspectFill;

                [circleImage sd_setImageWithURL:[array[i] lkbImageUrl5] placeholderImage:YQNormalBackGroundPlaceImage];
                
                
                [cell addSubview:circleImage];
            }

        }

        
        
    }
    if (indexPath.row==2) {
        UILabel *articLable = [[UILabel alloc]initWithFrame:CGRectMake(14, 18, 50, 16)];
        articLable.text = @"专栏";
        articLable.textAlignment = NSTextAlignmentLeft;
        [articLable setTextColor:CCCUIColorFromHex(0x333333)];
        articLable.font = [UIFont systemFontOfSize:16];
        [cell addSubview:articLable];
        
        UIImageView *rightImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27,35,6, 10.5)];
        rightImage.image = [UIImage imageNamed:@"icon_arrow_r"];
        
        [cell addSubview:rightImage];
        UIView *lineView  = [[UIView alloc]initWithFrame:CGRectMake(14,75,kDeviceWidth - 30, 0.5)];
        lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
        [cell.contentView addSubview:lineView];


        
        
        UILabel *cumlnLable = [[UILabel alloc]initWithFrame:CGRectMake(14, 50, 260, 14)];
        cumlnLable.text =  [NSString stringWithFormat:@"%@篇文章    %@人关注",model.insightNum,insightModel.attNum]   ;
        
        cumlnLable.textAlignment = NSTextAlignmentLeft;
        [cumlnLable setTextColor:CCCUIColorFromHex(0x999999)];
        cumlnLable.font = [UIFont systemFontOfSize:14];

        [cell addSubview:cumlnLable];

        
//        UIImageView *cumlnImage = [[UIImageView alloc]initWithFrame:CGRectMake(14, 51, 50, 50)];
//        cumlnImage.layer.cornerRadius = cumlnImage.frame.size.width / 2;
//        cumlnImage.clipsToBounds = YES;
//        [cumlnImage sd_setImageWithURL:[insightModel.featureAvatar lkbImageUrl3] placeholderImage:YQNormalPlaceImage];
//        
//        UILabel *cumlnLable = [[UILabel alloc]initWithFrame:CGRectMake(78,59, 200, 16)];
//        cumlnLable.text = insightModel.featureName;
//        cumlnLable.textAlignment = NSTextAlignmentLeft;
//        [cumlnLable setTextColor:CCCUIColorFromHex(0x333333)];
//        cumlnLable.font = [UIFont systemFontOfSize:16];
//        
//        
//        UILabel *attentionNumLable = [[UILabel alloc]initWithFrame:CGRectMake(78,82, 100, 12)];
//        
//        
//        NSString *str= [NSString stringWithFormat:@"%@人关注", insightModel.attNum];
//
//        NSMutableAttributedString* remAttributedStr = [[NSMutableAttributedString alloc] initWithString:str];
//        [remAttributedStr addAttribute:NSForegroundColorAttributeName value:CCCUIColorFromHex(0x22a941) range:NSMakeRange(0, insightModel.attNum.length)];
//        [remAttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,insightModel.attNum.length)];
//        
//        [remAttributedStr addAttribute:NSForegroundColorAttributeName value:CCCUIColorFromHex(0xaaaaaa) range:NSMakeRange(insightModel.attNum.length, str.length -insightModel.attNum.length)];
//        [remAttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(insightModel.attNum.length,str.length -insightModel.attNum.length)];
//        attentionNumLable.attributedText= remAttributedStr;

//        attentionNumLable.text = [NSString stringWithFormat:@"%@人关注", insightModel.attNum];
//        attentionNumLable.textAlignment = NSTextAlignmentLeft;
//        [attentionNumLable setTextColor:CCCUIColorFromHex(0x333333)];
//        attentionNumLable.font = [UIFont systemFontOfSize:16];
        
        
        
//        [cell addSubview:cumlnImage];
//        [cell addSubview:cumlnLable];
//        [cell addSubview:attentionNumLable];
        
    }
    if (indexPath.row==3) {
        UILabel *infoLable = [[UILabel alloc]initWithFrame:CGRectMake(14, 18, 100, 16)];
        infoLable.text = @"个人信息";
        infoLable.textAlignment = NSTextAlignmentLeft;
        [infoLable setTextColor:CCCUIColorFromHex(0x333333)];
        infoLable.font = [UIFont systemFontOfSize:16];
        [cell addSubview:infoLable];
        
        
        UILabel *goodFiledLable = [[UILabel alloc]initWithFrame:CGRectMake(14, 50, 260, 14)];
        if (model.goodFiled == nil || [model.goodFiled isEqualToString:@""]) {
            
            goodFiledLable.text =  [NSString stringWithFormat:@"擅长领域： %@", @"ta比较懒还没留下什么"]   ;

        }
        else {
            
            goodFiledLable.text = [NSString stringWithFormat:@"擅长领域： %@", model.goodFiled]   ;
        }
        goodFiledLable.textAlignment = NSTextAlignmentLeft;
        [goodFiledLable setTextColor:CCCUIColorFromHex(0x999999)];
        goodFiledLable.font = [UIFont systemFontOfSize:14];
        
        UILabel *identityLable = [[UILabel alloc]initWithFrame:CGRectMake(14, 69, 260, 14)];
        
        if (model.identity == nil || [model.identity isEqualToString:@""]) {
            
            identityLable.text = [NSString stringWithFormat:@"职业身份： %@", @"ta比较懒还没留下什么"];
            
        }
        else {
            
            identityLable.text = [NSString stringWithFormat:@"职业身份： %@", model.identity];
        }

        identityLable.textAlignment = NSTextAlignmentLeft;
        [identityLable setTextColor:CCCUIColorFromHex(0x999999)];
        identityLable.font = [UIFont systemFontOfSize:14];
        
        UILabel *addressNumLable = [[UILabel alloc]initWithFrame:CGRectMake(14, 88,260,14)];
        
        if (model.address == nil || [model.address isEqualToString:@""]) {
            
            identityLable.text = [NSString stringWithFormat:@"所在地区： ta比较懒还没留下什么"];
            
        }
        else {
            
            addressNumLable.text = [NSString stringWithFormat:@"所在地区： %@", model.address]   ;
        }

        addressNumLable.textAlignment = NSTextAlignmentLeft;
        [addressNumLable setTextColor:CCCUIColorFromHex(0x999999)];
        addressNumLable.font = [UIFont systemFontOfSize:14];
        
        
        [cell addSubview:goodFiledLable];
        [cell addSubview:identityLable];
        [cell addSubview:addressNumLable];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;

    
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
    
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


    if (indexPath.row == 0) {
        // 动态
        UserInforDynamicViewController * userDynamicVC =[[ UserInforDynamicViewController alloc]init];
        
        if ([_toUserId isEqual:[MyUserInfoManager shareInstance].userId]) {
            userDynamicVC.title = @"我的动态";
        }else {
            userDynamicVC.title = @"Ta的动态";
            
        }
        userDynamicVC.toUserId = _toUserId;
        userDynamicVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userDynamicVC animated:YES];

        
    }
    if (indexPath.row == 1) {
        // 圈子
        UserInforGroupViewController * userGroupVC =[[ UserInforGroupViewController alloc]init];
        if ([_toUserId isEqual:[MyUserInfoManager shareInstance].userId]) {
            userGroupVC.title = @"我的圈子";
        }else {
            userGroupVC.title = @"Ta的圈子";
            
        }

        userGroupVC.toUserId = _toUserId;
        userGroupVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userGroupVC animated:YES];

        
    }
    if (indexPath.row == 2) {
        // 专栏
        ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
        if ([insightModel.featureId isEqualToString:[MyFeatureIdManager shareInstance].featureId]) {
            ColumnListViewVC.title = @"我的专栏";
        }else {
            ColumnListViewVC.title = @"Ta的专栏";
            
        }

        ColumnListViewVC.featureId = insightModel.featureId;
        ColumnListViewVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ColumnListViewVC animated:YES];
        
    }


    
}


#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}



-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if([viewController isEqual:self]){
        NSLog(@"跳转到自己，显示NavBar,隐藏TabBar");
        [self.tabBarController.tabBar setHidden:YES];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        //[self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        self.navigationController.delegate = nil;
        [viewController.tabBarController.tabBar setHidden:NO];
        [navigationController setNavigationBarHidden:YES animated:YES];
        //self.navigationController.delegate = viewController;
        NSLog(@"跳转回去，显示TabBar,隐藏NavBar");
    }
}



@end
