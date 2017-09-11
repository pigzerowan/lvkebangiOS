//
//  LKBNetworkManage.h
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQApi.h"
typedef void(^loadProgress)(float progress);
@interface LKBNetworkManage : NSObject
@property (nonatomic, assign) NSInteger errorCode;





+ (LKBNetworkManage*)sharedMange;







- (void)getInfoDataWithServiceUrl:(NSString*)urlString
                       parameters:(NSDictionary*)parameters
                          success:(void (^)(id responseData))success
                          failure:(void (^)(NSString* errorMessage))failure;

/**
 * post方法, 一般用于向服务器端SAVE数据的接口，适合数据量较大的。
 */
/*
 eg:
 NSDictionary *parameters = @{@"phone":@"xxx"};
 [[YTNetworkMange sharedMange] postResultWithServiceUrl:YT_RegMobile parameters:parameters success:^(id responseData) {
 
 } failure:^(NSString *errorMessage) {
 
 }];
 */
- (void)postResultWithServiceUrl:(NSString*)urlString
                      parameters:(NSDictionary*)parameters
                         success:(void (^)(id parserObject))success
                         failure:(void (^)(NSString* errorMessage))failure;




/*!
 *  POST请求 缓存数据
 *
 *  @param urlStr     url
 *  @param parameters post参数
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
- (void)postRequestCacheURLStr:(NSString *)urlStr
                       withDic:(NSDictionary *)parameters
                       success:(void (^)(id parserObject))success
                       failure:(void (^)(NSString* errorMessage))failure;




/**
 *   用post方法,特别用于单张图片指定文件名上传
 *
 *  @param method       服务器路径
 *  @param parameters   参数
 *  @param image        图片
 *  @param imageName    图片名称
 */
- (void)postResultWithServiceUrl:(NSString *)urlString
                      parameters:(NSDictionary *)parameters
                     singleImage:(UIImage *)image
                       imageName:(NSString *)imageName
                         success:(void (^) (id responseData))success
                         failure:(void (^) (NSString *errorMessage))failure;
/**
 *  上传多张图片
 *
 *  @param images   上传的图片数组
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)postFromWithImages:(NSArray*)images
                   success:(void (^)(id responseData))success
                   failure:(void (^)(NSString* errorMessage))failure;



- (void)postQuestionFromWithPath:(NSString*)urlString
                      WithParams:(NSDictionary*)parameters
                          images:(NSArray*)images
                         success:(void (^)(id responseData))success
                         failure:(void (^)(NSString* errorMessage))failure;


//群组头像上传图片
- (void)postResultWithGroupServiceUrl:(NSString *)urlString
                           parameters:(NSDictionary *)parameters
                          singleImage:(UIImage *)image
                            imageName:(NSString *)imageName
                              success:(void (^) (id responseData))success
                              failure:(void (^) (NSString *errorMessage))failure;


//群组头像
- (void)postResultWithInsigServiceUrl:(NSString *)urlString
                           parameters:(NSDictionary *)parameters
                          singleImage:(UIImage *)image
                            imageName:(NSString *)imageName
                              success:(void (^) (id responseData))success
                              failure:(void (^) (NSString *errorMessage))failure;


// 发布疑难
- (void)postPubQuestionResultWithServiceUrl:(NSString *)urlString
                      parameters:(NSDictionary *)parameters
                     singleImage:(UIImage *)image
                       imageName:(NSString *)imageName
                         success:(void (^) (id responseData))success
                         failure:(void (^) (NSString *errorMessage))failure;

// 发布话题
- (void)postPubTopicResultWithServiceUrl:(NSString *)urlString
                                 parameters:(NSDictionary *)parameters
                                singleImage:(UIImage *)image
                                  imageName:(NSString *)imageName
                                    success:(void (^) (id responseData))success
                                    failure:(void (^) (NSString *errorMessage))failure;


#pragma mark ---
#pragma mark ---   计算一共缓存的数据的大小
+ (NSString *)cacheSize;

#pragma mark ---
#pragma mark ---   清空缓存的数据
+ (void)deleateCache;

/**
 *  获取文件大小
 *
 *  @param path 本地路径
 *
 *  @return 文件大小
 */
+ (unsigned long long)fileSizeForPath:(NSString *)path;

@end
