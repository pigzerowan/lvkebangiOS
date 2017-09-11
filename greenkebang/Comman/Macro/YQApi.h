
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG
//佛曰：
//                   写字楼里写字间,写字间里程序员;
//                   程序人员写程序,又拿程序换酒钱;
//                   酒醒只在网上坐,酒醉还来网下眠;
//                   酒醉酒醒日复日,网上网下年复年;
//                   但愿老死电脑间,不愿鞠躬老板前;
//                   奔驰宝马贵者趣,公交自行程序员;
//                   别人笑我忒疯癫,我笑自己命太贱;
//                   不见满街漂亮妹,哪个归得程序员.




#import <Foundation/Foundation.h>


//*< 服务器IP 正式
static NSString* const LKB_WSSERVICE_HTTP = @"http://112.124.96.181:8099/mobile/app";
// 测试
//static NSString* const LKB_WSSERVICE_HTTP = @"http://192.168.1.199:8082/app";

/**< 服务器IP*/
//static NSString* const LKB_WSSERVICE_HTTP = @"http://192.168.1.52:8080/app";
//static NSString* const LKB_WSSERVICE_HTTP = @"http://192.168.1.52:8080/app/";

//*< 测试
/**< 图片ip*/
static NSString* const LKB_IMAGEBASE_HTTP = @"http://www.lvkebang.cn";
/**< 专栏文章ip2*/
static NSString* const LKB_COUMN_HTTP = @"http://www.lvkebang.cn";


/**< 专栏头像ip2*/
//static NSString* const LKB_COUMN_HEADER_HTTP = @"http:// www.greentechplace.com /static/insight_feature/";
static NSString* const LKB_COUMN_HEADER_HTTP = @"http://imagetest.lvkebang.cn/static/insight_feature/";


/**< 星创学堂ip2*/
//static NSString* const LKB_COUMN_HEADER_HTTP = @"http:// www.greentechplace.com /static/insight_feature/";
static NSString* const LKB_STAR_HEADER_HTTP = @"http://imagetest.lvkebang.cn/static/star_school/";

/**< 活动列表ip2*/
static NSString* const LKB_Activity_HTTP = @"http://imagetest.lvkebang.cn/static/activity/";

/**< 圈子列表ip2*/
static NSString* const LKB_Activity_All_HTTP = @"http://imagetest.lvkebang.cn/static/group_topic/";


/**< 滚动图片ip6*/
static NSString* const LKB_COVER_iMAGE_HTTP = @"http://imagetest.lvkebang.cn/static/powerpoint_cover/";
///**< 用户头像正式ip3*/
//static NSString* const LKB_USERHEADER_HTTP = @"http:// www.greentechplace.com /static/user_header/";



//*< 用户头像ip3
static NSString* const LKB_USERHEADER_HTTP = @"http://imagetest.lvkebang.cn/static/user_header/";

/**< 群组头像ip4*/
static NSString* const LKB_GROUPHEADER_HTTP = @"http://imagetest.lvkebang.cn/static/group_header/";
/**< 专栏文章ip5*/
static NSString* const LKB_COLMN_HTTP = @"http://www.lvkebang.cn";
/**< 锄禾说ip5*/
static NSString* const LKB_ChuHeShuo_HTTP = @"http://imagetest.lvkebang.cn/static/hoe_cover/";


// 用户模块
/**<1.1 手机验证码*/
//static NSString* const LKB_TelephoneSms_Url = @"reg/verify";
//*********************************************/**< 手机号发送验证码*/
static NSString* const LKB_TelephoneSms_Url = @"common/validate";
//*********************************************/**<手机号验证验证码*/
static NSString* const LKB_Verify_Url = @"common/validate/verify";

//商城验证码
static NSString* const LKB_APPlyTelephoneSms_Url = @"common/sendCode";
//商城更新
static NSString* const LKB_APPlyMallUpdate_Url = @"usercenter/update/mobilepassword";



//*********************************************/**< 个推绑定*/
static NSString* const LKB_common_addUid_Url = @"common/addUid";
//*********************************************/**< 交易验证*/
static NSString* const LKB_jiaoyi_Url = @"http://jiaoyi.lvkebang.cn/login/Appcheckuser.htm";

static NSString* const LKB_Mall_lOGIN_Url = @"http://mall.lvkebang.cn/login/app/login.jhtml";


//*********************************************/**< 交易系统提交审核*/
static NSString* const LKB_jiaoyiShenhe_Url = @"usercenter/userTrade/add";

//*********************************************/**< 交易系统验证*/
static NSString* const LKB_jiaoyiValidate_Url = @"usercenter/userTrade/validate";

//*********************************************/**< 登陆版本记录*/
static NSString* const LKB_Login_ClientVersion_Url = @"login/clientVersion";



/**<1.2 手机号注册*/
//static NSString* const LKB_Signup_Url = @"reg";
//*********************************************/**< 手机号注册*/
static NSString* const LKB_Signup_Url = @"register";
//*********************************************/**< 手机号登陆*/
static NSString* const LKB_Login_Url = @"login";
//*********************************************/**<用户信息完善*/
static NSString* const LKB_Update_Url = @"/usercenter/update/information";

//*********************************************/**<找回密码发送验证码*/
static NSString* const LKB_SendCheck_Url = @"common/sendcheckCode";
//*********************************************/**<找回密码发送验证码*/
static NSString* const LKB_CheckCheck_Url = @"common/validate/verify";

//*********************************************/**<找回密码*/
//static NSString* const LKB_Findpassword_Url = @"usercenter/password/reset";

/**<1.4 密码重置*/
//static NSString* const LKB_ResetPassWord_Url = @"password/reset";
//*********************************************/**<找回密码*/
static NSString* const LKB_Findpassword_Url = @"usercenter/password/reset";
//*********************************************/**<修改密码*/
static NSString* const LKB_ResetPassWord_Url = @"usercenter/update/password";

/**<1.4 获取通讯录*/
static NSString* const LKB_Attention_All_Url = @"attention/me-all";
/**<1.5 密码重置获取验证码*/
static NSString* const LKB_Recover_Url = @"recover";
/**<1.6 他的话题*/
static NSString* const LKB_His_Topic_Url= @"group/topic-my";
/**<1.7 他的群组*/
static NSString* const LKB_His_Group_Url = @"group/group-my";
/**<1.8 他的见解*/
static NSString* const LKB_His_Insight_Url = @"insight/my";
/**<1.9 他的问答*/
static NSString* const LKB_His_Question_Url = @"question/my";

/**<1.9 他的问答*/
static NSString* const LKB_Group_Users = @"group/group-users";


/**<1.10 第三方登陆*/
//static NSString* const LKB_Social_Regist_Url = @"reg/social";
/******************************************************<1.10 第三方登陆*/
static NSString* const LKB_Social_Login_Url = @"login/social";
static NSString* const LKB_Browsing_Login_Url = @"common/browsing";



/******************************************************<1.10 第三方注册*/
static NSString* const LKB_Social_Regist_Url = @"reg/social";

/******************************************************<1.10 推荐好友*/
//static NSString* const LKB_Recommend_Friend_Url = @"attention/recommendUser";
static NSString* const LKB_Recommend_Friend_Url = @"find/recommend";

/******************************************************<1.10 关注推荐好友*/
static NSString* const LKB_Attention_Friend_Url = @"find/recommend/attention";

//static NSString* const LKB_Social_Login_Url = @"login/social";
 
//********************************************************/**<所有动态*/
static NSString* const LKB_All_dynamic_Url = @"dynamic/all";

//********************************************************/**<发布技术答疑*/
static NSString* const LKB_Publish_Question_Url = @"/question/pub";

/**<1.11 他的详情*/
static NSString* const LKB_User_Center_Url = @"center/user";
/**<1.12 他的关注对方*/
static NSString* const LKB_Attention_New_Url = @"attention/new";
/**<1.12.1 他的取消关注*/
static NSString* const LKB_Attention_Un_Url = @"attention/un";

//********************************************************/**<个人用户信息*/
static NSString* const LKB_User_Infor_Url = @"usercenter/information";

//********************************************************/**<用户信息下的动态*/
static NSString* const LKB_UserInfor_dynamic_Url = @"dynamic/personal";

/**<1.13 我的群组*/ // 有分页
static NSString* const LKB_MyGroup_List_Url = @"group/my-group";

/**<1.13 我的群组*/ // 有分页
static NSString* const LKB_ALLGroup_List_Url = @"group/all-group";

// 没分页
static NSString* const LKB_Group_List_Url = @"group/user-group";

/**************************************************************<3.13 群组信息*/
static NSString* const LKB_Group_Detaill_Url = @"group/group-info";

/**************************************************************<3.13 更新群组信息*/
static NSString* const LKB_Group_Update_Url = @"/group/group-update";

/**************************************************************<3.13 我的话题*/
static NSString* const LKB_Topic_Url = @"group/user-topic";
/**************************************************************<3.13 我的答疑*/
static NSString* const LKB_Question_Url = @"question/question-list";

/**************************************************************<3.13 我的活动*/
static NSString* const LKB_Activity_Url = @"activity/list/user";

/**************************************************************<3.13 加群*/
static NSString* const LKB_Group_Join_Url = @"group/apply-join";

/**************************************************************<3.13 退群*/
static NSString* const LKB_Group_Logout_Url = @"group/exit-group";

/**************************************************************<3.13 申请加群*/
static NSString* const LKB_Group_Applyjoin_Url = @"group/apply-join";

/**************************************************************<3.13 同意加群*/
static NSString* const LKB_Group_Pass_Url = @"group/pass-join";

/**************************************************************<3.13 拒绝加群*/
static NSString* const LKB_Group_Refuse_Url = @"group/refuse-join";


/**************************************************************<3.13 群成员信息*/
static NSString* const LKB_Group_UsersInfor_Url = @"group/group-users";

//群所有用户
static NSString* const LKB_Group_ALLUsers_Url = @"group/all-users";

//删除成员
static NSString* const LKB_Group_DLEATEUser_Url = @"agriculture/member/remove";



/***************************************<1.13.1 创建专栏*/
static NSString* const LKB_Column_Create_Url = @"/insight/pub-feature";


/**<1.13.1 创建群组*/
static NSString* const LKB_Group_Create_Url = @"/group/group-create";

/**<1.14 用户昵称修改*/
static NSString* const LKB_Center_Usernick_Url = @"center/usernick";
/**<1.14 用户头像修改*/
static NSString* const LKB_Center_Useravatar_Url = @"/center/useravatar";
/**<1.15 个人简介*/
static NSString* const LKB_Center_Setdesc_Url = @"center/setdesc";



/**<1.16 获取粉丝*/
static NSString* const LKB_Attention_Fans_Url = @"attention/fans";

/*********************************************************<1.16 获取粉丝*/
static NSString* const LKB_Attention_All_Fans_Url = @"usercenter/fans-all";
/**<1.17 获取用户关注的人*/
static NSString* const LKB_Attention_Url = @"attention/me";

/***************************************************<1.17 获取用户关注的人*/
static NSString* const LKB_Attention_Users_Url = @"usercenter/attention-users";

/***************************************************<1.17 关注单个好友*/
static NSString* const LKB_Attention_User_Url = @"attention/user-attention";
/***************************************************<1.17 取消关注好友*/
static NSString* const LKB_UnAttention_User_Url = @"attention/cancel-attention";


/**<1.18 搜索人*/
static NSString* const LKB_Search_People_Url = @"center/find-name";
/**<1.19 搜索群组*/
static NSString* const LKB_Search_Group_Url = @"group/list-name";
/*************************************************************************<1.20 发布话题*/
static NSString* const LKB_Group_Topic_New_Url = @"/group/pub-topic";
/**<1.21 获取地区*/
static NSString* const LKB_Center_Arealist_Url = @"center/arealist";
/**<1.22 修改地区*/
static NSString* const LKB_Center_Setarea_Url = @"center/setarea";
/**<1.23 修改行业*/
static NSString* const LKB_Center_Industrylist_Url = @"center/industrylist";
/**<1.23 圈子发布*/

static NSString* const LKB_Circle_Publish_Url = @"agriculture/content/pub";
// 消息模块
/**<3.0.1 评论消息接口*/
static NSString* const LKB_ALL_FIND = @"find/list-find";

/**<3.0.2 消息评论接口*/
static NSString* const LKB_Get_Comment = @"record/getComment";
/**<3.0.3 消息 动态通知接口*/
static NSString* const LKB_Dynamic_Notice = @"record/dynamic/notice";
/**<3.0.4 消息动态通知 邀请回答接口*/
//static NSString* const LKB_Notice_Question = @"record/notice/question";
static NSString* const LKB_Notice_Question = @"record/invite/join";
/**<3.0.5 消息、 邀请回答 所有邀请者接口*/
static NSString* const LKB_Invite_User = @"record/join/user";
/**<3.0.6 消息、 邀请回答 邀请回答接口*/
static NSString* const LKB_Invite_answer = @"agriculture/content/invite/join";
/**<3.0.7 消息、 邀请回答 邀请回答接口*/
static NSString* const LKB_System_Informs = @"usercenter/mess";
/**<3.0.8 消息、 邀请回答 邀请回答接口*/
static NSString* const LKB_System_Informs_Clear = @"usercenter/mess/clear";


// 发现模块

/**<2.0.1 发现接口*/


/**<2.0.3 检测圈子*/
static NSString* const LKB_CREAT_CIRCLE_COVER = @"agriculture/groupName/validate";

/**<2.0.3 创建圈子*/
static NSString* const LKB_CREAT_CIRCLE_LAST_COVER = @"agriculture/create";

/**<2.0.2 发现滚动图*/
static NSString* const LKB_ALL_FIND_COVER = @"find/system/cover";

/**<2.1 发现人*/
static NSString* const LKB_FIND_PEOPLE_URL = @"center/find";
/**<2.2 发现banner*/
static NSString* const LKB_Activity_List_URL = @"activity/list";
/**<2.2 发现群组*/
static NSString* const LKB_FIND_Group_List_Url = @"group/list-find";
/**<2.3 发现话题*/
static NSString* const LKB_FIND_Topic_List_Url = @"group/topic-list-find";
/**<2.4 发现见解*/
static NSString* const LKB_FIND_Insight_List_Url = @"insight/list-find";
/**<2.5 发现问题*/
static NSString* const LKB_FIND_Question_List_Url = @"question/list-find";
/**<2.6 创建群组*/
static NSString* const LKB_Group_New_Url = @"/group/new";
/**<2.7 群组信息*/
static NSString* const LKB_Group_Groupbyid_Url = @"group/groupbyid";

/**<2.7.1 加群审核*/
static NSString* const LKB_Group_isApply_Url = @"group/isApply";

/**<2.8 群组信息-人*/
static NSString* const LKB_Group_Users_Url = @"group/users";
/**<2.9 加入群组*/
static NSString* const LKB_Group_Jion_Url = @"group/join";
/**<2.10 退出群组*/
static NSString* const LKB_Group_EXSIT_Url = @"group/del-user";
/**<2.11 群组话题*/
//static NSString* const LKB_Group_Topic_Url = @"group/topic-list";
/****************************************************<2.11 群组话题*/
static NSString* const LKB_Group_Topic_Url = @"group/group-topics";
///**<2.111 圈子内容*/
static NSString* const LKB_Circle_Topic_Url = @"agriculture/content/list";
///**<2.112 圈子资料*/
static NSString* const LKB_Circle_Info_Url = @"agriculture/content/info";

///**<2.113 星创学堂*/
static NSString* const LKB_Star_School_Url = @"starSchool/course/list";



/**<2.13 群组问答*/
static NSString* const LKB_Group_QA_Url = @"question/list";

//********************************************************/**<发现搜索*/
static NSString* const LKB_Find_Search_Url = @"find/new/search";
/**<2.14 锄禾说列表*/
static NSString* const LKB_Discover_Hoe_List_Url = @"hoe/content/list";
/**<2.15 活动列表*/
static NSString* const LKB_Discover_Activity_List_Url = @"activity/list";

/**<2.16 文章 活动 H5的分享*/
static NSString* const LKB_Agriculture_sharepub_Url = @"agriculture/content/sharepub";

///**<2.17 名家专栏*/
static NSString* const LKB_Find_Features_Url = @"find/features";




// 动态模块

/**<3.0.1 所有不分类动态*/



static NSString* const LKB_ALL_allDynamics = @"dynamic/allDynamics";
static NSString* const LKB_ALL_DYNAMIC = @"dynamic/agriculture";
static NSString* const LKB_ALL_DYNAMIC_Insight = @"dynamic/insight";
static NSString* const LKB_ALL_DYNAMIC_Question = @"dynamic/question";
static NSString* const LKB_ALL_DYNAMIC_Topic = @"dynamic/topic";
/**<3.1 我关注的人的话题*/
static NSString* const LKB_TOPIC_ATS = @"group/topic-ats";
/**<3.2 技术答疑*/
static NSString* const LKB_QUESTION_DYNAMIC = @"question/dynamic";
/**<3.3 行业见解*/
static NSString* const LKB_INSIGHT_DYNAMIC = @"insight/dynamic";

/**<3.4 回复详情*/
static NSString* const LKB_Reply_Detail_Url = @"group/list-reply";

/**<3.5 回复消息*/
static NSString* const LKB_Topic_Reply_Url = @"group/topic-reply";
/**<3.5.1 回复疑难问题*/
//static NSString* const LKB_Question_Reply_Url = @"question/reply";
/**********************************************************<3.6 我的关注*/
static NSString* const LKB_Attention_Contents_Url = @"attention/contentsList";

/**********************************************************<3.6 我的关注*/
static NSString* const LKB_All_Artic_Contents_Url = @"insight/feature/list";

/**********************************************************<3.6 删除话题*/
static NSString* const LKB_Delete_Topic_Url = @"/group/deltopic";



/**********************************************************<3.6 见解详情*/
static NSString* const LKB_Insight_Detail_Url = @"insight/insight-info";
/**********************************************************<3.6 专栏分享数*/
static NSString* const LKB_Share_Num_Url = @"share/addNum";
/**********************************************************<3.6 内容点赞*/

static NSString* const LKB_Common_Star_Url = @"common/star";
/**********************************************************<3.6 内容取消点赞*/

static NSString* const LKB_Common_Cancel_Star_Url = @"common/cancelStar";

static NSString* const LKB_Common_Collection_Url = @"insight/collection";
static NSString* const LKB_Common_Cancel_Collection_Url = @"insight/cancel-collection";
///**<3.6 见解详情*/
//static NSString* const LKB_Insight_Detail_Url = @"insight/detail";

/**<3.7 疑难详情*/
static NSString* const LKB_Question_Detail_Url = @"question/question-info";
/***************************************************<3.8 关注话题*/
static NSString* const LKB_Topic_Attention_Url = @"group/topic-attention";
/***************************************************<3.8 取消关注话题*/
static NSString* const LKB_Topic_UnAttention_Url = @"group/cancel-attention";

/***************************************************<3.8 关注疑难*/
static NSString* const LKB_Question_Attention_Url = @"question/attention-question";
/***************************************************<3.8 取消关注话题*/
static NSString* const LKB_Question_UnAttention_Url = @"question/cancel-attention";



/**<3.8 话题详情*/
static NSString* const LKB_Topic_Detail_Url = @"group/topic-info";
/**<3.8 回复疑难详情*/
static NSString* const LKB_Question_reply_Url = @"question/answer";
/**<3.9 回复疑难详情*/
static NSString* const LKB_Question_reply_List_Url = @"question/question-answers";
/**<3.10 回复见解*/
static NSString* const LKB_Insight_Reply_Url = @"insight/insight-reply";
/**<3.11 回复见解列表*/
static NSString* const LKB_Insight_Replies_Url = @"insight/find-reply";

/**<3.12 我的专栏*/
static NSString* const LKB_Insight_features_Url = @"insight/user/feature";
/**<3.13 查询专栏信息*/
static NSString* const LKB_ColumnInfo_Url = @"insight/feature";

/**<3.14 专栏列表*/
static NSString* const LKB_ColumnInfo_List_Url = @"insight/find-insights";

/**<3.15 关注专栏*/
static NSString* const LKB_ColumnInfo_Attention_Url = @"insight/attention";
/**<3.15 取消关注专栏*/
static NSString* const LKB_ColumnInfo_Cancel_Attention_Url = @"insight/cancel-attention";

/**<3.16 更新专栏*/
static NSString* const LKB_ColumnInfo_Update_Url = @"/insight/update-feature";
/******************************************<3.16收藏的所有专栏*/
static NSString* const LKB_ColumnInfo_Collection_Url = @"insight/list-collection";
static NSString* const LKB_Report_Content_Url = @"report/content";




///************************************************************<3.16 分享专栏到群组*/
//static NSString* const LKB_ShareColumn_ToGroup_Url = @"share/insight-group";
/************************************************************<3.16 分享技术答疑到群组*/
static NSString* const LKB_ShareQuestion_ToGroup_Url = @"share/question-group";
/************************************************************<3.16 分享技术答疑到好友*/
static NSString* const LKB_ShareQuestion_ToUser_Url = @"share/question-user";

/************************************************************<3.16 分享专栏到群组*/
static NSString* const LKB_ShareColumn_ToGroup_Url = @"share/insight-group";
/************************************************************<3.16 分享专栏到好友*/
static NSString* const LKB_ShareColumn_ToUser_Url = @"share/insight-user";


/************************************************************<3.16 分享群组话题到群组*/
static NSString* const LKB_ShareTopic_ToGroup_Url = @"share/topic-group";
/************************************************************<3.16 分享群组话题到好友*/
static NSString* const LKB_ShareTopic_ToUser_Url = @"share/topic-user";


/************************************************************<3.16 分享用户名片到群组*/
static NSString* const LKB_ShareCard_ToGroup_Url = @"share/card-group";
/************************************************************<3.16 分享用户名片到好友*/
static NSString* const LKB_ShareCard_ToUser_Url = @"share/card-user";

//4......
/************************************************************<个人中心用户信息*/
static NSString* const LKB_Usercenterpersonal_Url = @"usercenter/personal";








@interface YQApi : NSObject


+ (NSString*)loginCookieName;
// 保存某个urlcookie
+ (void)saveCookiesWithUrl:(NSString*)url;
// 获取cookie
+ (void)setupCookies;
// 指定删除登录cookie
+ (void)deleteLoginCookie;
// 指定删除某个cookie
+ (void)deleteCookieWithKey:(NSString*)key;
// 删除所有cookie
+ (void)deleteAllCookieWithKey;

@end
