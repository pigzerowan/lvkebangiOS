//
//  SetUserInfoViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 9/21/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "SetUserInfoViewController.h"
#import "FileHelpers.h"
#import "MBProgressHUD+Add.h"
#import "LKBNetworkManage.h"
#import "CityViewController.h"
#import "MyUserInfoManager.h"
#import "IntroduceSelfViewController.h"
#import "LocationAreaViewController.h"
#import "UserCenterModel.h"
#import "areaManager.h"
#import "ChangeChooseViewController.h"
static NSString* CellIdentifier = @"UserCellIdentifier";
@interface SetUserInfoViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
      UIButton *photoBtn;
    NSString *_encodedImageStr;
}
@property (strong, nonatomic) NSArray *classArray;
@property (strong, nonatomic) UITableView* tableView;
@property(nonatomic,copy)UIImage *photoImg;
@property(nonatomic,copy)NSURL *photoUrl;
@property(nonatomic,strong)UILabel *nickNameLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UILabel *areaLable;

@end

@implementation SetUserInfoViewController

#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
    self.tableView.scrollEnabled = NO;
    _classArray = @[@"头像",@"昵称",@"个人简介",@"所在地区",@"行业"];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;

    _photoUrl =  [[MyUserInfoManager shareInstance].avatar lkbImageUrl];
    
    //    NSString *city = [[UserMationMange sharedInstance] userDefaultCity];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:city style:UIBarButtonItemStylePlain target:self action:@selector(didLeftBarButtonItemAction:)];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarButtonItemAction:)];
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.requestParas = @{@"userId":[MyUserInfoManager shareInstance].userId,
                          @"fromUser":[MyUserInfoManager shareInstance].userId
                          };
    self.requestURL = LKB_User_Center_Url;
    
    
    
//    if ([MyUserInfoManager shareInstance].nickName!=nil) {
//        _nickNameLab.text = [MyUserInfoManager shareInstance].nickName;
//    }
//    
//    if ([MyUserInfoManager shareInstance].desc!=nil) {
//        _descLab.text = [MyUserInfoManager shareInstance].desc;
//        NSLog(@"==========================%@",_descLab.text);
//    }
}






#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        return 2;
    }else
    {
        return 3;
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (indexPath.section==0) {
        if(indexPath.row==0 )
        {
            return 80;
        }else
        {
            return 50;
        }
    }
    return 50;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (indexPath.section==0&&indexPath.row==0 ) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 79, SCREEN_WIDTH, 1)];
        lineView.backgroundColor =UIColorWithRGBA(237, 238, 239, 1);
        [cell addSubview:lineView];
        
    }
    if (indexPath.section==0) {
           cell.textLabel.text = _classArray[indexPath.row];
//        photoBtn.layer.cornerRadius = 30;
        
        if (indexPath.row==0) {
             photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 10, 60, 60)];
            if (_photoUrl == nil) {
                [photoBtn setImage:[UIImage imageNamed:@"bg_head"] forState:UIControlStateNormal];
            }else{
                if (hasCachedImage(_photoUrl))
                {
                    _photoImg = [UIImage imageWithContentsOfFile:pathForURL(_photoUrl)];
                    [photoBtn setImage:_photoImg forState:UIControlStateNormal];
                }
                else
                {
                    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_photoUrl,@"Photo",nil];
                    [FileHelpers dispatch_process_with_thread:^{
                        UIImage* ima = [self LoadImage:dic];
                        return ima;
                    } result:^(UIImage *ima){
                        [photoBtn setImage:ima forState:UIControlStateNormal];
                    }];
                }
                
            }
            [photoBtn addTarget:self action:@selector(btnUploadHeadClicked:)forControlEvents:UIControlEventTouchUpInside];
              [cell addSubview:photoBtn];
        }
        else if(indexPath.row==1){
            if ([MyUserInfoManager shareInstance].nickName!=nil) {
                if (!_nickNameLab) {
                     _nickNameLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+80, 10, 80, 30)];
                }
               
                _nickNameLab.font = [UIFont systemFontOfSize:13];
                _nickNameLab.textColor = [UIColor lightGrayColor];
                _nickNameLab.text = [MyUserInfoManager shareInstance].nickName;
                [cell addSubview:_nickNameLab];
            }
        }

    }else if(indexPath.section==1)
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor =UIColorWithRGBA(237, 238, 239, 1);
        [cell addSubview:lineView];
        cell.textLabel.text = _classArray[indexPath.row+2];
        
        if (indexPath.row==0) {
            if (!_descLab) {
                _descLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+30, 10, 120, 30)];
            }
            
            _descLab.text = [MyUserInfoManager shareInstance].desc;
            _descLab.font = [UIFont systemFontOfSize:13];
            _descLab.textColor = [UIColor lightGrayColor];
            [cell addSubview:_descLab];

        }
       else if (indexPath.row==1) {
           if (!_areaLable) {
                _areaLable = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+80, 10, 120, 30)];
           }
           
            _areaLable.text = [areaManager shareInstance].areaName;
            _areaLable.font = [UIFont systemFontOfSize:13];
            _areaLable.textColor = [UIColor lightGrayColor];
            [cell addSubview:_areaLable];
            
        }
    }


    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
            
        }else
        {
            PushNickNameViewController *nickNameVC = [[PushNickNameViewController alloc] init];
            [self.navigationController pushViewController:nickNameVC animated:YES];
        }
        
        
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            IntroduceSelfViewController *IntroduceVC = [[IntroduceSelfViewController alloc] init];
            [self.navigationController pushViewController:IntroduceVC animated:YES];

            
        }
        else if(indexPath.row==1)
        {
            
            LocationAreaViewController *IntroduceVC = [[LocationAreaViewController alloc] init];
            [self.navigationController pushViewController:IntroduceVC animated:YES];

            
            
//            CityViewController *cityVC = [[CityViewController alloc] initWithStyle:UITableViewStylePlain];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cityVC];
//            __weak __typeof(self)weakSelf = self;
//            [cityVC setFinishedSelectBlock:^(NSString *city) {
//                __strong __typeof(weakSelf)strongSelf = weakSelf;
//                NSString *cityStr = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
//                strongSelf.navigationItem.leftBarButtonItem.title = cityStr;
//            }];
//            [self presentViewController:nav animated:YES completion:^{
//                
//            }];

        }else
        {
            ChangeChooseViewController *peopleVC = [[ChangeChooseViewController alloc] init];
//            peopleVC.typeStr = @"1";
            [self.navigationController pushViewController:peopleVC animated:YES];
        }

    }
    if(indexPath.section==2)
    {
        
    }
}


//异步加载图片
- (UIImage *)LoadImage:(NSDictionary*)aDic{
    NSURL *aURL=[aDic objectForKey:@"Photo"];
    NSData *data=[NSData dataWithContentsOfURL:aURL];
    if (data == nil) {
        return nil;
    }
    UIImage *image=[UIImage imageWithData:data];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager createFileAtPath:pathForURL(aURL) contents:data attributes:nil];
    return image;
}


- (void)btnUploadHeadClicked:(id)sender
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
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
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

     NSDictionary *params = @{@"userId":[MyUserInfoManager shareInstance].userId};
//    self.requestURL = LKB_Center_Useravatar_Url;
    
    [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Center_Useravatar_Url parameters:params singleImage:image imageName:@"avatar" success:^(id responseData) {
 
            [self ShowProgressHUDwithMessage:@"上传成功"];
    } failure:^(NSString *errorMessage) {
        
    }];
}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    if ([request.url isEqualToString:LKB_Center_Useravatar_Url]) {
        
    }
    
    if ([request.url isEqualToString:LKB_User_Center_Url]) {
        UserCenterModel *userCenterModel = (UserCenterModel *)parserObject;
        
        NSLog(@"=======%@========",userCenterModel.ifAttention);
        [MyUserInfoManager shareInstance].nickName = userCenterModel.contactName;
        [areaManager shareInstance].areaName = userCenterModel.areaName;
        [MyUserInfoManager shareInstance].desc = userCenterModel.singleDescription;
        
        [self.tableView reloadData];
    }
    
}

#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    _nickNameLab.text=nil;
     _descLab.text=nil;
     _areaLable.text=nil;

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
