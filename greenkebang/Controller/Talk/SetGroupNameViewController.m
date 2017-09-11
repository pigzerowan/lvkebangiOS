//
//  SetGroupNameViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 2/1/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "SetGroupNameViewController.h"
#import "MyUserInfoManager.h"


@interface SetGroupNameViewController ()

@end
@implementation SetGroupNameViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    [_GroupNameTextField resignFirstResponder];
}


- (void)tap:(UITapGestureRecognizer *)recognizer
{
    [_GroupNameTextField resignFirstResponder];
}


- (void)BackButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)nextVCBlock:(SetGroupNameBlock)block
{
    _nextVCBlock=block;
}

// 完成按钮
- (void)finishButton:(id)sender {
    
    
    if (_nextVCBlock) {
        _nextVCBlock(_GroupNameTextField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



- (UITextField *)schoolText {
    
    _GroupNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 64)];
//    _GroupNameTextField.placeholder = @"请输入群组名称";
    if (_nameLabel == nil) {
            _GroupNameTextField.placeholder = @"请输入群组名称";

    }
    else {
        
        _GroupNameTextField.text = _nameLabel;
    }
    _GroupNameTextField.font = [UIFont systemFontOfSize:14];
    return _GroupNameTextField;
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

@end
