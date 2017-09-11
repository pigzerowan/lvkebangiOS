//
//  MemberApplyVC.m
//  greenkebang
//
//  Created by 郑渊文 on 1/17/17.
//  Copyright © 2017 transfar. All rights reserved.
//

#import "MemberApplyVC.h"
#import "LKBPrefixHeader.pch"
#import "FinishRegisterViewController.h"
#import "MBProgressHUD+Add.h"
#import "CheckNumManager.h"
#import "LKBLoginModel.h"
#import "MyUserInfoManager.h"
#import "LKBLoginModel.h"
#import "TranceApplyViewController.h"

@interface MemberApplyVC ()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField * phoneNumberTextField;


@property (nonatomic, strong)UILabel * titileLable;
@property (nonatomic, strong)UIButton * checkButton;
@property (nonatomic, strong)UIView * line_1;
@property (nonatomic, strong)UITextField * checkTextFiled;
@property (nonatomic, strong)UIView * line_2;
@property (nonatomic, strong)UIButton * nextButton;
@property (nonatomic, strong)UIButton * ProtocolButton;
@property (nonatomic, strong)UILabel * textLabel;
@property (nonatomic, strong)UITextField * codeTextFiled;
@property (nonatomic, strong)UIView * line_3;



@end

@implementation MemberApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"会员申请";
    // 设置navigationbar的半透明
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // 设置导航栏颜色
    
    
    
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    
// 
  
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.navigationController.navigationBar setBarTintColor:CCCUIColorFromHex(0x323436)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_pre"]style:UIBarButtonItemStyleDone target:self action:@selector(BackButton:)];
    self.navigationItem.leftBarButtonItem = left;
    
    
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(nextClicked:)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    [self initializePageSubviews];
    //     Do any additional setup after loading the view.
}

- (void)initializePageSubviews {
    
    [self.view addSubview:self.phoneNumberTextField];
    [self.view addSubview:self.checkButton];
    [self.view addSubview:self.line_1];
    [self.view addSubview:self.checkTextFiled];
    [self.view addSubview:self.line_2];
    [self.view addSubview:self.nextButton];
        [self.view addSubview:self.titileLable];
        [self.view addSubview:self.codeTextFiled];
    [self.view addSubview:self.line_3];
    CGFloat padding = iPhone4 ? 24 : 44;
    
    
    
    // 账户
    [_titileLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(padding).offset(24);
        make.left.mas_equalTo(self.view).offset(10);
        //        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(200,20));
        
    }];

    
    // 账户
    [_phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titileLable.bottom).offset(24);
        make.left.mas_equalTo(self.view).offset(10);
        //        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(200,20));
        
    }];
    
    // 发送验证码
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titileLable.bottom).offset(15);
        make.right.mas_equalTo(self.view).offset(-10);
        //        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(76,30));
        
    }];
    
    
    
    // 线条1
    [_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_checkButton.bottom).offset(15);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 0.7));
        
    }];
    
    // 验证码
    [_checkTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line_1.bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(200,20));
        
    }];
    
    // 线条
    [_line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_checkTextFiled.bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        //        make.bottom.mas_equalTo(_loginButton.top).offset(34);
        make.size.mas_equalTo(CGSizeMake(90, 0.7));
        
    }];
    

    [_codeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line_2.bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(200,20));
        
    }];
    

    [_line_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_codeTextFiled.bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        //        make.bottom.mas_equalTo(_loginButton.top).offset(34);
        make.size.mas_equalTo(CGSizeMake(90, 0.7));
        
    }];
    

}

- (void)BackButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [MobClick beginLogPageView:@"memberApplyViewController"];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"memberApplyViewController"];
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

- (UITextField *)phoneNumberTextField{
    
    _phoneNumberTextField = [[UITextField alloc]init];
    _phoneNumberTextField.placeholder = @"手机号";
    [_phoneNumberTextField setValue:CCCUIColorFromHex(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    _phoneNumberTextField.font = [UIFont systemFontOfSize:14.0f];
    _phoneNumberTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneNumberTextField.returnKeyType = UIReturnKeyNext;
    return _phoneNumberTextField;
}

- (UIButton *)checkButton {
    
    _checkButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_checkButton setBackgroundColor:[UIColor colorWithHex:0x1fa940 alpha:1]];
    _checkButton.layer.masksToBounds = YES;
    _checkButton.layer.cornerRadius = 5;
    [_checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_checkButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    _checkButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_checkButton addTarget:self action:@selector(pushCheckNumAgainClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return _checkButton;
}

- (void)pushCheckNumAgainClicked:(id)sender {
    
    if(_phoneNumberTextField.text.length==0)
    {
        [self ShowProgressHUDwithMessage:@"请输入手机号码"];
        
    }
   else if(_phoneNumberTextField.text.length>0 ) {
        
        if(![self isMobileNumber:_phoneNumberTextField.text]) {
            [self ShowProgressHUDwithMessage:@"输入的手机号码不合法"];
        }
        else  {
            
            self.requestParas = @{
                                  @"type":@"0",
                                  @"phone":_phoneNumberTextField.text,
                                  };
            self.requestURL = LKB_APPlyTelephoneSms_Url;
            
            
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
                 [_checkButton setBackgroundColor:[UIColor colorWithHex:0x1fa940 alpha:1]];
                _checkButton.enabled = YES;
            });
        }
        else {
            
            NSInteger seconds = timeout % 180;
            _checkButton.enabled = NO;
            NSString* strTime = [NSString stringWithFormat:@"%@秒后重发", @(seconds)];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_checkButton setTitle:strTime forState:UIControlStateNormal];
                [_checkButton setBackgroundColor:[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1]];
            });
            
            timeout--;
        }
        
    });
    
    dispatch_resume(_timer);
    
}

- (UIView *)line_1 {
    
    _line_1 = [[UIView alloc]init];
    _line_1.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
    return _line_1;
}

- (UITextField *)checkTextFiled {
    
    _checkTextFiled = [[UITextField alloc]init];
    _checkTextFiled.placeholder = @"验证码";
    [_checkTextFiled setValue:CCCUIColorFromHex(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    _checkTextFiled.font = [UIFont systemFontOfSize:14.0f];
    _checkTextFiled.keyboardType = UIKeyboardTypePhonePad;
    _checkTextFiled.returnKeyType = UIReturnKeyNext;
    
    
    return _checkTextFiled;
}

- (UITextField *)codeTextFiled {
    
    _codeTextFiled = [[UITextField alloc]init];
    _codeTextFiled.delegate = self;
    _codeTextFiled.placeholder = @"密码";
    [_codeTextFiled setValue:CCCUIColorFromHex(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    _codeTextFiled.font = [UIFont systemFontOfSize:14.0f];
    _codeTextFiled.keyboardType = UIKeyboardTypeDefault;
    _codeTextFiled.returnKeyType = UIReturnKeyDone;
    _codeTextFiled.secureTextEntry = YES;
    return _codeTextFiled;
}




- (UIView *)line_2 {
    
    _line_2 = [[UIView alloc]init];
    _line_2.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
    return _line_2;
}

- (UIView *)line_3 {
    
    _line_3 = [[UIView alloc]init];
    _line_3.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
    return _line_3;
}

- (UIButton *)nextButton {
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = 5;
    _nextButton.backgroundColor = [UIColor LkbBtnColor];
    [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return _nextButton;
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
    else if(_phoneNumberTextField.text.length>0 ) {
        
        if(![self isMobileNumber:_phoneNumberTextField.text]) {
            [self ShowProgressHUDwithMessage:@"输入的手机号码不合法"];
        }else
        {
            if (_codeTextFiled.text.length<6)
            {
                [self ShowProgressHUDwithMessage:@"请使用6-16位英文或数字密码"];
            }else if (_checkTextFiled.text.length == 0)
            {
                [self ShowProgressHUDwithMessage:@"请输入验证码"];
            }
            
            else  {
                
                self.requestParas = @{@"password":_codeTextFiled.text,
                                      @"validate":_checkTextFiled.text,
                                      @"token":[[MyUserInfoManager shareInstance]token],
                                      @"phone":_phoneNumberTextField.text,
                                      @"userId":[[MyUserInfoManager shareInstance]userId],
                                      };
                
                self.requestURL = LKB_APPlyMallUpdate_Url;
 
            }
        }
    }
    
   
//    if(_phoneNumberTextField.text.length==0)
//    {
//        [self ShowProgressHUDwithMessage:@"请输入手机号码"];
//    }
//    
//    if(_phoneNumberTextField.text.length>0)
//    {
//        if(![self isMobileNumber:_phoneNumberTextField.text])
//        {
//            [self ShowProgressHUDwithMessage:@"输入的手机号码不合法"];
//        }
//        else
//        {
//            if(_checkTextFiled.text.length == 0 ) {
//                
//                [self ShowProgressHUDwithMessage:@"请输入验证码"];
//                
//            }
//            else {
//                
////                [MobClick event:@"nextClickedButtonEvent"];
//                
//                
//                self.requestParas = @{@"password":_codeTextFiled.text,
//                                      @"validate":_checkTextFiled.text,
//                                      @"token":[[MyUserInfoManager shareInstance]token],
//                                      @"phone":_phoneNumberTextField.text,
//                                      @"userId":[[MyUserInfoManager shareInstance]userId],
//                                      };
//                
//                self.requestURL = LKB_APPlyMallUpdate_Url;
//            }
//        }
//    }
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    LKBBaseModel* responseModel = (LKBBaseModel*)parserObject;
    
    if ([request.url isEqualToString:LKB_APPlyTelephoneSms_Url]) {
        
        if (errorMessage) {
            [self ShowProgressHUDwithMessage:errorMessage];
            return;
        }
        
        if ([responseModel.msg isEqualToString:@"发送成功"]) {
            
            [self ShowProgressHUDwithMessage:responseModel.msg];
            
            [self timeCountdown];

        }

    }
    
    
    if (self.requestURL == LKB_APPlyMallUpdate_Url) {
        
     
        
        if ([ responseModel.msg isEqualToString:@"更新成功"]) {

    
            
        
            NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
            [Defaults setObject:_phoneNumberTextField.text forKey:[NSString stringWithFormat:@"updatemall%@",[MyUserInfoManager shareInstance].userId]];
            [Defaults synchronize];
            
            TranceApplyViewController *outSideWeb = [[TranceApplyViewController alloc]init];
            outSideWeb.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:outSideWeb animated:YES];
        }

//            [self ShowProgressHUDwithMessage:responseModel.msg];
//            FinishRegisterViewController * finishRegisterVC =[[FinishRegisterViewController alloc]init];
//            finishRegisterVC.telPhone = _phoneNumberTextField.text;
//            finishRegisterVC.checkNum = _checkTextFiled.text;
//            [self.navigationController pushViewController:finishRegisterVC animated:YES];


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

- (UILabel *)titileLable {
    
    if (!_titileLable) {
        
        _titileLable = [[UILabel alloc]init];
        _titileLable.text = @"绑定手机号";
        _titileLable.textColor = [UIColor lightGrayColor];
        _titileLable.font = [UIFont systemFontOfSize:14];
    }
    
    return _titileLable;
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
