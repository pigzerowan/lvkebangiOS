//
//  PushNickNameViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 9/21/15.
//  Copyright © 2015 transfar. All rights reserved.
//
#import "MyUserInfoManager.h"
#import "PushNickNameViewController.h"

@interface PushNickNameViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *nickNameTextfiled;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *introduceLab;
@end

@implementation PushNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;

    UIButton *senderBtn = [[UIButton alloc]initWithFrame:CGRectMake(286, 12, 24, 24)];
    [senderBtn setImage:[UIImage imageNamed:@"addright"] forState:UIControlStateNormal];
    [senderBtn addTarget:self action:@selector(toSenderMyName:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:senderBtn];
    ;

    // Do any additional setup after loading the view.
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)toSenderMyName:(id)sender
{
    self.requestParas=@{@"userId":[MyUserInfoManager shareInstance].userId,
                        @"userNick":_nickNameTextfiled.text
                        };
    self.requestURL = LKB_Center_Usernick_Url;
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
        if ([request.url isEqualToString:LKB_Center_Usernick_Url]) {
        LKBBaseModel *model = (LKBBaseModel *)parserObject;
        [self ShowProgressHUDwithMessage:model.msg];
            if ([model.msg isEqualToString:@"更新用户昵称成功"]) {
                [self.navigationController popViewControllerAnimated:YES];
                
                [MyUserInfoManager shareInstance].nickName = _nickNameTextfiled.text;
//                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        NSLog(@"========%@===============",parserObject);
               
    }
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initSubViews
{
    [self.view addSubview:self.nickNameTextfiled];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.introduceLab];
    
    
    
    [_nickNameTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nickNameTextfiled.bottom).offset(5);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(1);
//        make.size.mas_equalTo(CGSizeMake(280,1));
    }];
    
    
    [_introduceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineView.bottom).offset(10);
        make.left.mas_equalTo(_lineView.left).offset(10);
        make.centerX.mas_equalTo(_lineView);
//        make.size.mas_equalTo(CGSizeMake(280, 30));
    }];

    
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


#pragma mark - Getters & Setters
- (UITextField*)nickNameTextfiled
{
    if (!_nickNameTextfiled) {
        _nickNameTextfiled = [[UITextField alloc] init];
        _nickNameTextfiled.delegate = self;
        
        _nickNameTextfiled.placeholder = @"请输入您得昵称";
        
        _nickNameTextfiled.keyboardType = UIKeyboardTypeDefault;
        _nickNameTextfiled.returnKeyType = UIReturnKeyNext;
        
    }
    return _nickNameTextfiled;
}

- (UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _lineView;
}
- (UILabel*)introduceLab
{
    if (!_introduceLab) {
        _introduceLab = [[UILabel alloc] init];
        _introduceLab.numberOfLines = 1;
        _introduceLab.text = @"好的昵称可以让朋友更容易记住你";
        _introduceLab.textColor = [UIColor textGrayColor];
        _introduceLab.font = [UIFont systemFontOfSize:13];
        _introduceLab.textAlignment =NSTextAlignmentLeft;
        _introduceLab.lineBreakMode = NSLineBreakByTruncatingTail;
        
    }
    return _introduceLab;
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
