//
//  InsightReplistViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 11/4/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "InsightReplistViewController.h"
#import "ReplyTabViewCell.h"
#import "ReplyModel.h"
#import "SVPullToRefresh.h"
#import "UIImageView+EMWebCache.h"
#import "MyUserInfoManager.h"
#import "OtherUserInforViewController.h"
#import "UserRootViewController.h"
#import "LoveTableFooterView.h"
#import "InsightDetailViewController.h"
#import "MBProgressHUD+Add.h"
#import "ReplyTabViewCell.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"
#import "FileHelpers.h"
#import "GTMNSString+HTML.h"
#import "DynamicModel.h"
#import "UIView+TYAlertView.h"
#import "NewShareActionView.h"
#import "TooBarView.h"
#import "UIView+SDAutoLayout.h"
#import "UserGroupViewController.h"
#import "CustomView.h"
#import <UIImageView+WebCache.h>
#import "GTMNSString+HTML.h"
#import "UILabel+StringFrame.h"
#import "UIView+TYAlertView.h"
#import "UMSocial.h"
#import "UIView+LQXkeyboard.h"
#import "OtherUserInforViewController.h"
#import "UserRootViewController.h"
#import "NewUserMainPageViewController.h"

#define CLICK_LIKE 10003
#define CANCEL_LIKE 10004

static NSString* CellIdentifier = @"TimeTableViewCellIdentifier";
@interface InsightReplistViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic) UITableView *tableView;
@end


@implementation InsightReplistViewController

- (void)viewDidLoad {
    self.title = @"见解评论";
    self.view.backgroundColor =  [UIColor whiteColor];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    
    [self.navigationItem.titleView setFrame:CGRectMake(20, 10, 100, 40)];
    //    self.navigationItem.titleView = self.leftTitle;
    self.view.backgroundColor =  [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    
    
    
    [[NSNotificationCenter
      defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:)
     name:UIKeyboardWillChangeFrameNotification object:nil];//在这里注册通知
    
    
    [self initializePageSubviews];
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReplyTabViewCell *cell =(ReplyTabViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReplyTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ReplyTabViewCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    if (indexPath.section < self.dataArray.count) {
        ReplyDetailModel *model = (ReplyDetailModel *)_dataArray[indexPath.row];
        cell.replyBtn.hidden = YES;
        
        //    [model.replyContent gtm_stringByUnescapingFromHTML];
        
        //    [string stringByUnescapingHTML];
        //    [_webView loadHTMLString:_htmlss baseURL:nil];
        //    [_webView loadHTMLString:[_htmlss stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];
        //        NSString *str = [self filterHTML:model.content];
        
        
        //         NSURL *url =[NSURL URLWithString:model.content];
        
        
        NSString *str2 = [model.content stringByReplacingOccurrencesOfString:@"/static/" withString:@"http://www.lvkebang.cn/static/"];
        
        
        NSString * htmlString =str2;
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        //
        //        NSAttributedString *attrStr = [[NSAttributedString alloc]
        //                                       initWithFileURL:url
        //                                       options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
        //                                       documentAttributes:nil error:nil];
        //        [_textView setAttributedText:attrStr];
        
        
        [cell setIntroductionText:attrStr];

        
        if ([model.isStar isEqualToString:@"1"]) {
            
            [cell.loveBtn setImage:[UIImage imageNamed:@"icon_unPushlove"] forState:UIControlStateNormal];
            [cell.loveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else {
            
            [cell.loveBtn setImage:[UIImage imageNamed:@"icon_Pushlove"] forState:UIControlStateNormal];
            [cell.loveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
        }
        
        [cell.loveBtn setTitle:[NSString stringWithFormat:@"(%@)",model.starNum] forState:UIControlStateNormal];
        

        
        // 时间设置
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString*strrr=model.operateDate;
        NSTimeInterval time=[strrr doubleValue]/1000;
        NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        
        NSString *confromTimespStr = [formatter stringFromDate:detaildate];
        
        cell.timeLable.text = [NSString stringWithFormat:@"%@",confromTimespStr];
        
        cell.name.text = model.userName;
        
        UIImageView *image = [[UIImageView alloc]init];
        [image sd_setImageWithURL:[model.avatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
        [cell.userImage setImage:image.image forState:UIControlStateNormal];
    
        cell.userImage.tag = indexPath.row;
        [cell.userImage addTarget:self action:@selector(choseReply:) forControlEvents:UIControlEventTouchUpInside];

        
    }
    
    
    [cell handlerButtonAction:^(NSInteger clickIndex) {
        
        ReplyDetailModel *model = (ReplyDetailModel *)_dataArray[indexPath.row ];
        
        // 点赞
        if (clickIndex == 1 ) {
            
            
            if ([model.isStar isEqualToString:@"1"]) {
                
                [cell.loveBtn setImage:[UIImage imageNamed:@"icon_Pushlove"] forState:UIControlStateNormal];
                [cell.loveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                cell.loveBtn .tag = CLICK_LIKE;
                
                self.requestParas = @{
                                      @"objectId":model.commentId,
                                      @"objectType":@"1",
                                      @"userId":[[MyUserInfoManager shareInstance]userId],
                                      @"token":[[MyUserInfoManager shareInstance]token]
                                      };
                self.requestURL = LKB_Common_Star_Url;
            }
            
            if ([model.isStar isEqualToString:@"0"]) {
                
                [cell.loveBtn setImage:[UIImage imageNamed:@"icon_Pushlove"] forState:UIControlStateNormal];
                [cell.loveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                cell.loveBtn .tag = CLICK_LIKE;
                
                self.requestParas = @{
                                      @"objectId":model.commentId,
                                      @"objectType":@"1",
                                      @"userId":[[MyUserInfoManager shareInstance]userId],
                                      @"token":[[MyUserInfoManager shareInstance]token]
                                      };
                self.requestURL = LKB_Common_Cancel_Star_Url;
            }
            
            
        }
        
        
        
    }];
    
    return cell;
}

- (void)choseReply:(UIButton *)button {
    
    ReplyDetailModel *model = (ReplyDetailModel *)_dataArray[button.tag];
    
//    UserRootViewController *otherVC = [[UserRootViewController alloc]init];
//    otherVC.toUserId = model.userId;
//    otherVC.type = @"2";
//    [self.navigationController pushViewController:otherVC animated:YES];
    NewUserMainPageViewController *peopleVC = [[NewUserMainPageViewController alloc] init];
    peopleVC.type = @"2";
    peopleVC.toUserId = model.userId;
    peopleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:peopleVC animated:YES];
    
}


-(NSString *)filterHTML:(NSString *)html
{
    //    两种方法
    //        NSRange range;
    //        NSString *string = html;
    //        while ((range = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
    //            string=[string stringByReplacingCharactersInRange:range withString:@""];
    //        }
    //        NSLog(@"Un block string : %@",string);
    
    NSString *newStr = html;
    newStr = [newStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"&amp;nbsp;" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"&middot;" withString:@""];
    NSScanner * scanner = [NSScanner scannerWithString:newStr];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        newStr = [newStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return newStr;
}



#pragma mark - Page subviews
- (void)initializePageSubviews
{
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.tableFooterView.backgroundColor =  [UIColor whiteColor];
    self.tableView.backgroundColor = UIColorWithRGBA(238, 238, 238, 1);
    
    
    if ([_commentType isEqualToString:@"1"]) {
        
        UIButton *headerbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
        headerbutton.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        
        
        [headerbutton setTitle:[NSString stringWithFormat:@"%@",_headerTitle] forState:UIControlStateNormal];
        headerbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        headerbutton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        [headerbutton setTitleColor:CCCUIColorFromHex(0x333333) forState:UIControlStateNormal];
        headerbutton.titleLabel.font = [UIFont systemFontOfSize:14];
        [headerbutton addTarget:self action:@selector(headerButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _tableView.tableHeaderView = headerbutton;
        
    }

    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [topBtn setImage:[UIImage imageNamed:@"btn_list_top_p"] forState:UIControlStateNormal];
    //    [topBtn setImage:[UIImage imageNamed:@"btn_list_top_p"] forState:UIControlStateHighlighted];
    //    [topBtn addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    //    [topBtn setFrame:CGRectMake(SCREEN_WIDTH-60,SCREEN_HEIGHT-100,44,44)];
    
    self.critiqueView = [[UIView alloc] initWithFrame:CGRectMake(0, KDeviceHeight - 40, kDeviceWidth, 40)];
    //    self.critiqueView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"所有背景.png"]];
    self.critiqueView.backgroundColor =[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:245.0/255.0 alpha:1];
    [self.view addSubview:self.critiqueView];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, kDeviceWidth - 70, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"输入评论...";
    self.textField.font = [UIFont fontWithName:@"Arial" size:13.0f];
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    self.textField.returnKeyType = UIReturnKeyGo;
    self.textField.delegate = self;
    //    self.search.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"所有背景.png"]];
    [self.critiqueView addSubview:self.textField];
    
    
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(kDeviceWidth - 50, 5, 40, 30);
    button.backgroundColor = [UIColor LkbBtnColor];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    
    [button setTitle:@"发送" forState:0];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [self.critiqueView  addSubview:button];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(sendMess) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTouchView)];
    [self.view addGestureRecognizer:recognizer];
    
    
    
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
        footerVew.backgroundColor =  UIColorWithRGBA(238, 238, 238, 1);
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = YES;
    }
}


- (void)headerButton:(id)sender {
    
    InsightDetailViewController *insightVC = [[InsightDetailViewController alloc]init];
    insightVC.topicId = _blogId;
    insightVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:insightVC animated:YES];

    
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
    
    self.requestParas = @{@"insightId":_blogId,
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token],
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)
                          };
    self.requestURL = LKB_Insight_Replies_Url;
    
    
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!isLoadingMore) {
//            [self.tableView.pullToRefreshView stopAnimating];
//        }
//        else {
//            //[self.dataArray addObject:[NSNull null]];
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
        return;
    }
    if ([request.url isEqualToString:LKB_Insight_Replies_Url]) {
        ReplyModel *replymodel = (ReplyModel *)parserObject;
        if (!request.isLoadingMore) {
            
            
            _dataArray = [NSMutableArray arrayWithArray:replymodel.data];
            
        } else {
            if (_dataArray.count<replymodel.num) {
                [_dataArray addObjectsFromArray:replymodel.data];
            }
        }
        [self.tableView reloadData];
        
        if (replymodel.num == 0) {
            
            _tableView.tableFooterView.hidden = NO;
            [_tableView.infiniteScrollingView endScrollAnimating];
        } else {
            //            _tableView.showsInfiniteScrolling = YES;
            _tableView.tableFooterView.hidden = NO;
            
            [_tableView.infiniteScrollingView beginScrollAnimating];
            
        }
    }
    
    
    
    
    if ([request.url isEqualToString:LKB_Insight_Reply_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
            [self ShowProgressHUDwithMessage:@"评论成功"];
            [self.tableView triggerPullToRefresh];
        }
        [self.tableView reloadData];
        
    }
    
    if ([request.url isEqualToString:LKB_Common_Star_Url]) {
        
        
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
//            [self ShowProgressHUDwithMessage:@"点赞成功！"];
            
            [self.tableView triggerPullToRefresh];
            
        }
    }
    if ([request.url isEqualToString:LKB_Common_Cancel_Star_Url]) {
        
        
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
//            [self ShowProgressHUDwithMessage:@"取消点赞成功！"];
            [self.tableView triggerPullToRefresh];
            
        }
    }
    
    
}

//#pragma mark
//#pragma mark - 滚回顶部
//-(void)scrollToTop
//{
//    UITableView *table = (UITableView *)[self.view viewWithTag:TABLE_VIEW_TAG];
//
//    [table setContentOffset:CGPointMake(0,0) animated:YES];
//
//    //    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}
- (void)ShowProgressHUDwithMessage:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.dimBackground = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}


#pragma mark - 监听方法
/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    //    if (self.picking) return;
    /**
     notification.userInfo = @{
     // 键盘弹出\隐藏后的frame
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 352}, {320, 216}},
     // 键盘弹出\隐藏所耗费的时间
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     // 键盘弹出\隐藏动画的执行节奏（先快后慢，匀速）
     UIKeyboardAnimationCurveUserInfoKey = 7
     }
     */
    
    NSDictionary *userInfo = notification.userInfo;
    
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > KDeviceHeight) { // 键盘的Y值已经远远超过了控制器view的高度
            self.critiqueView.y = KDeviceHeight - 40;//这里的<span style="background-color: rgb(240, 240, 240);">self.toolbar就是我的输入框。</span>
            
        } else {
            self.critiqueView.y = keyboardF.origin.y - 40;
        }
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.critiqueView.frame = CGRectMake(0, KDeviceHeight - 294, kDeviceWidth, 40);
        
    }];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendMess];
    
    return YES;
}
- (void)sendMess
{
    static const NSInteger Min_Num_TextView = 10;
    static const NSInteger Max_Num_TextView = 5000;
    
    
    if (self.textField.text.length==0) {
        [self ShowProgressHUDwithMessage:@"请输入评论"];
    }
    
    if (self.textField.text.length < Min_Num_TextView ) {
        
        [self ShowProgressHUDwithMessage:@"评论内容最少10个字"];
        
    }
    if (self.textField.text.length > Max_Num_TextView ) {
        
        [self ShowProgressHUDwithMessage:@"评论内容最多5000个字"];
        
    }
    else
    {
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"insightId":_blogId,
                              @"content":self.textField.text,
                              @"token":[[MyUserInfoManager shareInstance]token]
                              };
        self.requestURL = LKB_Insight_Reply_Url;
        
    }
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
        self.textField.text = nil;
    }
}


#pragma Check dealloc

// Dismiss the keyboard on view touches by making
// the view the first responder
- (void)didTouchView {
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
        self.textField.text = nil;
    }
}



#pragma Check dealloc

// Dismiss the keyboard on view touches by making
// the view the first responder



@end
