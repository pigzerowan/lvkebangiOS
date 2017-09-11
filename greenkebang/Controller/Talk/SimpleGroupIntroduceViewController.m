//
//  SimpleGroupIntroduceViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 2/1/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "SimpleGroupIntroduceViewController.h"
#import "MyUserInfoManager.h"
@interface SimpleGroupIntroduceViewController ()<UITextViewDelegate,UITextFieldDelegate>


@end

@implementation SimpleGroupIntroduceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_pre"]style:UIBarButtonItemStyleDone target:self action:@selector(BackButton:)];
    self.navigationItem.leftBarButtonItem = left;
    self.title = @"群组简介";
    self.introductionView.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(saveButton:)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:self.wordNumberView];
    [self.view addSubview:self.introductionView];
    
    // Do any additional setup after loading the view.
}

// 返回键
- (void)BackButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

// 完成键
- (void)saveButton:(id)sender {
    
    if (_introduceBlock) {
        _introduceBlock(_introductionView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}




-(void)sendeGroupIntroduceBlock:(SetGroupIntroduceBlock)block
{
    _introduceBlock=block;
}
// 介绍自己
- (UITextView *)introductionView {
    
    if (!_introductionView) {
        
        _introductionView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 150)];
//        _introductionView.text = @"请用1-200个字介绍群组";
        if (self.fieldText == nil) {
            
            _introductionView.text =  @"请用1-200个字介绍群组";
        }
        else {
            
            self.introductionView.text = self.fieldText;
        }
        _introductionView.textColor = [UIColor lightGrayColor];
        _introductionView.font = [UIFont systemFontOfSize:13];
        _introductionView.layer.borderWidth = 1;
        _introductionView.layer.borderColor = UIColorWithRGBA(237, 238, 239, 1).CGColor;
        //        _describle.returnKeyType = UIReturnKeyDefault;
        //        _describle.keyboardType = UIKeyboardAppearanceDefault;
        
    }
    return _introductionView;
}


// 实现正文的placeholder
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"请用1-200个字介绍群组"]) {
        
        textView.text = @"";
        textView.textColor = [UIColor textGrayColor];
        
    }
    
}

//在结束编辑的代理方法中进行如下操作
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length<1) {
        
        textView.text = @"请用1-200个字介绍群组";
        
    }
    
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    [_introductionView resignFirstResponder];
}

- (UILabel *)wordNumberView {
    
    _wordNumberlLabel = [[UILabel alloc]init];
    _wordNumberlLabel.frame = CGRectMake(SCREEN_WIDTH - 75, 170, 100, 20);
    _wordNumberlLabel.textColor = [UIColor lightGrayColor];
    
    
    return _wordNumberlLabel;
}



// 字数统计
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=200)
    {
        return  NO;
    }
    else
    {
        return YES;
    }
}


- (void)textViewDidChange:(UITextView *)textView {
    NSInteger number = [self.introductionView.text length];
    if (number > 200) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于200" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:200];
        number = 200;
    }
    self.wordNumberlLabel.text = [NSString stringWithFormat:@"%ld/200",number];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
