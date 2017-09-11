//
//  FinishRegisterViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 15/12/8.
//  Copyright © 2015年 transfar. All rights reserved.
//

#import "FinishRegisterViewController.h"
#import "LKBPrefixHeader.pch"
#import "MBProgressHUD+Add.h"
#import "LoginHomeViewController.h"
#import "AccountLoginViewController.h"
#import "DerectManager.h"
#import "MyUserInfoManager.h"
#import "UserInforSettingViewController.h"
#import "SelectedRecommendViewController.h"
#import "AttentionDefaultViewController.h"


#define NUMBERSVALUE @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
@interface FinishRegisterViewController ()<UIAlertViewDelegate,UITextFieldDelegate>

{
    
    BOOL  ifsecureTextEntrySelect;

}
@property (nonatomic, strong)UITextField * nicknameTextField;
@property (nonatomic, strong)UIView * line_1;
@property (nonatomic, strong)UITextField * passwordTextfield;
@property (nonatomic, strong)UIView * line_2;
@property (nonatomic, strong)UIButton * finishButton;
@property (nonatomic, strong) UILabel * settingLabel;
@property (nonatomic, strong) UIButton * lookPassWordButton;
@property (nonatomic, strong) UIButton * clearButton;





@end

@implementation FinishRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initializePageSubviews];
    
    [_nicknameTextField becomeFirstResponder];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [MobClick beginLogPageView:@"FinishRegisterViewController"];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"FinishRegisterViewController"];
}

- (void)initializePageSubviews {
    
    [self.view addSubview:self.settingLabel];
    [self.view addSubview:self.nicknameTextField];
    [self.view addSubview:self.line_1];
    [self.view addSubview:self.passwordTextfield];
    [self.view addSubview:self.lookPassWordButton];
    [self.view addSubview:self.clearButton];


    [self.view addSubview:self.line_2];
    [self.view addSubview:self.finishButton];
    
    CGFloat padding = iPhone4 ? 24 : 44;
    
    [_settingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(self.view);
        //        make.left.mas_equalTo(40);
        //        make.right.mas_equalTo(-40);
        //        make.size.mas_equalTo(CGSizeMake(90,40));
        make.height.mas_equalTo(22);
        
    }];
    
    if (iPhone5 ) {
        
        // 昵称
        [_nicknameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(115);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-40);
            //        make.size.mas_equalTo(CGSizeMake(90,40));
            make.height.mas_equalTo(15);
            
        }];
    }
    else {
        
        // 昵称
        [_nicknameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(145);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-40);
            //        make.size.mas_equalTo(CGSizeMake(90,40));
            make.height.mas_equalTo(15);
            
        }];
        
    }


    
//    // 昵称
//    [_nicknameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(padding).offset(24);
//        make.left.mas_equalTo(self.view).offset(10);
//        make.size.mas_equalTo(CGSizeMake(200,20));
//        
//    }];
    
    
    // 线条1
    [_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nicknameTextField.bottom).offset(8);
        make.left.mas_equalTo(_nicknameTextField);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(0.5);
        
    }];
    
    // 设置密码
    [_passwordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line_1.bottom).offset(24);
        make.left.mas_equalTo(_nicknameTextField);
        make.right.mas_equalTo(-90);
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
        make.top.mas_equalTo(_passwordTextfield.bottom).offset(8);
        make.left.mas_equalTo(_nicknameTextField);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(0.5);
        
    }];
    
    // 完成注册
    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line_2.bottom).offset(26);
        make.left.mas_equalTo(_nicknameTextField);
        make.right.mas_equalTo(self.view.right).offset(-40);
        make.height.mas_equalTo(40);
    }];
    
}


- (UILabel *)settingLabel {
    
    if (!_settingLabel) {
        
        _settingLabel = [[UILabel alloc]init];
        _settingLabel.text = @"设置信息";
        _settingLabel.textAlignment = NSTextAlignmentCenter;
        _settingLabel.textColor = CCCUIColorFromHex(0x555555);
        _settingLabel.font = [UIFont systemFontOfSize:22];
        
    }
    return _settingLabel;
    
}



- (UITextField *)nicknameTextField {
    
    _nicknameTextField = [[UITextField alloc]init];
    _nicknameTextField.delegate = self;
    _nicknameTextField.placeholder = @"输入名字";
    [_nicknameTextField setValue:CCCUIColorFromHex(0xaaaaaa) forKeyPath:@"_placeholderLabel.textColor"];
    _nicknameTextField.textColor = CCCUIColorFromHex(0x333333);
    _nicknameTextField.font = [UIFont systemFontOfSize:14.0f];
    [_nicknameTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    _nicknameTextField.keyboardType = UIKeyboardTypeDefault;
    _nicknameTextField.returnKeyType = UIReturnKeyNext;

    [_nicknameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    return _nicknameTextField;
}

- (UIView *)line_1 {
    
    _line_1 = [[UIView alloc]init];
    _line_1.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    
    return _line_1;
}

- (UITextField *)passwordTextfield {
    
    _passwordTextfield = [[UITextField alloc]init];
    _passwordTextfield.placeholder = @"输入6-16位密码";
    _passwordTextfield.delegate = self;
    [_passwordTextfield setValue:CCCUIColorFromHex(0xaaaaaa) forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTextfield.textColor = CCCUIColorFromHex(0x333333);
    _passwordTextfield.font = [UIFont systemFontOfSize:14.0f];
    [_passwordTextfield setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    _passwordTextfield.keyboardType = UIKeyboardTypeASCIICapable;
    _passwordTextfield.returnKeyType = UIReturnKeyGo;
    [_passwordTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _passwordTextfield.text = [_passwordTextfield.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    _passwordTextfield.clearsOnBeginEditing = NO;



    return _passwordTextfield;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    if (_passwordTextfield.text.length > 0 ) {
        _clearButton.hidden = NO;
    }
}








- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (_clearButton.isHidden == NO && _passwordTextfield.text.length == 0) {
        
        _clearButton.hidden = YES;
        _finishButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
        _finishButton.userInteractionEnabled = NO;
        _passwordTextfield.secureTextEntry = NO;
        
    }else {
        
        
        if (_passwordTextfield.text.length == 0) {
            _clearButton.hidden = YES;
            _finishButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
            _finishButton.userInteractionEnabled = NO;
            _passwordTextfield.secureTextEntry = NO;
            
        }
        else {
            
            _clearButton.hidden = YES;
            _finishButton.backgroundColor = CCCUIColorFromHex(0x22a941);
            _finishButton.userInteractionEnabled = YES;
            
        }

        
    }
    
}


- (void)textFieldDidChange:(UITextField *)textField {
    
    
    
    if (_nicknameTextField.text.length > 0 ) {
        
        if (_passwordTextfield.text.length > 0) {
            
            _finishButton.userInteractionEnabled = YES;
            _clearButton.hidden = NO;
            _finishButton.backgroundColor = CCCUIColorFromHex(0x22a941);
            
            if (ifsecureTextEntrySelect) {
                
                _passwordTextfield.secureTextEntry = NO;
                
            }
            else {
                
                _passwordTextfield.secureTextEntry = YES;
                
            }
            
            
        }
        
        else {
            
            _finishButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
            _finishButton.userInteractionEnabled = NO;
        }
    }
    
    
//    if (_passwordTextfield.markedTextRange == nil) {
//        
//        textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    }
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //明文切换密文后避免被清空
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == _passwordTextfield && textField.isSecureTextEntry) {
        textField.text = toBeString;
        return NO;
    }
    
    
//    if (textField == _passwordTextfield ) {
//        
//        NSCharacterSet *cs;
//        
//        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERSVALUE]invertedSet];
//        
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
//        
//        BOOL canChange = [string isEqualToString:filtered];
//        
//        return canChange;
//        
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
    
    
    _passwordTextfield.text = @"";
    _finishButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
    _finishButton.userInteractionEnabled = NO;
    _clearButton.hidden = YES;
    ifsecureTextEntrySelect = NO;
    _passwordTextfield.secureTextEntry = NO;
    
    
    
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
    _passwordTextfield.enabled = NO;    // the first one;
    _passwordTextfield.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
    
    _clearButton.hidden = NO;
    _finishButton.backgroundColor = CCCUIColorFromHex(0x22a941);
    _finishButton.userInteractionEnabled = YES;
    
    if (_passwordTextfield.secureTextEntry) {
        
        ifsecureTextEntrySelect = NO;
        
    }
    else {
        
        ifsecureTextEntrySelect = YES;
        
    }
    
    
    
    _passwordTextfield.enabled = YES;  // the second one;
//    [_passwordTextfield becomeFirstResponder];
    
}



- (UIView *)line_2 {
    
    _line_2 = [[UIView alloc]init];
    _line_2.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
    return _line_2;
}

- (UIButton *)finishButton {
    
    _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishButton.layer.masksToBounds = YES;
    _finishButton.layer.cornerRadius = 5;
    [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _finishButton.backgroundColor = CCCUIColorFromHex(0x8cd09c);
    _finishButton.userInteractionEnabled = NO;
    [_finishButton setTitle:@"注册" forState:UIControlStateNormal];
    [_finishButton addTarget:self action:@selector(finishButton:) forControlEvents:UIControlEventTouchUpInside];

    return _finishButton;
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

- (void)finishButton:(id)sender {
    
    
    [MobClick event:@"finishButtonEvent"];

    
    NSLog(@"===================%@",_passwordTextfield.text);
    
    
    NSLog(@"===================%lu",_passwordTextfield.text.length);
    

    
    
    if (_passwordTextfield.text.length < 6) {
        
        [self ShowProgressHUDwithMessage:@"请使用6-16位英文或数字密码"];
    }
    else if (_nicknameTextField.text.length == 0 ){
        
        [self ShowProgressHUDwithMessage:@"请输入昵称"];
    }
    else if ([_passwordTextfield.text rangeOfString:@" "].location != NSNotFound) {
        
        [self ShowProgressHUDwithMessage:@"密码包含空格,请重新输入哦~"];

    }
    else if ([self stringContainsEmoji:_nicknameTextField.text] == YES) {
        
         [XHToast showTopWithText:@"不支持输入表情" topOffset:60.0];
    }
    else {
        
        self.requestParas = @{
                              @"validate":_checkNum, // 验证码
                              @"phone":_telPhone,
                              @"clientType":@"2",
                              @"password":_passwordTextfield.text,
                              @"nickName":_nicknameTextField.text,
                              };

        self.requestURL = LKB_Signup_Url ;
    }
}

// 判断是否有表情
- (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}



- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
//    UIAlertView *perfect = [[UIAlertView alloc]initWithTitle:@"完善信息" message:@"为了更好推荐喜欢的内容,请完善基础信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"去完善信息", nil];
//    [perfect show];
    SelectedRecommendViewController *attentionVC = [[SelectedRecommendViewController alloc]init];
    
//    AttentionDefaultViewController *attentionVC = [[AttentionDefaultViewController alloc]init];
    
    [self.navigationController pushViewController:attentionVC animated:YES];



}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
//    UserInforSettingViewController * perfectInformationVC = [[UserInforSettingViewController alloc]init];
//    perfectInformationVC.attentionNum = @"0";
//
//    [self.navigationController pushViewController:perfectInformationVC animated:YES];
//
//    NSLog(@"----------完善信息---------------");

    
    
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
