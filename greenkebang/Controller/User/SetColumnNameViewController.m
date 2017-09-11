//
//  SetColumnNameViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/3.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SetColumnNameViewController.h"

@interface SetColumnNameViewController ()

@end

@implementation SetColumnNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"专栏名称";
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_pre"]style:UIBarButtonItemStyleDone target:self action:@selector(BackButton:)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishButton:)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    
    [self.view addSubview:self.schoolText];
    [self.view addSubview:self.line_1];
    // 键盘回收
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    // Do any additional setup after loading the view.
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
    
    [_ColumnNameTextField resignFirstResponder];
}


- (void)tap:(UITapGestureRecognizer *)recognizer
{
    [_ColumnNameTextField resignFirstResponder];
}


- (void)BackButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)nextVCBlock:(SetColumnNameBlock)block
{
    _nextVCBlock=block;
}

// 完成按钮
- (void)finishButton:(id)sender {
    
    
    if (_nextVCBlock) {
        _nextVCBlock(_ColumnNameTextField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



- (UITextField *)schoolText {
    
    _ColumnNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 64)];
    if ([_column isEqualToString:@""]||_column == nil) {
        _ColumnNameTextField.placeholder = @"请输入专栏名称";

    }
    else {
        
        _ColumnNameTextField.text = _column;
    }
    _ColumnNameTextField.font = [UIFont systemFontOfSize:14];
    return _ColumnNameTextField;
}

- (UIView *)line_1 {
    
    _line_1 = [[UIView alloc]initWithFrame:CGRectMake(10, 66, self.view.frame.size.width - 20, 0.7)];
    _line_1.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
    
    return _line_1;
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
