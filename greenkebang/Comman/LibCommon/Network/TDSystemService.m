//
//  TDSystemService.m
//  Tudur
//
//  Created by WuHai on 15/3/10.
//  Copyright (c) 2015年 LZeal Information Technology Co.,Ltd. All rights reserved.
//

#import "TDSystemService.h"
//#import "TDSystemStorage.h"
//#import "NSDate+Formatting.h"
//#import "TDAccount.h"
//#import "UIImage+Resize.h"
#import "TDQiNiuUploadHelper.h"
#import "LKBBaseFactory.h"

@implementation TDSystemService

//+ (void)saveIntroShowed
//{
//    [TDSystemStorage saveIntroShowed];
//}
//
//+ (BOOL)hasIntroShowed
//{
//    return [TDSystemStorage getIntroShowed].length;
//}
//


// 个人资料图片上传
+ (void)uploadHeaderImage:(UIImage*)image progress:(QNUpProgressHandler)progress success:(void(^)(NSString*url))success failure:(void(^)())failure {
    
    [TDSystemService getQiniuUploadToken:^(NSString*token) {
        
        NSData*data =UIImageJPEGRepresentation(image,0.01);
        
        if(!data) {
            
            if(failure) {
                
                failure();
                
            }
            
            return;
            
        }
        
        NSString*fileName = [NSString stringWithFormat:@"%@%@_%@.png",@"static/user_header/",[TDSystemService getDateTimeString], [TDSystemService randomStringWithLength:8]];
        
        
        QNUploadOption*opt = [[QNUploadOption alloc]initWithMime:nil
                              
                                                progressHandler:progress
                              
                                                         params:nil
                              
                                                       checkCrc:NO
                              
                                             cancellationSignal:nil];
        
        QNUploadManager*uploadManager = [QNUploadManager sharedInstanceWithConfiguration:nil];
        
        [uploadManager putData:data
         
                           key:fileName
         
                         token:token
         
                      complete:^(QNResponseInfo*info,NSString*key,NSDictionary*resp) {
                          
                          NSLog(@"%@", info);
                          
                          NSLog(@"七牛返回信息%@", resp);
                          
                          if(info.statusCode==200&& resp) {
                              
                              NSString*url= [NSString stringWithFormat:@"%@",resp[@"key"]];
//                              NSString*url= [NSString stringWithFormat:@"%@", resp[@"key"]];
//                        NSString*url= [NSString stringWithFormat:@"%@%@",@"rgth", resp[@"key"]];

                              
                              NSLog(@"=====================%@",url);

                              if(success) {
                                  
                                  success(url);
                                  
                              }
                              
                          }
                          
                          else{
                              
                              if(failure) {
                                  
                                  failure();
                                  
                              }
                              
                          }
                          
                      }option:opt];
        
    }failure:^{
        
    }];
    
}

// 创建群组时图片上传
+ (void)uploadGroupHeaderImage:(UIImage *)image
                      progress:(QNUpProgressHandler)progress
                       success:(void (^)(NSString *url))success
                       failure:(void (^)())failure
{
    
    [TDSystemService getQiniuUploadToken:^(NSString*token) {
        
        NSData*data =UIImageJPEGRepresentation(image,0.01);
        
        if(!data) {
            
            if(failure) {
                
                failure();
                
            }
            
            return;
            
        }
        
        NSString*fileName = [NSString stringWithFormat:@"%@%@_%@.png",@"static/group_header/",[TDSystemService getDateTimeString], [TDSystemService randomStringWithLength:8]];
        
        QNUploadOption*opt = [[QNUploadOption alloc]initWithMime:nil
                              
                                                 progressHandler:progress
                              
                                                          params:nil
                              
                                                        checkCrc:NO
                              
                                              cancellationSignal:nil];
        
        QNUploadManager*uploadManager = [QNUploadManager sharedInstanceWithConfiguration:nil];
        
        [uploadManager putData:data
         
                           key:fileName
         
                         token:token
         
                      complete:^(QNResponseInfo*info,NSString*key,NSDictionary*resp) {
                          
                          NSLog(@"%@", info);
                          
                          NSLog(@"七牛返回信息%@", resp);
                          
                          if(info.statusCode==200&& resp) {
                              
                              NSString*url= [NSString stringWithFormat:@"%@",resp[@"key"]];
                              //                              NSString*url= [NSString stringWithFormat:@"%@", resp[@"key"]];
                              //                        NSString*url= [NSString stringWithFormat:@"%@%@",@"rgth", resp[@"key"]];
                              
                              
                              NSLog(@"=====================%@",url);
                              
                              if(success) {
                                  
                                  success(url);
                                  
                              }
                              
                          }
                          
                          else{
                              
                              if(failure) {
                                  
                                  failure();
                                  
                              }
                              
                          }
                          
                      }option:opt];
        
    }failure:^{
        
    }];
}




// 商城图片上传时
+ (void)uploadImage:(UIImage*)image  fileNameT:(NSString*)fileNameT progress:(QNUpProgressHandler)progress success:(void(^)(NSString*url))success failure:(void(^)())failure {
    
    [TDSystemService getQiniuUploadToken:^(NSString*token) {
        
        NSData*data =UIImageJPEGRepresentation(image,0.01);
        
        if(!data) {
            
            if(failure) {
                
                failure();
                
            }
            
            return;
            
        }
        
        NSString*fileName = [NSString stringWithFormat:@"%@%@_%@.png",@"static/group_topic/",[TDSystemService getDateTimeString], [TDSystemService randomStringWithLength:8]];
        
        NSLog(@"------------------------------%@",fileName);
        
        QNUploadOption*opt = [[QNUploadOption alloc]initWithMime:nil
                              
                                                 progressHandler:progress
                              
                                                          params:nil
                              
                                                        checkCrc:NO
                              
                                              cancellationSignal:nil];
        
        QNUploadManager*uploadManager = [QNUploadManager sharedInstanceWithConfiguration:nil];
        
        [uploadManager putData:data
         
                           key:fileName
         
                         token:token
         
                      complete:^(QNResponseInfo*info,NSString*key,NSDictionary*resp) {
                          
                          if(info.statusCode==200&& resp) {
                              
                              NSString*url= [NSString stringWithFormat:@"%@", resp[@"key"]];
                              //                              NSString*url= [NSString stringWithFormat:@"%@", resp[@"key"]];
                              
                              NSLog(@"=====================%@",url);
                              
                              if(success) {
                                  
                                  success(url);
                                  
                              }
                              
                          }
                          
                          else{
                              
                              if(failure) {
                                  
                                  failure();
                                  
                              }
                              
                          }
                          
                      }option:opt];
        
    }failure:^{
        
    }];
    
}
// 发布时候上传多张图片,按队列依次上传
+ (void)uploadPublishQAImage:(UIImage *)image
                    progress:(QNUpProgressHandler)progress
                     success:(void (^)(NSString *url))success
                     failure:(void (^)())failure  {
    [TDSystemService getQiniuUploadToken:^(NSString*token) {
        
        NSData*data =UIImageJPEGRepresentation(image,0.01);
        
        if(!data) {
            
            if(failure) {
                
                failure();
                
            }
            
            return;
            
        }
        
        NSString*fileName = [NSString stringWithFormat:@"%@%@_%@.png",@"static/group_topic/",[TDSystemService getDateTimeString], [TDSystemService randomStringWithLength:8]];
        
        NSLog(@"====================%@",fileName);
        
        
        QNUploadOption*opt = [[QNUploadOption alloc]initWithMime:nil
                              
                                                 progressHandler:progress
                              
                                                          params:nil
                              
                                                        checkCrc:NO
                              
                                              cancellationSignal:nil];
        
        QNUploadManager*uploadManager = [QNUploadManager sharedInstanceWithConfiguration:nil];
        
        [uploadManager putData:data
         
                           key:fileName
         
                         token:token
         
                      complete:^(QNResponseInfo*info,NSString*key,NSDictionary*resp) {
                          
                          if(info.statusCode==200&& resp) {
                              
                              NSString*url = [NSString stringWithFormat:@"%@", resp[@"key"]];
                              
                              
                              NSLog(@"================================%@",url);
                              
                              
                              
                              
                              //                              NSRange range = [string rangeOfString:@"static/group_topic/"];
                              //                              NSString *subStr = [string substringFromIndex:range.location];
                              //
                              //                              NSString*url= subStr;
                              //                              NSString*url= [NSString stringWithFormat:@"%@", resp[@"key"]];
                              
                              
                              
                              
                              
                              
                              if(success) {
                                  
                                  success(url);
                                  NSLog(@"================================%@",url);
                                  
                                  
                              }
                              
                          }
                          
                          else{
                              
                              if(failure) {
                                  
                                  failure();
                                  
                              }
                              
                          }
                          
                      }option:opt];
        
    }failure:^{
        
    }];

    
}



// 商城图片上传时
+ (void)uploadShoppingMallImage:(UIImage*)image progress:(QNUpProgressHandler)progress success:(void(^)(NSString*url))success failure:(void(^)())failure {
    
    [TDSystemService getQiniuUploadToken:^(NSString*token) {
        
        NSData*data =UIImageJPEGRepresentation(image,0.01);
        
        if(!data) {
            
            if(failure) {
                
                failure();
                
            }
            
            return;
            
        }
        
        NSString*fileName = [NSString stringWithFormat:@"%@_%@.png",[TDSystemService getDateTimeString], [TDSystemService randomStringWithLength:8]];
        
        NSLog(@"====================%@",fileName);

        
        QNUploadOption*opt = [[QNUploadOption alloc]initWithMime:nil
                              
                                                 progressHandler:progress
                              
                                                          params:nil
                              
                                                        checkCrc:NO
                              
                                              cancellationSignal:nil];
        
        QNUploadManager*uploadManager = [QNUploadManager sharedInstanceWithConfiguration:nil];
        
        [uploadManager putData:data
         
                           key:fileName
         
                         token:token
         
                      complete:^(QNResponseInfo*info,NSString*key,NSDictionary*resp) {
                          
                          if(info.statusCode==200&& resp) {
                              
                              NSString*url = [NSString stringWithFormat:@"%@", resp[@"key"]];
                              
                              
                              NSLog(@"================================%@",url);
                              
                              

                              
//                              NSRange range = [string rangeOfString:@"static/group_topic/"];
//                              NSString *subStr = [string substringFromIndex:range.location];
//         
//                              NSString*url= subStr;
                              //                              NSString*url= [NSString stringWithFormat:@"%@", resp[@"key"]];
                              

                              
                              
                              
                              
                              if(success) {
                                  
                                  success(url);
                                  NSLog(@"================================%@",url);

                                  
                              }
                              
                          }
                          
                          else{
                              
                              if(failure) {
                                  
                                  failure();
                                  
                              }
                              
                          }
                          
                      }option:opt];
        
    }failure:^{
        
    }];
    
}



+ (void)getQiniuUploadToken:(void(^)(NSString*))success failure:(void(^)())failure {
    
    NSString*aPath = [NSString stringWithFormat:@"common/qiniu/token"];
    
    
    [[LKBNetworkManage sharedMange] postResultWithServiceUrl:aPath parameters:nil success:^(id parserObject) {
        
        NSLog(@"=======%@====",parserObject);
        LKBBaseModel* model =(LKBBaseModel *)parserObject;
        
//        NSDictionary *dic = (NSDictionary *)parserObject;
//
        NSLog(@"=======%@====",model.qiniuToken);

        
        success(model.qiniuToken);
//        
        
    } failure:^(NSString *errorMessage) {
      
        
    }];
    
 
    
}

+ (NSString*)getDateTimeString

{
    
    NSDateFormatter*formatter;
    
    NSString*dateString;
    
    formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    return dateString;
    
}

+ (NSString*)randomStringWithLength:(int)len

{
    
    NSString*letters =@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString*randomString = [NSMutableString stringWithCapacity: len];
    
    for(int i=0;i<len;i++)
    {
        
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random_uniform((int)[letters length])]];
        
        }
        
        return randomString;
        
 }
        

        
// 发布时候上传多张图片,按队列依次上传
+ (void)uploadPublishQAImages:(NSArray *)imageArray progress:(void (^)(CGFloat))progress success:(void (^)(NSArray *))success failure:(void (^)())failure
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    __block float totalProgress = 0.0f;
    __block float partProgress = 1.0f / [imageArray count];
    __block NSUInteger currentIndex = 0;
    
    TDQiNiuUploadHelper *uploadHelper = [TDQiNiuUploadHelper sharedInstance];
    __weak typeof(uploadHelper) weakHelper = uploadHelper;
    
    uploadHelper.singleFailureBlock = ^() {
        failure();
        return;
    };
    uploadHelper.singleSuccessBlock  = ^(NSString *url) {
        
        NSLog(@"----------------------%@",url);
        
        
        [array addObject:url];
        totalProgress += partProgress;
        progress(totalProgress);
        currentIndex++;
        if ([array count] == [imageArray count]) {
            success([array copy]);
            return;
        }
        else {
            [TDSystemService uploadPublishQAImage:imageArray[currentIndex] progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];

        }
    };

    [TDSystemService uploadPublishQAImage:imageArray[0] progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
    
}



@end
