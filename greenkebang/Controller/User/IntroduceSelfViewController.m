//
//  IntroduceSelfViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 10/5/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "IntroduceSelfViewController.h"
#import "MyUserInfoManager.h"

@interface IntroduceSelfViewController ()<UITextViewDelegate>

@property(nonatomic,strong)UITextView *introduceMsg;
@property(nonatomic,strong)UILabel *introduceLab;
@end

@implementation IntroduceSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人简介";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    
    UIButton *senderBtn = [[UIButton alloc]initWithFrame:CGRectMake(286, 12, 24, 24)];
    [senderBtn setImage:[UIImage imageNamed:@"sender_talk"] forState:UIControlStateNormal];
    [senderBtn addTarget:self action:@selector(toSenderMyName:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:senderBtn];
    ;
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;

    // Do any additional setup after loading the view.
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated

{
     _introduceLab.text = [MyUserInfoManager shareInstance].desc;
}
-(void)toSenderMyName:(id)sender
{
    self.requestParas=@{@"userId":[MyUserInfoManager shareInstance].userId,
                        @"desc":_introduceMsg.text
                        };
    self.requestURL = LKB_Center_Setdesc_Url;
}

- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if ([request.url isEqualToString:LKB_Center_Setdesc_Url]) {
        LKBBaseModel *model = (LKBBaseModel *)parserObject;
        [self ShowProgressHUDwithMessage:model.msg];
        if ([model.msg isEqualToString:@"更新用户简介 成功"]) {
             [self.navigationController popViewControllerAnimated:YES];
            [MyUserInfoManager shareInstance].desc = _introduceMsg.text;
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
    [self.view addSubview:self.introduceMsg];
    [self.view addSubview:self.introduceLab];
    
    
    
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


- (UITextView*)introduceMsg
{
    if (!_introduceMsg) {
        _introduceMsg = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 200)];
        _introduceMsg.textColor = [UIColor textGrayColor];
        _introduceMsg.font = [UIFont systemFontOfSize:13];
        _introduceMsg.layer.borderWidth =1;
       
        _introduceMsg.layer.borderColor = UIColorWithRGBA(237, 238, 239, 1).CGColor;
        _introduceMsg.textAlignment =NSTextAlignmentLeft;
    }
    
    return _introduceMsg;
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


@end
