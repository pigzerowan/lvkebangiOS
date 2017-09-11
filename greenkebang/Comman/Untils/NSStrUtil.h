#import <Foundation/Foundation.h>


@interface NSStrUtil : NSObject

// 是否为空
+ (BOOL)isEmptyOrNull:(NSString*)string;
// 不为空
+ (BOOL)notEmptyOrNull:(NSString*)string;
// 是否手机号
+ (BOOL)isValidateMobile:(NSString*)mobile;
+ (BOOL)isMobileNumber:(NSString*)mobileNum;
// 是否包含空格
+ (BOOL)isContainSpace:(NSString*)string;

// node 格式
+ (NSString*)makeNode:(NSString*)str;
// 返回非空数据
+ (NSString*)makeBlank:(NSString*)str;
// 整理
+ (NSString*)trimString:(NSString*)str;
// 时间戳
+ (NSString*)generateTimestamp;
// 签名
+ (NSString*)signString:(NSArray*)array;
// 秒转时分秒
+ (NSString*)timeformatFromSeconds:(NSInteger)seconds;
// 数字转换
+ (NSString*)stringFromIntegerValue:(NSInteger)integerValue;
// 文字高度
+ (CGFloat)stringHeightWithString:(NSString*)string stringFont:(UIFont*)font textWidth:(CGFloat)width;
// 文字宽度
+ (CGFloat)stringWidthWithString:(NSString*)string stringFont:(UIFont*)font;
// 字数
+ (NSInteger)wordCount:(NSString*)s;
// 转化json
+ (id)jsonObjecyWithString:(NSString*)str;

// 转化数字 3为单位添加,
+ (NSString*)stringWithNumberDecimalFormat:(NSNumber*)number;

// 判断是否为整形
+ (BOOL)isPureInt:(NSString*)string;
// 判断是否为浮点形
+ (BOOL)isPureFloat:(NSString*)string;



- (NSString *)gtm_stringByEscapingForHTML;

/// Get a string where internal characters that need escaping for HTML are escaped
//
///  For example, '&' become '&amp;'
///  All non-mapped characters (unicode that don't have a &keyword; mapping)
///  will be converted to the appropriate &#xxx; value. If your webpage is
///  unicode encoded (UTF16 or UTF8) use stringByEscapingHTML instead as it is
///  faster, and produces less bloated and more readable HTML (as long as you
///  are using a unicode compliant HTML reader).
///
/// For obvious reasons this call is only safe once.
//
//  Returns:
//    Autoreleased NSString
//
- (NSString *)gtm_stringByEscapingForAsciiHTML;

/// Get a string where internal characters that are escaped for HTML are unescaped
//
///  For example, '&amp;' becomes '&'
///  Handles &#32; and &#x32; cases as well
///
//  Returns:
//    Autoreleased NSString
//
- (NSString *)gtm_stringByUnescapingFromHTML;

@end

@interface NSString (ImageUrl)
- (NSURL *)lkbImageUrl0;
- (NSURL*)lkbImageUrl;
- (NSURL *)lkbImageUrl2;
- (NSURL *)lkbImageUrl3;
- (NSURL *)lkbImageUrl4;
- (NSURL *)lkbImageUrl5;
- (NSURL *)lkbImageUrl6;
- (NSURL *)lkbImageUrl7;
- (NSURL *)lkbImageUrl8;
- (NSURL *)lkbImageUrlSTARCover;
- (NSURL *)lkbImageUrlActivityCover;
- (NSURL *)lkbImageUrlChuHeShuoCover;
- (NSURL *)lkbImageUrlAllCover;
@end

@interface NSString (MyExtensions)
- (NSString*)md5;
- (NSString*)GetMD5;
- (NSString*) sha1;
@end

@interface NSData (MyExtensions)
- (NSString*)md5;
@end
