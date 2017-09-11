//
//  QADetailViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 9/29/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "QADetailViewController.h"
#import "GTMNSString+HTML.h"
#import "DynamicModel.h"
#import "UIView+TYAlertView.h"
#import "UMSocial.h"
#import "NewShareActionView.h"
#import "TooBarView.h"
#import "UIView+SDAutoLayout.h"
#import "UIView+LQXkeyboard.h"
#import "UserGroupViewController.h"
#import "CommentViewController.h"
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"
#import "WFBottomBarView.h"
#import "WFWebImageShowView.h"
#import "UIImageView+EMWebCache.h"
#import "OtherUserInforViewController.h"
#import "PeopleViewController.h"
#import "UserRootViewController.h"
#import "LoveTableFooterView.h"
#define ATTENTION_QUESTION 10001
#define UNATTENTION_QUESTION 10002

#define CLICK_LIKE 10003
#define CANCEL_LIKE 10004

#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height
#define Powder [UIColor colorWithRed:254/255.0 green:124/255.0 blue:148/255.0 alpha:1]

@interface QADetailViewController ()<UIWebViewDelegate,WFWebViewDelegate,WFBottomBarDelegate,NewShareActionViewDelegete>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *topicHeaderView;
@property (copy, nonatomic) NSString *questionDesc;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (nonatomic, strong) UIView *critiqueView;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIView* webBrowserView;
@property (nonatomic, strong) UIView *InforView ;

@property (nonatomic ,strong) UIButton *praiseBtn;// 关注疑难按钮
@property (nonatomic, strong) UIButton *inviteBtn;
@property (nonatomic ,strong) SSTextView *textviews;
@property (nonatomic ,strong) UIButton *btn;
@property (nonatomic ,strong) TooBarView *toolBar;

@property(nonatomic,strong)TYAlertController *alertController;
@property(nonatomic,assign)float titleHeight;
//@property(nonatomic,strong)NewShareActionView *shareView;
//@property(nonatomic,strong)TYAlertController *alertController;
//@property (strong, nonatomic) UILabel *leftTitle;

@end
@implementation QADetailViewController
- (void)viewDidLoad {
    self.requestParas = @{
                          @"questionId":_questionId,
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token]
                          };
    self.requestURL = LKB_Question_Detail_Url;
    
    self.view.backgroundColor =  [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_share_pre"] style:UIBarButtonItemStylePlain target:self action:@selector(inviteBtn:)];
    self.navigationItem.title = @"疑难解答";
    
    
    [[NSNotificationCenter
      defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:)
     name:UIKeyboardWillChangeFrameNotification object:nil];//在这里注册通知
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    [self.navigationItem.titleView setFrame:CGRectMake(20, 10, 100, 40)];
    //    self.navigationItem.titleView = self.leftTitle;
    self.view.backgroundColor =  [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];

    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

//- (void)sendMassage{
//    NSLog(@"%@",self.textviews.text);
//
//
//
//    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
//                          @"questionId":_questionId,
//                          @"content":self.textviews.text,
//                          @"token":[[MyUserInfoManager shareInstance]token]
//                          };
//    self.requestURL = LKB_Question_reply_Url;
//
//
//    [self.textviews resignFirstResponder];
//    self.textviews.text= nil;
//
//}



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

- (void)didShareBarButtonItemAction:(id)sender
{
    
    [MyUserInfoManager shareInstance].shaImage = @"";
    [MyUserInfoManager shareInstance].shaTitle = _questionDesc;
    [MyUserInfoManager shareInstance].shaDes = _questionDesc;
    [MyUserInfoManager shareInstance].shaUrl = [NSString stringWithFormat:@"http://www.greentechplace.com/wenda/%@?mobileType=%@",_questionId,@"2"];
    
    
    
    
    ShareModel* shareData = [[ShareModel alloc] init];
    shareData.title = _questionDesc;
    shareData.shareText = _questionDesc;
    shareData.imgUrl = @"";
    shareData.url = [NSString stringWithFormat:@"http://112.124.96.181:8099/mobile/app/question/question-info/%@.html",_questionId];
    
    //    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewShareActionView" owner:self options:nil];
    //    NewShareActionView *newshare = [nib objectAtIndex:0];
    
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
    
    //    _shareView = [[NewShareActionView alloc]init];
    //
    //    _shareView.delegate = self;
    //
    //    _alertController = [TYAlertController alertControllerWithAlertView:_shareView preferredStyle:TYAlertControllerStyleAlert];
    //
    //    _alertController.backgoundTapDismissEnable = YES;
    //    [self presentViewController:_alertController animated:YES completion:nil];
    
    
    
}




- (void)newShareActionView:(NewShareActionView *)UserHeaderView didatterntion:(NSInteger)index
{
    NSLog(@"点击了群组");
    
    if (index==0) {
        [_alertController dismissViewControllerAnimated:YES];
        UserGroupViewController *shareTogroupView = [[UserGroupViewController alloc]init];
        shareTogroupView.title = @"我的群组";
        shareTogroupView.ifshare = @"2";
        
        shareTogroupView.shareDes =[NSString stringWithFormat: @"分享问答：<a href='http://www.lvkebang.cn/wenda/%@'>【%@】</a>",_questionId,_questionTitle];
        //        NSDictionary *shareDic = @{@"userId":[[MyUserInfoManager shareInstance]userId],
        //                                   @"title":_questionTitle,
        //                                   @"questionId":_questionId,
        //                                   @"summary":_questionDesc,
        //                                   @"cover":@"",
        //                                   @"token":[[MyUserInfoManager shareInstance]token],
        //                                   };
        //
        //        NSMutableDictionary* mydic = [NSMutableDictionary dictionaryWithDictionary:shareDic];
        //
        //        NSLog(@"-----------------------------%@",mydic);
        //        shareTogroupView.shareDic = mydic;
        //
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
        
        peopleVC.shareDes =[NSString stringWithFormat: @"分享问答：<a href='http://www.lvkebang.cn/wenda/%@'>【%@】</a>",_questionId,_questionTitle];
        peopleVC.ifshare = @"2";
        [self.navigationController pushViewController:peopleVC animated:YES];
        
        
    }
    
    
    if (index==2) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _questionDesc;
        extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/wenda/%@",_questionId];;
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_questionDesc shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    if (index==3) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _questionDesc;
        extConfig.wechatTimelineData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/wenda/%@",_questionId];;
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_questionDesc shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    if (index==4) {
        
        [_alertController dismissViewControllerAnimated:YES];
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _questionDesc;
        
        extConfig.sinaData.shareText =[NSString stringWithFormat:@"http://www.lvkebang.cn/wenda/%@",_questionId];
        //        extConfig.wechatSessionData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/jianjie/%@",_topicId];
        
        [[UMSocialControllerService defaultControllerService] setShareText:_questionDesc shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self, [UMSocialControllerService defaultControllerService], YES);
    }
    if (index==5) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _questionDesc;
        
        extConfig.tencentData.shareText = _questionDesc;
        extConfig.qzoneData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/wenda/%@",_questionId];
        
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_questionDesc shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    if (index==6) {
        
        [_alertController dismissViewControllerAnimated:YES];
        
        UMSocialExtConfig* extConfig = [UMSocialData defaultData].extConfig;
        extConfig.title = _questionDesc;
        extConfig.qqData.shareText = _questionDesc;
        extConfig.qqData.url  = [NSString stringWithFormat:@"http://www.lvkebang.cn/wenda/%@",_questionId];
        
        
        [[UMSocialControllerService defaultControllerService] setShareText:_questionDesc shareImage:YQ_ShareDefaultImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }

    
    
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
    ReplyDetailModel *model = (ReplyDetailModel *)_dataArray[indexPath.row];
    
    if (indexPath.section < self.dataArray.count) {
        if ([model.isStar isEqualToString:@"1"]) {
            
            [cell.loveBtn setImage:[UIImage imageNamed:@"icon_unPushlove"] forState:UIControlStateNormal];
            [cell.loveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else {
            
            [cell.loveBtn setImage:[UIImage imageNamed:@"icon_Pushlove"] forState:UIControlStateNormal];
            [cell.loveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
        }
        
        [cell.replyBtn setTitle:[NSString stringWithFormat:@"(%@)",model.applyNum] forState:UIControlStateNormal];
        [cell.loveBtn setTitle:[NSString stringWithFormat:@"(%@)",model.starNum] forState:UIControlStateNormal];
        
        
        NSString *str2 = [model.content stringByReplacingOccurrencesOfString:@"/static/" withString:@"http://www.lvkebang.cn/static/"];
        NSString * htmlString =str2;
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        [cell setIntroductionText:attrStr];
        
        
        // 时间设置
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString*strrr1=model.answerDate;
        NSTimeInterval time=[strrr1 doubleValue]/1000;
        NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        
        NSString *confromTimespStr = [formatter stringFromDate:detaildate];
        
        
        cell.timeLable.text = [NSString stringWithFormat:@"%@",confromTimespStr];
        cell.name.text = model.userName;
        cell.name.font = [UIFont systemFontOfSize:13];
        
        
//        UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[model.userAvatar lkbImageUrl4]]];
        
        
        
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
        [cell.userImage addTarget:self action:@selector(choseReply:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //        [cell.userImage.imageView sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalPlaceImage];
        
    }
    
    [cell handlerButtonAction:^(NSInteger clickIndex) {
        
        // 点赞
        if (clickIndex == 1 ) {
            
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
                
                [cell.loveBtn setImage:[UIImage imageNamed:@"icon_Pushlove"] forState:UIControlStateNormal];
                [cell.loveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
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
        
    }];
    
    return cell;
}


- (void)choseReply:(UIButton *)button {
    
    ReplyDetailModel *model = (ReplyDetailModel *)_dataArray[button.tag];
    
    //    OtherUserInforViewController *otherVC = [[OtherUserInforViewController alloc]init];
    //    otherVC.toUserId = model.userId;
    UserRootViewController *otherVC = [[UserRootViewController alloc]init];
    
    otherVC.type = @"2";
    otherVC.toUserId = model.userId;
    
    
    [self.navigationController pushViewController:otherVC animated:YES];
    
}

//// 评价
//-(double)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 8;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    UIView *contentView = [[UIView alloc] init];
//    [contentView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
//    label.backgroundColor = [UIColor clearColor];
//    [label setText:@"评价"];
//    [contentView addSubview:label];
//    return contentView;
//
//}

// 评价cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReplyDetailModel *model = (ReplyDetailModel *)_dataArray[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < self.dataArray.count) {
        
        CommentViewController *commentVC = [[CommentViewController alloc]init];
        
        commentVC.parentId = model.answerId;
        commentVC.topicId = _questionId;
        commentVC.userAvatar = model.userAvatar;
        commentVC.userName = model.userName;
        commentVC.replyDate = model.answerDate;
        commentVC.replyNum = model.applyNum;
        commentVC.starNum = model.starNum;
        commentVC.isStar = model.isStar;
        commentVC.content = model.content;
        commentVC.type = @"2";
        
        [self.navigationController pushViewController:commentVC animated:YES];
    }
}


// 去掉html的标签
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
    
    
    _topicHeaderView = [[UIView alloc]init];
    _topicHeaderView.backgroundColor = [UIColor whiteColor];
    // 标题
    UILabel *topicDescView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    // label获取字符串
    topicDescView.text = _questionTitle;
    topicDescView.textColor = CCCUIColorFromHex(0x333333);
    topicDescView.font = [UIFont systemFontOfSize:14];
    CGSize size =   [topicDescView boundingRectWithSize:CGSizeMake(kDeviceWidth-10, 0)];
    _titleHeight = size.height;
    topicDescView.numberOfLines = 0;
    
    [topicDescView setFrame:CGRectMake(10, 10, size.width, size.height)];
    topicDescView.text = _questionTitle;
    
    
    _mywebView = [[WFWebView alloc]initWithFrame:CGRectMake(0, size.height +30, kDeviceWidth,100)];
    _mywebView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    NSString *BookStr = [NSString stringWithFormat:@"<html> \n"
                         "<head> \n"
                         "<style type=\"text/css\"> \n"
                         "body {margin:10;font-size: %f; color: %@;}\n"
                         "</style> \n"
                         "</head> \n"
                         "<body>%@</body> \n"
                         "</html>",12.0,CCCUIColorFromHex(0x666666),_htmlss];
    [_mywebView loadHTMLString:BookStr baseURL:nil];
    
    _mywebView.webDelegate = self;
    _mywebView.scrollView.scrollEnabled = YES;
    [_mywebView sizeToFit];
    [_topicHeaderView addSubview:_mywebView];
    
    
    
    [_topicHeaderView addSubview:topicDescView];
    
    
    
    _InforView = [[UIView alloc]initWithFrame:CGRectMake(0, size.height +100, kDeviceWidth,30)];
    
    // 名字
    NSString *nameString = [[NSString alloc]initWithString:_autherName];
    UIButton *nameButton = [[UIButton alloc]init];
    CGSize nameSize = [nameString sizeWithFont:nameButton.font constrainedToSize:CGSizeMake(MAXFLOAT, 25)];
    
    if (iPhone5) {
        nameButton.frame = CGRectMake(10, 10, 100, 30) ;
    }else {
    nameButton.frame = CGRectMake(10, 10, nameSize.width, 30) ;
    }
    
//    nameButton .titleLabel.textAlignment = NSTextAlignmentLeft;
    nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [nameButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [nameButton setTitleColor:UIColorWithRGBA(194, 139, 83, 1) forState:UIControlStateNormal];
    [nameButton setTitle:nameString forState:UIControlStateNormal];
    [nameButton addTarget:self action:@selector(nameButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // 时间
    NSString *timeString = [NSString stringWithFormat:@"·%@",_timeStr];
    UILabel *timeLabel = [[UILabel alloc]init];
    CGSize timeSize = [timeString sizeWithFont:timeLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 25)];
    
    if (iPhone5) {
        timeLabel.frame = CGRectMake(110 , 10, timeSize.width, 30);

    }
    else {
    timeLabel.frame = CGRectMake(nameSize.width + 5, 10, timeSize.width, 30);
    }
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.text = timeString;
    
    // 关注
    _praiseBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-160, 10, 60, 30)];
    
    NSString * userstr = [NSString stringWithFormat:@"%@",[MyUserInfoManager shareInstance].userId];
    
    NSLog(@"+++++++++++++++++++%@",userstr);
    
    if ([ _questionUserId isEqualToString: [MyUserInfoManager shareInstance].userId]) {
        
        _praiseBtn.hidden = YES;
        
    }

    // 是否关注
    if ([_isAttention isEqualToString:@"0"]) {
        // 已关注
        [_praiseBtn setImage:[UIImage imageNamed:@"Topic_attention_pre"] forState:UIControlStateNormal];
        _praiseBtn.tag = ATTENTION_QUESTION;
    }else
    {
        [_praiseBtn setImage:[UIImage imageNamed:@"Question_attention_nor"] forState:UIControlStateNormal];
        _praiseBtn.tag = UNATTENTION_QUESTION;
    }
    [_praiseBtn addTarget:self action:@selector(tohold:) forControlEvents:UIControlEventTouchUpInside];
    
    // 邀请回答
    _inviteBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 70, 10, 60, 30)];
    [_inviteBtn setImage:[UIImage imageNamed:@"invite_answer"] forState:UIControlStateNormal];
    [_inviteBtn addTarget:self action:@selector(inviteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_InforView addSubview:nameButton];
    [_InforView addSubview:timeLabel];
    [_InforView addSubview:_praiseBtn];
    [_InforView addSubview:_inviteBtn];
    
    
    [_topicHeaderView addSubview:_InforView];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.tableFooterView.backgroundColor =  [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    self.tableView.tableHeaderView = _topicHeaderView;
    //    self.tableView.backgroundColor = UIColorWithRGBA(238, 238, 238, 1);
    self.tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = TABLE_VIEW_TAG;
    
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topBtn setImage:[UIImage imageNamed:@"btn_list_top_p"] forState:UIControlStateNormal];
    [topBtn setImage:[UIImage imageNamed:@"btn_list_top_p"] forState:UIControlStateHighlighted];
    [topBtn addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [topBtn setFrame:CGRectMake(SCREEN_WIDTH-60,SCREEN_HEIGHT-100,44,44)];
    
    
    [self.view addSubview:_tableView];
    [self.view   addSubview:topBtn];
    
    
    self.critiqueView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 40, ScreenWidth, 40)];
    //    self.critiqueView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"所有背景.png"]];
    self.critiqueView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:self.critiqueView];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth - 70, 30)];
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
    button.backgroundColor = [UIColor LkbBtnColor];
    button.frame = CGRectMake(ScreenWidth - 50, 5, 40, 30);
    button.layer.masksToBounds= YES;
    button.layer.cornerRadius = 5;
    [button setTitle:@"发送" forState:0];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [self.critiqueView  addSubview:button];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(sendMess) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTouchView)];
    //    [self.view addGestureRecognizer:recognizer];
    
    
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







// 关注按钮的点击事件
-(void)tohold:(id)sender
{
    if (_praiseBtn.tag == UNATTENTION_QUESTION) {
        
        
        self.requestParas = @{@"questionId":_questionId,
                              @"userId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token]
                              };
        self.requestURL = LKB_Question_Attention_Url;
        
        
    }
    else if (_praiseBtn.tag == ATTENTION_QUESTION){
        
        
        self.requestParas = @{@"questionId":_questionId,
                              @"userId":[[MyUserInfoManager shareInstance]userId],
                              @"token":[[MyUserInfoManager shareInstance]token]
                              };
        self.requestURL = LKB_Question_UnAttention_Url;
    }
}

// 邀请回答
- (void)inviteBtn:(id)sender {
    
    PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
    peopleVC.requestUrl = LKB_Attention_Users_Url;
    peopleVC.userId = [MyUserInfoManager shareInstance].userId;
    peopleVC.hidesBottomBarWhenPushed = YES;
    peopleVC.title = @"我的好友";
    peopleVC.shareDes =[NSString stringWithFormat: @"%@邀请您回答：<a href='http://www.lvkebang.cn/wenda/%@'>【%@】</a>",[[MyUserInfoManager shareInstance]userName],_questionId,_questionTitle];
    peopleVC.ifshare = @"2";
    peopleVC.questionId = _questionId;
    peopleVC.questionUserId = _questionUserId;
    [self.navigationController pushViewController:peopleVC animated:YES];
    
    
}


// 名字点击
- (void)nameButton:(id)sender {
    
    
    //    OtherUserInforViewController *otherVC = [[OtherUserInforViewController alloc]init];
    //    otherVC.toUserId = _autherId;
    UserRootViewController *otherVC = [[UserRootViewController alloc]init];
    
    otherVC.type = @"2";
    otherVC.toUserId = _autherId;
    
    
    [self.navigationController pushViewController:otherVC animated:YES];
    NSLog(@"55555");
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
    self.requestParas = @{@"questionId":_questionId,
                          @"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[[MyUserInfoManager shareInstance]token],
                          @"page":@(currPage),
                          isLoadingMoreKey:@(isLoadingMore)};
    self.requestURL = LKB_Question_reply_List_Url;
    
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
        //        [MBProgressHUD showError:errorMessage toView:self.view];
        return;
    }
    if ([request.url isEqualToString:LKB_Question_reply_List_Url]) {
        ReplyModel *replymodel = (ReplyModel *)parserObject;
        
        
        if (!request.isLoadingMore) {
            _dataArray = [NSMutableArray arrayWithArray:replymodel.data];
        }else {
            [_dataArray addObjectsFromArray:replymodel.data];
        }
        
        [self.tableView reloadData];
        
        if (replymodel.num == 0) {
            
            _tableView.tableFooterView.hidden = NO;
            [_tableView.infiniteScrollingView endScrollAnimating];
        } else {
            //            _tableView.showsInfiniteScrolling = YES;
            _tableView.tableFooterView.hidden = YES;
            
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
    if ([request.url isEqualToString:LKB_Question_Detail_Url]) {
        
        DynamicModel *replymodel = (DynamicModel *)parserObject;
        NSDictionary *dic =(NSDictionary *)replymodel.data;
        
        
        _isAttention = replymodel.isAttention;
        _questionDesc = dic[@"summary"];
        _autherName = dic[@"userName"];
        _questionUserId = [NSString stringWithFormat:@"%@",dic[@"userId"]] ;
        //        _coverImg = dic[@"cover"];
        _questionTitle = dic[@"title"];
        _autherId = dic[@"userId"];
        
        // 是否关注
        if ([_isAttention isEqualToString:@"0"]) {
            // 已关注
            [_praiseBtn setImage:[UIImage imageNamed:@"Topic_attention_pre"] forState:UIControlStateNormal];
            _praiseBtn.tag = ATTENTION_QUESTION;
            
            
        }else
        {
            [_praiseBtn setImage:[UIImage imageNamed:@"Question_attention_nor"] forState:UIControlStateNormal];
            _praiseBtn.tag = UNATTENTION_QUESTION;
        }
        
        
        // 图片设置
        NSString *strnomal = dic[@"content"];
        NSString *str = [strnomal gtm_stringByUnescapingFromHTML];
        NSString *str2 = [str stringByReplacingOccurrencesOfString:@"/static/" withString:@"http://www.lvkebang.cn/static/"];
        _htmlss = [NSMutableString stringWithString:str2];
        
        
        // 时间设置
        NSString*strrr1=dic[@"questionDate"];
        NSTimeInterval time=[strrr1 doubleValue];
        
        NSDate *createDate = [NSDate dateFormJavaTimestamp:time];
        _timeStr = [createDate timeAgo];
        
        [self initializePageSubviews];
        [self.tableView reloadData];
        
    }
    
    if ([request.url isEqualToString:LKB_Question_Attention_Url]) {
        //        [_praiseBtn setImage:[UIImage imageNamed:@"Topic_attention_pre"] forState:UIControlStateNormal];
        //
        ////        [_praiseBtn setImage:[UIImage imageNamed:@"Question_attention_nor"] forState:UIControlStateNormal];
        //
        //        _praiseBtn.tag = UNATTENTION_QUESTION;
        //
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        NSLog(@"-------------------------------------------%@",replymodel.msg);
        
        if ([replymodel.msg isEqualToString:@"关注成功！"]) {
            //            [self ShowProgressHUDwithMessage:@"关注成功！"];
            
            [_praiseBtn setImage:[UIImage imageNamed:@"Topic_attention_pre"] forState:UIControlStateNormal];
            
            _praiseBtn.tag = ATTENTION_QUESTION;
            
        }
        [self.tableView reloadData];
        
    }
    if ([request.url isEqualToString:LKB_Question_UnAttention_Url]) {
        
        
        
        LKBBaseModel *replymodel = (LKBBaseModel *)parserObject;
        
        NSLog(@"-------------------------------------------%@",replymodel.msg);
        
        if ([replymodel.msg isEqualToString:@"取消关注成功"]) {
            //            [self ShowProgressHUDwithMessage:@"取消关注成功"];
            
            [_praiseBtn setImage:[UIImage imageNamed:@"Question_attention_nor"] forState:UIControlStateNormal];
            _praiseBtn.tag = UNATTENTION_QUESTION;
            
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

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//    return 10;
//}





#pragma mark
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

#pragma mark - WFWebViewDelegate -
- (void)clickActionOnHyperlink:(NSString *)linkUrl{
    
    //    WFOutsideWebController *outSideWeb = [[WFOutsideWebController alloc] initWithReqUrl:linkUrl];
    //    [self.navigationController pushViewController:outSideWeb animated:YES];
    
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


-(void)sendeHeight:(float)height
{
    NSLog(@"高度是多少%f",height);
    
    
    //  _mywebView = [[WFWebView alloc]initWithFrame:CGRectMake(0, _titleHeight+20, kDeviceWidth,100)];
    [_mywebView setFrame:CGRectMake(0, _titleHeight +10, kDeviceWidth,height+40)];
    _mywebView.backgroundColor = [UIColor whiteColor];
    _mywebView.scrollView.scrollEnabled = NO;
    [_topicHeaderView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, height+_titleHeight+50)];
    
    
    [_InforView setFrame:CGRectMake(0, _titleHeight +height +10, kDeviceWidth, 30)];
    self.tableView.tableHeaderView = _topicHeaderView;
    [self.tableView reloadData];
}




-(void)hideButtomView:(__autoreleasing id *)sender
{
    
    //    [UIView animateWithDuration:0.3 animations:^{
    //        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    //        [_detailBottomView setFrame:CGRectMake(0, KDeviceHeight - 50.f, kDeviceWidth, 50.f)];
    //    } completion:^(BOOL finished) {
    //
    //    }];
    
    NSLog(@"--------------------------");
    
    
    
    
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
                              @"questionId":_questionId,
                              @"content":self.textField.text,
                              @"token":[[MyUserInfoManager shareInstance]token]
                              };
        self.requestURL = LKB_Question_reply_Url;
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


@end
