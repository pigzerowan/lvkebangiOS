//
//  AccountLoginViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 15/12/3.
//  Copyright © 2015年 transfar. All rights reserved.
//

#import "AccountLoginViewController.h"
#import "LKBPrefixHeader.pch"
#import "LoginHomeViewController.h"
#import "AccountRegisterViewController.h"
#import "FindPassWordViewController2.h"
#import "SocialRigistManager.h"
#import "MyUserInfoManager.h"
#import "GroupModel.h"
#import "MBProgressHUD+Add.h"
#import "AppUtils.h"
#import "LKBLoginModel.h"
@interface AccountLoginViewController ()<UITextFieldDelegate,MBProgressHUDDelegate>
{
    EMPushNotificationNoDisturbStatus _noDisturbingStatus;
    BOOL  ifsecureTextEntrySelect;
}
@property (nonatomic, strong) UITextField * userName; // 用户信息
@property (nonatomic, strong) UITextField * passWord; // 密码
@property (nonatomic, strong) UIView * line_1;
@property (nonatomic, strong) UIView * line_2;
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) UIButton * registerButton;
@property (nonatomic, strong) UIButton * findPassWordButton;
@property (nonatomic, strong) UILabel * registerLabel;
@property (nonatomic, strong) UIButton * lookPassWordButton;
@property (nonatomic, strong) UIButton * clearButton;

@property (strong, nonatomic) NSMutableArray *groupArray;
@property (strong, nonatomic) MBProgressHUD * hud;
@end

@implementation AccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    // 左键按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    // 极速注册
    _registerButton = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - 74, 14,60, 22)];
    [_registerButton addTarget:self action:@selector(registerButton:) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton setImage:[UIImage imageNamed:@"registerButton"] forState:UIControlStateNormal];
    
    [self.navigationController.navigationBar addSubview:_registerButton];



//     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_registerButton];
    

//    [_userName becomeFirstResponder];
    
    
    ;
    // 键盘回收
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self initializePageSubviews];
    
    
    // Do any additional setup after loading the view.
}


- (BOOL)becomeFirstResponder

{
    
    //这句可写可不写，中间妖魔鬼怪的无所谓
    
    [super becomeFirstResponder];
    
    return [_userName becomeFirstResponder];
    
}



-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    
    // 隐藏导航下的线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self.navigationController.navigationBar addSubview:_registerButton];
    self.navigationController.edgesForExtendedLayout = 0;
    
    [MobClick beginLogPageView:@"AccountLoginViewController"];

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;
    
    [_registerButton removeFromSuperview];

    [MobClick endLogPageView:@"AccountLoginViewController"];
}




- (void)initializePageSubviews {
    
    [self.view addSubview:self.registerLabel];
    [self.view addSubview:self.userName];
    [self.view addSubview:self.line_1];
    [self.view addSubview:self.passWord];
    [self.view addSubview:self.lookPassWordButton];
    [self.view addSubview:self.line_2];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.clearButton];
    [self.view addSubview:self.findPassWordButton];
    
    //    CGFloat padding = iPhone4 ? 24 : 44;
    
    
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
        [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(115);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-40);
            //        make.size.mas_equalTo(CGSizeMake(90,40));
            make.height.mas_equalTo(15);
            
        }];
    }
    else {
        
        // 账户
        [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(145);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-40);
            //        make.size.mas_equalTo(CGSizeMake(90,40));
            make.height.mas_equalTo(15);
            
        }];
        
    }
    
    

    
    
    // 线条
    [_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userName.bottom).offset(8);
        make.left.mas_equalTo(_userName);
        make.right.mas_equalTo(-40);
        //        make.size.mas_equalTo(CGSizeMake(90, 1));
        make.height.mas_equalTo(0.5);
        
    }];
    
    // 密码
    [_passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line_1.bottom).offset(24);
        make.left.mas_equalTo(_userName);
        make.right.mas_equalTo(-90);
        //        make.size.mas_equalTo(CGSizeMake(90,40));
        make.height.mas_equalTo(15);
        
    }];
    
    [_clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_line_2.top).offset(-11.5);
        make.right.mas_equalTo(-76);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];

    
    [_lookPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_line_2.top).offset(-11.5);
        make.right.mas_equalTo(-40);
        make.size.mas_equalTo(CGSizeMake(16, 16));
        
        
        
    }];

    
    // 线条
    [_line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passWord.bottom).offset(8);
        make.left.mas_equalTo(_userName);
        make.right.mas_equalTo(-40);
        //        make.size.mas_equalTo(CGSizeMake(90, 0.7));
        make.height.mas_equalTo(0.5);
        
        
    }];
    
    
    
    // 忘记密码
    [_findPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line_2.bottom).offset(24);
        make.right.mas_equalTo(self.view.right).offset(-40);
//        make.left.mas_equalTo(self.view.centerX).offset(30);
        //        make.size.mas_equalTo(CGSizeMake(70, 33));
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(12);

        
    }];
    
    // 登录
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_findPassWordButton.bottom).offset(19);
        make.left.mas_equalTo(_userName);
        make.right.mas_equalTo(self.view.right).offset(-40);
        //        make.size.mas_equalTo(CGSizeMake(95,40));
        
        make.height.mas_equalTo(40);
        
    }];

    
    
}


- (UILabel *)registerLabel {
    
    if (!_registerLabel) {
        
        _registerLabel = [[UILabel alloc]init];
        _registerLabel.text = @"登录绿科邦";
        _registerLabel.textAlignment = NSTextAlignmentCenter;
        _registerLabel.textColor = CCCUIColorFromHex(0x555555);
        _registerLabel.font = [UIFont systemFontOfSize:22];
        
    }
    return _registerLabel;
    
}

// 账号
- (UITextField *)userName {
    
    _userName = [[UITextField alloc]init];
//    _userName.delegate = self;
    _userName.placeholder = @"手机号/邮箱";
    [_userName setValue:CCCUIColorFromHex(0xaaaaaa) forKeyPath:@"_placeholderLabel.textColor"];
    _userName.textColor = CCCUIColorFromHex(0x333333);
    _userName.font = [UIFont systemFontOfSize:15.0f];
    [_userName setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    _userName.keyboardType = UIKeyboardTypeASCIICapable;
    _userName.returnKeyType = UIReturnKeyNext;
    [_userName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    return _userName;
}

- (UIView *)line_1 {
    
    if (!_line_1) {
        
        _line_1 = [[UIView alloc]init];
        _line_1.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
        
    }
    return _line_1;
    
}

// 密码
- (UITextField *)passWord {
    
    if (!_passWord) {
    
        _passWord = [[UITextField alloc]init];
        _passWord.delegate = self;
        _passWord.placeholder = @"密码";
        [_passWord setValue:CCCUIColorFromHex(0xaaaaaa) forKeyPath:@"_placeholderLabel.textColor"];
        _passWord.textColor = CCCUIColorFromHex(0x333333);
        _passWord.font = [UIFont systemFontOfSize:14.0f];
        [_passWord setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        _passWord.keyboardType = UIKeyboardTypeASCIICapable;
        _passWord.returnKeyType = UIReturnKeyDone;
        [_passWord addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        _passWord.clearButtonMode = UITextFieldViewModeWhileEditing;

//        _passWord.secureTextEntry = YES;
//        _passWord.clearsOnBeginEditing = NO;


    
    }
    
    return _passWord;
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    if (_passWord.text.length > 0 ) {
        _clearButton.hidden = NO;
    }
}








- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (_clearButton.isHidden == NO && _passWord.text.length == 0) {
        
        _clearButton.hidden = YES;
        _loginButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
        _loginButton.userInteractionEnabled = NO;
        _passWord.secureTextEntry = NO;

    }else {
        _clearButton.hidden = YES;
        _loginButton.backgroundColor = CCCUIColorFromHex(0x22a941);
        _loginButton.userInteractionEnabled = YES;

    }

}




- (void)textFieldDidChange:(UITextField *)textField {
    
    
    if (_userName.text.length > 0 ) {
        
        if (_passWord.text.length > 0) {
            
            _clearButton.hidden = NO;
            _loginButton.userInteractionEnabled = YES;
            _loginButton.backgroundColor = CCCUIColorFromHex(0x22a941);
            if (ifsecureTextEntrySelect) {
                
                _passWord.secureTextEntry = NO;

            }
            else {
                
                _passWord.secureTextEntry = YES;

            }

        }
        
        else {
            
            _loginButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
            _loginButton.userInteractionEnabled = NO;

        }
    }

    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //明文切换密文后避免被清空
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == _passWord && textField.isSecureTextEntry) {
        textField.text = toBeString;
        return NO;
    }
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
    
    
    _passWord.text = @"";
    _loginButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
    _loginButton.userInteractionEnabled = NO;
    _clearButton.hidden = YES;
    ifsecureTextEntrySelect = NO;
    _passWord.secureTextEntry = NO;


    
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
    _passWord.enabled = NO;    // the first one;
    _passWord.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
    
    _clearButton.hidden = NO;
    _loginButton.backgroundColor = CCCUIColorFromHex(0x22a941);
    _loginButton.userInteractionEnabled = YES;

    
    if (_passWord.secureTextEntry) {
        
        ifsecureTextEntrySelect = NO;

    }
    else {
        
        ifsecureTextEntrySelect = YES;

    }
    
    
    
    _passWord.enabled = YES;  // the second one;
//    [_passWord becomeFirstResponder];

}

// 划线
- (UIView *)line_2 {
    
    if (!_line_2) {
        
        _line_2 = [[UIView alloc]init];
        _line_2.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
        
    }
    
    return _line_2;
    
}

// 登录
- (UIButton *)loginButton {
    
    if (!_loginButton) {
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loginButton setTitle:@"登录"forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_loginButton setTintColor:[UIColor whiteColor]];
        _loginButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
//        _loginButton.alpha = 0.5;
        _loginButton.userInteractionEnabled = NO;
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 5;
        [_loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
    
}


- (void)loginButtonClicked:(id)sender
{
    
    [MobClick event:@"loginButtonEvent"];
    

    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [self.view addSubview: self.hud];
    _hud.delegate = self;
    self.hud.labelText = @"正在登录...";
    [self.view bringSubviewToFront:self.hud];
    
    self.requestParas = @{@"phone":_userName.text,
                          @"password":_passWord.text,
                          @"clientType":@"2"
                          };
    self.requestURL = LKB_Login_Url;
    
    
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
    if (errorMessage) {
        [self ShowProgressHUDwithMessage:errorMessage];
        [self.hud hide:YES];
        return;
    }
    // 账户登录
    if(self.requestURL == LKB_Login_Url)
    {
//        self.requestParas =  @{@"userId":[[MyUserInfoManager shareInstance]userId],
//                               @"ownerId":[[MyUserInfoManager shareInstance]userId],
//                               @"token":[[MyUserInfoManager shareInstance]token]};
//        
//        self.requestURL = LKB_Group_List_Url;
        
        
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        
        NSString *strUrl = [[infoDictionary objectForKey:@"CFBundleVersion"] stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        int ivalue = [strUrl intValue];
        
        NSLog(@"当前应用版本号码：%d",ivalue);
        
        
        NSLog(@"当前应用版本号码：%@",@(ivalue));
        
        [self setUIWebviewcookie];
        NSDictionary *IDdic =  @{@"clientType":@"2",
                                 @"clientVersion":strUrl
                                 };
        [[LKBNetworkManage sharedMange]postResultWithServiceUrl:LKB_Login_ClientVersion_Url parameters:IDdic success:^(id parserObject) {
            
            NSLog(@"记录成功");
            
        } failure:^(NSString *errorMessage) {
            
        }];

        
        [self.hud hide:YES];
        AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate showUserTabBarViewController];
        
        
        EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
        options.noDisturbStatus = ePushNotificationNoDisturbStatusDay;
        [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options];
        
        [[EaseMob sharedInstance].chatManager updatePushOptions:options error:nil];
        
        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[[MyUserInfoManager shareInstance]userId] password:@"dream" completion:^(NSDictionary *loginInfo, EMError *error) {
            if (!error && loginInfo) {
                
                
                EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
                options.noDisturbStatus = ePushNotificationNoDisturbStatusDay;
                [[EaseMob sharedInstance].chatManager asyncUpdatePushOptions:options];
                NSLog(@"登陆成功");
                
                
            }
            
            else
            {
                [self ShowProgressHUDwithMessage:error.description];
            }
        } onQueue:nil];
        
    }
    
    
    else if(self.requestURL == LKB_Group_List_Url)
    {
        GroupModel *groupModel = (GroupModel *)parserObject;
        
        NSLog(@"========%@===============",parserObject);
        if (!request.isLoadingMore) {
            if(groupModel.data.count!=0&&groupModel!=nil)
            {
                _groupArray = [NSMutableArray arrayWithArray:groupModel.data];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                // 1秒后异步执行这里的代码...
                
                for (int i=0; i<_groupArray.count; i++) {
                    GroupDetailModel *findPeoleModel = (GroupDetailModel *)_groupArray[i];
                    
                    NSUserDefaults *userDefault = [[NSUserDefaults alloc]init];
                    
                    NSDictionary *mydic = @{@"userName":findPeoleModel.groupName,
                                            @"groupAvatar":findPeoleModel.groupAvatar,
                                            @"groupId":findPeoleModel.groupId
                                            };
                    NSMutableDictionary*dic =[NSMutableDictionary dictionaryWithDictionary:mydic];
                    [userDefault setObject:dic  forKey:findPeoleModel.groupId];
                }
                
            });
        }
    }
}


-(void)setUIWebviewcookie{
    //    NSString * strID = [NSString stringWithFormat:@"%@",[[UserInfoManager shareUserInfoManagerWithDic:nil] id]];LKB_WSSERVICE_HTTP http://192.168.1.199:8082 http://112.124.96.181:8099
    
    
    
    // 正式环境
    NSURL *cookieHost = [NSURL URLWithString:LKB_WSSERVICE_HTTP];
    
    // 测试环境
    //    NSURL *cookieHost = [NSURL URLWithString:@"http://192.168.1.199:8082/app"];
    // 设定 cookie
    NSHTTPCookie *cookie1 = [NSHTTPCookie cookieWithProperties:
                             [NSDictionary dictionaryWithObjectsAndKeys:
                              [cookieHost host], NSHTTPCookieDomain,
                              [cookieHost path], NSHTTPCookiePath,
                              @"userId",  NSHTTPCookieName,
                              [[MyUserInfoManager shareInstance] userId], NSHTTPCookieValue,
                              nil]];
    
    // 设定 cookie
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie1];
    //    NSString * mdStr = [UserInfoManager md5:[UserInfoManager md5:str]];
    // 定义 cookie 要设定的 host
    // 设定 cookie
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             [cookieHost host], NSHTTPCookieDomain,
                             [cookieHost path], NSHTTPCookiePath,
                             @"token",  NSHTTPCookieName,
                             [[MyUserInfoManager shareInstance] token], NSHTTPCookieValue,
                             nil]];
    // 设定 cookie
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
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



- (void)registerButton:(id)sender {
    
    [MobClick event:@"registerButtonEvent"];

    AccountRegisterViewController *AccountRegister = [[AccountRegisterViewController alloc]init];
    AccountRegister.pageType = @"1";
    
    [self.navigationController pushViewController:AccountRegister animated:YES];
}



// 忘记密码
- (UIButton *)findPassWordButton {
    
    if (!_findPassWordButton) {
        _findPassWordButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_findPassWordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _findPassWordButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_findPassWordButton setTintColor:CCCUIColorFromHex(0xaaaaaa)];
        _findPassWordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        [_findPassWordButton addTarget:self action:@selector(findPassWordButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findPassWordButton;
    
}

- (void)findPassWordButton:(id)sender {
    
    [MobClick event:@"findPassWordButtonEvent"];

    FindPassWordViewController2 *FindPassWordVC = [[FindPassWordViewController2 alloc]init];
    [self.navigationController pushViewController:FindPassWordVC animated:YES];
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
    [_passWord resignFirstResponder];
}


- (void)tap:(UITapGestureRecognizer *)recognizer
{
    [_userName resignFirstResponder];
    [_passWord resignFirstResponder];
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
