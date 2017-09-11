//
//  RevisePassWordViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 2017/2/22.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import "RevisePassWordViewController.h"
#import "CheckNumManager.h"
#import "LoginHomeViewController.h"
#import "MyUserInfoManager.h"

@interface RevisePassWordViewController ()
@property (nonatomic, strong)UITextField *oldPassWordText;
@property (nonatomic, strong)UIView *line_3;
@property (nonatomic, strong)UITextField *passWordText;
@property (nonatomic, strong)UIView *line_1;
@property (nonatomic, strong)UITextField *surePassWordText;
@property (nonatomic, strong)UIView *line_2;
@property (nonatomic, strong)UIButton *sureButton;
@property (strong, nonatomic) MBProgressHUD * hud;

@end

@implementation RevisePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.title = @"设置密码";
    self.title = @"修改密码";
    
    // 键盘回收
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self initializePageSubviews];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"SetPassWordViewController"];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"RevisePassWordViewController"];
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
    
    
    [self.view addSubview:self.passWordText];
    [self.view addSubview:self.line_1];
    [self.view addSubview:self.surePassWordText];
    [self.view addSubview:self.line_2];
    [self.view addSubview:self.sureButton];
    
    CGFloat padding = iPhone4 ? 24 : 44;
    
    
    // 密码
    [_passWordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(padding).offset(24);
        make.left.mas_equalTo(self.view).offset(10);
        //        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(200,20));
        
    }];
    
    
    
    
    // 线条1
    [_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passWordText.bottom).offset(15);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 0.7));
        
    }];
    
    // 确认密码
    [_surePassWordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line_1.bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(200,20));
        
    }];
    
    // 线条
    [_line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_surePassWordText.bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        //        make.bottom.mas_equalTo(_loginButton.top).offset(34);
        make.size.mas_equalTo(CGSizeMake(90, 0.7));
        
    }];
    
    // 确认
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line_2.bottom).offset(48);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(56,40));
        //        make.bottom.mas_equalTo(_registerButton.top).offset(25);
    }];
    
}



- (UITextField *)passWordText {
    
    if (!_passWordText) {
        
        _passWordText = [[UITextField alloc]init];
        
        _passWordText.placeholder = @"请输入旧密码";
        _passWordText.font = [UIFont systemFontOfSize:14];
        _passWordText.secureTextEntry = YES;
        
    }
    return _passWordText;
}

- (UIView *)line_1 {
    
    _line_1 = [[UIView alloc]init];
    _line_1.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
    return _line_1;
}

- (UITextField *)surePassWordText {
    
    _surePassWordText = [[UITextField alloc]init];
    
    _surePassWordText .placeholder =@"新密码";
    _surePassWordText.font = [UIFont systemFontOfSize:14];
    _surePassWordText.secureTextEntry = YES;
    return _surePassWordText;
}

- (UIView *)line_2 {
    
    _line_2 = [[UIView alloc]init];
    _line_2.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
    return _line_2;
}


- (UIButton *)sureButton {
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureButton.backgroundColor = [UIColor LkbBtnColor];
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
    else if (_surePassWordText.text.length < 6) {
        
        [self ShowProgressHUDwithMessage:@"请使用6-16位英文或数字密码"];
    }
    else
    {
        if (_passWordText.text == _surePassWordText.text) {
            [self ShowProgressHUDwithMessage:@"新旧密码不能一致"];
        }
        else{
            self.requestParas = @{
                                  @"password":_passWordText.text,
                                  @"newPassword":_surePassWordText.text,
                                  @"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"token":[[MyUserInfoManager shareInstance]token]
                                  };
            self.requestURL = LKB_ResetPassWord_Url;
            
            
        }
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
