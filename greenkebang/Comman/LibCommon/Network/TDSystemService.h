//
//  TDSystemService.h
//  Tudur
//
//  Created by WuHai on 15/3/10.
//  Copyright (c) 2015年 LZeal Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QiniuSDK.h>

@interface TDSystemService : NSObject

+ (void)saveIntroShowed;

+ (BOOL)hasIntroShowed;

/**
 *  头像上传图片
 *
 *  @param image    需要上传的image
 *  @param progress 上传进度block
 *  @param success  成功block 返回url地址
 *  @param failure  失败block
 */
// 个人资料图片上传
+ (void)uploadHeaderImage:(UIImage *)image
           progress:(QNUpProgressHandler)progress
            success:(void (^)(NSString *url))success
            failure:(void (^)())failure;


// 创建群组时图片上传
+ (void)uploadGroupHeaderImage:(UIImage *)image
                 progress:(QNUpProgressHandler)progress
                  success:(void (^)(NSString *url))success
                  failure:(void (^)())failure;


// 商城图片上传时
+ (void)uploadShoppingMallImage:(UIImage *)image
           progress:(QNUpProgressHandler)progress
            success:(void (^)(NSString *url))success
            failure:(void (^)())failure;
// 发布时候上传多张图片,按队列依次上传
+ (void)uploadPublishQAImage:(UIImage *)image
           progress:(QNUpProgressHandler)progress
            success:(void (^)(NSString *url))success
            failure:(void (^)())failure;


// 发布时候上传多张图片,按队列依次上传
+ (void)uploadPublishQAImages:(NSArray *)imageArray
            progress:(void (^)(CGFloat))progress
             success:(void (^)(NSArray *))success
             failure:(void (^)())failure;

// 获取七牛上传token
+ (void)getQiniuUploadToken:(void (^)(NSString *token))success failure:(void (^)())failure;

// 强制升级、启动页
+ (void)requestVersionUpdate:(void (^)(NSDictionary *dict))success failure:(void (^)())failure;

@end
