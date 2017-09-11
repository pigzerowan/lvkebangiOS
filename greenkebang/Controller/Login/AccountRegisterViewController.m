//
//  AccountRegisterViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 15/12/7.
//  Copyright © 2015年 transfar. All rights reserved.
//

#import "AccountRegisterViewController.h"
#import "LKBPrefixHeader.pch"
#import "FinishRegisterViewController.h"
#import "MBProgressHUD+Add.h"
#import "CheckNumManager.h"
#import "LKBLoginModel.h"
#import "AccountLoginViewController.h"
@interface AccountRegisterViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong)UITextField * phoneNumberTextField;
@property (nonatomic, strong)UIButton * checkButton;
@property (nonatomic, strong)UIView * line_1;
@property (nonatomic, strong)UITextField * checkTextFiled;
@property (nonatomic, strong)UIView * line_2;
@property (nonatomic, strong)UIButton * nextButton;
@property (nonatomic, strong)UIButton * ProtocolButton;
@property (nonatomic, strong)UILabel * textLabel;
@property (nonatomic, strong) UILabel * registerLabel;
@property (nonatomic, strong) UIButton * loginButton;



@end

@implementation AccountRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"注册";
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
    [self initializePageSubviews];
    
    [_phoneNumberTextField becomeFirstResponder];
//     Do any additional setup after loading the view.
}

- (void)initializePageSubviews {
    
    [self.view addSubview:self.registerLabel];
    [self.view addSubview:self.phoneNumberTextField];
    [self.view addSubview:self.checkButton];
    [self.view addSubview:self.line_1];
    [self.view addSubview:self.checkTextFiled];
    [self.view addSubview:self.line_2];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.loginButton];

//    [self.view addSubview:self.ProtocolButton];
//    [self.view addSubview:self.textLabel];
    
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
        
        // 账户
        [_phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(115);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-40);
            //        make.size.mas_equalTo(CGSizeMake(90,40));
            make.height.mas_equalTo(15);
            
        }];
    }
    else {
        
        // 账户
        [_phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(145);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-40);
            //        make.size.mas_equalTo(CGSizeMake(90,40));
            make.height.mas_equalTo(15);
            
        }];
        
    }


    
    
    
    // 线条1
    [_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneNumberTextField.bottom).offset(8);
        make.left.mas_equalTo(self.view).offset(40);
        make.right.mas_equalTo(self.view).offset(-40);
        make.height.mas_equalTo(0.5);
        
    }];

    // 验证码
    [_checkTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line_1.bottom).offset(24);
        make.left.mas_equalTo(_phoneNumberTextField);
        make.right.mas_equalTo(-110);
        make.height.mas_equalTo(15);
        
    }];
    
    // 发送验证码
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_line_1.bottom).offset(23);
        make.right.mas_equalTo(-40);
        //        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(15);
        
    }];
    


    // 线条
    [_line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_checkTextFiled.bottom).offset(8);
        make.left.mas_equalTo(_phoneNumberTextField);
        make.right.mas_equalTo(-40);
        //        make.bottom.mas_equalTo(_loginButton.top).offset(34);
        make.height.mas_equalTo(0.5);
        
    }];

    // 下一步
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line_2.bottom).offset(26);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(40);
    }];
    // 已有账号登陆
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nextButton.bottom).offset(22);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(40);
    }];

    

}

- (void)BackButton:(id)sender {
    
    
    if ([_pageType isEqualToString:@"1"]) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [MobClick beginLogPageView:@"AccountRegisterViewController"];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"AccountRegisterViewController"];
}


// 手机号码的格式
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (UILabel *)registerLabel {
    
    if (!_registerLabel) {
        
        _registerLabel = [[UILabel alloc]init];
        _registerLabel.text = @"极速注册";
        _registerLabel.textAlignment = NSTextAlignmentCenter;
        _registerLabel.textColor = CCCUIColorFromHex(0x555555);
        _registerLabel.font = [UIFont systemFontOfSize:22];
        
    }
    return _registerLabel;
    
}


- (UITextField *)phoneNumberTextField{
    
    _phoneNumberTextField = [[UITextField alloc]init];
    _phoneNumberTextField.placeholder = @"手机号";
    [_phoneNumberTextField setValue:CCCUIColorFromHex(0xaaaaaa) forKeyPath:@"_placeholderLabel.textColor"];
    _phoneNumberTextField.textColor = CCCUIColorFromHex(0x333333);
    _phoneNumberTextField.font = [UIFont systemFontOfSize:15];
    _phoneNumberTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneNumberTextField.returnKeyType = UIReturnKeyNext;
    [_phoneNumberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    return _phoneNumberTextField;
}

- (UIButton *)checkButton {
    
    _checkButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_checkButton setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
    [_checkButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _checkButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _checkButton.userInteractionEnabled = YES;
    [_checkButton addTarget:self action:@selector(pushCheckNumAgainClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return _checkButton;
}

- (void)pushCheckNumAgainClicked:(id)sender {
    
    if(_phoneNumberTextField.text.length==0)
    {
        [self ShowProgressHUDwithMessage:@"请输入手机号码"];
        
    }
    if(_phoneNumberTextField.text.length>0 ) {
        
        if(![self isMobileNumber:_phoneNumberTextField.text]) {
            [self ShowProgressHUDwithMessage:@"输入的手机号码不合法"];
        }
        
        else  {
            
            self.requestParas = @{
//                                  @"validate":_checkTextFiled.text,
                                  @"phone":_phoneNumberTextField.text,
                                  };
            self.requestURL = LKB_TelephoneSms_Url;
            
            
            
        }
    }
}

#pragma mark - 60s 倒计时
- (void)timeCountdown
{
    __block NSInteger timeout = 60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if (timeout <= 0) { //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                [_checkButton setTitle:@"再次获取" forState:UIControlStateNormal];
                _checkButton.enabled = YES;
                [_checkButton setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];

            });
        }
        else {
            
            NSInteger seconds = timeout % 180;
            _checkButton.enabled = NO;
            NSString* strTime = [NSString stringWithFormat:@"(%@)后重发", @(seconds)];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_checkButton setTitle:strTime forState:UIControlStateNormal];
                [_checkButton setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
//                [_checkButton setBackgroundColor:[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1]];
            });
            
            timeout--;
        }
        
    });
    
    dispatch_resume(_timer);

}

- (UIView *)line_1 {
    
    _line_1 = [[UIView alloc]init];
    _line_1.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    return _line_1;
}

- (UITextField *)checkTextFiled {
    
    _checkTextFiled = [[UITextField alloc]init];
    _checkTextFiled.placeholder = @"验证码";
    [_checkTextFiled setValue:CCCUIColorFromHex(0xaaaaaa) forKeyPath:@"_placeholderLabel.textColor"];
    _checkTextFiled.textColor = CCCUIColorFromHex(0x333333);
    _checkTextFiled.font = [UIFont systemFontOfSize:15];
    _checkTextFiled.keyboardType = UIKeyboardTypePhonePad;
    _checkTextFiled.returnKeyType = UIReturnKeyNext;
    [_checkTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];


    return _checkTextFiled;
}

- (UIView *)line_2 {
    
    _line_2 = [[UIView alloc]init];
    _line_2.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    return _line_2;
}

- (UIButton *)nextButton {
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = 5;
    _nextButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
    [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextButton.userInteractionEnabled = NO;
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];

    return _nextButton;
}

// 登录
- (UIButton *)loginButton {
    
    if (!_loginButton) {
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loginButton setTitle:@"已有绿科邦账号，去登陆"forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loginButton setTintColor:CCCUIColorFromHex(0x22a941)];
        [_loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
    
}
- (void)loginButtonClicked:(id)sender
{
    AccountLoginViewController *accountVC = [[AccountLoginViewController alloc]init];
    
    [self.navigationController pushViewController:accountVC animated:YES];
    
    
}



- (void)textFieldDidChange:(UITextField *)textField {
    
    
    
    if (_phoneNumberTextField.text.length > 0 ) {
        
        if (_checkTextFiled.text.length > 0) {
            
            _nextButton.userInteractionEnabled = YES;
            _nextButton.backgroundColor = CCCUIColorFromHex(0x22a941);

            
        }
        
        else {
            
            [_checkButton setTitleColor:CCCUIColorFromHex(0x22a941) forState:UIControlStateNormal];
            _checkButton.userInteractionEnabled = YES;
            
            
            _nextButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
            _nextButton.userInteractionEnabled = NO;

            
            
        }
        
        
        
    }
    else {
        
        [_checkButton setTitleColor:CCCUIColorFromHex(0xaaaaaa) forState:UIControlStateNormal];
        _checkButton.userInteractionEnabled = NO;

    }
    
    
}


// 提示框初始化
- (void)ShowProgressHUDwithMessage:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.dimBackground = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

// 点击下一步  判断验证码
- (void)nextClicked:(id)sender {
    
    
    
    if(_phoneNumberTextField.text.length==0)
    {
        [self ShowProgressHUDwithMessage:@"请输入手机号码"];
    }
    
    if(_phoneNumberTextField.text.length>0)
    {
        if(![self isMobileNumber:_phoneNumberTextField.text])
        {
            [self ShowProgressHUDwithMessage:@"输入的手机号码不合法"];
        }
        else
        {
            if(_checkTextFiled.text.length == 0 ) {
                
                [self ShowProgressHUDwithMessage:@"请输入验证码"];
                
            }
            else {
                
                [MobClick event:@"nextClickedButtonEvent"];

                
                self.requestParas = @{
                                      @"validate":_checkTextFiled.text,
                                      
                                      @"phone":_phoneNumberTextField.text,
                                      };
                
                self.requestURL = LKB_Verify_Url;
            }
        }
    }
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
//    LKBLoginModel* responseModel = (LKBLoginModel*)parserObject;
    LKBBaseModel* responseModel = (LKBBaseModel*)parserObject;
    
    NSLog(@"---------------------------%@------------------------------",responseModel.msg);
    if ([request.url isEqualToString:LKB_TelephoneSms_Url]) {
        
//        if (errorMessage) {
//            [self ShowProgressHUDwithMessage:errorMessage];
//            return;
//        }
        
        if ([errorMessage isEqualToString:@"手机号已被注册"]) {
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"注册提示" message:@"您输入的手机号已被注册" delegate:self cancelButtonTitle:@"换个手机号" otherButtonTitles:@"去登陆", nil];
            
            [alertView show];
            

            
        }
//        else {
//            
//            [self ShowProgressHUDwithMessage:errorMessage];
////            return;
//
//        }
        
        if ([responseModel.msg isEqualToString:@"发送成功"]) {
            
            [self ShowProgressHUDwithMessage:responseModel.msg];
            
            [self timeCountdown];
            
        }
        
        
        NSLog(@"******>>>>>>>>>>>>>>**********************%@<<<<<<<<<<<<<<<*********************************",responseModel.checkCode);

        
        
    }
    
    
    
        if (self.requestURL == LKB_Verify_Url) {
            
            if (errorMessage) {
                [self ShowProgressHUDwithMessage:errorMessage];
                return;
            }

            if ([ _checkTextFiled.text isEqualToString:responseModel.checkCode]) {
                
                [self ShowProgressHUDwithMessage:responseModel.msg];
                
                

            }
            else {
                
                [self ShowProgressHUDwithMessage:responseModel.msg];
                FinishRegisterViewController * finishRegisterVC =[[FinishRegisterViewController alloc]init];
                finishRegisterVC.telPhone = _phoneNumberTextField.text;
                finishRegisterVC.checkNum = _checkTextFiled.text;
                [self.navigationController pushViewController:finishRegisterVC animated:YES];

            }
  
                
           
            
            
            
            
            

            
            
            
        }
    
    //        [self ShowProgressHUDwithMessage:@"验证码错误"];

    NSLog(@"---------------------------%@------------------------------",responseModel.msg);




        
    

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        AccountLoginViewController *accountVC = [[AccountLoginViewController alloc]init];
        
        [self.navigationController pushViewController:accountVC animated:YES];

    }
    
}



- (UIButton *)ProtocolButton {
    
    _ProtocolButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_ProtocolButton setTitle:@"《用户使用协议》" forState:UIControlStateNormal];
    _ProtocolButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_ProtocolButton setTitleColor:[UIColor colorWithRed:1.000 green:0.692 blue:0.453 alpha:1.000] forState:UIControlStateNormal];
    [_ProtocolButton addTarget:self action:@selector(protocolButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return _ProtocolButton;
}


- (void)protocolButton:(id)sender {
    
    
}

- (UILabel *)textLabel {
    
    if (!_textLabel) {
        
        _textLabel = [[UILabel alloc]init];
        _textLabel.text = @"点击下一步代表您已阅读并同意";
        _textLabel.font = [UIFont systemFontOfSize:10];
    }

    return _textLabel;
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
