//
//  NewsCommentViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "NewsCommentViewController.h"
#import "NewsCommentCell.h"
#import "UserRootViewController.h"
#import "SVPullToRefresh.h"
#import "MBProgressHUD+Add.h"
#import "MyUserInfoManager.h"
#import "GetCommentModel.h"
#import "QADetailViewController.h"
#import "InsightDetailViewController.h"
#import "CommentViewController.h"
#import "InsightReplistViewController.h"
#import "LoveTableFooterView.h"
#import "NewsRootViewController.h"
#import "OutWebViewController.h"
#import "NewUserMainPageViewController.h"
static NSString* NewsCommentIdentifier = @"NewsCommentCellIdentifier";


@interface NewsCommentViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
{
    UIView *backGroundView;
    UIView *commentsView;
    UITextView *commentText;
    UIButton * senderButton;
    UIToolbar *topView;
    UITapGestureRecognizer * tapGestureRecognizer;
    UILabel * label;
    NSString * linkUrl;
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;

    
}


@end

@implementation NewsCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    // 键盘回收
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.delegate = self;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self initializePageSubviews];
    
    
    
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"newMessage" object:nil];
    
    self.view.multipleTouchEnabled=TRUE;
    
    
    UISwipeGestureRecognizer  *slider = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
    slider.direction=UISwipeGestureRecognizerDirectionDown;
    slider.delegate = self;
    [self.view addGestureRecognizer:slider];
    
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


- (void)handleSwipes:(UISwipeGestureRecognizer *) sender {
    
    
    [self.view removeGestureRecognizer:sender];
}




-(void)notice:(id)sender{
    
    
    NSLog(@"%@",sender);
    
    
    [self initializePageSubviews];
    
    
    //    [self.tableView triggerPullToRefresh];
    
    [self.tableView reloadData];
    
    
}




//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//
//    NSLog(@"99999999");
//}




- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[NewsCommentCell class] forCellReuseIdentifier:NewsCommentIdentifier];
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
    static NSString *NewsCommentCellIdentifier = @"newCommentCell";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsCommentCellIdentifier];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"no-comment"]];
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );
        
        [cell addSubview:loadingImage];

        return cell;
    }
    
    else  if (indexPath.row < self.dataArray.count) {
        
        GetDetailCommentModel *model = (GetDetailCommentModel *)_dataArray[indexPath.row];
        
        NSLog(@"--------------------%@",model);
        
        cell = [tableView dequeueReusableCellWithIdentifier:NewsCommentIdentifier];
        
        
        if (!cell) {
            
            cell =  [[NewsCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsCommentIdentifier];
        }
        
        NewsCommentCell * simplescell = (NewsCommentCell *)cell;
        simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
        [simplescell configSingelGetCommentTableCellWithGoodModel:model];
        
        
        [simplescell handlerButtonAction:^(NSInteger clickIndex) {
            //  头像
            if (clickIndex == 1) {
                
                NSLog(@"-----------------%@",model.userId);
                
                //                UserRootViewController *userVC = [[UserRootViewController alloc]init];
                //                userVC.toUserId = model.userId;
                //                userVC.type = @"2";
                //                userVC.hidesBottomBarWhenPushed = YES;
                //                [self.navigationController pushViewController:userVC animated:YES];
                NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
                peopleVC.type = @"2";
                peopleVC.toUserId = model.userId;
                peopleVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:peopleVC animated:YES];
                
            }
            // 回复
            if (clickIndex == 2) {
                
                backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
                backGroundView.backgroundColor = [UIColor blackColor];
                backGroundView.alpha = 0.4;
                
                [backGroundView addGestureRecognizer:tapGestureRecognizer];
                
                commentsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height - 216-40, self.view.frame.size.width-70, 40.0)];
                commentsView.backgroundColor = [UIColor clearColor];
                
                commentText = [[UITextView alloc] initWithFrame:CGRectInset(commentsView.bounds, 5.0, 5.0)];
                commentText.layer.borderColor   = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
                commentText.layer.borderWidth   = 1.0;
                commentText.layer.cornerRadius  = 2.0;
                commentText.layer.masksToBounds = YES;
                //            commentText.text = @"请输入回复内容";
                commentText.textColor= CCCUIColorFromHex(0x888888);
                commentText.keyboardType = UIKeyboardAppearanceDefault;
                commentText.returnKeyType = UIReturnKeyDefault;
                //        commentText.inputAccessoryView  = commentsView;
                commentText.backgroundColor = [UIColor whiteColor];
                commentText.delegate = self;
                commentText.font = [UIFont systemFontOfSize:15.0];
                
                
                label = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 200, 14)];
                label.text = @"请输入回复内容";
                label.font = [UIFont systemFontOfSize:14];
                label.textColor = CCCUIColorFromHex(0x888888);
                
                [commentText addSubview:label];
                
                topView = [[UIToolbar alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 70, self.view.frame.size.height -216-40-40, 76, 40)];
                topView.backgroundColor = [UIColor whiteColor];
                
                commentText.inputAccessoryView = topView;
                
                senderButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth -70, 0, 70, 40)];
                [senderButton setTitle:@"发送" forState:UIControlStateNormal];
                senderButton.backgroundColor = [UIColor whiteColor];
                [senderButton setTitleColor:UIColorWithRGBA(22, 153, 71, 0.5) forState:UIControlStateNormal];
                
                senderButton.tag = indexPath.row;
                
                senderButton.userInteractionEnabled = NO;
                
                [senderButton addTarget:self action:@selector(senderButton:) forControlEvents:UIControlEventTouchUpInside];
                [topView addSubview:senderButton];
                
                [topView addSubview:commentText];
                
                [commentsView addSubview:topView];
                
                [backGroundView addSubview:commentsView];
                [self.view.window addSubview:backGroundView];//添加到window上或者其他视图也行，只要在视图以外就好了
                
                
                [commentText becomeFirstResponder];//让textView成为第一响应者（第一次）这次键盘并未显示出来，（个人觉得这里主要是将commentsView设置为commentText的inputAccessoryView,然后再给一次焦点就能成功显示）
                
                
                //            [commentText becomeFirstResponder];//再次让textView成为第一响应者（第二次）这次键盘才成功显示
                
                
            }
            // 内容
            if (clickIndex == 3) {
                // 专栏
                if (model.commentType == 1 ||model.commentType == 4) {
                    
                    linkUrl = [NSString stringWithFormat:@"%@/detail/insight/%@",LKB_WSSERVICE_HTTP,model.objId];
                    
                }
                else {
                    linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/%@",LKB_WSSERVICE_HTTP,model.objId];
                    
                }
                
                
                NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                NSURL *url = [NSURL URLWithString:strmy];
                
                OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
                
                outSideWeb.sendMessageType = @"2";
                outSideWeb.rightButtonType = @"2";
                if (model.commentType == 1 ||model.commentType == 4) {
                    outSideWeb.VcType = @"2";// 圈子动态
                    
                }
                else {
                    outSideWeb.VcType = @"1";// 圈子动态
                    
                }
                outSideWeb. urlStr =linkUrl;
                outSideWeb.htmlStr = linkUrl;
                //                outSideWeb.circleId = insight.groupId;
                outSideWeb.circleDetailId = model.objId;
                outSideWeb.objectId = model.objId;
                
                outSideWeb.mytitle = model.summary;
                //                outSideWeb.describle = insight.summary;
                //                outSideWeb.userAvatar = insight.userAvatar;
                //                outSideWeb.isAttention = insight.isAttention;
                outSideWeb.commendVcType = @"1";
                
                outSideWeb.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:outSideWeb animated:YES];
                
                
                
            }
        }];
        
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return cell;
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]){
        
        
        return NO;
    }
    return YES;
}



#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count == 0) {
        return self.view.frame.size.height;
    }
    else {
        return 135;
    }
}




- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [commentText resignFirstResponder];
    
    
}




- (void)senderButton:(UIButton *)sender {
    
    
    
    GetDetailCommentModel *model = (GetDetailCommentModel *)_dataArray[sender.tag];
    
    //    OtherUserInforViewController *otherVC = [[OtherUserInforViewController alloc]init];
    NSLog(@"________________%ld",(long)model.commentType);
    
    
    if (commentText.text.length==0) {
        
        [self ShowProgressHUDwithMessage:@"请输入评论"];
    }
    else
    {
        if (model.commentType == 3 || model.commentType == 2 ) {
            
            self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"topicId":model.objId,
                                  @"content":commentText.text,
                                  @"parentId":model.commentId,
                                  @"token":[[MyUserInfoManager shareInstance]token]
                                  };
            self.requestURL = LKB_Topic_Reply_Url;
            
            
        }
        if (model.commentType == 4) {
            
            // 专栏
            self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"insightId":model.objId,// 文章Id
                                  @"commentId":model.commentId,// 评论Id
                                  @"content":commentText.text,
                                  @"token":[[MyUserInfoManager shareInstance]token]
                                  };
            self.requestURL = LKB_Insight_Reply_Url;
            
            
        }
        
        if (model.commentType == 6) {
            
            self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"topicId":model.objId, // 文章Id
                                  @"content":commentText.text,
                                  @"parentId":model.commentId,
                                  @"token":[[MyUserInfoManager shareInstance]token]
                                  };
            self.requestURL = LKB_Topic_Reply_Url;
            
        }
        
    }
    
}





- (void)textViewDidChange:(UITextView *)textView{
    
    if ([textView.text length] == 0) {
        [label setHidden:NO];
        senderButton.userInteractionEnabled = NO;
        [senderButton setTitleColor:UIColorWithRGBA(22, 153, 71, 0.5) forState:UIControlStateNormal];
    }else{
        [label setHidden:YES];
        senderButton.userInteractionEnabled = YES;
        [senderButton setTitleColor:UIColorWithRGBA(22, 153, 71, 1) forState:UIControlStateNormal];
        
    }
    
    CGSize constraintSize;
    
    constraintSize. width = 300 ;
    
    constraintSize. height = MAXFLOAT ;
    
    CGSize sizeFrame =[textView.text sizeWithFont:textView.font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    
    //    textView.frame = CGRectMake( 0 , 0 ,sizeFrame.width,sizeFrame.height);
    
    if (sizeFrame.height < 140) {
        [commentText setFrame:CGRectMake(5, 5, self.view.frame.size.width-70, 140)];
        
        [topView setFrame:CGRectMake(0, -sizeFrame.height + 15, self.view.frame.size.width, 140)];
        
        [senderButton setFrame:CGRectMake(kDeviceWidth -70, sizeFrame.height -15 , 70, 40)];
    }
    else {
        
        [commentText setFrame:CGRectMake(5, 0, self.view.frame.size.width-70, 140)];
        [topView setFrame:CGRectMake(0, -98, self.view.frame.size.width, 140)];
        
        [senderButton setFrame:CGRectMake(kDeviceWidth -70, 98 , 70, 40)];
        
        commentText.scrollEnabled = YES;
        
    }
}


// 键盘回收
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}





-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    
    [commentText resignFirstResponder];
    
    [backGroundView removeFromSuperview];
    
    
}


- (void)tap:(UITapGestureRecognizer *)recognizer
{
    [commentText resignFirstResponder];
    [backGroundView removeFromSuperview];
    
    NSLog(@"999999");
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GetDetailCommentModel *model = (GetDetailCommentModel *)_dataArray[indexPath.row];
    
    
    // 专栏
    if (model.commentType == 1 ||model.commentType == 4) {
        
        linkUrl = [NSString stringWithFormat:@"%@/detail/insight/comment/%@?sourceId=%@",LKB_WSSERVICE_HTTP,model.commentId,model.objId];
        
    }
    else {
        linkUrl = [NSString stringWithFormat:@"%@/detail/agriculture/comment/%@?sourceId=%@",LKB_WSSERVICE_HTTP,model.commentId,model.objId];
    }
    
    
    NSString *strmy = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strmy];
    
    OutWebViewController *outSideWeb = [[OutWebViewController alloc] initWithReqUrl:url];
    
    //    outSideWeb.sendMessageType = @"3";
    //    outSideWeb.rightButtonType = @"2";
    //    if (model.commentType == 1 ||model.commentType == 4) {
    //        outSideWeb.VcType = @"2";// 专栏
    //
    //    }
    //    else {
    //        outSideWeb.VcType = @"4";// 圈子动态
    //
    //    }
    
    outSideWeb.sendMessageType = @"3";
    outSideWeb.rightButtonType = @"2";
    outSideWeb.VcType = @"4";
    outSideWeb.circleDetailId = model.objId;
    outSideWeb.QuanDetailId = model.commentId;
    outSideWeb.commendVcType = @"2";
    outSideWeb.objectId = model.objId;
    
    // 专栏
    if (model.commentType == 1 ||model.commentType == 4) {
        
        outSideWeb.commentType = @"1";
        
    }
    else {
        outSideWeb.commentType = @"0";
        
    }
    
    
    outSideWeb. urlStr =linkUrl;
    outSideWeb.htmlStr = linkUrl;
    //                outSideWeb.circleId = insight.groupId;
    outSideWeb.circleDetailId = model.objId;
    outSideWeb.objectId = model.objId;
    
    outSideWeb.mytitle = model.summary;
    //                outSideWeb.describle = insight.summary;
    //                outSideWeb.userAvatar = insight.userAvatar;
    //                outSideWeb.isAttention = insight.isAttention;
    outSideWeb.commendVcType = @"2";
    
    outSideWeb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:outSideWeb animated:YES];
    
    
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
    
    self.requestURL = LKB_Get_Comment;
    
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








- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (!request.isLoadingMore) {
        [self.tableView.pullToRefreshView stopAnimating];
    } else {
        [self.tableView.infiniteScrollingView stopAnimating];
    }
    
    if (errorMessage) {
//        [MBProgressHUD showError:errorMessage toView:self.view];
        [XHToast showTopWithText:errorMessage topOffset:60.0];

        if ([errorMessage isEqualToString:@"没有网络，连接失败"]) {
            
            
            [self.tableView removeFromSuperview];
            WithoutInternetImage.hidden = NO;
            tryAgainButton.hidden = NO;
            
            
            
        }

        return;
    }
    
    
    
    if ([request.url isEqualToString:LKB_Get_Comment]) {
        GetCommentModel *getDetailModel = (GetCommentModel *)parserObject;
        
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
    
    if ([request.url isEqualToString:LKB_Topic_Reply_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        
        if ([replymodel.success isEqualToString:@"1"]) {
            [self ShowProgressHUDwithMessage:@"回复成功"];
            //            [self.tableView triggerPullToRefresh];
        }
        [commentText resignFirstResponder];
        [backGroundView removeFromSuperview];
        
        
    }
    
    if ([request.url isEqualToString:LKB_Question_reply_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        [commentText resignFirstResponder];
        
        if ([replymodel.success isEqualToString:@"1"]) {
            [self ShowProgressHUDwithMessage:@"回复成功"];
            
            //            [self.tableView triggerPullToRefresh];
        }
        [commentText resignFirstResponder];
        [backGroundView removeFromSuperview];
        
    }
    
    
}


// 开始滚动监听
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    //创建一个消息对象
    NSNotification *slider = [NSNotification notificationWithName:@"scrollViewWillBeginDragging" object:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:slider];
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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





