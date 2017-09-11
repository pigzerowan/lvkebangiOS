//
//  ReportViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/7.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "ReportViewController.h"
#import "QRadioButton.h"
#import "MyUserInfoManager.h"
#import "MBProgressHUD+Add.h"
@interface ReportViewController ()<UITextViewDelegate,UIAlertViewDelegate>
@property(nonatomic, strong) QRadioButton *radio1;
@property(nonatomic, strong) QRadioButton *radio2;
@property(nonatomic, strong) QRadioButton *radio3;
@property(nonatomic, strong) QRadioButton *radio4;
@property(nonatomic, strong) QRadioButton *radio5;
@property(nonatomic, strong) QRadioButton *radio6;
@property(nonatomic, strong) UITextView *reportView;
@property(nonatomic, strong) UIButton *reportButton;

@property (copy, nonatomic) NSString * ReportIfPublic;//举报内容

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"举报";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    // 键盘回收
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self initializePageSubviews];

    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
//    // 隐藏导航下的线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    
}

-(void)backToMain
{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    [_reportView resignFirstResponder];
    
    NSLog(@"111111");

}






- (void)initializePageSubviews {
    
    _radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    _radio1.frame = CGRectMake(20, 10, 90, 40);
    [_radio1 setTitle:@"垃圾营销" forState:UIControlStateNormal];
    [_radio1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio1];
    [_radio1 setChecked:YES];
    
    _radio2 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    _radio2.frame = CGRectMake(kDeviceWidth /2 +20, 10, 90, 40);
    [_radio2 setTitle:@"不实消息" forState:UIControlStateNormal];
    [_radio2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_radio2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio2];


    _radio3 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    _radio3.frame = CGRectMake(20, 60, 90, 40);
    [_radio3 setTitle:@"违法信息" forState:UIControlStateNormal];
    [_radio3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_radio3.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio3];
    
    _radio4 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    _radio4.frame = CGRectMake(kDeviceWidth /2 +20 ,60, 90, 40);
    [_radio4 setTitle:@"有害信息" forState:UIControlStateNormal];
    [_radio4 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_radio4.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio4];
    
    
    _radio5 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    _radio5.frame = CGRectMake(20, 110, 90, 40);
    [_radio5 setTitle:@"人生攻击" forState:UIControlStateNormal];
    [_radio5 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_radio5.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio5];
    
    
    _radio6 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
    _radio6.frame = CGRectMake(kDeviceWidth/2 +20, 110, 90, 40);
    [_radio6 setTitle:@"内容抄袭" forState:UIControlStateNormal];
    [_radio6 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_radio6.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio6];
    
    [self.view addSubview:self.reportView];
    [self.view addSubview:self.reportButton];

    
}

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    
    
    NSLog(@"did selected radio:%@ groupId:%@", radio.titleLabel.text, groupId);
    if ([radio.titleLabel.text isEqualToString:@"垃圾"] ) {
        _ReportIfPublic = @"0";
    }else
    {
        _ReportIfPublic = @"1";
    }
    
}


- (UITextView *)reportView  {
    
    _reportView = [[UITextView alloc]initWithFrame:CGRectMake(20, 160, kDeviceWidth -40, 100)];
    _reportView.text = @"其他理由";
    _reportView.delegate = self;
    _reportView.textColor = [UIColor lightGrayColor];
    _reportView.font = [UIFont systemFontOfSize:13];
    _reportView.layer.borderWidth = 1;
    _reportView.layer.borderColor = UIColorWithRGBA(237, 238, 239, 1).CGColor;


    return _reportView;
}
// 实现正文的placeholder
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"其他理由"]) {
        
        textView.text = @"";
//        textView.textColor = [UIColor textGrayColor];
        
    }
}

//在结束编辑的代理方法中进行如下操作
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length<1) {
        
        textView.text = @"其他理由";
        
    }
    
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    [_reportView resignFirstResponder];
}


- (UIButton *)reportButton {
    
    _reportButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 280, kDeviceWidth -40, 40)];
    [_reportButton setTitle:@"提交" forState:UIControlStateNormal];
    _reportButton.backgroundColor = [UIColor LkbBtnColor];
    [_reportButton setTitleColor:[UIColor whiteColor] forState:0];
    [_reportButton addTarget:self action:@selector(reportButton:) forControlEvents:UIControlEventTouchUpInside];
    return _reportButton;
}

- (void)reportButton:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否提交？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];

    }
    else {
        
//        self.requestParas = @{@"reportType":_reportType,
//                              @"userId":[[MyUserInfoManager shareInstance]userId],
//                              @"token":[[MyUserInfoManager shareInstance]token],
//                              @"objId":_objId,
//                              @"reportContent":_reportView.text,
//                              };
//        self.requestURL = LKB_Report_Content_Url;
        [self ShowProgressHUDwithMessage:@"举报成功！"];
        
        [self.navigationController popViewControllerAnimated:YES];


    }
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    
    if (self.requestURL ==  LKB_Report_Content_Url) {
        
        LKBBaseModel* responseModel = (LKBBaseModel*)parserObject;
        
        if ([responseModel.success isEqualToString:@"1"]) {
            
            [self ShowProgressHUDwithMessage:@"举报成功！"];
            
            
            
        }

        [self.navigationController popViewControllerAnimated:YES];

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
