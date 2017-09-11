//
//  FileHelpers.m
//  AAPinChe
//
//  Created by Reese on 13-1-17.
//  Copyright (c) 2013年 Himalayas Technology&Science Company CO.,LTD-重庆喜玛拉雅科技有限公司. All rights reserved.
//

#import "FileHelpers.h"
@implementation FileHelpers

NSString *pathInDocumentDirectory(NSString *fileName){
    
    //获取沙盒中的文档目录
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    NSString *documentDirectory=[documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:fileName];
}


NSString *pathInCacheDirectory(NSString *fileName){
    //获取沙盒中缓存文件目录
    NSString *cacheDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    
    //将传入的文件名加在目录路径后面并返回
    return [cacheDirectory stringByAppendingPathComponent:fileName];
}


//根据URL的hash码为图片文件命名
NSString *pathForURL(NSURL *aURL){
    return pathInCacheDirectory([NSString stringWithFormat:@"cachedImage-%@", @([[aURL description] hash])]);
}


//判断是否已经缓存过这个URL
BOOL hasCachedImage(NSURL *aURL){
    
NSFileManager *fileManager=[NSFileManager defaultManager];
    
if ([fileManager fileExistsAtPath:pathForURL(aURL)]) {
    return YES;
}
else return NO;
    
}
UIImage *changeImageSize(UIImage *image,int w,int h)
{
//    NSFileManager *fileManager=[NSFileManager defaultManager];
    CGSize origImageSize= [image size];
    CGRect newRect;
    newRect.origin= CGPointZero;
    //拉伸到多大
    newRect.size.width=200;
    newRect.size.height=200;
    //缩放倍数
    float ratio = MIN(newRect.size.width/origImageSize.width, newRect.size.height/origImageSize.height);
    UIGraphicsBeginImageContext(newRect.size);
    
    CGRect projectRect;
    projectRect.size.width =ratio * origImageSize.width;
    projectRect.size.height=ratio * origImageSize.height;
    projectRect.origin.x= (newRect.size.width -projectRect.size.width)/2.0;
    projectRect.origin.y= (newRect.size.height-projectRect.size.height)/2.0;
    [image drawInRect:projectRect];
    UIImage *small = UIGraphicsGetImageFromCurrentImageContext();
    //    NSData *smallData=UIImageJPEGRepresentation(small, 1);
    
    //    if(smallData != nil){
    //        BOOL ret = [fileManager createFileAtPath:pathForURL(aURL) contents:smallData attributes:nil];
    //        NSLog(@"ret:%d",ret);
    //    }
    
    //    UIGraphicsEndImageContext();
    return small;
}


NSString *hashCodeForURL(NSURL *aURL)
{
    return [NSString stringWithFormat:@"%@",@([[aURL description]hash])];
}

+ (void)dispatch_process_with_thread:(UIImage* (^)())block1 result:(void (^)(UIImage*))block2
{
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        UIImage* img = block1();
        dispatch_async(dispatch_get_main_queue(),^{
            block2(img);
        });
    });
}

@end
