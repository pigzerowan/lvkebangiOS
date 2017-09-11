//
//  CommentViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/24.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "CommentViewController.h"
#import "ReplyTabViewCell.h"
#import "ReplyModel.h"
#import "MBProgressHUD+Add.h"
#import "ReplyTabViewCell.h"
#import "SVPullToRefresh.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"
#import "MBProgressHUD+Add.h"
#import "FileHelpers.h"

#import "GTMNSString+HTML.h"
#import "DynamicModel.h"
#import "UIView+TYAlertView.h"
#import "NewShareActionView.h"
#import "TooBarView.h"
#import "UIView+SDAutoLayout.h"
#import "SVPullToRefresh.h"
#import "MyUserInfoManager.h"

#import "CustomView.h"
#import "ReplyModel.h"
#import <UIImageView+WebCache.h>
#import "GTMNSString+HTML.h"
#import "UILabel+StringFrame.h"
#import "ToPicModel.h"
#import "UIView+TYAlertView.h"
#import "UMSocial.h"
#import "UIView+LQXkeyboard.h"

#import "CommentViewController.h"
#import "OtherUserInforViewController.h"
#import "UserRootViewController.h"
#import "LoveTableFooterView.h"

#import "QADetailViewController.h"
#import "InsightDetailViewController.h"
#import "NewUserMainPageViewController.h"
#define TABLE_VIEW_TAG 8004

#define ATTENTION_TOPIC 10001
#define UNATTENTION_TOPIC 10002

#define CLICK_LIKE 10003
#define CANCEL_LIKE 10004

static NSString* CommentCellIdentifier = @"CommentTableViewCellIdentifier";

@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>


@property (nonatomic,strong)UITableView *tableView;

@property (strong, nonatomic) NSMutableArray* dataArray;

@property (nonatomic, strong) UIView *critiqueView;
@property (nonatomic, strong) UITextField *textField;



@end

@implementation CommentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"评论";
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    [[NSNotificationCenter
      defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:)
     name:UIKeyboardWillChangeFrameNotification object:nil];//在这里注册通知
    [self initializePageSubviews];
    NSLog(@"------------------------%@",_topicId);
    NSLog(@",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,%@",_parentId);
    
    
    // Do any additional setup after loading the view.
}



-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)initializePageSubviews {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kDeviceWidth, KDeviceHeight-144) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.tableFooterView.backgroundColor =  [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    _tableView.backgroundColor = [UIColor whiteColor];
    

    if ([_commentType isEqualToString:@"2"]||[_commentType isEqualToString:@"3"]||[_commentType isEqualToString:@"5"]||[_commentType isEqualToString:@"6"]) {
        
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
    
    
    _tableView.tag = TABLE_VIEW_TAG;
    //    [_tableView registerClass:[ReplyTabViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    
    
    
    [self.view addSubview:self.tableView];
    
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topBtn setImage:[UIImage imageNamed:@"btn_list_top_p"] forState:UIControlStateNormal];
    [topBtn setImage:[UIImage imageNamed:@"btn_list_top_p"] forState:UIControlStateHighlighted];
    [topBtn addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [topBtn setFrame:CGRectMake(SCREEN_WIDTH-60,SCREEN_HEIGHT-144,44,44)];
    [self.view addSubview:topBtn];
    
    self.critiqueView = [[UIView alloc] initWithFrame:CGRectMake(0, KDeviceHeight - 104, kDeviceWidth, 40)];
    self.critiqueView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:245.0/255.0 alpha:1];
    [self.view addSubview:self.critiqueView];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, kDeviceWidth - 70, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"输入评论...";
    self.textField.font = [UIFont fontWithName:@"Arial" size:13.0f];
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    self.textField.returnKeyType = UIReturnKeyGo;
    self.textField.delegate = self;
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
        self.tableView.tableFooterView.hidden = NO;
    }
    
    
}

- (void)headerButton:(id)sender {
    
    if ([_commentType isEqualToString:@"2"] || [_commentType isEqualToString:@"5"]) {
        // 答疑
                QADetailViewController *questionVC = [[QADetailViewController alloc]init];
        
                questionVC.questionId = _topicId;
                [self.navigationController pushViewController:questionVC animated:YES];

    }
    if ([_commentType isEqualToString:@"3"]|| [_commentType isEqualToString:@"6"]) {
//        // 话题
//                TopicDetaillViewController *topicVC = [[TopicDetaillViewController alloc]init];
//                topicVC.topicId = _topicId;
//                [self.navigationController pushViewController:topicVC animated:YES];
        
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
    
    if ([_type isEqualToString:@"1"]) {
        self.requestParas = @{@"topicId":_topicId,
                              @"userId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token],
                              @"parentId":_parentId,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)};
        self.requestURL = LKB_Reply_Detail_Url;
        
    }
    if ([_type isEqualToString:@"2"]) {
        self.requestParas = @{@"questionId":_topicId,
                              @"userId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token],
                              @"parentId":_parentId,
                              @"page":@(currPage),
                              isLoadingMoreKey:@(isLoadingMore)};
        self.requestURL = LKB_Question_reply_List_Url;
        
    }
    if ([_type isEqualToString:@"3"]) {
        
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!isLoadingMore) {
            [self.tableView.pullToRefreshView stopAnimating];
        }
        else {
            //[self.dataArray addObject:[NSNull null]];
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
        return;
    }
    
    
    if ([request.url isEqualToString:LKB_Reply_Detail_Url]) {
        ReplyModel *replymodel = (ReplyModel *)parserObject;
        
        NSLog(@"-----------------------%@",replymodel.data);
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
    
    if ([request.url isEqualToString:LKB_Topic_Reply_Url]) {
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"true"]) {
            [self ShowProgressHUDwithMessage:@"评论成功"];
            [self.tableView triggerPullToRefresh];
        }
        [self.tableView reloadData];
        
    }
    
    if ([request.url isEqualToString:LKB_Question_reply_List_Url]) {
        ReplyModel *replymodel = (ReplyModel *)parserObject;
        
        NSLog(@"-----------------------%@",replymodel.data);
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
    
    if ([request.url isEqualToString:LKB_Question_reply_Url]) {
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
            [self ShowProgressHUDwithMessage:@"点赞成功！"];
            
                     [self.tableView triggerPullToRefresh];
            
        }
    }
    if ([request.url isEqualToString:LKB_Common_Cancel_Star_Url]) {
        
        
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        if ([replymodel.success isEqualToString:@"1"]) {
            [self ShowProgressHUDwithMessage:@"取消点赞成功！"];
            [self.tableView triggerPullToRefresh];
            
        }
    }
    
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count +1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReplyTabViewCell *cell =(ReplyTabViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReplyTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
    if (cell == nil) {
        cell = [[ReplyTabViewCell alloc] initWithReuseIdentifier:CommentCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.row == 0) {
        cell.replyBtn.hidden = NO;
        cell.name.text = _userName;
        
        UIImageView *btnimage;
        
        
        btnimage = [[UIImageView alloc]init];
        
        [btnimage sd_setImageWithURL:[_userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
        
        
        
        if ([_userAvatar isEqualToString:@"" ] ||_userAvatar == nil) {
            [cell.userImage setImage:YQNormalPlaceImage forState:UIControlStateNormal];
        }
        else {
            [cell.userImage setImage:btnimage.image forState:UIControlStateNormal];
        }
        
        if ([_isStar isEqualToString:@"1"]) {
            
            [cell.loveBtn setImage:[UIImage imageNamed:@"icon_unPushlove"] forState:UIControlStateNormal];
            [cell.loveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else {
            
            [cell.loveBtn setImage:[UIImage imageNamed:@"icon_Pushlove"] forState:UIControlStateNormal];
            [cell.loveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
        }
        
        [cell.replyBtn setTitle:[NSString stringWithFormat:@"(%@)",_replyNum] forState:UIControlStateNormal];
        [cell.loveBtn setTitle:[NSString stringWithFormat:@"(%@)",_starNum] forState:UIControlStateNormal];
        // 时间设置
        NSTimeInterval time=[_replyDate doubleValue];
        
        NSDate *createDate = [NSDate dateFormJavaTimestamp:time];
        
        cell.timeLable.text = [NSString stringWithFormat:@"%@",[createDate timeAgo]];
        
        NSLog(@"----------------------------------------%@",cell.timeLable.text);
//        NSString *str = [self filterHTML:_content];
//        [cell setIntroductionText:str];
        
        NSString *str2 = [_content stringByReplacingOccurrencesOfString:@"/static/" withString:@"http://www.lvkebang.cn/static/"];
        NSString * htmlString =str2;
        
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

        [cell setIntroductionText:attrStr];
        
    }
    else {
        cell.replyBtn.hidden = YES;
        
        ReplyDetailModel *model = (ReplyDetailModel *)_dataArray[indexPath.row -1];
        
        NSString *str2 = [model.content stringByReplacingOccurrencesOfString:@"/static/" withString:@"http://www.lvkebang.cn/static/"];
        NSString * htmlString =str2;
        
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
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
        if ([_type isEqualToString:@"1"]) {
            
            _timeStr = model.replyDate;
            
        }
        if ([_type isEqualToString:@"2"]) {
            _timeStr = model.answerDate;
        }
        NSTimeInterval time=[_timeStr doubleValue]/1000;
        NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        
        NSString *confromTimespStr = [formatter stringFromDate:detaildate];
        
        cell.timeLable.text = [NSString stringWithFormat:@"%@",confromTimespStr];
        
        
        cell.name.text = model.userName;
        cell.name.font = [UIFont systemFontOfSize:13];
        // 头像
        UIImageView *btnimage;
        
        
        btnimage = [[UIImageView alloc]init];
        
        [btnimage sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
        if ([model.userAvatar isEqualToString:@"" ] || model.userAvatar == nil) {
            [cell.userImage setImage:YQNormalPlaceImage forState:UIControlStateNormal];
        }
        else {
            [cell.userImage setImage:btnimage.image forState:UIControlStateNormal];
        }
        cell.userImage.tag = indexPath.row;
//        [cell.userImage addTarget:self action:@selector(choseReply:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    [cell handlerButtonAction:^(NSInteger clickIndex) {
        if (indexPath.row == 0 ) {
            
        }
        else {
            ReplyDetailModel *model = (ReplyDetailModel *)_dataArray[indexPath.row -1 ];
            // 头像
            
            if (clickIndex ==3  ) {
                
                
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
            // 点赞
            if (clickIndex == 1 ) {
                
                if ([_type isEqualToString:@"1"]) {
                    
                    if ([model.isStar isEqualToString:@"1"]) {
                        
                        [cell.loveBtn setImage:[UIImage imageNamed:@"icon_Pushlove"] forState:UIControlStateNormal];
                        [cell.loveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                        cell.loveBtn .tag = CLICK_LIKE;
                        
                        self.requestParas = @{
                                              @"objectId":model.replyId,
                                              @"objectType":@"2",
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
                                              @"objectId":model.replyId,
                                              @"objectType":@"2",
                                              @"userId":[[MyUserInfoManager shareInstance]userId],
                                              @"token":[[MyUserInfoManager shareInstance]token]
                                              };
                        self.requestURL = LKB_Common_Cancel_Star_Url;
                    }
                    
                    
                }
                
            }
            
            if  ([_type isEqualToString:@"2"]) {
                if ([model.isStar isEqualToString:@"1"]) {
                    
                    [cell.loveBtn setImage:[UIImage imageNamed:@"icon_Pushlove"] forState:UIControlStateNormal];
                    [cell.loveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    cell.loveBtn .tag = CLICK_LIKE;
                    
                    self.requestParas = @{
                                          @"objectId":model.answerId,
                                          @"objectType":@"3",
                                          @"userId":[[MyUserInfoManager shareInstance]userId],
                                          @"token":[[MyUserInfoManager shareInstance]token]
                                          };
                    self.requestURL = LKB_Common_Star_Url;
                }
                
                if ([model.isStar isEqualToString:@"0"]) {
                    
                    [cell.loveBtn setImage:[UIImage imageNamed:@"icon_unPushlove"] forState:UIControlStateNormal];
                    [cell.loveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    cell.loveBtn .tag = CLICK_LIKE;
                    
                    self.requestParas = @{
                                          @"objectId":model.answerId,
                                          @"objectType":@"3",
                                          @"userId":[[MyUserInfoManager shareInstance]userId],
                                          @"token":[[MyUserInfoManager shareInstance]token]
                                          };
                    self.requestURL = LKB_Common_Cancel_Star_Url;
                }
                
                
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
            self.critiqueView.y = KDeviceHeight - 104;//这里的<span style="background-color: rgb(240, 240, 240);">self.toolbar就是我的输入框。</span>
            
        } else {
            self.critiqueView.y = keyboardF.origin.y - 104;
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
        if ([_type isEqualToString:@"1"]) {
            
            self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"topicId":_topicId,
                                  @"content":self.textField.text,
                                  @"parentId":_parentId,
                                  @"token":[[MyUserInfoManager shareInstance]token]};
            self.requestURL = LKB_Topic_Reply_Url;
            
            
        }
        if ([_type isEqualToString:@"2"]) {
            
            self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"questionId":_topicId,
                                  @"content":self.textField.text,
                                  @"answerId":_parentId,
                                  @"token":[[MyUserInfoManager shareInstance]token]};
            self.requestURL = LKB_Question_reply_Url;
            
        }
    }
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
        self.textField.text = nil;
    }
    
}

#pragma mark - 滚回顶部
-(void)scrollToTop
{
    UITableView *table = (UITableView *)[self.view viewWithTag:TABLE_VIEW_TAG];
    
    [table setContentOffset:CGPointMake(0,0) animated:YES];
    
    //    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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

#pragma Check dealloc

// Dismiss the keyboard on view touches by making
// the view the first responder

//cell不可点击
- (void)didTouchView {
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
        self.textField.text = nil;
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
