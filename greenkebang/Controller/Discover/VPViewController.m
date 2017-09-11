//
//  VPViewController.m
//  VPImageCropperDemo
//
//  Created by Vinson.D.Warm on 1/13/14.
//  Copyright (c) 2014 Vinson.D.Warm. All rights reserved.
//

#import "VPViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "RSKImageCropViewController.h"
#import "CircleIntrduceViewController.h"
#import "TDSystemService.h"
#import "ZFActionSheet.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZImagePickerController.h"
#import "CircleImageManager.h"
#import "FileHelpers.h"
#import "TabbarManager.h"
#define ORIGINAL_MAX_WIDTH 640.0f

@interface VPViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate,RSKImageCropViewControllerDelegate,ZFActionSheetDelegate,TZImagePickerControllerDelegate>
{
    UIButton *backBtn;
    UIButton *btn;
    
    BOOL _isSelectOriginalPhoto;
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;

}

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UIImageView *cameraImg;
@property(nonatomic,strong)UILabel *CircleLable;
@property(nonatomic,strong)UILabel *describleLable;
@property(nonatomic,copy)NSString *imagenewCircleImg;
@property (strong, nonatomic)ZFActionSheet *actionSheet;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@end

@implementation VPViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];

    
    UIImage *image = [UIImage imageNamed: @"NavBarImage.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    self.navigationItem.titleView = imageView;
    
    
    
    
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [self initsubViews];
    [self.view addSubview:self.portraitImageView];
    [self.portraitImageView addSubview:self.cameraImg];
    [self loadPortrait];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [MobClick beginLogPageView:@"VPViewController"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"VPViewController"];
}


//异步加载图片
- (UIImage *)LoadImage:(NSDictionary*)aDic{
    
    NSLog(@"--------------------------%@",aDic);
    
    
    //    NSURL *aURL=[NSURL URLWithString:[aDic objectForKey:@"featureAvatar"]];
    NSURL *aURL = [aDic objectForKey:@"circleAvatar"];
    
    NSData *data=[NSData dataWithContentsOfURL:aURL];
    if (data == nil) {
        return nil;
    }
    UIImage *image=[UIImage imageWithData:data];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager createFileAtPath:pathForURL(aURL) contents:data attributes:nil];
    return image;
}


-(void)backToMain
{
    _actionSheet = [ZFActionSheet actionSheetWithTitle:@"退出后资料信息将不被保存" confirms:@[@"放弃创建",@"继续创建"] cancel:@"取消" style:ZFActionSheetStyleDefault];
    
    
    _actionSheet.delegate = self;
    [_actionSheet showInView:self.view.window];

    
//    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - ZFActionSheetDelegate
- (void)clickAction:(ZFActionSheet *)actionSheet atIndex:(NSUInteger)index
{
    NSLog(@"选中了 %zd",index);
    
    
    if (index==1) {
        
    }else
    {
        
        if ([[TabbarManager shareInstance].createCirleVcType isEqualToString:@"1"]) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            [TabbarManager shareInstance].createCirleVcType = nil;
            [CircleImageManager shareInstance].CircleImage = nil;

            
        }else {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]                                              animated:YES];

            
        }
        
        [CircleImageManager shareInstance].CircleImage = nil;

        
    }
}


- (UILabel*)describleLable
{
    if (!_describleLable) {
        _describleLable = [[UILabel alloc] init];
        _describleLable.textAlignment = NSTextAlignmentCenter;
        _describleLable.numberOfLines = 1;
        _describleLable.text = @"添加一张有代表性的图片作为部落头像";
        _describleLable.font = [UIFont systemFontOfSize:14];
        _describleLable.textColor = CCCUIColorFromHex(0xaaaaaa);
        _describleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _describleLable;
}


- (UILabel*)CircleLable
{
    if (!_CircleLable) {
        _CircleLable = [[UILabel alloc] init];
        _CircleLable.textAlignment = NSTextAlignmentCenter;
        _CircleLable.numberOfLines = 1;
        _CircleLable.text = @"圈子头像";
        _CircleLable.font = [UIFont systemFontOfSize:40];
        _CircleLable.textColor = CCCUIColorFromHex(0x999999);
        _CircleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _CircleLable;
}
- (void)backBtnEvent:(UIButton *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)btnEvent:(UIButton *)button
{
    
    NSLog(@"============================%@",_imagenewCircleImg);
    
    
    

    CircleIntrduceViewController*photonViewController = [[CircleIntrduceViewController alloc]init];
    photonViewController.imageUrl = _imagenewCircleImg;
    photonViewController.cirCleNameText = _cirleName;
    [self.navigationController pushViewController:photonViewController animated:YES];
}



-(void)initsubViews
{
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(14, KDeviceHeight -8 -33, 66, 33);
    [backBtn setBackgroundColor:[UIColor whiteColor]];
    backBtn.layer.cornerRadius = 5;
    [backBtn.layer setMasksToBounds:YES];
    [backBtn setTitle:@"上一步" forState:UIControlStateNormal];
    [backBtn setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
    backBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [backBtn addTarget:self action:@selector(backBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kDeviceWidth-66 -14 , KDeviceHeight-8 -33 , 66,
                           33);
    [btn setBackgroundColor:CCCUIColorFromHex(0x01b554)];
    btn.layer.cornerRadius = 3.5;
    [btn.layer setMasksToBounds:YES];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    btn.titleLabel.font =[UIFont systemFontOfSize:14];
    
    if ([CircleImageManager shareInstance].CircleImage != nil) {
        
        btn.userInteractionEnabled=YES;
        btn.alpha= 1 ;

    }
    else{
        btn.userInteractionEnabled=NO;
        btn.alpha=0.4;

    }

    [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    

    [self.view addSubview:self.CircleLable];
     [self.view addSubview:self.describleLable];
    
    
    [_CircleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(88);
        make.centerX.mas_equalTo(self.view.centerX);
        make.size.mas_equalTo(CGSizeMake(280, 40));
    }];
    [_describleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_CircleLable.bottom).offset(13);
        make.centerX.mas_equalTo(self.view.centerX);
        make.size.mas_equalTo(CGSizeMake(280, 16));
    }];
    

}

- (void)loadPortrait {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
//        NSURL *portraitUrl = [NSURL URLWithString:@"http://photo.l99.com/bigger/31/1363231021567_5zu910.jpg"];
//        UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
        UIImage *protraitImg = [UIImage imageNamed:@"createcircle_btn_headportrait_add_nor"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.portraitImageView.image = protraitImg;
        });
    });
}

- (void)editPortrait {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
    
//    [self pushImagePickerController];

}

#pragma mark - TZImagePickerController
- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    // 1.如果你需要将拍照按钮放在外面，不要传这个参数
    imagePickerVc.selectedAssets = _selectedAssets; // optional, 可选的
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
#pragma mark - 到这里为止
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        NSLog(@"---------------------------%@",photos);
        
        NSLog(@">>>>>>>>>>>>>>>>>>>>---------------------------%@",assets);
        
//        UIImage *portraitImg;
//
//        for (UIImage *image in photos) {
//            
//            portraitImg = image;
//            
//        }
//        
//        portraitImg = [self imageByScalingToMaxSize:portraitImg];
//        // 裁剪
//        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:portraitImg];
//        imageCropVC.delegate = self;
//        [self presentViewController:imageCropVC animated:YES completion:^{
//            // TO DO
//            
//            
//            NSLog(@"照片选择");
//            
//            
//        }];

        
        
        
        
        
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS8Later) {
        // 无权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([type isEqualToString:@"public.image"]) {
//        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
//        [tzImagePickerVc showProgressHUD];
//        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        // save photo and get asset / 保存图片，获取到asset
//        [[TZImageManager manager] savePhotoWithImage:image completion:^{
//            [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
//                [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
//                    [tzImagePickerVc hideProgressHUD];
//                    TZAssetModel *assetModel = [models firstObject];
//                    if (tzImagePickerVc.sortAscendingByModificationDate) {
//                        assetModel = [models lastObject];
//                    }
//                    [_selectedAssets addObject:assetModel.asset];
//                    [_selectedPhotos addObject:image];
//                }];
//            }];
//        }];
//    }
    
    
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        
        NSLog(@"=======================%@========",portraitImg);

        // 裁剪
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:portraitImg];
        imageCropVC.delegate = self;
        [self presentViewController:imageCropVC animated:YES completion:^{
            // TO DO
            
            
            NSLog(@"照片选择");
            
            NSLog(@"=======================");

            
            
        }];
    }];

}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=Photos"]];
        }
    }
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
//    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
//    _selectedAssets = [NSMutableArray arrayWithArray:assets];
//    _isSelectOriginalPhoto = isSelectOriginalPhoto;
////    _layout.itemCount = _selectedPhotos.count;
    
    UIImage *portraitImg;
    
    for (UIImage *image in photos) {
        
        portraitImg = image;
        
    }
    
    portraitImg = [self imageByScalingToMaxSize:portraitImg];
    // 裁剪
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:portraitImg];
    imageCropVC.delegate = self;
    [self presentViewController:imageCropVC animated:YES completion:^{
        // TO DO
        
        
        NSLog(@"照片选择");
        
        
    }];

    

}











#pragma mark - RSKImageCropViewControllerDelegate
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];

}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    

    btn.userInteractionEnabled = YES;
    btn.alpha = 1;
    
    self.portraitImageView.image = croppedImage;
    
    NSLog(@"-=========================%@",_portraitImageView);


    [TDSystemService uploadGroupHeaderImage:croppedImage progress:^(NSString *key, float percent) {
        NSLog(@"qin niu --%@",key);
    } success:^(NSString *url) {
        NSLog(@"qin niu --%@",url);
        if ([url rangeOfString:@"static/group_header/"].location!=NSNotFound) {
            _imagenewCircleImg = [url stringByReplacingOccurrencesOfString:@"static/group_header/" withString:@""];
            
            
            NSLog(@"-=========================%@",_imagenewCircleImg);
            
            [CircleImageManager shareInstance].CircleImage =_imagenewCircleImg;

        }
        

    } failure:^{
        NSLog(@" --->> error:");
    }];
    
    
    _cameraImg.hidden = NO;
    [controller dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
    
   
    
}





#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    
//    [picker dismissViewControllerAnimated:YES completion:^() {
//        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//        portraitImg = [self imageByScalingToMaxSize:portraitImg];
//        // 裁剪
//        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:portraitImg];
//        imageCropVC.delegate = self;
//       [self presentViewController:imageCropVC animated:YES completion:^{
//            // TO DO
//            
//            
//            NSLog(@"照片选择");
//            
//            
//        }];
//    }];
//}





-(void)drawRect:(CGRect)rect
{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextAddRect(ref, rect);
    CGContextAddArc(ref, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2, arcWitch, 0, M_PI*2, NO);
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]setFill];
    CGContextDrawPath(ref, kCGPathEOFill);
    
    CGContextAddArc(ref, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2, arcWitch, 0, M_PI*2, NO);
    [[UIColor whiteColor]setStroke];
    CGContextStrokePath(ref);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
     NSLog(@"======%lu",(unsigned long)navigationController.viewControllers.count);
    if (navigationController.viewControllers.count == 3)
    {
        Method method = class_getInstanceMethod([self class], @selector(drawRect:));
        class_replaceMethod([[[[navigationController viewControllers][2].view subviews][1] subviews][0] class],@selector(drawRect:),method_getImplementation(method),method_getTypeEncoding(method));
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    if (!_portraitImageView) {
        CGFloat w = 150.0f; CGFloat h = w;
        CGFloat x = (self.view.frame.size.width - w) / 2;
        CGFloat y = (self.view.frame.size.height - h) / 2 ;
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _portraitImageView.backgroundColor = [UIColor clearColor];
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
//        _portraitImageView.layer.shadowColor = [UIColor blackColor].CGColor;
//        _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
//        _portraitImageView.layer.shadowOpacity = 0.5;
//        _portraitImageView.layer.shadowRadius = 2.0;
        if ([CircleImageManager shareInstance].CircleImage != nil) {
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[[CircleImageManager shareInstance].CircleImage lkbImageUrl5] ,@"circleAvatar",nil];
            [FileHelpers dispatch_process_with_thread:^{
                UIImage* ima = [self LoadImage:dic];
                return ima;
            } result:^(UIImage *ima){
                [_portraitImageView setImage:ima];
            }];
            
            
            
        }


        _portraitImageView.layer.borderColor = [[UIColor clearColor] CGColor];
        _portraitImageView.layer.borderWidth = 1.0f;
        _portraitImageView.userInteractionEnabled = YES;
        _portraitImageView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [_portraitImageView addGestureRecognizer:portraitTap];
    }
    return _portraitImageView;
}

#pragma mark portraitImageView getter
- (UIImageView *)cameraImg {
    if (!_cameraImg) {
        CGFloat w = 35.0f; CGFloat h = 25;
        CGFloat x = (_portraitImageView.frame.size.width - w) / 2;
        CGFloat y = (_portraitImageView.frame.size.height - h) / 2;
        _cameraImg = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];


        [_cameraImg setImage:[UIImage imageNamed:@"createcircle_icon_headportrait_replace"]];
        _cameraImg.userInteractionEnabled = YES;
        _cameraImg.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [_cameraImg addGestureRecognizer:portraitTap];
        if ([CircleImageManager shareInstance].CircleImage != nil) {
            
            _cameraImg.hidden= NO;
        }
        else{
            
            _cameraImg.hidden= YES;
            
        }

    }
    return _cameraImg;
}







@end
