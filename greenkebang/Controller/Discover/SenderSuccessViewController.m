//
//  SenderSuccessViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 10/14/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "SenderSuccessViewController.h"
#import "UIImage+GIF.h"

@interface SenderSuccessViewController ()

@end

@implementation SenderSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

  UIImageView *  noNetImg = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2-60, KDeviceHeight/2-218, 120, 120)];
    
//    UIImage *myImg = [UIImage sd_animatedGIFNamed:@"publish_success"];
    
    
    UIImage *myImg = [UIImage imageNamed:@"publish_success_a"];
    noNetImg.image = myImg;
    
    
    
    UILabel *  successLable = [[UILabel alloc]initWithFrame:CGRectMake(50, KDeviceHeight/2 -44, kDeviceWidth-100, 24)];
    successLable.text = @"您的申请已提交成功";
    successLable.textAlignment = NSTextAlignmentCenter;
    successLable.font = [UIFont systemFontOfSize:18];

    
    
  UILabel *  nonetLable = [[UILabel alloc]initWithFrame:CGRectMake(60, KDeviceHeight/2-16, kDeviceWidth-120, 24)];
    nonetLable.text = @"请耐心等待我们的审核";
    nonetLable.textAlignment = NSTextAlignmentCenter;
    nonetLable.font = [UIFont systemFontOfSize:12];
    nonetLable.textColor = CCCUIColorFromHex(0x999999);
    
    
   UIButton* tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth/2-50, KDeviceHeight/2-180+260, 135, 33)];
    [tryAgainBtn setBackgroundImage:[UIImage imageNamed:@"select_tranBtn"] forState:UIControlStateNormal];
    tryAgainBtn.layer.cornerRadius = 3.5;
    [tryAgainBtn setTitle:@"确定" forState:UIControlStateNormal];
    tryAgainBtn .titleLabel.font = [UIFont systemFontOfSize:14];
    [tryAgainBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [tryAgainBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:noNetImg];
    [self.view addSubview:successLable];
    [self.view addSubview:nonetLable];
    [self.view addSubview:tryAgainBtn];
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    //    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    
    
    // Do any additional setup after loading the view.
}

-(void)backToMain
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]                                              animated:YES];
}


- (UIImageView *)findBottomLineInView:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findBottomLineInView:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
    
    UIImageView *navBarBottomLine = [self findBottomLineInView:self.navigationController.navigationBar];
    navBarBottomLine.hidden = YES;
    [MobClick beginLogPageView:@"SenderSuccessViewController"];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"SenderSuccessViewController"];
}



-(void)makesure:(id)sender
{

      [self.navigationController popToRootViewControllerAnimated:YES];
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
