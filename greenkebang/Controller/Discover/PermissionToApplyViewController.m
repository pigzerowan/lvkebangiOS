//
//  PermissionToApplyViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 2017/3/20.
//  Copyright © 2017年 transfar. All rights reserved.
//

#import "PermissionToApplyViewController.h"

@interface PermissionToApplyViewController ()

@end

@implementation PermissionToApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"交易权限申请";
    
    UIImageView *  noNetImg = [[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth - 175)/ 2, 155, 175, 173)];
    
    //    UIImage *myImg = [UIImage sd_animatedGIFNamed:@"publish_success"];
    
    
    UIImage *myImg = [UIImage imageNamed:@"Review"];
    noNetImg.image = myImg;

    
    [self.view addSubview:noNetImg];

    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_write_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    
    
    // Do any additional setup after loading the view.
}

-(void)backToMain
{
    
    if ([_btnType isEqualToString:@"1"]) {
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    else {
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]                                              animated:YES];

    }
    

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
