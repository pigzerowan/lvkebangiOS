//
//  OutWebViewController.h
//  YT_business
//
//  Created by chun.chen on 15/6/4.
//  Copyright (c) 2015年 chun.chen. All rights reserved.
//
#define NavBarFrame self.navigationController.navigationBar.frame
#import <UIKit/UIKit.h>
#import "WFWebView.h"
#import "XHYScrollingNavBarViewController.h"
//导入头文件
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>
//tianbai对象调用的JavaScript方法，必须声明！！！
- (void)call;
- (void)showReport;
- (void)getCall:(NSString *)callString;
- (void)showImg:(NSString *)showImgString;
- (void)showQuanList:(NSString *)showCirCleId; //圈子详情的头部点击
- (void)showUserDetail:(NSInteger )uid;
- (void)invitedQuanDetail:(NSString *)CircleDetailId;// 邀请好友
- (void)showQuanWriteComment:(NSInteger )WriteCommentId; // 有空沙发的点击
- (void)shareDetailChuhe:(NSString *)DetailChuheId;
- (void)showActiveApply:(NSInteger )ActiveApply;
- (void)showActiveDetail:(NSString *)ActiveDetailId;// 活动详情页面
- (void)shareDetailActive:(NSString *)ActiveDetailId;// 活动报名成功
- (void)showCommentQuanDetail:(NSString *)QuanDetailId; //跳转圈子评论详情页 评论一级
- (void)showArticleWriteComment:(NSString *)ArticleDetailId;// 文章详情
- (void)initErrorContet;
- (void)ShowErrorBack;
- (void)showArticleCommentDetail:(NSString *)ArticleCommentDetailId;// 跳转专栏评论详情页 评论一级
- (void)showColumnDetail:(NSString *)ColumnDetailId;// H5 专栏点击
- (void)showQuanDetail:(NSString *)QuanDetaillId; // 消息页面圈子的头部
- (void)showArticleDetail:(NSString *)QuanDetaillId; // 消息页面评论二级页面专栏的头部
- (void)h5backData:(NSString *)h5backDataJson;
- (void)showUserDetail2:(NSInteger )uid;

//- (void)h5backData:(NSInteger )uid;
//- (void)InitComment:(NSString *)QuanDetailId;


@end
@interface OutWebViewController : BaseViewController<UIWebViewDelegate,JSObjcDelegate>
@property (nonatomic, strong) JSContext *jsContext;
@property (strong, nonatomic)  WFWebView *webView;
@property (strong, nonatomic) NSString *urlStr;
@property (strong, nonatomic) NSString *VcType; // 1 圈子 2 专栏 3 星创学堂 4 评论 5 圈子列表 6 锄禾说  7 活动 8交易系统
@property (strong, nonatomic) NSString *rightButtonType; // 1分享 2 三点 3无
@property (strong, nonatomic) NSString *sendMessageType; // 1有收藏分享评论 2只有关注分享 3发送
@property (strong, nonatomic) NSString *circleId;// 圈子id
@property (strong, nonatomic) NSString *circleDetailId;// 圈子详情id
@property (strong, nonatomic) NSString *mytitle;
@property (strong, nonatomic) NSString *describle;
@property (strong, nonatomic) NSString *userAvatar;
@property (strong, nonatomic) NSString *htmlStr;
@property (strong, nonatomic) NSString * objectId;// 圈子详情Id
@property (strong, nonatomic) NSString * isAttention;// 1是未关注 0是关注
@property (strong, nonatomic) NSString *replyNum;// 评论数
@property (strong, nonatomic) NSString *couAvatar; // 专栏头像
@property (strong, nonatomic) NSString *cover;

@property (strong, nonatomic) NSString *shareUrlStr;
@property (strong, nonatomic) NSString *groupAvatar;// 分享头像
@property (strong, nonatomic) NSString *shareCover;// 分享字典里的图片
@property (strong, nonatomic) NSString *shareColumnAvatar;// 分享字典里专栏的头像
@property (strong, nonatomic) NSString *shareImage;// 分享字典里的图片

@property (strong, nonatomic) NSString *shareType;
@property (strong, nonatomic) NSString *fromLable;
@property (strong, nonatomic) NSString *QuanDetailId;
@property (strong, nonatomic) NSString *commendVcType;// 评论页面

@property (strong, nonatomic) NSString *featureId;// 专栏作者的Id
@property (strong, nonatomic) NSString *commentType;// 圈子的二级评论页面0  专栏详情的二级评论1
@property (strong, nonatomic) NSString *isCollect;// 0已收藏1未收藏
@property (weak, nonatomic) UIView *scrollView;
@property (retain, nonatomic)UIPanGestureRecognizer *panGesture;
@property (retain, nonatomic)NSString *groupName;
//@property (retain, nonatomic)UIView *overLay;
@property (strong, nonatomic) NSString *squareType;//广场评论的入口
@property (strong, nonatomic) NSString *chatResportType;//评论举报的入口
@property (strong, nonatomic) NSString *pushType;
@property (strong, nonatomic) NSString *toUserId;// 传过来的userid

@property (assign, nonatomic)BOOL isHidden;

- (id)initWithReqUrl:(NSURL *)reqUrlString;
@end
