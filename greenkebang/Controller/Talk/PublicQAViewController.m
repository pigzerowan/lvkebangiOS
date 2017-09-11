//
//  PublicQAViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 11/17/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "PublicQAViewController.h"
#import "WtDynamicPhotoCell.h"


NSInteger const Photo = 8;
@interface PublicQAViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIButton *photoBtn;
    NSString *_encodedImageStr;
    UIButton *aBt;
}
@property(nonatomic,copy)NSString *photoUrl;
@property(nonatomic,strong)UIImage *photoImg;
@property(nonatomic,strong)UIImageView *lineImg;
@property (strong, nonatomic)UITextField *titleTextFiled;
@property (strong, nonatomic)UIButton *creatBtn;
@property (copy, nonatomic)UITextField *describleTextFiled;

@property (strong, nonatomic)  UICollectionView *collectionView;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger deleteIndex;

@property (assign, nonatomic) BOOL wobble;
@end



@implementation PublicQAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建问答";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    
    
    self.photos = [[NSMutableArray alloc ] init];
    
    self.dataArray = [[NSMutableArray alloc ] init];
    [self.dataArray addObject:[UIImage imageNamed:@"plus"]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    
      // Do any additional setup after loading the view.
}


-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)initSubViews
{
    [self.view addSubview:self.describleTextFiled];
    [self.view addSubview:self.titleTextFiled];
    [self.view addSubview:self.collectionView];

}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSLog(@"%lu",(unsigned long)_dataArray.count);
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WtDynamicPhotoCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"WtDynamicPhotoCell" forIndexPath:indexPath];
    cell.tag = indexPath.row;
    // 删除按钮
    cell.closeBtn.tag = indexPath.row;
    [cell.closeBtn addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    cell.photoImageView.image = self.dataArray[indexPath.row];
    
    if (indexPath.row == self.dataArray.count -1) {
        cell.ddBtn.hidden = NO;
    }else
    {
        cell.ddBtn.hidden = YES;
    }
    
    
    [cell.ddBtn addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
    // 长按删除
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc ] initWithTarget:self action:@selector(longPressedAction)];
    [cell.contentView addGestureRecognizer:longPress];
    
    return cell;
}



#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    return CGSizeMake((kDeviceWidth-30)/4, 75);
}

// 删除方法
-(void)deletePhoto:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc ] initWithTitle:@"提示" message:@"您确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.deleteIndex = sender.tag;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.dataArray removeObjectAtIndex:self.deleteIndex];
        NSIndexPath *path =  [NSIndexPath indexPathForRow:self.deleteIndex inSection:0];
        [self.collectionView deleteItemsAtIndexPaths:@[path]];
        
        // 如果删除完，则取消编辑
        if (self.dataArray.count == 1) {
            [self cancelWobble];
            
        }
        // 没有删除完，执行晃动动画
        else
        {
            [self longPressedAction];
        }
    }
}

// 添加图片
-(void)addPhoto
{
    // 如果是编辑状态则取消编辑状态
    if (self.wobble) {
        [self cancelWobble];
    }
    // 不是编辑状态，添加图片
    else
    {
        
        if (self.dataArray.count > Photo) {
            UIAlertView *alert = [[UIAlertView alloc ] initWithTitle:@"提示" message:@"最多支持8个" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alert show];
        }else
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:nil
                                          delegate:(id)self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"拍照", @"我的相册",nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [actionSheet showInView:self.view];
        }
    }
}


// 取消晃动
-(void)cancelWobble
{
    self.wobble = NO;
    NSArray *array =  [self.collectionView subviews];
    
    for (int i = 0; i < array.count; i ++) {
        
        
        if ([array[i] isKindOfClass:[WtDynamicPhotoCell class]]) {
            WtDynamicPhotoCell *cell = array[i];
            cell.closeBtn.hidden =  YES;
            if (cell.tag == 999999) {
                cell.photoImageView.image = [UIImage imageNamed:@"plus"];
            }
            
            // 晃动动画
            [self animationViewCell:cell];
        }
    }
}

// 长按
-(void)longPressedAction
{
    self.wobble = YES;
    NSArray *array =  [self.collectionView subviews];
    
    for (int i = 0; i < array.count; i ++) {
        
        if ([array[i] isKindOfClass:[WtDynamicPhotoCell class]]) {
            WtDynamicPhotoCell *cell = array[i];
            
            if (cell.ddBtn.hidden) {
                cell.closeBtn.hidden = NO;
            }
            else
            {
                cell.closeBtn.hidden = YES;
                cell.photoImageView.image = [UIImage imageNamed:@"ensure"];
                cell.tag = 999999;
            }
            
            // 晃动动画
            [self animationViewCell:cell];
        }
    }
}

// 晃动动画
-(void)animationViewCell:(WtDynamicPhotoCell *)cell
{
    //摇摆
    if (self.wobble){
        cell.transform = CGAffineTransformMakeRotation(-0.1);
        
        [UIView animateWithDuration:0.08
                              delay:0.0
                            options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear
                         animations:^{
                             cell.transform = CGAffineTransformMakeRotation(0.1);
                         } completion:nil];
    }
    else{
        
        [UIView animateWithDuration:0.25
                              delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             cell.transform = CGAffineTransformIdentity;
                         } completion:nil];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self openCamera];
    }else if(buttonIndex == 1) {
        [self openPics];
    }
}

// 打开相机
- (void)openCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if (_imagePicker == nil) {
            _imagePicker =  [[UIImagePickerController alloc] init];
        }
        _imagePicker.delegate = (id)self;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.showsCameraControls = YES;
        _imagePicker.allowsEditing = YES;
        [self.navigationController presentViewController:_imagePicker animated:YES completion:nil];
    }
}

// 打开相册
- (void)openPics {
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
    }
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.allowsEditing = YES;
    _imagePicker.delegate = (id)self;
    [self presentViewController:_imagePicker animated:YES completion:NULL];
}

// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    [_imagePicker dismissViewControllerAnimated:YES completion:NULL];
    _imagePicker = nil;
    
    // 判断获取类型：图片
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *theImage = nil;
        
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage] ;
            
        }
        if (self.dataArray.count>3) {
            return ;
        }
        else{
            
            [self.dataArray insertObject:theImage atIndex:0];
            
            
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.collectionView insertItemsAtIndexPaths:@[path]];
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark - 相册文件选取相关
// 相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}



- (void)ShowProgressHUDwithMessage:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.dimBackground = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}


- (UITextField*)describleTextFiled
{
    if (!_describleTextFiled) {
        _describleTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(10, 120, SCREEN_WIDTH-20, 150)];
        _describleTextFiled.placeholder = @"描述问题";
        _describleTextFiled.textColor = [UIColor textGrayColor];
        _describleTextFiled.font = [UIFont systemFontOfSize:13];
        _describleTextFiled.layer.borderWidth =1;
        _describleTextFiled.layer.borderColor = UIColorWithRGBA(237, 238, 239, 1).CGColor;
        _describleTextFiled.textAlignment =NSTextAlignmentLeft;
    }
    
    return _describleTextFiled;
}

- (UITextField*)titleTextFiled
{
    if (!_titleTextFiled) {
        _titleTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, SCREEN_WIDTH-20, 40)];
        _titleTextFiled.placeholder = @"问题";
        _titleTextFiled.layer.borderWidth =1;
         _titleTextFiled.layer.borderColor = UIColorWithRGBA(237, 238, 239, 1).CGColor;
        _titleTextFiled.textColor = [UIColor textGrayColor];
        _titleTextFiled.font = [UIFont systemFontOfSize:13];
        _titleTextFiled.textAlignment =NSTextAlignmentLeft;
 
        
    }
    return _titleTextFiled;
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    [_titleTextFiled resignFirstResponder];
    [_describleTextFiled resignFirstResponder];
}


- (UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing=5;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 300, SCREEN_WIDTH-20, 80)collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
         _collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[WtDynamicPhotoCell class]forCellWithReuseIdentifier:@"WtDynamicPhotoCell"];
//        _collectionView.backgroundColor = [UIColor redColor];
        
        
        
    }
    return _collectionView;
}



@end
