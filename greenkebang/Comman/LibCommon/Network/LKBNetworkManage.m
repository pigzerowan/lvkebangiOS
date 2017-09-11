//
//  LKBNetworkManage.m
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "LKBNetworkManage.h"
#import <AFNetworkActivityIndicatorManager.h>
#import <AFHTTPRequestOperationManager.h>
#include "LKBBaseFactory.h"
#import "LKBLoginModel.h"
#import "FMDB.h"
#import "LxDBAnything.h"


static NSInteger const cacheTime = 0 ;
//  是否需要请求数据的时候显示进度/* 如果需要进度，那么你需要在方法中添加对应的  block  */
static BOOL kRequestProgress = NO;

// 缓存路径  缓存到Caches目录  统一做计算缓存大小，以及删除缓存操作
// NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
#define cachePath  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

// 请求方式
typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet,
    RequestTypePost,
    RequestTypeUpLoad
};


@implementation LKBNetworkManage
+ (LKBNetworkManage*)sharedMange
{
    static LKBNetworkManage* sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[LKBNetworkManage alloc] init];
    });
    return sharedManager;
}

- (void)getInfoDataWithServiceUrl:(NSString*)urlString
                       parameters:(NSDictionary*)parameters
                          success:(void (^)(id responseData))success
                          failure:(void (^)(NSString* errorMessage))failure
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", @"text/json", @"text/html", @"text/plain", nil];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *httpUrl = [NSString stringWithFormat:@"%@%@",LKB_WSSERVICE_HTTP,urlString];
    [manager GET:httpUrl
      parameters:parameters
         success:^(AFHTTPRequestOperation* operation, id responseObject) {
             NSLog(@"---------------------****GET %@ Success****-----------------------", httpUrl);
             //        NSLog(@"Get operation is :%@",operation);
             
             NSInteger responseCode = [responseObject[@"code"] integerValue];
             _errorCode = responseCode;
             if (responseCode == 200) {
                 if (success) {
                     success(responseObject);
                 }
             }
             else {
                 NSLog(@"***********************Get %@ fail = %@ *************************", httpUrl, @(responseCode));
                 NSString* errorStr = responseObject[@"message"];
                 NSLog(@"GET ERROR is :%@", errorStr);
                 if (failure) {
                     failure(errorStr);
                 }
                 NSLog(@"******************************fail END************************************************");
             }
             
         }
         failure:^(AFHTTPRequestOperation* operation, NSError* error) {
             NSLog(@"---------------------****ERROR****-----------------------");
             NSLog(@"operation is :%@", operation);
             NSLog(@"error is :%@", error);
             _errorCode = [error code];
             if (failure) {
                 failure(@"服务连接失败");
             }
             NSLog(@"******************************GET ERROR END************************************************");
         }];
}




#pragma mark -- POST请求 缓存数据
- (void)postRequestCacheURLStr:(NSString *)urlStr
                       withDic:(NSDictionary *)parameters
                       success:(void (^)(id parserObject))success
                       failure:(void (^)(NSString* errorMessage))failure
{
    
    NSString *httpUrl = [NSString stringWithFormat:@"%@/%@",LKB_WSSERVICE_HTTP,urlStr];
    httpUrl = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    if(![self requestBeforeCheckNetWork]){
//        
//        failure(@"没有网络,连接失败");NSLog(@"\n\n---%@----\n\n",@"没有网络呀");
//        return;
//    }
//    else {
    
        
        [self requestWithUrl:httpUrl  parameters:parameters requsetType:RequestTypePost isCache:YES imageKey:nil withData:nil loadProgress:^(float progress) {
            
        } success:^(id parserObject) {
            
            NSLog(@"post responseObject:%@", parserObject);
            
            if (!success) {
                
                return;
            }
            if ([parserObject isKindOfClass:[NSDictionary class]]) {
                LKBBaseModel* model = [LKBBaseFactory modelWithURL:urlStr
                                                      responseJson:parserObject];
                if ([model.success isEqualToString:@"1"]) {
                    
                    NSLog(@"*********************data******************%@",model.msg);
                    
                    success(model);
                }else {
                    NSLog(@"*********************** %@ fail \n %@ *************************", urlStr, model.msg);
                    
                    
                    
                    
                    if ([model.code isEqualToString:@"4001"]||[model.code isEqualToString:@"4004"]) {
                        {
                            if ([model.msg isEqualToString:@"用户不存在"]) {
                                failure(model.msg);
                            }
                            
                            else
                            {
                                success(model);
                            }
                        }
                        
                        
                    }
                    
                    else if ([model.code isEqualToString:@"4000"])
                    {
                        failure(model.msg);
                    }
                    
                    else
                    {
                        
                        success(model);
                        
                    }
                    NSLog(@"******************************fail END************************************************");
                }
                
            }
            else if ([parserObject isKindOfClass:[NSArray class]])
            {
                NSDictionary *mydic  = [NSDictionary dictionaryWithObject:parserObject forKey:@"data"];
                LKBBaseModel* model = [LKBBaseFactory modelWithURL:urlStr
                                                      responseJson:mydic];
                //                     if (model.data) {
                
                NSLog(@"*********************data******************%@",mydic);
                success(model);
                
            }
            
            else {
                
                success(parserObject);
                
                
            }
            
        } failure:^(NSString *errorMessage) {
            
            NSLog(@"=======================%@",errorMessage);
            
            failure(errorMessage);
        }];

//    }
    

    

}


#pragma mark -- 网络请求统一处理
- (void)requestWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameters
           requsetType:(RequestType)requestType
               isCache:(BOOL)isCache
              imageKey:(NSString *)attach
              withData:(NSData *)data
          loadProgress:(loadProgress)loadProgress
               success:(void (^)(id parserObject))success
               failure:(void (^)(NSString* errorMessage))failure{
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]; // ios9
    NSString * cacheUrl = [self urlDictToStringWithUrlStr:[NSString stringWithFormat:@"%@",url] WithDict:parameters];
    
    
    if ([cacheUrl rangeOfString:@"??"].location!=NSNotFound) {
        cacheUrl = [cacheUrl stringByReplacingOccurrencesOfString:@"??" withString:@"?"];
    }
    
    NSLog(@"\n\n-网址--\n\n       %@--->     %@\n\n-网址--\n\n",(requestType ==RequestTypeGet)?@"Get":@"POST",cacheUrl);
    NSData * cacheData;
    if (isCache) {
        cacheData = [self cachedDataWithUrl:cacheUrl];
        if(cacheData.length != 0){
            
            
            [self returnDataWithRequestData:cacheData success:^(id responseData) {
                 success(responseData);
            } failure:^(NSString *errorMessage) {
                 failure(errorMessage);
            }];
            

        }
    }
//    //请求前网络检查
//    if(![self requestBeforeCheckNetWork]){
//        failure(@"大哥，没有网络");NSLog(@"\n\n---%@----\n\n",@"没有网络呀");
//        return;
//    }
    AFHTTPRequestOperationManager *  manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    [manager.requestSerializer setTimeoutInterval:10];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPRequestOperation * op;
    if (requestType == RequestTypeGet) {
        op = [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            
            [self dealwithResponseObject:responseObject cacheUrl:cacheUrl cacheData:cacheData isCache:isCache success:^(id responseData) {
                 success(responseData);
            } failure:^(NSString *errorMessage) {
                failure(errorMessage);
            }];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            //请求前网络检查
            if(![self requestBeforeCheckNetWork]){
                failure(@"没有网络，连接失败");NSLog(@"\n\n---%@----\n\n",@"没有网络呀");
            }
            else {
                
                failure(@"程序媛MM正在努力抢救");

            }

        }];
    }
    if (requestType == RequestTypePost) {
        
        op = [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            [self dealwithResponseObject:responseObject cacheUrl:cacheUrl cacheData:cacheData isCache:isCache success:^(id responseData) {
                success(responseData);
            } failure:^(NSString *errorMessage) {
                failure(errorMessage);
            }];
            

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            //请求前网络检查
            if(![self requestBeforeCheckNetWork]){
                failure(@"没有网络，连接失败");
                NSLog(@"\n\n---%@----\n\n",@"没有网络呀");
            }
            else {
                
                failure(@"程序媛MM正在努力抢救");
                
            }
            
            
        }];
    }
    if (requestType == RequestTypeUpLoad) {
        
        op =  [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            // 给上传的文件命名
            NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
            NSString * fileName =[NSString stringWithFormat:@"%@.png",@(timeInterval)];
            //添加要上传的文件，此处为图片   1.
            //            NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"123.ipa" withExtension:nil];
            //            [formData appendPartWithFileURL:fileURL name:fileName error:NULL];
            //添加图片，并对其进行压缩（0.0为最大压缩率，1.0为最小压缩率）  2.
            [formData appendPartWithFileData:data name:attach fileName:fileName mimeType:@"image/png"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [self dealwithResponseObject:responseObject cacheUrl:cacheUrl cacheData:cacheData isCache:NO success:^(NSDictionary *responseObject) {
                success(responseObject);
            } failure:^(NSString *errorInfo) {
                failure(errorInfo);
            }];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(@"程序媛MM正在努力抢救");
            NSLog(@"上传文件发生错误\n\n    %@   \n\n", error);
        }];
    }
    if (requestType == RequestTypeUpLoad) {
        [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            NSLog(@"上传的进度参数...\n\n上传速度  %lu \n已上传    %lld \n文件大小  %lld\n\n", (unsigned long)bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
            float myProgress = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
            loadProgress(myProgress);
        }];
    }else{
        if (kRequestProgress) {
            [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
                float myProgress = (float)totalBytesRead / (float)totalBytesExpectedToRead;
                loadProgress(myProgress);
                NSLog(@"下载的进度参数...\n\n上传速度  %lu \n已上传    %lld \n文件大小  %lld\n\n", (unsigned long)bytesRead, totalBytesRead, totalBytesExpectedToRead);
            }];
        }
    }
}


#pragma mark -- 统一处理请求到得数据
/*!
 *  @param responseObject 网络请求的数据
 *  @param cacheUrl       缓存的url标识
 *  @param cacheData      缓存的数据
 *  @param isCache        是否需要缓存
 */
- (void)dealwithResponseObject:(NSData *)responseData
                      cacheUrl:(NSString *)cacheUrl
                     cacheData:(NSData *)cacheData
                       isCache:(BOOL)isCache
                       success:(void (^)(id responseData))success
                       failure:(void (^)(NSString* errorMessage))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
    });
    NSString * dataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    dataString = [self deleteSpecialCodeWithStr:dataString];
    NSData *requstData=[dataString dataUsingEncoding:NSUTF8StringEncoding];
    if (isCache) {/**更新缓存数据*/
        [self saveData:requstData url:cacheUrl];
    }
    if (!isCache || ![cacheData isEqual:requstData]) {
        
        
        [self returnDataWithRequestData:requstData success:^(id responseData) {
            success(responseData);
        } failure:^(NSString *errorMessage) {
            failure(errorMessage);
        }];
        
    }
}


#pragma mark --根据返回的数据进行统一的格式处理  ----requestData 网络或者是缓存的数据----
- (void)returnDataWithRequestData:(NSData *)requestData success:(void (^)(id responseData))success
    failure:(void (^)(NSString* errorMessage))failure{

    id myResult = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
    if ([myResult isKindOfClass:[NSDictionary  class]]) {
        NSDictionary *  requestDic = (NSDictionary *)myResult;
        NSString * succ =[NSString stringWithFormat:@"%@", requestDic[@"code"]];
        if ([succ isEqualToString:@"2000"]) {
            success(requestDic);
        }else{
            failure(requestDic[@"msg"]);
        }
    }
}

- (void)postResultWithServiceUrl:(NSString*)urlString
                      parameters:(NSDictionary*)parameters

                         success:(void (^)(id parserObject))success
                         failure:(void (^)(NSString* errorMessage))failure
{
    NSString *httpUrl;
    if ([urlString rangeOfString:@"http://mall.lvkebang.cn"].location!=NSNotFound) {
        httpUrl = [NSString stringWithFormat:@"%@",urlString];
    }
    else
    {
        
        
        httpUrl = [NSString stringWithFormat:@"%@/%@",LKB_WSSERVICE_HTTP,urlString];
    }
    httpUrl = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //请求前网络检查
    if(![self requestBeforeCheckNetWork]){
        failure(@"没有网络，连接失败");NSLog(@"\n\n---%@----\n\n",@"没有网络呀");
    }

    
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFHTTPRequestOperationManager* AFHmanager = [AFHTTPRequestOperationManager manager];
    AFHmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", @"text/json", @"text/html", @"text/plain", nil];
    //    AFHmanager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    AFHmanager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    [AFHmanager.requestSerializer setValue:@"7.0.0 (iPhone;iOS 8.1.1)" forHTTPHeaderField:@"User-Agent"];
    NSLog(@"httpUrl = %@ ",httpUrl);
    NSLog(@"post parameters:%@", parameters);
    
    
    if(![self requestBeforeCheckNetWork]){
        
        failure(@"没有网络，连接失败");NSLog(@"\n\n---%@----\n\n",@"没有网络呀");
        return;
    }
    
    [AFHmanager POST:httpUrl
          parameters:parameters
             success:^(AFHTTPRequestOperation* operation, id responseObject) {
#ifdef DEBUG
                 NSLog(@"post responseObject:%@", responseObject);
#endif
                 if (!success) {
                     return;
                 }
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     LKBBaseModel* model = [LKBBaseFactory modelWithURL:urlString
                                                           responseJson:responseObject];
                     if ([model.success isEqualToString:@"1"]) {
                         
                         //                         NSLog(@"*********************data******************%@",model.data);
                         success(model);
                     }else {
                         NSLog(@"*********************** %@ fail \n %@ *************************", urlString, model.msg);
                         
                         
                         
                         
                         if ([model.code isEqualToString:@"4001"]||[model.code isEqualToString:@"4004"]) {
                             {
                                 if ([model.msg isEqualToString:@"用户不存在"]) {
                                     failure(model.msg);
                                 }
                                 
                                 else
                                 {
                                     success(model);
                                 }
                             }
                             
                             
                         }
                         
                         else if ([model.code isEqualToString:@"4000"])
                         {
                             failure(model.msg);
                         }
                         
                         else
                         {
                             
                             success(model);
                             
                         }
                         NSLog(@"******************************fail END************************************************");
                     }
                     
                 }
                 else if ([responseObject isKindOfClass:[NSArray class]])
                 {
                     NSDictionary *mydic  = [NSDictionary dictionaryWithObject:responseObject forKey:@"data"];
                     LKBBaseModel* model = [LKBBaseFactory modelWithURL:urlString
                                                           responseJson:mydic];
                     //                     if (model.data) {
                     
                     //                         NSLog(@"*********************data******************%@",model.data);
                     success(model);
                     
                 }
                 
                 else {
                     
                     success(responseObject);
                     
                     
                 }
             }
             failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                 NSLog(@"***********************POST error *************************");
                 NSLog(@"POST ERROR:operation :%@", operation);
                 NSLog(@"POST ERROR: :%@", error);
                 _errorCode = [error code];
                 if (failure) {
                     failure(@"连接失败");
                 }
                 NSLog(@"******************************POST ERROR END************************************************");
             }];
}




//群组头像
- (void)postResultWithGroupServiceUrl:(NSString *)urlString
                           parameters:(NSDictionary *)parameters
                          singleImage:(UIImage *)image
                            imageName:(NSString *)imageName
                              success:(void (^) (id responseData))success
                              failure:(void (^) (NSString *errorMessage))failure
{
    NSString *httpUrl = [NSString stringWithFormat:@"%@%@",LKB_WSSERVICE_HTTP,urlString];
    httpUrl = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFHTTPRequestOperationManager* AFHmanager = [AFHTTPRequestOperationManager manager];
    AFHmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", @"text/json", @"text/html", @"text/plain", nil];
    [AFHmanager POST:httpUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (image) {
            NSString *fileName = [NSString stringWithFormat:@"%@.png",imageName];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData :imageData name:@"groupAvatar" fileName:fileName mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation* operation, id responseObject) {
        NSLog(@"post responseObject:%@", responseObject);
        NSInteger responseCode = [responseObject[@"success"] integerValue];
        NSString *hahha = responseObject[@"groupId"];
        _errorCode = responseCode;
        
        
        NSLog(@"===========%@=========",responseObject[@"msg"]);
        if (responseCode == 1) {
            NSLog(@"---------------------****POST Image  %@ Success****-----------------------", urlString);
            if (success) {
                success(responseObject);
            }
        }
        else {
            NSLog(@"*********************** %@ fail %@ *************************", urlString, @(responseCode));
            NSString* errorStr = responseObject[@"msg"];
            NSLog(@"post errorStr:%@", errorStr);
            if (failure) {
                failure(errorStr);
            }
            NSLog(@"******************************fail END************************************************");
        }
    } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        NSLog(@"***********************POST Image error *************************");
        NSLog(@"POST Image  ERROR:operation :%@", operation);
        NSLog(@"POST Image  ERROR: :%@", error);
        _errorCode = [error code];
        if (failure) {
            failure(@"服务连接失败");
        }
        NSLog(@"******************************POST Image  ERROR END************************************************");
    }];
}





//群组头像
- (void)postResultWithInsigServiceUrl:(NSString *)urlString
                           parameters:(NSDictionary *)parameters
                          singleImage:(UIImage *)image
                            imageName:(NSString *)imageName
                              success:(void (^) (id responseData))success
                              failure:(void (^) (NSString *errorMessage))failure
{
    NSString *httpUrl = [NSString stringWithFormat:@"%@%@",LKB_WSSERVICE_HTTP,urlString];
    httpUrl = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFHTTPRequestOperationManager* AFHmanager = [AFHTTPRequestOperationManager manager];
    AFHmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", @"text/json", @"text/html", @"text/plain", nil];
    [AFHmanager POST:httpUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (image) {
            NSString *fileName = [NSString stringWithFormat:@"%@.png",imageName];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData :imageData name:@"featureAvatar" fileName:fileName mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation* operation, id responseObject) {
        NSLog(@"post responseObject:%@", responseObject);
        NSInteger responseCode = [responseObject[@"success"] integerValue];
        NSString *hahha = responseObject[@"groupId"];
        _errorCode = responseCode;
        
        
        NSLog(@"===========%@=========",responseObject[@"msg"]);
        if (responseCode == 1) {
            NSLog(@"---------------------****POST Image  %@ Success****-----------------------", urlString);
            if (success) {
                success(responseObject);
            }
        }
        else {
            NSLog(@"*********************** %@ fail %@ *************************", urlString, @(responseCode));
            NSString* errorStr = responseObject[@"msg"];
            NSLog(@"post errorStr:%@", errorStr);
            if (failure) {
                failure(errorStr);
            }
            NSLog(@"******************************fail END************************************************");
        }
    } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        NSLog(@"***********************POST Image error *************************");
        NSLog(@"POST Image  ERROR:operation :%@", operation);
        NSLog(@"POST Image  ERROR: :%@", error);
        _errorCode = [error code];
        if (failure) {
            failure(@"服务连接失败");
        }
        NSLog(@"******************************POST Image  ERROR END************************************************");
    }];
}




//发布疑难问答
- (void)postPubQuestionResultWithServiceUrl:(NSString *)urlString
                                 parameters:(NSDictionary *)parameters
                                singleImage:(UIImage *)image
                                  imageName:(NSString *)imageName
                                    success:(void (^) (id responseData))success
                                    failure:(void (^) (NSString *errorMessage))failure
{
    NSString *httpUrl = [NSString stringWithFormat:@"%@%@",LKB_WSSERVICE_HTTP,urlString];
    httpUrl = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFHTTPRequestOperationManager* AFHmanager = [AFHTTPRequestOperationManager manager];
    AFHmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", @"text/json", @"text/html", @"text/plain", nil];
    [AFHmanager POST:httpUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (image) {
            NSString *fileName = [NSString stringWithFormat:@"%@.png",imageName];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData :imageData name:@"cover" fileName:fileName mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation* operation, id responseObject) {
        NSLog(@"post responseObject:%@", responseObject);
        NSInteger responseCode = [responseObject[@"success"] integerValue];
        NSString *hahha = responseObject[@"emobGroupId"];
        _errorCode = responseCode;
        
        
        NSLog(@"===========%@=========",responseObject[@"msg"]);
        if (responseCode == 1||hahha.length!=0) {
            NSLog(@"---------------------****POST Image  %@ Success****-----------------------", urlString);
            if (success) {
                success(responseObject);
            }
        }
        else {
            NSLog(@"*********************** %@ fail %@ *************************", urlString, @(responseCode));
            NSString* errorStr = responseObject[@"msg"];
            NSLog(@"post errorStr:%@", errorStr);
            if (failure) {
                failure(errorStr);
            }
            NSLog(@"******************************fail END************************************************");
        }
    } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        NSLog(@"***********************POST Image error *************************");
        NSLog(@"POST Image  ERROR:operation :%@", operation);
        NSLog(@"POST Image  ERROR: :%@", error);
        _errorCode = [error code];
        if (failure) {
            failure(@"服务连接失败");
        }
        NSLog(@"******************************POST Image  ERROR END************************************************");
    }];
}


//发布话题
- (void)postPubTopicResultWithServiceUrl:(NSString *)urlString
                              parameters:(NSDictionary *)parameters
                             singleImage:(UIImage *)image
                               imageName:(NSString *)imageName
                                 success:(void (^) (id responseData))success
                                 failure:(void (^) (NSString *errorMessage))failure
{
    NSString *httpUrl = [NSString stringWithFormat:@"%@%@",LKB_WSSERVICE_HTTP,urlString];
    httpUrl = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFHTTPRequestOperationManager* AFHmanager = [AFHTTPRequestOperationManager manager];
    AFHmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", @"text/json", @"text/html", @"text/plain", nil];
    [AFHmanager POST:httpUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (image) {
            NSString *fileName = [NSString stringWithFormat:@"%@.png",imageName];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData :imageData name:@"topicAvatar" fileName:fileName mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation* operation, id responseObject) {
        NSLog(@"post responseObject:%@", responseObject);
        NSInteger responseCode = [responseObject[@"success"] integerValue];
        NSString *hahha = responseObject[@"emobGroupId"];
        _errorCode = responseCode;
        
        
        NSLog(@"===========%@=========",responseObject[@"msg"]);
        if (responseCode == 1||hahha.length!=0) {
            NSLog(@"---------------------****POST Image  %@ Success****-----------------------", urlString);
            if (success) {
                success(responseObject);
            }
        }
        else {
            NSLog(@"*********************** %@ fail %@ *************************", urlString, @(responseCode));
            NSString* errorStr = responseObject[@"msg"];
            NSLog(@"post errorStr:%@", errorStr);
            if (failure) {
                failure(errorStr);
            }
            NSLog(@"******************************fail END************************************************");
        }
    } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        NSLog(@"***********************POST Image error *************************");
        NSLog(@"POST Image  ERROR:operation :%@", operation);
        NSLog(@"POST Image  ERROR: :%@", error);
        _errorCode = [error code];
        if (failure) {
            failure(@"服务连接失败");
        }
        NSLog(@"******************************POST Image  ERROR END************************************************");
    }];
}


//个人头像
- (void)postResultWithServiceUrl:(NSString *)urlString
                      parameters:(NSDictionary *)parameters
                     singleImage:(UIImage *)image
                       imageName:(NSString *)imageName
                         success:(void (^) (id responseData))success
                         failure:(void (^) (NSString *errorMessage))failure
{
    NSString *httpUrl = [NSString stringWithFormat:@"%@%@",LKB_WSSERVICE_HTTP,urlString];
    httpUrl = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFHTTPRequestOperationManager* AFHmanager = [AFHTTPRequestOperationManager manager];
    AFHmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", @"text/json", @"text/html", @"text/plain", nil];
    [AFHmanager POST:httpUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (image) {
            NSString *fileName = [NSString stringWithFormat:@"%@.png",imageName];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData :imageData name:@"avatar" fileName:fileName mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation* operation, id responseObject) {
        NSLog(@"post responseObject:%@", responseObject);
        NSInteger responseCode = [responseObject[@"success"] integerValue];
        NSString *hahha = responseObject[@"emobGroupId"];
        _errorCode = responseCode;
        
        
        
        
        
        NSLog(@"===========%@=========",responseObject[@"msg"]);
        if (responseCode == 1||hahha.length!=0) {
            NSLog(@"---------------------****POST Image  %@ Success****-----------------------", urlString);
            LKBBaseModel* model = [LKBBaseFactory modelWithURL:urlString
                                                  responseJson:responseObject];
            if (!model.rspCode) {
                success(model);
            }
        }
        else {
            NSLog(@"*********************** %@ fail %@ *************************", urlString, @(responseCode));
            NSString* errorStr = responseObject[@"msg"];
            NSLog(@"post errorStr:%@", errorStr);
            if (failure) {
                failure(errorStr);
            }
            NSLog(@"******************************fail END************************************************");
        }
    } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        NSLog(@"***********************POST Image error *************************");
        NSLog(@"POST Image  ERROR:operation :%@", operation);
        NSLog(@"POST Image  ERROR: :%@", error);
        _errorCode = [error code];
        if (failure) {
            failure(@"服务连接失败");
        }
        NSLog(@"******************************POST Image  ERROR END************************************************");
    }];
}

// 话题头像
- (void)postResultWithTopicServiceUrl:(NSString *)urlString
                           parameters:(NSDictionary *)parameters
                          singleImage:(UIImage *)image
                            imageName:(NSString *)imageName
                              success:(void (^) (id responseData))success
                              failure:(void (^) (NSString *errorMessage))failure
{
    NSString *httpUrl = [NSString stringWithFormat:@"%@%@",LKB_WSSERVICE_HTTP,urlString];
    httpUrl = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFHTTPRequestOperationManager* AFHmanager = [AFHTTPRequestOperationManager manager];
    AFHmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", @"text/json", @"text/html", @"text/plain", nil];
    [AFHmanager POST:httpUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (image) {
            NSString *fileName = [NSString stringWithFormat:@"%@.png",imageName];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData :imageData name:@"topicAvatar" fileName:fileName mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation* operation, id responseObject) {
        NSLog(@"post responseObject:%@", responseObject);
        NSInteger responseCode = [responseObject[@"success"] integerValue];
        NSString *hahha = responseObject[@"emobGroupId"];
        _errorCode = responseCode;
        
        
        NSLog(@"===========%@=========",responseObject[@"msg"]);
        
        if (responseCode == 1||hahha.length!=0) {
            NSLog(@"---------------------****POST Image  %@ Success****-----------------------", urlString);
            if (success) {
                success(responseObject);
            }
        }
        else {
            NSLog(@"*********************** %@ fail %@ *************************", urlString, @(responseCode));
            NSString* errorStr = responseObject[@"msg"];
            NSLog(@"post errorStr:%@", errorStr);
            if (failure) {
                failure(errorStr);
            }
            NSLog(@"******************************fail END************************************************");
        }
    } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        NSLog(@"***********************POST Image error *************************");
        NSLog(@"POST Image  ERROR:operation :%@", operation);
        NSLog(@"POST Image  ERROR: :%@", error);
        _errorCode = [error code];
        if (failure) {
            failure(@"服务连接失败");
        }
        NSLog(@"******************************POST Image  ERROR END************************************************");
    }];
}


- (void)postQuestionFromWithPath:(NSString*)urlString
                      WithParams:(NSDictionary*)parameters
                          images:(NSArray*)images
                         success:(void (^)(id responseData))success
                         failure:(void (^)(NSString* errorMessage))failure
{
    NSString* httpUrl = [NSString stringWithFormat:@"%@/%@", LKB_WSSERVICE_HTTP, urlString];
    httpUrl = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFHTTPRequestOperationManager* AFHmanager = [AFHTTPRequestOperationManager manager];
    AFHmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", @"text/json", @"text/html", @"text/plain", nil];
    [AFHmanager POST:httpUrl
          parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    for (NSInteger i = 0; i < images.count; i++) {
        UIImage* image = images[i];
        NSString* name = [NSString stringWithFormat:@"image%@", @(i)];
        NSString* fileName = [NSString stringWithFormat:@"%@.jpg", name];
        NSData* imageData = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:imageData name:@"imgFile" fileName:fileName mimeType:@"image/jpeg"];
    }
}
             success:^(AFHTTPRequestOperation* operation, id responseObject) {
#ifdef DEBUG
                 NSLog(@"post responseObject:%@", responseObject);
#endif
                 if (!success) {
                     return;
                 }
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     LKBBaseModel* model = [LKBBaseFactory modelWithURL:urlString
                                                           responseJson:responseObject];
                     if (!model.rspCode) {
                         success(model);
                     }
                     else {
                         NSLog(@"*********************** %@ fail \n %@ *************************", urlString, model.msg);
                         
                         failure(model.msg);
                         NSLog(@"******************************fail END************************************************");
                     }
                 }
                 else {
                     success(responseObject);
                 }
             }
             failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                 NSLog(@"***********************POST error *************************");
                 NSLog(@"POST ERROR:operation :%@", operation);
                 NSLog(@"POST ERROR: :%@", error);
                 _errorCode = [error code];
                 if (failure) {
                     failure(@"连接失败");
                 }
                 NSLog(@"******************************POST ERROR END************************************************");
             }];
}

// 话题图片
- (void)postTopicFromWithPath:(NSString*)urlString
                   WithParams:(NSDictionary*)parameters
                       images:(NSArray*)images
                      success:(void (^)(id responseData))success
                      failure:(void (^)(NSString* errorMessage))failure
{
    NSString* httpUrl = [NSString stringWithFormat:@"%@/%@", LKB_WSSERVICE_HTTP, urlString];
    httpUrl = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFHTTPRequestOperationManager* AFHmanager = [AFHTTPRequestOperationManager manager];
    AFHmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", @"text/json", @"text/html", @"text/plain", nil];
    [AFHmanager POST:httpUrl
          parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    for (NSInteger i = 0; i < images.count; i++) {
        UIImage* image = images[i];
        NSString* name = [NSString stringWithFormat:@"image%@", @(i)];
        NSString* fileName = [NSString stringWithFormat:@"%@.jpg", name];
        NSData* imageData = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:imageData name:@"topicAvatar" fileName:fileName mimeType:@"image/jpeg"];
    }
}
             success:^(AFHTTPRequestOperation* operation, id responseObject) {
#ifdef DEBUG
                 NSLog(@"post responseObject:%@", responseObject);
#endif
                 if (!success) {
                     return;
                 }
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     LKBBaseModel* model = [LKBBaseFactory modelWithURL:urlString
                                                           responseJson:responseObject];
                     if (!model.rspCode) {
                         success(model);
                     }
                     else {
                         NSLog(@"*********************** %@ fail \n %@ *************************", urlString, model.msg);
                         
                         failure(model.msg);
                         NSLog(@"******************************fail END************************************************");
                     }
                 }
                 else {
                     success(responseObject);
                 }
             }
             failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                 NSLog(@"***********************POST error *************************");
                 NSLog(@"POST ERROR:operation :%@", operation);
                 NSLog(@"POST ERROR: :%@", error);
                 _errorCode = [error code];
                 if (failure) {
                     failure(@"连接失败");
                 }
                 NSLog(@"******************************POST ERROR END************************************************");
             }];
}


#pragma mark -- 数据库实例
static FMDatabase *_db;
+ (void)initialize{
    NSString * bundleName =[[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey];
    NSString *dbName=[NSString stringWithFormat:@"%@%@",bundleName,@".sqlite"];
    NSString *filename = [cachePath stringByAppendingPathComponent:dbName];
    _db = [FMDatabase databaseWithPath:filename];
    if ([_db open]) {
        BOOL res = [_db tableExists:@"MCData"];
        if (!res) {
            // 4.创表
            BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS MCData (id integer PRIMARY KEY AUTOINCREMENT, url text NOT NULL, data blob NOT NULL,savetime date);"];
            NSLog(@"\n\n---%@----\n\n",result?@"成功创表":@"创表失败");
        }
    }
    [_db close];
}
#pragma mark --通过请求参数去数据库中加载对应的数据
- (NSData *)cachedDataWithUrl:(NSString *)url{
    NSData * data = [[NSData alloc]init];
    [_db open];
    FMResultSet *resultSet = nil;
    resultSet = [_db executeQuery:@"SELECT * FROM MCData WHERE url = ?", url];
    // 遍历查询结果
    while (resultSet.next) {
        NSDate *  time = [resultSet dateForColumn:@"savetime"];
        NSTimeInterval timeInterval = -[time timeIntervalSinceNow];
        if(timeInterval > cacheTime &&  cacheTime!= 0){
            NSLog(@"\n\n     %@     \n\n",@"缓存的数据过期了");
        }else{
            data = [resultSet objectForColumnName:@"data"];
        }
    }
    [_db close];
    return data;
}
#pragma mark -- 缓存数据到数据库中
- (void)saveData:(NSData *)data url:(NSString *)url{
    [_db open];
    FMResultSet *rs = [_db executeQuery:@"select * from MCData where url = ?",url];
    if([rs next]){
        BOOL res  =[_db executeUpdate: @"update MCData set data =?,savetime =? where url = ?",data,[NSDate date],url];
        NSLog(@"\n\n%@     %@\n\n",url,res?@"数据更新成功":@"数据更新失败");
    }
    else{
        BOOL res =  [_db executeUpdate:@"INSERT INTO MCData (url,data,savetime) VALUES (?,?,?);",url, data,[NSDate date]];
        NSLog(@"\n\n%@     %@\n\n",url,res?@"数据插入成功":@"数据插入失败");
    }
    [_db close];
}

#pragma mark  请求前统一处理：如果是没有网络，则不论是GET请求还是POST请求，均无需继续处理
- (BOOL)requestBeforeCheckNetWork {
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isNetworkEnable  =(isReachable && !needsConnection) ? YES : NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible =isNetworkEnable;/*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
    });
    return isNetworkEnable;
}
#pragma mark ---   计算一共缓存的数据的大小
+ (NSString *)cacheSize{
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *subpaths = [mgr subpathsAtPath:cachePath];
    long long ttotalSize = 0;
    for (NSString *subpath in subpaths) {
        NSString *fullpath = [cachePath stringByAppendingPathComponent:subpath];
        BOOL dir = NO;
        [mgr fileExistsAtPath:fullpath isDirectory:&dir];
        if (dir == NO) {// 文件
            ttotalSize += [[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize] longLongValue];
        }
    }//  M
    ttotalSize = ttotalSize/1024;
    return ttotalSize<1024?[NSString stringWithFormat:@"%lld KB",ttotalSize]:[NSString stringWithFormat:@"%.2lld MB",ttotalSize/1024];
}
/**
 *  获取文件大小
 */
+ (unsigned long long)fileSizeForPath:(NSString *)path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}
#pragma mark ---   清空缓存的数据
+ (void)deleateCache{
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:cachePath error:nil];
}
#pragma mark -- 拼接 post 请求的网址
- (NSString *)urlDictToStringWithUrlStr:(NSString *)urlStr WithDict:(NSDictionary *)parameters{
    if (!parameters) {
        return urlStr;
    }
    NSMutableArray *parts = [NSMutableArray array];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id<NSObject> obj, BOOL *stop) {
        NSString *encodedKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *encodedValue = [obj.description stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject: part];
    }];
    NSString *queryString = [parts componentsJoinedByString: @"&"];
    queryString =  queryString ? [NSString stringWithFormat:@"?%@", queryString] : @"";
    NSString * pathStr =[NSString stringWithFormat:@"%@?%@",urlStr,queryString];
    return pathStr;
}
#pragma mark -- 处理json格式的字符串中的换行符、回车符
- (NSString *)deleteSpecialCodeWithStr:(NSString *)str {
    NSString *string = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}

@end
