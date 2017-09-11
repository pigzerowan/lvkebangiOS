//
//  UserInforSettingViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/6.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforSettingViewController.h"
#import "MyUserInfoManager.h"
#import "UserInforModel.h"
#import "FileHelpers.h"
#import "CityViewController.h"
#import "LKBBaseNavigationController.h"
#import "SelectedRecommendViewController.h"
#import "TDSystemService.h"

static NSString* CellIdentifier = @"UserInforSettingCellIdentifier";

@interface UserInforSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,UITextFieldDelegate>

@end

@implementation UserInforSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    /*
     
     _publishButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     [_publishButton setFrame:CGRectMake(0, 2, 60, 28)];
     [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
     [_publishButton setTitleColor:CCCUIColorFromHex(0x69c21b) forState:UIControlStateNormal];
     
     //        [_publishButton setImage:[UIImage imageNamed:@"publish_Question"] forState:UIControlStateNormal];
     [_publishButton addTarget:self action:@selector(publishQuestion:) forControlEvents:UIControlEventTouchUpInside];
     UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_publishButton];
     self.navigationItem.rightBarButtonItem = releaseButtonItem;

     
     
     
     
     
     */
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([_attentionNum isEqualToString:@"0"]) {
        self.title = @"完善信息资料";
        _skipButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_skipButton setFrame:CGRectMake(0, 2, 60, 28)];
        [_skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        
        [_skipButton addTarget:self action:@selector(skipButton:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_skipButton];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
        

        
    }
    else {
        self.title= @"个人资料";
        
        _saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_saveButton sizeToFit];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        
        [_saveButton setFrame:CGRectMake(0, 2, 60, 28)];

        [_saveButton addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_saveButton];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
        
        _CancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_CancelButton setFrame:CGRectMake(0, 2, 60, 28)];
        [_CancelButton setTitle:@"取消" forState:UIControlStateNormal];
        
        [_CancelButton addTarget:self action:@selector(BackButton:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_CancelButton];
        self.navigationItem.leftBarButtonItem = leftButtonItem;
        
    }
    [self.view addSubview:self.tableView];
    
    
    
    
    
    self.introduceTextView.delegate = self;
    
    if ([_attentionNum isEqualToString:@"1"]) {
//        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
//                              @"ownerId":[[MyUserInfoManager shareInstance]userId],
//                              @"token":[MyUserInfoManager shareInstance].token
//                              };
//        
//        self.requestURL = LKB_User_Infor_Url;
        
    }
    else {
        
        UIButton * saveBut = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 - 64, SCREEN_WIDTH, 50)];
        saveBut.backgroundColor = CCColorFromRGBA(255, 255, 255, 1);
        saveBut.layer.borderColor =  [CCCUIColorFromHex(0xd3d3d3) CGColor];;
        saveBut.layer.borderWidth = 0.5f;
        [saveBut setTitle:@"保存" forState:UIControlStateNormal];
        [saveBut setTitleColor:CCCUIColorFromHex(0x22a941) forState:UIControlStateNormal];
        saveBut.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [saveBut addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view  addSubview:saveBut];

    }
    
    _photoUrl = [_headerImg lkbImageUrl4];
//    [MyUserInfoManager shareInstance].avatar = _headerImg;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
    
    
    
    
    
    
    // 键盘回收
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    

    
    // Do any additional setup after loading the view.
}



-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_nameTextField resignFirstResponder];
    [_identity resignFirstResponder];
    [_goodFiled resignFirstResponder];
    [_introduceTextView resignFirstResponder];
    
    
}




// 返回键
- (void)BackButton:(id)sender {
    if (![_attentionNum isEqualToString:@"0"])  {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定退出吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        [alert show];
        
    }
    else {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }
}


- (void)skipButton:(id)sender {
    
//    AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [appDelegate showUserTabBarViewController];
    
    SelectedRecommendViewController *attentionVC = [[SelectedRecommendViewController alloc]init];
    
    [self.navigationController pushViewController:attentionVC animated:YES];

    
}


// 完成键
- (void)saveButton:(id)sender {
    
    static const NSInteger Min_Num_TextView = 5;
    static const NSInteger Max_Num_TextView = 200;
    static const NSInteger Min_Name_TextField = 2;
    static const NSInteger Max_Name_TextField = 16;

    if (![_nameTextField.text isEqualToString:@""]|| _nameTextField.text !=nil) {
        
        _nameStr = _nameTextField.text;
    }
    
    if ([_SexLabel.text isEqualToString:@"男"]) {
        _sexTemp = @"0";
    }
    else if ([_SexLabel.text isEqualToString:@"女"]) {
        
        _sexTemp = @"1";
    }
    
    if ([_areaLabel.text isEqualToString:@""]||_areaLabel.text==nil) {
        
        _areaLabel.text = @"";
    }
    
    
    if ([_identity.text isEqualToString:@""]||_identity.text==nil) {
        
        _identity.text = @"";
    }
    
    if ([_goodFiled.text isEqualToString:@""]||_goodFiled.text==nil) {
        
        _goodFiledStr = @"";
    }
    else {
        _goodFiledStr =_goodFiled.text;
    }
    
    
    if ([_nameTextField.text isEqualToString:@""]|| _nameTextField.text ==nil ||self.nameTextField.text.length < Min_Name_TextField || self.nameTextField.text.length > Max_Name_TextField ||self.introduceTextView.text.length > Max_Num_TextView ) {
        
        
        if ([_nameTextField.text isEqualToString:@""]|| _nameTextField.text ==nil) {
            
            [self ShowProgressHUDwithMessage:@"昵称至少2个字"];
            
        }
        if (self.nameTextField.text.length < Min_Name_TextField ) {
            
            [self ShowProgressHUDwithMessage:@"昵称至少2个字"];
            
        }
        if (self.nameTextField.text.length > Max_Name_TextField ) {
            
            [self ShowProgressHUDwithMessage:@"昵称最多16个字"];
            
        }
        
        if (self.introduceTextView.text.length > Max_Num_TextView ) {
            
            [self ShowProgressHUDwithMessage:@"个人简介最多200个字"];
            
        }
        
        
    }
    else {
        
        NSString *str = [[MyUserInfoManager shareInstance]avatar];
        
        NSLog(@"=====================%@",str);
        UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[str lkbImageUrl4]]];
        
        NSLog(@"=====================%@",_headImg);

        
        if (_headImg == image) {
            
            self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"userName":_nameStr,
                                  @"gender":_sexTemp,
                                  //@"trade":_goodFiled.text,// 所属行业
                                  @"goodFiled":_goodFiledStr,// 所擅长的领域
                                  @"address":_areaLabel.text,// 居住地
                                  @"identity":_identity.text, // 职业身份
                                  @"remark":_introduceTextView.text,// 简介
                                  @"token":[[MyUserInfoManager shareInstance]token],// 个人简介
                                  };
            self.requestURL = LKB_Update_Url;
        }
        else {
            
            [TDSystemService uploadHeaderImage:_headImg progress:^(NSString *key, float percent) {
                
                NSLog(@",,,,,,,/.///////////////////_______________________%@",key);
                
                NSLog(@",,,,,,,/.///////////////////_______________________%f",percent);
                
                
            } success:^(NSString *url) {
                
                NSLog(@"--------------------%@",url);
                
                NSUInteger length = [@"static/user_header/" length];
                
                NSString * urlStr = [url substringFromIndex:length];
                
                NSLog(@">>>>>>>>>>>>--------------------%@",urlStr);
                
                [MyUserInfoManager shareInstance].avatar = urlStr;
                
                self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                      @"avatar":urlStr,
                                      @"userName":_nameStr,
                                      @"gender":_sexTemp,
                                      //@"trade":_goodFiled.text,// 所属行业
                                      @"goodFiled":_goodFiled.text,// 所擅长的领域
                                      @"address":_areaLabel.text,// 居住地
                                      @"identity":_identity.text, // 职业身份
                                      @"remark":_introduceTextView.text,// 简介
                                      @"token":[[MyUserInfoManager shareInstance]token],// 个人简介
                                      };
                self.requestURL = LKB_Update_Url;
                
                
            } failure:^{
                
                NSLog(@" --->> error:");
                
            }];
            
            
        }
    }
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _headerButton.imageView.image = _headImg;
    
    if (_headImg!=nil) {
        
        [_headerButton setImage:_headImg forState:UIControlStateNormal];
    }
    [self.navigationController setNavigationBarHidden:NO animated:animated];

    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    // 观察键盘变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDismiss:) name:UIKeyboardWillHideNotification object:nil];
    //
    [MobClick beginLogPageView:@"UserInforSettingViewController"];

    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"UserInforSettingViewController"];
}




- (UITableView *)tableView {
    
    if (!_tableView) {
        
        if ([_attentionNum isEqualToString:@"0"]) {
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight -50 -64) style:UITableViewStylePlain];
        }
        else {
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStylePlain];

        }
        _tableView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        _tableView.dataSource = self;
        _tableView.delegate= self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = false;
        
    }
    return _tableView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 116;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 52;
    
}





// 区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 116)];
    view.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    
    
    _headerButton  = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth /2 -40, 18 , 80, 80)];
    //    _headerButton.backgroundColor = [UIColor grayColor];
    _headerButton.layer.masksToBounds = YES;
    _headerButton.layer.cornerRadius = 40;
    
    if (_photoUrl == nil) {
        
        [_headerButton setImage:[UIImage imageNamed:@"setHeaderImage"] forState:UIControlStateNormal];
    }
    else {
        
        [_headerButton setImage:_headImg forState:UIControlStateNormal];
        
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_photoUrl,@"avatar",nil];
        [FileHelpers dispatch_process_with_thread:^{
            UIImage* ima = [self LoadImage:dic];
            
            _headImg = ima;
            return ima;
        } result:^(UIImage *ima){
            [_headerButton setImage:ima forState:UIControlStateNormal];
        }];
        
        
    }
    
    
    [_headerButton addTarget:self action:@selector(headerButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * headImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth /2 +10 , 70, 30, 30)];
    headImage.layer.masksToBounds = YES;
    headImage.layer.cornerRadius = 10;
    [headImage setImage:[UIImage imageNamed:@"icon_select_portrait"]];
    
    [view addSubview:_headerButton];
    [view addSubview:headImage];
    
    return view;
}

//异步加载图片
- (UIImage *)LoadImage:(NSDictionary*)aDic{
    
    NSLog(@"--------------------------%@",aDic);
    NSLog(@"--------------------------%@",[aDic objectForKey:@"avatar"]);
    
    
    NSURL *aURL=[aDic objectForKey:@"avatar"];
    NSLog(@"--------------------------%@",aURL);
    
    NSData *data=[NSData dataWithContentsOfURL:aURL];
    if (data == nil) {
        return nil;
    }
    UIImage *image=[UIImage imageWithData:data];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager createFileAtPath:pathForURL(aURL) contents:data attributes:nil];
    return image;
}



- (void)headerButton:(id)sender {
    
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

// 区尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, KDeviceHeight - 116 - 64*5 -10, kDeviceWidth, 125)];
    view.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 8, kDeviceWidth, 125 )];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel* introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 18, 100, 25)];
    introduceLabel.text = @"个人简介";
    introduceLabel.textColor = CCCUIColorFromHex(0x888888);
    introduceLabel.font = [UIFont systemFontOfSize:15];
    [backView addSubview:introduceLabel];
    
    
    _introduceTextView = [[UITextView alloc]initWithFrame:CGRectMake(100, 18, kDeviceWidth -100 -16, 107)];
    _introduceTextView.backgroundColor = [UIColor clearColor];
    _introduceTextView.delegate = self;
    _introduceTextView.font = [UIFont systemFontOfSize:15];
    _introduceTextView.text = _remarkStr;

    _wordNumberlLabel = [[UILabel alloc]init];
    _wordNumberlLabel.frame = CGRectMake(kDeviceWidth -85 , 105, 75, 20);
    _wordNumberlLabel.textColor = [UIColor blackColor];
    //    _wordNumberlLabel.backgroundColor = [UIColor magentaColor];
    [view addSubview:backView];
    
    
    [view addSubview:_introduceTextView];
    
    [view addSubview:_wordNumberlLabel];
    
    return view;
}


// 字数统计
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=200)
    {
        return  NO;
    }
    else
    {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
        return YES;
    }
    
    //判断加上输入的字符，是否超过界限
    NSString *str = [NSString stringWithFormat:@"%@", _introduceTextView.text];
    
    if (str.length > 88 && range.length!=1){
        
        _introduceTextView.text = [_introduceTextView.text substringToIndex:88];
        return YES;
        
    }
    
}


- (void)textViewDidChange:(UITextView *)textView {
    NSInteger number = [self.introduceTextView.text length];
    if (number > 200) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于200" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:200];
        number = 200;
        self.wordNumberlLabel.textColor = [UIColor redColor];
    }
    self.wordNumberlLabel.text = [NSString stringWithFormat:@"%ld/200",number];
}



- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 125;
}



- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"昵称"; // 888888
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = CCCUIColorFromHex(0x999999);
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, kDeviceWidth -100, 52)];
        [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _nameTextField.text = _nameStr;
        
        //            _nameTextField.backgroundColor = [UIColor magentaColor];
        [cell.contentView addSubview:_nameTextField];
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"性别"; // f7f7f7
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = CCCUIColorFromHex(0x999999);
        _SexLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, kDeviceWidth-100, 52)];
        //            _SexLabel.backgroundColor = [UIColor magentaColor];
        if ([_genderStr isEqualToString:@"1"]) {
            
            _SexLabel.text = @"女";
            _SexLabel.textColor = CCCUIColorFromHex(0x333333);

        }
        else if ([_genderStr isEqualToString:@"0"]) {
            
            _SexLabel.text = @"男";
            _SexLabel.textColor = CCCUIColorFromHex(0x333333);

        }
        else {
            
            _SexLabel.text = @"请点击选择性别";
            _SexLabel.textColor = CCCUIColorFromHex(0xaaaaaa);

        }

        [cell.contentView addSubview:_SexLabel];
        
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"擅长领域";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = CCCUIColorFromHex(0x999999);
        _goodFiled = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, kDeviceWidth -100, 52)];
        
        if ([_goodFiledStr isEqualToString:@""] || _goodFiledStr == nil) {
            _goodFiled.placeholder = @"例如:多肉种植";

        }
        else {
            _goodFiled.text = _goodFiledStr;

            _goodFiled.textColor = CCCUIColorFromHex(0x333333);

        }
        [_goodFiled setValue:CCCUIColorFromHex(0xaaaaaa) forKeyPath:@"_placeholderLabel.textColor"];
        [cell.contentView addSubview:_goodFiled];
        
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"所在区域";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = CCCUIColorFromHex(0x999999);
        _areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, kDeviceWidth -100, 52)];
        if ([_addressStr isEqualToString:@""] || _addressStr == nil) {
            _areaLabel.text= @"请点击选择所在区域";
            _areaLabel.textColor = CCCUIColorFromHex(0xaaaaaa);

        }
        else {
            _areaLabel.text = _addressStr;
            _areaLabel.textColor = CCCUIColorFromHex(0x333333);

            
        }

        [cell.contentView addSubview:_areaLabel];
        
    }
    if (indexPath.row == 4) {
        cell.textLabel.text = @"职业身份";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = CCCUIColorFromHex(0x999999);
        _identity = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, kDeviceWidth -100, 52)];
        //            _occupationTextField.backgroundColor = [UIColor cyanColor];
        if ([_identityStr isEqualToString:@""] || _identityStr == nil) {
            _identity.placeholder = @"例如:种植大户";
            
        }
        else {
            _identity.text = _identityStr;
            _identity.textColor = CCCUIColorFromHex(0x333333);

            
        }

        [_identity setValue:CCCUIColorFromHex(0xaaaaaa) forKeyPath:@"_placeholderLabel.textColor"];

        [cell.contentView addSubview:_identity];
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(16, 52, SCREEN_WIDTH -32, 1)];
    lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    [cell addSubview:lineView];
    
    return cell;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 20) {
        textField.text = [textField.text substringToIndex:10];
    }
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction * manAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _SexLabel.text = @"男";
            
            NSLog(@"-------------------%@",_SexLabel);
        }];
        
        
        UIAlertAction * womanAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _SexLabel.text = @"女";
            
            NSLog(@"-------------------%@",_SexLabel);
        }];
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler: nil];
        [alert addAction:manAction];
        
        [alert addAction:womanAction];
        [alert addAction:cancelAction];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
    if (indexPath.row == 3) {
        CityViewController *cityVC = [[CityViewController alloc] initWithStyle:UITableViewStylePlain];
        LKBBaseNavigationController *nav = [[LKBBaseNavigationController alloc] initWithRootViewController:cityVC];
        __weak __typeof(self)weakSelf = self;
        [cityVC setFinishedSelectBlock:^(NSString *city) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.areaLabel.text = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
        }];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
    }
    
    
    
}



- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage {
    if (errorMessage) {
        [self ShowProgressHUDwithMessage:errorMessage];
    }
    
//    if (self.requestURL == LKB_User_Infor_Url) {
//        
//        UserInforModel *userInfor = (UserInforModel*)parserObject;
//        UserInforModellIntroduceModel *model =userInfor.data;
//        
//        
//        _nameTextField.text = model.userName;
//        // 性别
//        if ([model.gender isEqualToString: @"0"]) {
//            _SexLabel.text = @"男";
//            _SexLabel.textColor = [UIColor blackColor];
//        }
//        else {
//            
//            _SexLabel.text = @"女";
//            _SexLabel.textColor = [UIColor blackColor];
//            
//        }
//        
//        _areaLabel.text = model.address;
//        _areaLabel.textColor = [UIColor blackColor];
//        
//        _introduceTextView.text = model.remark;
//        
//        _goodFiled.text = model.goodFiled;
//        
//        _identity.text = model.identity;
//        _headImg =[UIImage imageWithData:[NSData dataWithContentsOfURL:[model.avatar lkbImageUrl4]]];
//        [_headerButton setImage:_headImg forState:UIControlStateNormal];
//
//        
//    }
    
    if(self.requestURL == LKB_Update_Url) {
        
        LKBLoginModel* responseModel = (LKBLoginModel*)parserObject;
        [self ShowProgressHUDwithMessage:responseModel.msg];
        
        NSLog(@"===========%@==============",responseModel.msg);
        
        
        [self ShowProgressHUDwithMessage:responseModel.msg];
        
        
        
        if ([_attentionNum isEqualToString:@"1"]) {
            
            NSString *NameStr = _nameTextField.text;
            NSString *RemarkStr = _introduceTextView.text;
            NSString *imageStr = [MyUserInfoManager shareInstance].avatar;
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:NameStr,@"名字",RemarkStr,@"简介",imageStr,@"头像",nil];
        
            NSNotification* notification = [NSNotification notificationWithName:@"发送" object:self userInfo:dic];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self.navigationController popToRootViewControllerAnimated:YES];

        }
        else {
            
            SelectedRecommendViewController *attentionVC = [[SelectedRecommendViewController alloc]init];
            
            [self.navigationController pushViewController:attentionVC animated:YES];

        }
        
    }

    
}


- (void)receive:(NSNotification *)notification
{
    
    
    NSLog(@"--------------------%@",notification);
    
}



- (void)keyboardWillHide {
    
    [self.introduceTextView resignFirstResponder];
}



//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘信息
    NSDictionary *userInfo = [aNotification userInfo];
    //获取键盘的高度
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //获取视图与输入框位置的差值
    CGFloat offset = SCREEN_HEIGHT -  (400 + 60 + kbSize.height );
    //根据差值移动视图
    if (offset <= 0)
    {
        __weak typeof(self) weakself = self;
        [UIView animateWithDuration:0.3 animations:^{
            [weakself.view setFrame:CGRectMake(0, offset , weakself.view.frame.size.width, weakself.view.frame.size.height)];
        }];
    }
}

//当键盘将要退出时调用
- (void)keyboardWillDismiss:(NSNotification *)aNotification {
    
    //获取键盘信息
    NSDictionary *userInfo = [aNotification userInfo];
    //获取键盘的高度
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //获取视图与输入框位置的差值
    CGFloat offset = SCREEN_HEIGHT -  (400 + 60 + kbSize.height );
    if (offset <= 0)
    {
        
        //键盘退出的时候，将视图的位置调回原来的位置
        __weak typeof(self) weakself = self;
        [UIView animateWithDuration:0.3 animations:^{
            [weakself.view setFrame:CGRectMake(0,64,  weakself.view.frame.size.width, weakself.view.frame.size.height)];
        }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
