
// 友盟key
static NSString* const YQ_UM_Appkey = @"5565833b67e58eca57002384";
static NSString* const YQ_APP_URL = @"https://www.baidu.com/";

// 微信
static NSString* const YQ_WeiXin_APPID = @"wx7252377e7e74e101";
static NSString* const YQ_WeiXin_Secret = @"b9f623996c2b2d4ebfc6c3c8a181eb64";

// 新浪微博
static NSString* const YQ_Sina_APPID = @"1760423286";
static NSString* const YQ_Sina_Secret = @"255d56ad8dee167185f0859a1c61d4c2";



#pragma mark - 登录类型（【手机号码】【QQ】【微信】【微博】）
typedef NS_ENUM(NSInteger, LoginType) {
    LKBLoginType_Phone          = 0,
    LKBLoginType_QQ             = 1,
    LKBLoginType_Wechat         = 2,
    LKBLoginType_Sina           = 3,
};

#pragma mark - 缓存文件夹
//extern NSString * const kCache_Folder;

#define kCache_Folder @"kCache_Folder"
#define kNoContentMSG @"暂时没有数据!去发现更多数据吧"
/////////////////////
//     第三方SDK定义 //
/////////////////////
//登陆成功失败的通知名



#define LKBWEBOLOGINCALLBACK_Network @"http://sns.whalecloud.com/sina2/callback"
////登陆成功失败的通知名
//NSString * const kThirdLogInSuccessNoti = @"thirdLogInSucccessNotif";
//NSString * const kThirdLogInFailedNoti = @"thirdLogInFailedNotif";
#define LKBLogin_Failed_Network @"网络错误导致登录失败!"
#define LKBLogin_Failed @"登录失败!"
#define LKBLogin_Canceled @"登录取消!"
#define LKBErr_Msg_key @"ErrorMsg"


#define LKBWeibo_Token_key @"weibo_token"
#define LKBQQ_ShareType_QQ @"qq_friend"
#define LKBQQ_ShareType_Zone @"qq_zone"
//登陆成功失败的通知名
//登陆成功失败的通知名
#define LKBLogin_User_Type_Phone @"1"
#define LKBLogin_User_Type_QQ @"2"
#define LKBLogin_User_Type_Wechat @"3"
#define LKBLogin_User_Type_Weibo @"4"
//登陆成功失败的通知名
#define kThirdLogInFailedNoti @"thirdLogInFailedNotif"
#define kThirdLogInSuccessNoti @"thirdLogInSucccessNotif"

// 登录用户的数据的总Key
#define kLogin_UserInfo_Dic_Key @"login_user_info_dic"


// 登录用户的数据的各个Key
#define kUser_User_Type_Key @"user_user_type_key"
#define kUser_User_Id_Key @"user_user_id_key"
#define kUser_Login_Id_Key @"user_login_id_key"
#define kUser_Nick_Name_Key @"user_nick_name_key"
#define kUser_Phone_Number_Key @"user_phone_number_key"
#define kUser_Avator_Url_Key @"user_avatorurl_key"
#define kUser_Avator_Data_Key @"user_avator_data_key"
#define kUser_Score_Key @"user_score_key"
#define kUser_Reg_Date_Key @"user_reg_date_key"




// QQ互联

/**
 16进制
 */


static NSString* const LKBKKK_QQ_APPID = @"tencent101229960";
static NSString* const YQ_QQ_APPID = @"101229960";
static NSString* const YQ_QQ_APPKEY = @"814742681973560f9644a29d500df9f2";
// 高德
static NSString* const YQ_Gaodei_APPKEY = @"";

// 百度
static NSString* const YQ_Baidu_APPKEY = @"";
static NSString* const YQ_BaiduMap_AK = @"";

// 默认分享logo
#define YQ_ShareDefaultImage [UIImage imageNamed:@"icon"]