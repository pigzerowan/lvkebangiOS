//
//  CreateColumnViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/3.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "CreateColumnViewController.h"
#import "LKBPrefixHeader.pch"
#import "FileHelpers.h"
#import "SetGroupNameViewController.h"
#import "SimpleGroupIntroduceViewController.h"
#import "SetColumnNameViewController.h"
#import "SetColumnIntroduceViewController.h"
#import "MyUserInfoManager.h"
#import "SVPullToRefresh.h"
#import "ColumnInfoMation.h"
#import <UIImageView+WebCache.h>
#import "NSStrUtil.h"
#import "MyColumnViewController.h"
#import "SetUpColumnManager.h"
#import "MBProgressHUD+Add.h"
static NSString* ColumnStypeCellIdentifier = @"ColumnCellIdentifier";

@interface CreateColumnViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray * classArray;
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UIView * headerView;
@property (strong, nonatomic) UIView * footerView;
@property (nonatomic, strong)UIVisualEffectView * visualEffectView; //毛玻璃效果
@property (strong, nonatomic) UIImageView * header;
@property (strong, nonatomic) UIImage *headImg;
@property (strong, nonatomic) UIButton * headImage;
@property (strong, nonatomic) UILabel * columnName;
@property (strong, nonatomic) UILabel * columnIntroduce;



@property (nonatomic, copy) NSURL *photoUrl;


@end

@implementation CreateColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _classArray = @[@"专栏名称",@"专栏简介"];
    
    if ([_type isEqualToString:@"1"]) {
        self.title =@"设置专栏";
    }
    else {
        self.title = @"创建专栏";
    }
    

    [self.view addSubview:self.tableView];

    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishButton)];
    self.navigationItem.rightBarButtonItem = right;
    
    if ([_type isEqualToString:@"1"]) {
        
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"featureId":_featureId,
                              @"token":[[MyUserInfoManager shareInstance]token]
                              };
        
        self.requestURL = LKB_ColumnInfo_Url;
    }
    
//    _photoUrl = [self.featureAvatar lkbImageUrl8];
//    _photoUrl = [[SetUpColumnManager shareInstance].featureAvatar lkbImageUrl8];
    _photoUrl = [_featureAvatar lkbImageUrl8];
    NSLog(@"================================================%@",[SetUpColumnManager shareInstance].featureAvatar);
    NSLog(@"================================================%@",[[SetUpColumnManager shareInstance].featureAvatar lkbImageUrl8]);
    NSLog(@"================================================%@",_photoUrl);

    // Do any additional setup after loading the view.
}

- (void)finishButton {
    
//    if ([_columnName.text isEqualToString:@"" ]|| _columnName.text == nil) {
//        
//        [self ShowProgressHUDwithMessage:@"请输入专栏名称"];
//    }
//    if ([_columnIntroduce.text isEqualToString:@""]||_columnIntroduce.text == nil) {
//        [self ShowProgressHUDwithMessage:@"请输入专栏简介"];
//    }
//    
//    if (_headImg == nil) {
//        NSString *str = [SetUpColumnManager shareInstance].featureAvatar ;
//        UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[str lkbImageUrl8]]];
//        
//        _headImg = image;
//    }

    
    
        // 如果是设置界面进入
        if ([_type isEqualToString:@"1"]) {
            
            if ([_columnName.text isEqualToString:@"" ]|| _columnName.text == nil) {
                
                [self ShowProgressHUDwithMessage:@"请输入专栏名称"];
            }
            else if ([_columnIntroduce.text isEqualToString:@""]||_columnIntroduce.text == nil) {
                [self ShowProgressHUDwithMessage:@"请输入专栏简介"];
            }
            
            else if (_headImg == nil) {
                NSString *str = [SetUpColumnManager shareInstance].featureAvatar ;
                UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[str lkbImageUrl8]]];
                
                _headImg = image;
            }
            else {
                
                NSDictionary *mydic = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                        @"featureName":_columnName.text,
                                        @"featureDesc":_columnIntroduce.text,
                                        @"featureId":_featureId,
                                        @"token":[[MyUserInfoManager shareInstance]token]// 个人简介
                                        };
                
                // 带图片上传时数据请求
                [[LKBNetworkManage sharedMange]postResultWithInsigServiceUrl:LKB_ColumnInfo_Update_Url parameters:mydic singleImage:_headImg imageName:@"featureAvatar" success:^(id responseData) {
                    
                    NSLog(@"成功");
                    
                    [self ShowProgressHUDwithMessage:responseData[@"msg"]];
                    
                    //                MyColumnViewController *peopleVC = [[MyColumnViewController alloc] init];
                    //                peopleVC.therquestUrl = [MyUserInfoManager shareInstance].userId;
                    //                peopleVC.title = @"我的专栏";
                    //                peopleVC.hidesBottomBarWhenPushed = YES;
                    //                [self.navigationController pushViewController:peopleVC animated:YES];
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                } failure:^(NSString *errorMessage) {
                    
                    [self ShowProgressHUDwithMessage:errorMessage];
                    
                }];
                
            }
        }
    
        else{
            
            if ([_columnName.text isEqualToString:@"" ]|| _columnName.text == nil) {
                
                [self ShowProgressHUDwithMessage:@"请输入专栏名称"];
            }
            else if ([_columnIntroduce.text isEqualToString:@""]||_columnIntroduce.text == nil) {
                [self ShowProgressHUDwithMessage:@"请输入专栏简介"];
            }
            
            else if (_headImg == nil) {
                NSString *str = [SetUpColumnManager shareInstance].featureAvatar ;
                UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[str lkbImageUrl8]]];
                
                _headImg = image;
            }
            
            
            else {
                NSDictionary *mydic = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                        @"featureName":_columnName.text,
                                        @"featureDesc":_columnIntroduce.text,
                                        @"token":[[MyUserInfoManager shareInstance]token]// 个人简介
                                        };
                
                // 带图片上传时数据请求
                [[LKBNetworkManage sharedMange]postResultWithInsigServiceUrl:LKB_Column_Create_Url parameters:mydic singleImage:_headImg imageName:@"featureAvatar" success:^(id responseData) {
                    
                    NSLog(@"成功");
                    
                    [self ShowProgressHUDwithMessage:responseData[@"msg"]];
                    
                    //                MyColumnViewController *peopleVC = [[MyColumnViewController alloc] init];
                    //                peopleVC.therquestUrl = [MyUserInfoManager shareInstance].userId;
                    //                peopleVC.title = @"我的专栏";
                    //                peopleVC.hidesBottomBarWhenPushed = YES;
                    //                [self.navigationController pushViewController:peopleVC animated:YES];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                } failure:^(NSString *errorMessage) {
                    
                    [self ShowProgressHUDwithMessage:errorMessage];
                    
                }];
            }
        }
    
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _headImage.imageView.image = _headImg;
    
    if (_headImg!=nil) {
        
        [_headImage setImage:_headImg forState:UIControlStateNormal];
        [_header setImage:_headImg];
    }
    
}

-(void)resetLabel:(NSString *)textField
{
    _columnName.text=textField;
}

-(void)resetGroupIntroduceLabel:(NSString *)textField
{
    _columnIntroduce.text=textField;
}


- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ColumnStypeCellIdentifier];
        _tableView.scrollEnabled = false;
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ColumnStypeCellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ColumnStypeCellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _classArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    if (indexPath.row==0) {
        if (!_columnName) {
            _columnName = [[UILabel alloc]initWithFrame:CGRectMake(120, 5, kDeviceWidth-150, 30)];
        }
        _columnName.textAlignment = NSTextAlignmentRight;
        _columnName.font = [UIFont systemFontOfSize:13];
        _columnName.textColor = [UIColor colorWithRed:194 /256 green:139/256 blue:83/256 alpha:1];
        [cell addSubview:_columnName];
        
    }
    else if (indexPath.row == 1) {
        if (!_columnIntroduce) {
            _columnIntroduce = [[UILabel alloc]initWithFrame:CGRectMake(120, 5, kDeviceWidth-150, 30)];
        }
        _columnIntroduce.textAlignment = NSTextAlignmentRight;
        _columnIntroduce.font = [UIFont systemFontOfSize:13];
        _columnIntroduce.textColor = [UIColor colorWithRed:194 /256 green:139/256 blue:83/256 alpha:1];
        [cell addSubview:_columnIntroduce];
        
    }

    return cell;
}
// 区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    _header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 150)];
//    _header.image = [UIImage imageNamed:@"PerfectBasicInformation_bg"];
    if (_header==nil) {
        
        
        _header = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PerfectBasicInformation_bg"]];
        _header.frame = _headerView.frame;
        
    }
    else {
        
        
        _headImg = [UIImage imageWithContentsOfFile:pathForURL(_photoUrl)];
        
        _header = [[UIImageView alloc]initWithImage:_headImg];
        _header.frame = _headerView.frame;
        
    }

    _header.userInteractionEnabled = YES;
    [self.headerView addSubview:_header];
    
    _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    _visualEffectView.frame = _header.frame;
    _visualEffectView.alpha = 1.0;
    [_header addSubview:_visualEffectView];
    
    
    [self initializePageSubviews];
    
    return _headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    self.automaticallyAdjustsScrollViewInsets =NO;
    return 165;
}

// 区尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    _footerView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height - 213 - 176 , self.view.frame.size.width, self.view.frame.size.height - 213 - 176 )];
    
    _footerView.backgroundColor = [UIColor whiteColor];
    _footerView.userInteractionEnabled = YES;
    
    
//    [self.footerView addSubview:self.finishButton];
//    // 完成
//    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.footerView).offset(10);
//        make.right.mas_equalTo(self.footerView).offset(-10);
//        make.bottom.mas_equalTo(self.footerView).offset(-44);
//        make.size.mas_equalTo(CGSizeMake(56,40));
//    }];
    
    return _footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return  self.view.frame.size.height - 213 - 176;
}



- (void)initializePageSubviews {
    
    [self.header addSubview:self.headImage];
    
    CGFloat padding = iPhone4 ? 24 : 44;
    
    // 头像
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(padding).offset(23);
        make.centerX.mas_equalTo(self.headerView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        
    }];
    
    
//    // 名字编辑
//    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_headImage.bottom).offset(5);
//        make.size.mas_equalTo(CGSizeMake(60, 20));
//        make.centerX.mas_equalTo(self.headerView);
//    }];
    
    
    
}
// 设置头像
- (UIButton *)headImage {
    
    _headImage = [UIButton buttonWithType:UIButtonTypeCustom];
    _headImage.layer.cornerRadius = 40.f;
    _headImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _headImage.layer.borderWidth = 1.0f;
    _headImage.layer.masksToBounds = YES;
    if (_photoUrl== nil) {
        
        [_headImage setImage:[UIImage imageNamed:@"setHeaderImage"] forState:UIControlStateNormal];
    }
    else {
        
        if (hasCachedImage(_photoUrl))
        {
            [_headImage setImage:_headImg forState:UIControlStateNormal];
        }
        else
        {
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_photoUrl,@"featureAvatar",nil];
            [FileHelpers dispatch_process_with_thread:^{
                UIImage* ima = [self LoadImage:dic];
                return ima;
            } result:^(UIImage *ima){
                [_headImage setImage:ima forState:UIControlStateNormal];
            }];
        }
        
        
    }
    
    [_headImage addTarget:self action:@selector(headerImage:) forControlEvents:UIControlEventTouchUpInside];
    
    return _headImage;
}

//异步加载图片
- (UIImage *)LoadImage:(NSDictionary*)aDic{
    
    NSLog(@"--------------------------%@",aDic);

    
//    NSURL *aURL=[NSURL URLWithString:[aDic objectForKey:@"featureAvatar"]];
    NSURL *aURL = [aDic objectForKey:@"featureAvatar"];
    
    NSData *data=[NSData dataWithContentsOfURL:aURL];
    if (data == nil) {
        return nil;
    }
    UIImage *image=[UIImage imageWithData:data];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager createFileAtPath:pathForURL(aURL) contents:data attributes:nil];
    return image;
}



- (void)headerImage:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [actionSheet addButtonWithTitle:@"拍照"];
    [actionSheet addButtonWithTitle:@"从手机相册选择"];
    // 同时添加一个取消按钮
    [actionSheet addButtonWithTitle:@"取消"];
    // 将取消按钮的index设置成我们刚添加的那个按钮，这样在delegate中就可以知道是那个按钮
    actionSheet.destructiveButtonIndex = actionSheet.numberOfButtons - 1;
    [actionSheet showInView:self.view];
}

#pragma mark - 判断设备是否有摄像头

- (BOOL) isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}


#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.editing = YES;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    if (buttonIndex == 0)//照相机
    {
        if ([self isCameraAvailable]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentViewController:imagePicker animated:YES completion:nil];
            [self presentViewController:imagePicker animated:YES completion:nil];
            //            [self.navigationController pushViewController:imagePicker animated:YES];
        }else{
            //            [PublicMethod showMBProgressHUD:@"该设备没有摄像头" andWhereView:self.view hiddenTime:kHiddenTime];
            [self ShowProgressHUDwithMessage:@"没有摄像头"];
        }
    }
    if (buttonIndex == 1)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //        [self presentViewController:imagePicker animated:YES completion:nil];
        //        [self presentModalViewController:imagePicker animated:YES ];
        [self presentViewController:imagePicker animated:YES completion:nil];
        //        [self.navigationController pushViewController:imagePicker animated:YES];
        
    }
    if (buttonIndex == 2)
    {
        //        [self presentModalViewController:imagePicker animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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


#pragma mark - UIImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //    UIImage *image = [[info objectForKey:UIImagePickerControllerEditedImage];
    //    UIImage *image = [info objectForKey:UIImagePickerControllerCameraDeviceRear];
    UIImage *image1 = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:) withObject:image1 afterDelay:0.5];
    //    [self dismissViewControllerAnimated:YES completion:^{
    //
    //    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



#pragma mark -

- (void)saveImage:(UIImage *)image
{
    
    //    NSData *data = UIImagePNGRepresentation(image);
    //            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    //           // 要解决此问题，
    //           // 可以在上传时使用当前的系统事件作为文件名
    //            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //            // 设置时间格式
    //            formatter.dateFormat = @"yyyyMMddHHmmss";
    //             NSString *str = [formatter stringFromDate:[NSDate date]];
    //            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    //    _photoImg = changeImageSize(image,200,200);
    //    NSData *_data = UIImageJPEGRepresentation(_photoImg, 1.0);
    //    _encodedImageStr = [_data base64EncodedStringWithOptions:NSUTF8StringEncoding];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    _headImg = image;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0){
        

        SetColumnNameViewController *setColumnName = [[SetColumnNameViewController alloc]init];
        
        [setColumnName nextVCBlock:^(NSString *textField) {
            [self resetLabel:textField];
        }];
        
        setColumnName.column = _columnName.text;
        [self.navigationController pushViewController:setColumnName animated:YES];
        
    }
    else {

        SetColumnIntroduceViewController *columnVC = [[SetColumnIntroduceViewController alloc]init];
        
        [columnVC sendeGroupIntroduceBlock:^(NSString *textField) {
            [self resetGroupIntroduceLabel:textField];
        }];
        columnVC.introduce = _columnIntroduce.text;
//        columnVC.title = @"专栏简介";
        [self.navigationController pushViewController:columnVC animated:YES];
        
    }


}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage  {
    
//    if (!request.isLoadingMore) {
//        [self.tableView.pullToRefreshView stopAnimating];
//    } else {
//        [self.tableView.infiniteScrollingView stopAnimating];
//    }
//    
//    if (errorMessage) {
//        [MBProgressHUD showError:errorMessage toView:self.view];
//        return;
//    }
    
    if ([request.url isEqualToString:LKB_ColumnInfo_Url]) {
        ColumnInfoMation *ColumnInfoMationModel = (ColumnInfoMation *)parserObject;
        ColumnInfoMationDetailModel *detailMode =ColumnInfoMationModel.data;
        
        NSLog(@"------------------------------------------%@",detailMode.featureAvatar);
        _columnName.text = detailMode.featureName;
        _columnIntroduce.text = detailMode.featureDesc;
        
        _featureAvatar = detailMode.featureAvatar;
        [_header sd_setImageWithURL:[detailMode.featureAvatar lkbImageUrl8] placeholderImage:YQNormalPlaceImage];
        
    }

    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
