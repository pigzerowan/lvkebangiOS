//
//  QuesAndAnsViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "QuesAndAnsViewController.h"
#import "InvitePeopleViewController.h"
#import "SVPullToRefresh.h"
#import "LoveTableFooterView.h"
#import "MyUserInfoManager.h"
#import "InviteAnswerModel.h"
#import <UIImageView+WebCache.h>
#import "QADetailViewController.h"
#import "QuestionAndAnswerCell.h"
#import "QuestAndAnswerManager.h"
#import "OutWebViewController.h"
#define Start_X 12.0f           // 第一个按钮的X坐标
#define Start_Y 14.0f           // 第一个按钮的Y坐标
#define Width_Space 14.0f        // 2个按钮之间的横间距
#define Button_Height 20.0f    // 高
#define Button_Width 20.0f      // 宽

static NSString* NewsQuestionInviteCellIdentifier = @"QuestionInviteCellIdentifier";

@interface QuesAndAnsViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    
    NSMutableArray *mystr;
    NSInteger intcount;
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;

}

@end

@implementation QuesAndAnsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    mystr = [[NSMutableArray alloc]initWithCapacity:0];
    self.title = @"参与邀请";
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
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
    
    [self initializePageSubviews];


    
    
}

- (void)tryAgainButton:(id )sender {
    
    [self initializePageSubviews];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [MobClick beginLogPageView:@"NewsQuestionInviteCellIdentifier"];

    //    [_tableView pullToRefreshView];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"NewsQuestionInviteCellIdentifier"];

    
}

-(void)questionInvite:(NSNotification *)sender{
    
    NSLog(@"!!!!!!!!!~!《《《》》》》》》》》》》》》》》》》》%@",sender.userInfo);
    
    NSLog(@"------------------------------%@",sender.userInfo);
    
    
    NSDictionary *dic = [sender.userInfo objectForKey:@"object"];
    
    NSLog(@"------------------------------%@",dic);
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *objectId =[NSString stringWithFormat:@"yaoqing%@",[dic objectForKey:@"objId"]] ;
    
    NSLog(@"------------------------------%@",objectId);
    
    
    [userDefault setObject:@"isUnRead" forKey:objectId];
    
    NSString *str = [userDefault objectForKey:objectId];
    
    
    NSLog(@"------------------------------%@",str);
    
//    [self.tableView reloadData];
    
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [QuestAndAnswerManager shareInstance].unreadNum = 0;
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
    self.tableView.showsInfiniteScrolling = YES;
    [self.tableView triggerPullToRefresh];
    
    if (self.dataArray.count == 0) {
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = YES;
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
    
    self.requestParas = @{
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"page":@(currPage),
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)};
    
    
    self.requestURL = LKB_Notice_Question;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            [self.tableView.pullToRefreshView stopAnimating];
        }
        else {
            //            [self.dataArray addObject:[NSNull null]];
            [self.tableView.infiniteScrollingView stopAnimating];
        }
        [self.tableView reloadData];
    });
    
}



- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //        [_tableView registerClass:[QuestionAndAnswerCell class] forCellReuseIdentifier:NewsQuestionInviteCellIdentifier];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _tableView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray.count == 0) {
        return 1;
    }
    else {
        return self.dataArray.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SlideBarCell =@"SlideBarCell";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SlideBarCell];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Did-not-receive-an-invitation"]];
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );        
        [cell addSubview:loadingImage];
        
        
        
        return cell;
    }
    
    else  if (indexPath.row < self.dataArray.count)  {
        
        InviteAnswerDetailModel * model = (InviteAnswerDetailModel *)_dataArray[indexPath.row];
        
//        NSLog(@"---------------------%@",model);
        
        cell = [tableView dequeueReusableCellWithIdentifier:NewsQuestionInviteCellIdentifier];
        if (!cell) {
            cell = [[QuestionAndAnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsQuestionInviteCellIdentifier];
        }
        QuestionAndAnswerCell * simplescell = (QuestionAndAnswerCell *)cell;
        
        
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        // 未读的数组
        NSString *KeyStr = [NSString stringWithFormat:@"QuestionAndAnswer%@",[MyUserInfoManager shareInstance].userId];
        NSMutableArray *userDefaultArray =[[userDefault objectForKey:KeyStr] mutableCopy];
        
        
        NSLog(@"=====================%@",userDefaultArray);
        
        
        simplescell.redImage.hidden = YES;

        if (userDefaultArray.count > 0 ) {
            
            NSString *UnReadobjId;
            
            NSMutableArray * UnReadArr = [NSMutableArray array];

            for (NSDictionary * objectDic in userDefaultArray) {
                NSDictionary * object = [objectDic valueForKey:@"object"];
                
                UnReadobjId = [NSString stringWithFormat:@"%@",[object valueForKey:@"objId"]];
                
                if ([model.objId isEqual:UnReadobjId]) {
                    
//                    simplescell.redImage.hidden = NO;
                    [UnReadArr addObject:objectDic];
                    
                    
                    
                    
                    
                }
                
            }
            
            for (NSDictionary * UnReadDic in UnReadArr) {
                
                simplescell.redImage.hidden = NO;
                
            }

        }
        


//        else {
//
//            simplescell.redImage.hidden = YES;
//        }
        
        [QuestAndAnswerManager shareInstance].unreadNum = [NSString stringWithFormat:@"%lu",(unsigned long)[mystr count]];
        
        if (model.inviteAnswerNum == 1) {
            for (NSString *str in model.avatars) {
                
                [simplescell.headerImage sd_setImageWithURL:[str lkbImageUrl4] placeholderImage:LKBUserInvitePlaceImage];
            }
            
            simplescell.headerImage_2.hidden = YES;
            simplescell.headerImage_3.hidden = YES;
            
            simplescell.answerLabel.frame = CGRectMake(40,7, kDeviceWidth, 34);
            simplescell.answerLabel.text = @"邀请你回答";
        }
        
        else if (model.inviteAnswerNum == 2) {
            
            [simplescell.headerImage sd_setImageWithURL:[model.avatars[0] lkbImageUrl4] placeholderImage:LKBUserInvitePlaceImage];
            
            [simplescell.headerImage_2 sd_setImageWithURL:[model.avatars[1] lkbImageUrl4] placeholderImage:LKBUserInvitePlaceImage];
            
            
            simplescell.headerImage_3.hidden = YES;
            
            simplescell.answerLabel.frame = CGRectMake(52, 7, kDeviceWidth, 34);
            simplescell.answerLabel.text = @"等2人邀请你回答";
            
            
        }
        
        else if (model.inviteAnswerNum > 3 || model.inviteAnswerNum == 3) {
            
            
            [simplescell.headerImage sd_setImageWithURL:[model.avatars[0] lkbImageUrl4] placeholderImage:LKBUserInvitePlaceImage];
            
            [simplescell.headerImage_2 sd_setImageWithURL:[model.avatars[1] lkbImageUrl4] placeholderImage:LKBUserInvitePlaceImage];
            [simplescell.headerImage_3 sd_setImageWithURL:[model.avatars[2] lkbImageUrl4] placeholderImage:LKBUserInvitePlaceImage];
            simplescell.answerLabel.frame = CGRectMake(64, 7, kDeviceWidth, 34);

            simplescell.answerLabel.text = [NSString stringWithFormat:@"等%ld人邀请你回答",(long)model.inviteAnswerNum];
            
            
            
        }
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
        
        
        [simplescell.titleButton setTitle:[NSString stringWithFormat:@"%@",model.objTitle] forState:UIControlStateNormal];
        
        [simplescell handlerButtonAction:^(NSInteger clickIndex) {
            // 头像
            if (clickIndex == 1) {
                
                InvitePeopleViewController *invitePeopleVC = [[InvitePeopleViewController alloc]init];
                invitePeopleVC.objId = model.objId;
                invitePeopleVC.type = @"1";
                
                invitePeopleVC.title = [NSString stringWithFormat:@"共%ld人",(long)model.inviteAnswerNum];
                //    [self.tableView reloadData];
                invitePeopleVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:invitePeopleVC animated:YES];
                
                if (userDefaultArray.count > 0) {
                    
                    NSMutableArray * willDelDefaultArr = [NSMutableArray array];

                    for (NSDictionary * DefaultDic in userDefaultArray) {
                        
                        NSLog(@"=====================%@",DefaultDic);
                        
                        NSDictionary * objectIdDic = [DefaultDic valueForKey:@"object"];
                        
                        NSString *isUnReadobjId = [NSString stringWithFormat:@"%@",[objectIdDic valueForKey:@"objId"]];
                        
                        if ([isUnReadobjId  isEqualToString:model.objId]) {
                            
                            [willDelDefaultArr addObject:DefaultDic];

                        }
                    }
                    for (NSDictionary *  delDefaultDic in willDelDefaultArr) {
                        
                        [userDefaultArray removeObject:delDefaultDic];
                    }

                    
                    
                    
                    NSArray * DefaultArray = [NSArray arrayWithArray:userDefaultArray];
                    
                    [userDefault setObject:DefaultArray forKey:KeyStr];
                    
                    
                    NSMutableArray *updateNewArr = [[userDefault objectForKey:KeyStr]mutableCopy];
                    
                    NSLog(@"=======================%@",updateNewArr);// 数组里
                    
                    NSLog(@"=====================%lu",(unsigned long)updateNewArr.count);
                    //
                    //
                }

                
                
                [_tableView reloadData];
            }
            
            
            if (clickIndex == 2) {
                
                
                NSLog(@"=====================%@",userDefaultArray);
                
                
                NSLog(@"=====================%lu",(unsigned long)userDefaultArray.count);
                
                if (userDefaultArray.count > 0) {
                    
                    
                    NSMutableArray * willDelArr = [NSMutableArray array];
                    
                    for (NSDictionary * Dic in userDefaultArray) {
                        
                        NSLog(@"=====================%@",Dic);
                        
                        NSDictionary * objectIdDic = [Dic valueForKey:@"object"];
                        
                        NSString *UnobjId = [NSString stringWithFormat:@"%@",[objectIdDic valueForKey:@"objId"]];
                        
                        if ([UnobjId  isEqualToString:model.objId]) {
                            
                            [willDelArr addObject:Dic];
                        }
                    }
                    
                    //遍历完成后遍历查找到的数组，逐一删除
                    for (NSDictionary *  delDic in willDelArr) {
                        
                        [userDefaultArray removeObject:delDic];
                    }
                    
                    
                    
                    
                    NSArray * array = [NSArray arrayWithArray:userDefaultArray];
                    
                    [userDefault setObject:array forKey:KeyStr];
                    
                    
                    NSMutableArray *updateNewArr = [[userDefault objectForKey:KeyStr]mutableCopy];
                    
                    NSLog(@"=======================%@",updateNewArr);// 数组里
                    
                    NSLog(@"=====================%lu",(unsigned long)updateNewArr.count);

                    NSString *linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@?sourceId=%@",LKB_WSSERVICE_HTTP,model.objId,model.groupId];
                    NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    NSURL *url = [NSURL URLWithString:strmy];
                    
                    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                    
                    outSideWeb.sendMessageType = @"2";
                    outSideWeb.rightButtonType = @"2";
                    outSideWeb.VcType = @"1";// 圈子动态
                    outSideWeb. urlStr =linkUrl;
                    outSideWeb.htmlStr = linkUrl;
                    outSideWeb.circleId = model.groupId;
                    outSideWeb.circleDetailId = model.objId;
                    outSideWeb.objectId =  model.objId;
                    
                    outSideWeb.mytitle = model.objTitle;
                    //                outSideWeb.describle = insight.summary;
                    //                outSideWeb.userAvatar = insight.userAvatar;
                    //                outSideWeb.isAttention = insight.isAttention;
                    outSideWeb.commendVcType = @"1";
                    outSideWeb.groupName = model.groupNmae;
                    
                    outSideWeb.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:outSideWeb animated:YES];

                
                
//
//
                }

                [_tableView reloadData];
                
                
            }
        }];
        
    }
    return cell;
}



#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count == 0) {
        return KDeviceHeight;

    }
    else {
        
        return 79;

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
            
            
            [self.tableView removeFromSuperview];
            WithoutInternetImage.hidden = NO;
            tryAgainButton.hidden = NO;
            
            
            
        }

        return;
    }
    if ([request.url isEqualToString:LKB_Notice_Question]) {
        InviteAnswerModel *getDetailModel = (InviteAnswerModel *)parserObject;
        
        NSLog(@"-----------------------%@",getDetailModel.data);
        
        
        if (!request.isLoadingMore) {
            
            _dataArray = [NSMutableArray arrayWithArray:getDetailModel.data];

        }else {

            [_dataArray addObjectsFromArray:getDetailModel.data];
        }
        
        
        [self.tableView reloadData];
        
        if (getDetailModel.num == 0) {
            
            _tableView.tableFooterView.hidden = NO;
            [_tableView.infiniteScrollingView endScrollAnimating];
        } else {
            //            _tableView.showsInfiniteScrolling = YES;
            _tableView.tableFooterView.hidden = YES;
            
            [_tableView.infiniteScrollingView beginScrollAnimating];
            
        }
        
    }
    
    
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
