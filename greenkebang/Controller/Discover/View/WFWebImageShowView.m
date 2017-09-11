//
//  WFWebImageShowView.m
//  WFZhihuDaily
//
//  Created by 阿虎 on 16/1/9.
//  Copyright (c) 2016年 xiupintech. All rights reserved.
//

#import "WFWebImageShowView.h"
#import "UIImageView+EMWebCache.h"


#define kImageViewTag 99999

@implementation WFWebImageShowView
{
    
    UIScrollView *_scrollView;
    UIView   *_maskView;//蒙板
    UIButton *_downLoadBtn;//透明视图上的下载按钮
}

- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl{

    if (self == [super initWithFrame:frame]) {
    
        [self configUI:imageUrl];
    }
    return self;
}


- (void)configUI:(NSString *)imageUrl{

    [self configMaskView];
    [self configScrollViewWithImageUrl:imageUrl];
    [self configGesture];
    
}


#pragma mark - 初始化手势
- (void)configGesture{
    
    UITapGestureRecognizer *tapGser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappear)];
    tapGser.numberOfTouchesRequired = 1;
    tapGser.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGser];

}

#pragma mark - 初始化底部视图
- (void)configMaskView{

    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    _maskView.backgroundColor = [UIColor blackColor];
    [self addSubview:_maskView];
//    _maskView.alpha = 0.f;
  
    _downLoadBtn = [UIButton buttonWithType:0];
    _downLoadBtn.frame = CGRectMake(kDeviceWidth - 60, KDeviceHeight - 50, 50, 50);
    [_downLoadBtn setImage:Image(@"picture_download") forState:0];
    [_downLoadBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:0.25f animations:^{
        
//        _maskView.alpha = 0.7f;
        
    } completion:^(BOOL finished) {
        
        [self.superview addSubview:_downLoadBtn];
    
    }];
    
}

#pragma mark - 初始化主视图
- (void)configScrollViewWithImageUrl:(NSString *)imageUrl{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = true;
    _scrollView.delegate = self;
    _scrollView.alwaysBounceHorizontal = true;
    _scrollView.contentSize = CGSizeMake(0, 0);
    [self addSubview:_scrollView];
    _scrollView.alpha = 0.f;
    
    [UIView animateWithDuration:0.4f animations:^{
        _scrollView.alpha = 1.f;
    } completion:^(BOOL finished) {
        
    }];
    
    
    UIScrollView *imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.frame.size.height)];
    imageScrollView.backgroundColor = [UIColor clearColor];
    imageScrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    imageScrollView.delegate = self;
    imageScrollView.maximumZoomScale = 2;
    imageScrollView.minimumZoomScale = 1;
    
    
    UIImageView *imageView_above = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView_above.userInteractionEnabled = YES;
    imageView_above.tag = kImageViewTag;
    [imageScrollView addSubview:imageView_above];

    if (imageView_above.image == nil) {
        imageScrollView.userInteractionEnabled = NO;
    }
    
    [_scrollView addSubview:imageScrollView];
    
    
//    imageView_above sd_setImageWithURL:[NSURL URLWithString:imageUrl]  placeholderImage:Image(@"tags_selected.png") options:<#(EMSDWebImageOptions)#> completed:<#^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL)completedBlock#>
    
    
    [imageView_above sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:Image(@"tags_selected.png") options:EMSDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        if (receivedSize != expectedSize) {
            imageScrollView.userInteractionEnabled = NO;
        }else{
            imageScrollView.userInteractionEnabled = YES;
        }
        
    } completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image) {
            imageScrollView.userInteractionEnabled = YES;
           
            CGSize  size = image.size;
            float imgScale = size.height/size.width;
            float viewScale = self.frame.size.height/self.frame.size.width;
            float width = size.width,height = size.height;
            
            if(imgScale < viewScale && size.width > self.frame.size.width){
                width = self.frame.size.width;
                height = self.frame.size.width * imgScale;
                
            }else if(imgScale >= viewScale && size.height > self.frame.size.height){
                height = self.frame.size.height;
                width = height/imgScale;
                imageScrollView.maximumZoomScale = imgScale / 2;
            }
            
            CGRect newFrame = CGRectMake((self.frame.size.width - width)/2, (self.frame.size.height - height)/2 + 25, width, height);//25 因为底部有50px

            imageView_above.frame = newFrame;
            
            imageView_above.transform = CGAffineTransformMakeScale(0.7, 0.7);
            [UIView animateWithDuration:0.25f animations:^{
                imageView_above.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            } completion:^(BOOL finished) {
                
            }];
        }
    }];
}


#pragma mark - Private Method
#pragma mark - 保存图片
- (void)saveImage{
    
    UIImageView *saveImage = (UIImageView *)[self viewWithTag:kImageViewTag];
    
    if (saveImage.image != nil) {
        if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            UIImageWriteToSavedPhotosAlbum(saveImage.image, nil, nil, nil);
            [MBProgressHUD showSuccess:@"保存成功" toView:nil];
            
        }else{
            
            [MBProgressHUD showSuccess:@"没有用户权限" toView:nil];
        }
        
    }

}

#pragma mark － 移除事件
- (void)disappear{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //变小
    [UIView animateWithDuration:.4f animations:^{
        
        _maskView.alpha = 0;
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [_downLoadBtn removeFromSuperview];
        [_maskView removeFromSuperview];
        [_scrollView removeFromSuperview];
        _removeImg();
        
    }];
    
    
}


#pragma mark - 外部方法 展现
- (void)show:(UIView *)bgView didFinish:(didRemoveImage)tempBlock{
    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [bgView addSubview:self];
    
    _removeImg = tempBlock;
    
    [UIView animateWithDuration:.4f animations:^(){
        
        self.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
        
    }];
    
}


#pragma mark - UIScrollViewDelegate -
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    UIView *imageView = (UIView *)[self viewWithTag:kImageViewTag];
    
    return imageView;
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    
    if (self.bounds.size.width > scrollView.contentSize.width) {
        
        offsetX = (self.bounds.size.width - scrollView.contentSize.width) * 0.5;
        
    }else{
        
        
        offsetX = 0.0;
    }
    
    
    if (self.bounds.size.height > scrollView.contentSize.height){
        
        offsetY = (self.bounds.size.height - scrollView.contentSize.height) * 0.5;
        
    }else{
        
        
        offsetY = 0.0;
    }
    
    UIImageView *imageView = (UIImageView *)[self viewWithTag:kImageViewTag];
    imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                   scrollView.contentSize.height * 0.5 + offsetY);
}

@end
