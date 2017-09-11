//
//  HZPhotoGroup.m
//  HZPhotoBrowser
//
//  Created by aier on 15-2-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HZPhotoGroup.h"
#import "HZPhotoItem.h"
#import "UIButton+WebCache.h"
#import "HZPhotoBrowser.h"
#import <UIImageView+WebCache.h>
#import "FileHelpers.h"
#define HZPhotoGroupImageMargin 6

@interface HZPhotoGroup () <HZPhotoBrowserDelegate>

@end

@implementation HZPhotoGroup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除图片缓存，便于测试
//        [[SDWebImageManager sharedManager].imageCache clearDisk];
    }
    return self;
}


- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    _photoItemArray = photoItemArray;
    
    [photoItemArray enumerateObjectsUsingBlock:^(HZPhotoItem *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = CCCUIColorFromHex(0xdddddd);
        //让图片不变形，以适应按钮宽高，按钮中图片部分内容可能看不到
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.clipsToBounds = YES;
        
        NSLog(@"===================%@",[NSURL URLWithString:obj.thumbnail_pic]);
        NSLog(@"===================%@",_photoItemArray);
        
        [btn sd_setImageWithURL:[NSURL URLWithString:obj.thumbnail_pic] forState:UIControlStateNormal];
        btn.tag = idx;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([_type isEqualToString:@"2"]) {
        
        long imageCount = self.photoItemArray.count;
        
        NSString *str = [NSString stringWithFormat:@"%lu",(unsigned long)self.photoItemArray.count];
        
        int photoCount = [str intValue];
        
        int perRowImageCount = (imageCount ? photoCount : 1);
        
        CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
        int totalRowCount = ceil(imageCount / perRowImageCountF);
        CGFloat w = (kDeviceWidth -28 -12 -60)/3;
        CGFloat h = ((kDeviceWidth -28 -12-60)/3)*0.95;
        [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
            
            long rowIndex = idx / perRowImageCount;
            if (idx < 3) {
                
                int columnIndex = idx % perRowImageCount ;
                CGFloat x = columnIndex * (w + 6);
                CGFloat y = rowIndex * (h + 6);
                btn.frame = CGRectMake(x, y, w, h);
                
            }
            else {
                
                int columnIndex = idx % perRowImageCount ;
                CGFloat x = columnIndex * (w + 6) +10;
                CGFloat y = rowIndex * (h + 6);
                btn.frame = CGRectMake(x, y, w, h);
                
            }
            
        }];

        
        
        self.frame = CGRectMake(0, 0, kDeviceWidth, totalRowCount * (HZPhotoGroupImageMargin + h));

        
        
    }
    else {
        
        NSLog(@"===================%f",_oneImageHeight);
        NSLog(@"===================%f",_oneImageWidth);
        if (self.photoItemArray.count == 1) {
            NSLog(@"===================%@",self.photoItemArray);
            
            long imageCount = self.photoItemArray.count;
            int perRowImageCount = ((imageCount == 4) ? 2 : 3);
            CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
            
            int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
            
            
            if ( _oneImageWidth / _oneImageHeight > 1 && _oneImageWidth / _oneImageHeight < 4 /3) {
                
                CGFloat w = (171 * _oneImageWidth) / _oneImageHeight ;
                CGFloat h = 171;
                [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                    
                    long rowIndex = idx / perRowImageCount;
                    int columnIndex = idx % perRowImageCount;
                    CGFloat x = columnIndex * (w + HZPhotoGroupImageMargin);
                    CGFloat y = rowIndex * (h + HZPhotoGroupImageMargin);
                    
                    btn.frame = CGRectMake(x, y, w, h);
                }];
                
                self.frame = CGRectMake(0, 0,kDeviceWidth, totalRowCount * (HZPhotoGroupImageMargin + h));
                
                
            }
            if(_oneImageWidth / _oneImageHeight< 1 && _oneImageWidth / _oneImageHeight > 3/4) {
                
                CGFloat w = 171;
                CGFloat h = (171*_oneImageHeight ) /_oneImageWidth;
                [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                    
                    long rowIndex = idx / perRowImageCount;
                    int columnIndex = idx % perRowImageCount;
                    CGFloat x = columnIndex * (w + HZPhotoGroupImageMargin);
                    CGFloat y = rowIndex * (h + HZPhotoGroupImageMargin);
                    
                    btn.frame = CGRectMake(x, y, w, h);
                }];
                
                self.frame = CGRectMake(0, 0, kDeviceWidth, totalRowCount * (HZPhotoGroupImageMargin + h));
                
                
            }
            
            
            if (_oneImageWidth / _oneImageHeight < 3/4 ) {
                
                CGFloat w = 171;
                CGFloat h = 228;
                [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                    
                    long rowIndex = idx / perRowImageCount;
                    int columnIndex = idx % perRowImageCount;
                    CGFloat x = columnIndex * (w + HZPhotoGroupImageMargin);
                    CGFloat y = rowIndex * (h + HZPhotoGroupImageMargin);
                    
                    btn.frame = CGRectMake(x, y, w, h);
                }];
                
                self.frame = CGRectMake(0, 0, kDeviceWidth, totalRowCount * (HZPhotoGroupImageMargin + h));
                
            }
            if (_oneImageWidth / _oneImageHeight > 4 /3) {
                
                CGFloat w = 228;
                CGFloat h = 171;
                [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                    
                    long rowIndex = idx / perRowImageCount;
                    int columnIndex = idx % perRowImageCount;
                    CGFloat x = columnIndex * (w + HZPhotoGroupImageMargin);
                    CGFloat y = rowIndex * (h + HZPhotoGroupImageMargin);
                    
                    btn.frame = CGRectMake(x, y, w, h);
                }];
                
                self.frame = CGRectMake(0, 0,kDeviceWidth, totalRowCount * (HZPhotoGroupImageMargin + h));
                
            }
            if (_oneImageHeight / _oneImageWidth > 4 /3) {
                
                CGFloat w = 171;
                CGFloat h = 228;
                [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                    
                    long rowIndex = idx / perRowImageCount;
                    int columnIndex = idx % perRowImageCount;
                    CGFloat x = columnIndex * (w + HZPhotoGroupImageMargin);
                    CGFloat y = rowIndex * (h + HZPhotoGroupImageMargin);
                    
                    btn.frame = CGRectMake(x, y, w, h);
                }];
                
                self.frame = CGRectMake(0, 0, kDeviceWidth, totalRowCount * (HZPhotoGroupImageMargin + h));
                
            }
            
            if (_oneImageWidth / _oneImageHeight == 1)  {
                CGFloat w = 171;
                CGFloat h = 171;
                [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                    
                    long rowIndex = idx / perRowImageCount;
                    int columnIndex = idx % perRowImageCount;
                    CGFloat x = columnIndex * (w + HZPhotoGroupImageMargin);
                    CGFloat y = rowIndex * (h + HZPhotoGroupImageMargin);
                    
                    btn.frame = CGRectMake(x, y, w, h);
                }];
                
                self.frame = CGRectMake(0, 0, kDeviceWidth, totalRowCount * (HZPhotoGroupImageMargin + h));
            }
        }
        else if (self.photoItemArray.count == 2) {
            
            long imageCount = self.photoItemArray.count;
            int perRowImageCount = ((imageCount == 4) ? 2 : 3);
            CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
            int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
            
            // (kDeviceWidth -28 -6)/3, ((kDeviceWidth -28 -6)/3)*0.95)
            CGFloat w = (kDeviceWidth -28)/3;
            CGFloat h = ((kDeviceWidth -28 )/3)*0.95;
            [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                
                long rowIndex = idx / perRowImageCount;
                int columnIndex = idx % perRowImageCount;
                CGFloat x = columnIndex * (w + HZPhotoGroupImageMargin);
                CGFloat y = rowIndex * (h + HZPhotoGroupImageMargin);
                btn.frame = CGRectMake(x, y, w, h);
            }];
            
            self.frame = CGRectMake(0, 0, kDeviceWidth, totalRowCount * (HZPhotoGroupImageMargin + h));
            
            
        }
        else if (self.photoItemArray.count == 3) {
            
            long imageCount = self.photoItemArray.count;
            int perRowImageCount = ((imageCount == 4) ? 2 : 3);
            CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
            int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
            
            // (kDeviceWidth -28 -6)/3, ((kDeviceWidth -28 -6)/3)*0.95)
            CGFloat w = (kDeviceWidth -28 -12)/3;
            CGFloat h = ((kDeviceWidth -28 -12)/3)*0.95;
            [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                
                if (idx > 3 ) {
                    idx = 3;
                }
                long rowIndex = idx / perRowImageCount;
                int columnIndex = idx % perRowImageCount;
                CGFloat x = columnIndex * (w + HZPhotoGroupImageMargin);
                CGFloat y = rowIndex * (h + HZPhotoGroupImageMargin);
                btn.frame = CGRectMake(x, y, w, h);
            }];
            
            self.frame = CGRectMake(0, 0, kDeviceWidth, totalRowCount * (HZPhotoGroupImageMargin + h));
            
            
        }
        
        else {
            
            long imageCount = self.photoItemArray.count;
            
            NSString *str = [NSString stringWithFormat:@"%lu",(unsigned long)self.photoItemArray.count];
            
            int photoCount = [str intValue];
            
            int perRowImageCount = (imageCount ? photoCount : 1);
            
            CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
            int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
            
            // (kDeviceWidth -28 -6)/3, ((kDeviceWidth -28 -6)/3)*0.95)
            CGFloat w = (kDeviceWidth -28 -12)/3;
            CGFloat h = ((kDeviceWidth -28 -12)/3)*0.95;
            [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                
                long rowIndex = idx / perRowImageCount;
                if (idx < 3) {
                    
                    int columnIndex = idx % perRowImageCount ;
                    CGFloat x = columnIndex * (w + 6);
                    CGFloat y = rowIndex * (h + 6);
                    btn.frame = CGRectMake(x, y, w, h);
                    
                }
                else {
                    
                    int columnIndex = idx % perRowImageCount ;
                    CGFloat x = columnIndex * (w + 6) +20;
                    CGFloat y = rowIndex * (h + 6);
                    btn.frame = CGRectMake(x, y, w, h);
                    
                }
                
            }];
            
            self.frame = CGRectMake(0, 0, kDeviceWidth, totalRowCount * (HZPhotoGroupImageMargin + h));
            
        }
        NSLog(@"---------------------------%lu",(unsigned long)self.photoItemArray.count);
        NSLog(@"---------------------------%@",self.photoItemArray);

    }
    
    
    
    
    
}




- (void)buttonClick:(UIButton *)button
{
    
    NSLog(@"===================%@",self.photoItemArray);
    
    
    [self.photoItemArray enumerateObjectsUsingBlock:^(HZPhotoItem *obj, NSUInteger idx, BOOL *stop) {

        
        NSLog(@"===================%@",[NSURL URLWithString:obj.thumbnail_pic]);
        
        NSLog(@"===================%@",_photoItemArray);
        
        
        

    }];


    //启动图片浏览器
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    

    browser.imageCount = self.photoItemArray.count;
    
    if (browser.imageCount==0) {
        
    }else
    {
    // 图片总数
    browser.currentImageIndex = (int)button.tag;
    browser.delegate = self;
    [browser show];
    }
    
}

#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.subviews[index ] currentImage];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [[self.photoItemArray[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    NSLog( @"====================%@",urlStr);
    
    // ?imageView2/1/w/228/h/228
    if ([urlStr rangeOfString:@"imageView2/1/w/200/h/200"].location != NSNotFound) {
        
        NSRange range_2 = [urlStr rangeOfString:@"?imageView2/1/w/200/h/200"];
        NSString *urlStr_2 = [urlStr substringToIndex:range_2.location];
        
        
        NSLog( @"====================%@",urlStr_2);

        return [NSURL URLWithString:urlStr_2];

        
    }
    else {
        
        NSRange range_1 = [urlStr rangeOfString:@"?imageView2/1/w/228/h/228"];
        NSString *urlStr_1 = [urlStr substringToIndex:range_1.location];

        return [NSURL URLWithString:urlStr_1];

        
    }
    
    // http://imagetest.lvkebang.cn/static/group_topic/o_1as4ffhm4bohv7d5gr1pf4t07.jpg?imageView2/1/w/200/h/200
    
}

@end
