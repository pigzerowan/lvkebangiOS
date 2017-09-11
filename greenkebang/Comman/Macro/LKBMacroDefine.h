/////////////////////
//     全局定义     //
/////////////////////

// UUID
#define YT_KEY_IDIC            @"com.youqu.idic"
#define YT_KEY_UUID            @"com.youqu.uuid"

#define YT_WSSERVICE_KEY @" "


// 尺寸
#define kStatusHeight  [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavigationFullHeight  64
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone7 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone7p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#define iPhone5_Before (([[UIScreen mainScreen] currentMode].size.height <= 1136) ? YES : NO)
#define iPhone6p_Later (([[UIScreen mainScreen] currentMode].size.height >= 2208) ? YES : NO)
#define iPhoneMultiple kDeviceWidth/320
#define kDeviceCurrentWidth [[UIScreen mainScreen] currentMode].size.width

#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#define CCImageNamed(name) ([UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]])

#define ArchiveFilePath(fileName) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:fileName]

// 颜色
#define CCCUIColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define CCColorFromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
#define CCColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define YQDefaultBuleColor CCCUIColorFromHex(0x0099ff)

// 图片
#define YQNavbackbarImage               [UIImage imageNamed:@"yq_navigation_background_01.png"]
#define YQlightGrayLineImage            [UIImage imageNamed:@"yq_grayline.png"]
#define YQlightGrayTopLineImage         [UIImage imageNamed:@"yq_grayline_03.png"]
#define YQlightGrayBottomLineImage      [UIImage imageNamed:@"yq_grayline_02.png"]

#define YQUserPlaceImage               [UIImage imageNamed:@"default.jpg"]
#define YQNormalPlaceImage             [UIImage imageNamed:@"defualt_normal.png"]
#define YQNoDynamicNormalPlaceImage             [UIImage imageNamed:@"noDynamic_normal.png"]
#define YQNormalBackGroundPlaceImage             [UIImage imageNamed:@"background_normal.png"]
#define YQNormalUserSharePlaceImage             [UIImage imageNamed:@"link_default_graph.png"]

#define LKBSecruitPlaceImage             [UIImage imageNamed:@"defualt_normal.png"]
#define LKBUserInvitePlaceImage             [UIImage imageNamed:@"userAvatar.png"]

// Tools
#define wSelf(wSelf)  __weak typeof(self) wSelf = self
#define NOTIFICENTER  [NSNotificationCenter defaultCenter]
#define USERDEFAULT   [NSUserDefaults standardUserDefaults]

// Keys
#define loadingKey      @"loadingKey"
#define postingDataKey    @"postingDataKey"
#define isLoadingMoreKey  @"isLoadingMoreKey"

// Notification
static NSString *const kUserLoginSuccessNotification        = @"userLoginSuccessNotification";
static NSString *const kUserLogOutNotification              = @"userLogOutNotification";

// 储存文件名
// 文件路径
static NSString *const iYQDataFileName                = @"YQData";
static NSString *const iYQImageFileName                = @"YQImage";

// 设置
static const CGFloat iYQUserVersion                   = 1.0;
static NSString *const iYQUserVersionKey              =@"userAppVersion";
static NSString *const iYQUserDataKey                 = @"yquserDataKey";
static NSString *const iYQUserTokenKey                 = @"yqLoginToken";
static NSString *const iYQUsercookiesKey              = @"usercookiesKey";
static NSString *const iYQUserCityKey                 = @"userCity";
static NSString *const iYQUserIdKey                   = @"UserIdKey";
static NSString *const iYQUserAvatarKey               = @"UserAvatarKey";
static NSString *const iYQUserImageKey                = @"UserImageKey";
static NSString *const iYQUserMobileKey               = @"UserMobileKey";
static NSString *const iYQUserNameKey                 = @"UserNameKey";
static NSString *const iYQUserUpdateDateKey           = @"UserUpdateDateKey";

