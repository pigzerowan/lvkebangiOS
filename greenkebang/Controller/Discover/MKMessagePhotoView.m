//
//  MKMessagePhotoView.h
//
//  Created by Mory on 16/3/12.
//  Copyright © 2016年 MCWonders. All rights reserved.
//


#import "MKMessagePhotoView.h"
//#import "AFNetworking.h"
//#import "MBProgressHUD+MJ.h"
//#import "MKCommitViewController.h"

#define MaxItemCount 9
#define ItemWidth 60
#define ItemHeight 100

//图片路径
#define  ImagePath  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Documents"]
#define KWIDTH [UIScreen mainScreen].bounds.size.width

@interface MKMessagePhotoView ()

/**
 *  这是背景滚动视图
 */
@property (nonatomic,strong) UIScrollView  *photoScrollView;
@property (nonatomic ,strong)MKComposePhotosView *photoItem;
@property (nonatomic, strong )NSMutableArray *array;
@property (nonatomic,strong) NSMutableArray *imgsArr;
@property (nonatomic,strong) NSMutableArray *imagePath;

@end
static int k = 10000;
@implementation MKMessagePhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup{
    
    _photoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 80)];
    _photoScrollView.contentSize = CGSizeMake(1024, 80);
    _itemArray = [NSMutableArray arrayWithCapacity:0];
    _array = [NSMutableArray arrayWithCapacity:0];
    _imgsArr = [NSMutableArray arrayWithCapacity:0];
    _imagePath = [NSMutableArray arrayWithCapacity:0];
    [self addSubview:_photoScrollView];
    
    [self initlizerScrollView:_array];
}

///调用布局
-(void)initlizerScrollView:(NSArray *)imgList{
    
    ///移除之前添加的图片缩略图
    [self.photoScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for(int i=0;i<imgList.count;i++){
        
        _photoItem = [[MKComposePhotosView alloc]initWithFrame:CGRectMake(16+ i * (ItemWidth + 8 ), 5, ItemWidth, ItemHeight)];
        _photoItem.delegate = self;
        _photoItem.index = i;
        _photoItem.image = (UIImage *)[imgList objectAtIndex:i];
        [self.photoScrollView addSubview:_photoItem];
        
       UIImage *img = (UIImage *)[imgList objectAtIndex:i];
        [self.itemArray addObject:img];
    }
    if(imgList.count<MaxItemCount){
        UIButton *btnphoto=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnphoto setFrame:CGRectMake(16 + (ItemWidth + 8) * imgList.count, 10, 60, 60)];//
        [btnphoto setImage:[UIImage imageNamed:@"release_btn_addimages_nor"] forState:UIControlStateNormal];
        [btnphoto setImage:[UIImage imageNamed:@"release_btn_addimages_nor"] forState:UIControlStateSelected];
        [btnphoto addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
        [self.photoScrollView addSubview:btnphoto];
    }
    
    NSInteger count = MIN(imgList.count, MaxItemCount);
    NSLog(@"]]]]]]]]]]]]]%ld",count);
    
    NSUserDefaults *imgPath = [NSUserDefaults standardUserDefaults];
    [imgPath setInteger:count forKey:@"imagecount"];
    [imgPath synchronize];
    
    if (count == 9) {
        [self.photoScrollView setContentSize:CGSizeMake(20 + (ItemWidth + 8)*count, 0)];

    }
    else {
        [self.photoScrollView setContentSize:CGSizeMake(20 + (ItemWidth + 8)*count +60, 0)];

    }
    
}
-(void)openMenu{
    //在这里呼出下方菜单按钮项
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles:@"打开照相机",@"从手机相册获取", nil];
    
    [myActionSheet showInView:self.window];
    
    
    
}
//下拉菜单的点击响应事件
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == myActionSheet.cancelButtonIndex){
        NSLog(@"取消");
    }
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self localPhoto];
            break;
        default:
            break;
    }
}

//开始拍照
-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [self.delegate addUIImagePicker:picker];
        
    }else{
        NSLog(@"模拟机中无法打开照相机,请在真机中使用");
    }
}


#pragma mark - ImagePicker delegate
//相机照完后点击use  后触发的方法 开始上传
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image =[info objectForKey:UIImagePickerControllerOriginalImage];
    [_array addObject:image];
    
    [self initlizerScrollView:_array];
    //压缩图片方法
    NSData *imageData=UIImageJPEGRepresentation(image, 0.5);
    
    [self imageWithImageData:imageData];
    
}

//打开相册，可以多选
-(void)localPhoto{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc]init];
    
    picker.maximumNumberOfSelection = 9;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,NSDictionary *bindings){
        if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
            return duration >= 5;
        }else{
            return  YES;
        }
    }];
    
    [self.delegate addPicker:picker];
    
    
}

/**
 * 得到选中的图片
 */
#pragma mark - ZYQAssetPickerController Delegate

-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSLog(@"assets is %lu",(unsigned long)assets.count);
    NSLog(@"你是什么%@",assets);
    
    for (int i =0; i< assets.count; i++) {
        
        ALAsset *asset = assets[i];
        ///获取到相册图片
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
        [_array addObject:tempImg];
        //压缩图片方法
        NSData *imageData=UIImageJPEGRepresentation(tempImg, 0.5);
        ///循环获得图片,并将其写入沙盒
        [self imageWithImageData:imageData];
        
    }
    
    [self initlizerScrollView:_array];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


/// 将原始图片转化为NSData数据,写入沙盒

- (void)imageWithImageData:(NSData *)imageData{
    
    k++;
    /// 创建存放原始图的文件夹--->Documents
    NSFileManager * fileManager = [NSFileManager defaultManager];
    ///判断有无文件夹
    if (![fileManager fileExistsAtPath:ImagePath]) {
        
        [fileManager createDirectoryAtPath:ImagePath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    ///获取沙盒目录
    filePath=[ImagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"maikejia%d.png",k]];
    [imageData writeToFile:filePath atomically:NO];
    NSLog(@"写入沙盒%@",filePath);
    
    [_imgsArr addObject:[NSString stringWithFormat:@"camera%d.png",k]];
    [_imagePath addObject:filePath];
    
    NSUserDefaults *imgPath = [NSUserDefaults standardUserDefaults];
    [imgPath setObject:_imagePath forKey:@"imagePath"];
    [imgPath setObject:_imgsArr forKey:@"fileName"];
    [imgPath synchronize];
    
    ////////////暂时隐藏上传
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //
    //        NSURL * URL = [NSURL URLWithString:@""];
    //        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    //        [request setHTTPMethod:@"POST"];
    //        [request setValue:@"" forHTTPHeaderField:@""];
    //        AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] init];
    //        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //
    //        [request addValue:[NSString stringWithFormat:@"camera%d.png",k] forHTTPHeaderField:@"fileName"];
    //        //进行上传操作
    //        NSURLSessionUploadTask *upLoadTask = [manager uploadTaskWithRequest:request fromData:imageData progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
    //                                              {
    //                                                  if (error) {
    //
    //                                                      [MBProgressHUD showError:@"请求失败"];
    //                                                  }else{
    //
    //                                                      NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    //
    //                                                      NSLog(@"请求完成的结果是:%@",dic);
    //                                                      //用户默认设置
    //                                                      NSUserDefaults *imgLinkDefault = [NSUserDefaults standardUserDefaults];
    //                                                      NSArray *aa = [[NSArray alloc] init];
    //                                                      aa = [imgLinkDefault objectForKey:@"imgLink"];
    //                                                      [aa arrayByAddingObject:[dic objectForKey:@"attachmentPath"]];
    //                                                      [imgLinkDefault setObject:aa forKey:@"aa"];
    //                                                      [imgLinkDefault synchronize];
    //
    //                                                  }
    //                                              }];
    //
    //        //开始上传操作
    //        [upLoadTask resume];
    //    });
    
    
    
}


#pragma mark - MKComposePhotosViewDelegate

///删除已选中图片并从新写入沙盒
-(void)MKComposePhotosView:(MKComposePhotosView *)MKComposePhotosView didSelectDeleBtnAtIndex:(NSInteger)Index{
    
    [_array removeObjectAtIndex:Index];
    [self initlizerScrollView:_array];
    
    /// 创建存放原始图的文件夹--->Documents
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    ///先删除原来沙盒里的文件
    [fileManager removeItemAtPath:ImagePath error:nil];
    for (int i = 0; i < _array.count; i++) {
        
        NSData *imgData =UIImageJPEGRepresentation([_array objectAtIndex:i], 0.5);
        
        [self imageWithImageData:imgData];
    }
    
    NSLog(@"%ld",(long)Index);
    
}



@end
