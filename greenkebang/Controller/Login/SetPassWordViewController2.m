//
//  SetPassWordViewController2.m
//  greenkebang
//
//  Created by 徐丽霞 on 15/12/14.
//  Copyright © 2015年 transfar. All rights reserved.
//

#import "SetPassWordViewController2.h"
#import "CheckNumManager.h"
#import "LoginHomeViewController.h"
#import "MyUserInfoManager.h"
@interface SetPassWordViewController2 ()<UITextFieldDelegate>

{
    BOOL  ifsecureTextEntrySelect;
}
@property (nonatomic, strong)UITextField *oldPassWordText;
@property (nonatomic, strong)UIView *line_3;
@property (nonatomic, strong)UITextField *passWordText;
@property (nonatomic, strong)UIView *line_1;
@property (nonatomic, strong)UITextField *surePassWordText;
@property (nonatomic, strong)UIView *line_2;
@property (nonatomic, strong)UIButton *sureButton;
@property (nonatomic, strong) UIButton * lookPassWordButton;
@property (nonatomic, strong) UIButton * clearButton;

@property (nonatomic, strong) UILabel * registerLabel;

@property (strong, nonatomic) MBProgressHUD * hud;
@end

@implementation SetPassWordViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.title = @"设置密码";
//    if ([_type isEqualToString: @"1"]) {
//        self.title = @"修改密码";
//    }
//    else {
//        
//        self.title = @"设置密码";
//    }
    
    // 键盘回收
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self initializePageSubviews];
    
    // 设置navigationbar的半透明
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // 隐藏导航下的线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_nor"]style:UIBarButtonItemStyleDone target:self action:@selector(BackButton:)];
    self.navigationItem.leftBarButtonItem = left;
    
    [_passWordText becomeFirstResponder];


    // Do any additional setup after loading the view.
}

- (void)BackButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;

    
    if ([_type isEqualToString: @"1"]) {
        [MobClick beginLogPageView:@"RevisePassWordViewController"];
    }
    else {
        
        [MobClick beginLogPageView:@"SetPassWordViewController"];
    }

    //    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([_type isEqualToString: @"1"]) {
        [MobClick endLogPageView:@"RevisePassWordViewController"];
    }
    else {
        
        [MobClick endLogPageView:@"SetPassWordViewController"];
    }
}

// 键盘回收
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_passWordText resignFirstResponder];
    [_surePassWordText resignFirstResponder];
    
}


- (void)tap:(UITapGestureRecognizer *)recognizer
{
    [_passWordText resignFirstResponder];
    [_surePassWordText resignFirstResponder];
}


- (void)initializePageSubviews {
    
    [self.view addSubview:self.registerLabel];

    [self.view addSubview:self.passWordText];
    
    [self.view addSubview:self.lookPassWordButton];
    [self.view addSubview:self.clearButton];

    [self.view addSubview:self.line_1];
//    [self.view addSubview:self.surePassWordText];
//    [self.view addSubview:self.line_2];
    [self.view addSubview:self.sureButton];
    
    CGFloat padding = iPhone4 ? 24 : 44;
    
    
    
    [_registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(self.view);
        //        make.left.mas_equalTo(40);
        //        make.right.mas_equalTo(-40);
        //        make.size.mas_equalTo(CGSizeMake(90,40));
        make.height.mas_equalTo(22);
        
    }];
    
    if (iPhone5 ) {
        
        // 密码
        [_passWordText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(115);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-60);
            //        make.size.mas_equalTo(CGSizeMake(90,40));
            make.height.mas_equalTo(15);
            
        }];
    }
    else {
        
        // 密码
        [_passWordText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(145);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-60);
            //        make.size.mas_equalTo(CGSizeMake(90,40));
            make.height.mas_equalTo(15);
            
        }];
        
    }
    
    [_clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_line_1.top).offset(-11.5);
        make.right.mas_equalTo(-76);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];

    
    [_lookPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_line_1.top).offset(-11.5);
        make.right.mas_equalTo(-40);
        make.size.mas_equalTo(CGSizeMake(16, 16));
        
        
        
    }];



    
    
    // 线条1
    [_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passWordText.bottom).offset(8);
        make.left.mas_equalTo(self.view).offset(40);
        make.right.mas_equalTo(self.view).offset(-40);
        make.height.mas_equalTo(0.5);
        
    }];
    
    
    // 确认
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line_1.bottom).offset(26);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(40);
    }];
    
}


- (UILabel *)registerLabel {
    
    if (!_registerLabel) {
        
        _registerLabel = [[UILabel alloc]init];
        _registerLabel.text = @"设置新密码";
        _registerLabel.textAlignment = NSTextAlignmentCenter;
        _registerLabel.textColor = CCCUIColorFromHex(0x555555);
        _registerLabel.font = [UIFont systemFontOfSize:22];
        
    }
    return _registerLabel;
    
}



- (UITextField *)passWordText {
    
    if (!_passWordText) {
        
        _passWordText = [[UITextField alloc]init];
        _passWordText.delegate = self;

        _passWordText.placeholder = @"新密码";
        [_passWordText setValue:CCCUIColorFromHex(0xaaaaaa) forKeyPath:@"_placeholderLabel.textColor"];
        _passWordText.textColor = CCCUIColorFromHex(0x333333);
        _passWordText.font = [UIFont systemFontOfSize:15];
        _passWordText.keyboardType = UIKeyboardTypeASCIICapable;

//        _passWordText.secureTextEntry = YES;
        [_passWordText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        
    }
    return _passWordText;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    if (_passWordText.text.length > 0 ) {
        _clearButton.hidden = NO;
    }
}








- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (_clearButton.isHidden == NO && _passWordText.text.length == 0) {
        
        _clearButton.hidden = YES;
        _sureButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
        _sureButton.userInteractionEnabled = NO;
        _passWordText.secureTextEntry = NO;
        
    }else {
        
        if (_passWordText.text.length == 0) {
            _clearButton.hidden = YES;
            _sureButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
            _sureButton.userInteractionEnabled = NO;
            _passWordText.secureTextEntry = NO;

        }
        else {
            
            _clearButton.hidden = YES;
            _sureButton.backgroundColor = CCCUIColorFromHex(0x22a941);
            _sureButton.userInteractionEnabled = YES;
 
        }
        
        
    }
    
}



- (void)textFieldDidChange:(UITextField *)textField {
    
    
    
    if (_passWordText.text.length > 0 ) {
        
        _clearButton.hidden = NO;
        _sureButton.userInteractionEnabled = YES;
        _sureButton.backgroundColor = CCCUIColorFromHex(0x22a941);
        
        if (ifsecureTextEntrySelect) {
            
            _passWordText.secureTextEntry = NO;
            
        }
        else {
            
            _passWordText.secureTextEntry = YES;
            
        }

        
    }
    else {
        
        [_sureButton setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
        _sureButton.userInteractionEnabled = NO;
        
    }
    
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //明文切换密文后避免被清空
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == _passWordText && textField.isSecureTextEntry) {
        textField.text = toBeString;
        return NO;
    }
    
//    NSString *tem = [[_passWordText.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
//    
//    
//    if ([tem length] == 0) {
//        
//        return NO;
//        
//    }
    return YES;
}

- (UIButton *)clearButton {
    
    if (!_clearButton) {
        
        _clearButton = [[UIButton alloc]init];
        
        [_clearButton addTarget:self action:@selector(clearButton:) forControlEvents:UIControlEventTouchUpInside];
        [_clearButton setImage:[UIImage imageNamed:@"login_icon_delete"] forState:UIControlStateNormal];
        _clearButton.hidden = YES;
        
    }
    
    return _clearButton;
    
    
}


- (void)clearButton:(UIButton *)sender {
    
    
    _passWordText.text = @"";
    _sureButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
    _sureButton.userInteractionEnabled = NO;
    _clearButton.hidden = YES;
    ifsecureTextEntrySelect = NO;
    _passWordText.secureTextEntry = NO;
    
    
    
}




- (UIView *)line_1 {
    
    _line_1 = [[UIView alloc]init];
    _line_1.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    return _line_1;
}




- (UIButton *)lookPassWordButton {
    
    if (!_lookPassWordButton) {
        
        _lookPassWordButton = [[UIButton alloc]init];
        
        [_lookPassWordButton addTarget:self action:@selector(lookPassWordButton:) forControlEvents:UIControlEventTouchUpInside];
        [_lookPassWordButton setImage:[UIImage imageNamed:@"login_icon_password_hide"] forState:UIControlStateNormal];
        
    }
    
    return _lookPassWordButton;
    
    
}

- (void)lookPassWordButton:(UIButton *)sender {
    
    //避免明文/密文切换后光标位置偏移
    _passWordText.enabled = NO;    // the first one;
    _passWordText.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
    
    if (_passWordText.secureTextEntry) {
        
        ifsecureTextEntrySelect = NO;
        
    }
    else {
        
        ifsecureTextEntrySelect = YES;
        
    }
    
    
    
    _passWordText.enabled = YES;  // the second one;
    [_passWordText becomeFirstResponder];
    
}



- (UITextField *)surePassWordText {
    
    _surePassWordText = [[UITextField alloc]init];
    
    _surePassWordText.placeholder = @"确认密码";
    _surePassWordText.font = [UIFont systemFontOfSize:14];
    _surePassWordText.secureTextEntry = YES;
    
    _surePassWordText.text = [_surePassWordText.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    return _surePassWordText;
}

- (UIView *)line_2 {
    
    _line_2 = [[UIView alloc]init];
    _line_2.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
    return _line_2;
}


- (UIButton *)sureButton {
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureButton.layer.masksToBounds = YES;
    _sureButton.layer.cornerRadius = 5;
    _sureButton.userInteractionEnabled = NO;
    _sureButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
    [_sureButton setTitle:@"确认" forState:UIControlStateNormal];
    _sureButton.tintColor = [UIColor whiteColor];
    [_sureButton addTarget:self action:@selector(sureButton:) forControlEvents:UIControlEventTouchUpInside];
    return _sureButton;
}

- (void)sureButton:(id)sender {
    
    [MobClick event:@"点击事件"];

    
    self.hud.hidden = NO;
    [self.hud show:YES];
    
    if (_passWordText.text.length < 6) {
        
        [self ShowProgressHUDwithMessage:@"请使用6-16位英文或数字密码"];
    }
    else if ([_passWordText.text rangeOfString:@" "].location != NSNotFound) {
        
        [self ShowProgressHUDwithMessage:@"密码包含空格,请重新输入哦~"];
        
    }
    else {
        
        self.requestParas = @{
                              @"password":_passWordText.text,
                              @"phone":_telPhone,
                              @"validate":_checkNum,
                              
                              };
        self.requestURL = LKB_Findpassword_Url;

        
    }
    
    
    
    
    
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    LKBBaseModel* responseModel = (LKBBaseModel*)parserObject;
    if(self.requestURL == LKB_Findpassword_Url) {
        
        if ([responseModel.msg isEqualToString:@"密码设置成功！"]) {
            [self ShowProgressHUDwithMessage:responseModel.msg];
            
            //            AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
            //            [appDelegate showUserTabBarViewController];
            
            
            LoginHomeViewController *loginVC = [[LoginHomeViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
            
//            AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
//            [appDelegate showUserTabBarViewController];

            
            
            
        }
        
        
    }
    if(self.requestURL == LKB_ResetPassWord_Url) {
        
        if (errorMessage) {
            [self ShowProgressHUDwithMessage:errorMessage];
            return;
        }
        else {
            [self ShowProgressHUDwithMessage:responseModel.msg];
            
            
            [self ShowProgressHUDwithMessage:responseModel.msg];
            
            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                if (!error && info) {
                    NSLog(@"退出成功");
                }
            } onQueue:nil];
            
            LoginHomeViewController *loginVC = [[LoginHomeViewController alloc]init];
            
            [self.navigationController pushViewController:loginVC animated:YES];
            
            
            
        }
        
        [self ShowProgressHUDwithMessage:responseModel.msg];
        
        
        
        
    }
    
    
    
    
    NSLog(@"***********************%@",responseModel.msg);
}

// 弹出提示框的初始化
- (void)ShowProgressHUDwithMessage:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.dimBackground = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
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
