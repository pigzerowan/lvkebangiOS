//
//  SetUpGroupInforViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/3/15.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SetUpGroupInforViewController.h"
#import "MyUserInfoManager.h"
#import "SVPullToRefresh.h"
#import "NewSeperateViewController.h"
#import "ReportViewController.h"
@interface SetUpGroupInforViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (strong, nonatomic)   UIButton *applyStatusBtn;

@end

@implementation SetUpGroupInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
;
//    [self.tableView addSubview:_applyStatusBtn];
    
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    // Do any additional setup after loading the view.
}


-(void)ifaddGroup:(UIButton *)sender {
    
//    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认要退群么？" preferredStyle:UIAlertController];
    
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认要退群么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    
    [alertView show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 1) {
        
            self.requestParas = @{@"groupId":_groupIdStr,
                                  @"userId":[MyUserInfoManager shareInstance].userId,
                                  @"token":[MyUserInfoManager shareInstance].token
                                  };
            self.requestURL = LKB_Group_Logout_Url;

    }
    
}







- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        _tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
        
//        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    }
    
    return _tableView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (section ==1) {
        return 1;
    }
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}



- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"GroupInfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
            lineView.backgroundColor =UIColorWithRGBA(237, 238, 239, 1);
            [cell addSubview:lineView];
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell .textLabel.text = @"邀请好友";

        }
        if (indexPath.row == 1) {
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
            lineView.backgroundColor =UIColorWithRGBA(237, 238, 239, 1);
            [cell addSubview:lineView];
            cell.textLabel.text = @"群消息接受";
            // 按钮
            UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectMake(kDeviceWidth -60, 20, 60, 20)];
            switchView.on = YES;
            switchView.onTintColor = [UIColor LkbBtnColor];
            [cell addSubview:switchView];
            
            
        }
    }
    if (indexPath.section == 1) {
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
        lineView.backgroundColor =UIColorWithRGBA(237, 238, 239, 1);
        [cell addSubview:lineView];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"举报";
    }
    if (indexPath.section == 2) {
        cell.backgroundColor =UIColorWithRGBA(237, 238, 239, 1);

        _applyStatusBtn =  [[UIButton alloc]initWithFrame:CGRectMake(10, 10  , SCREEN_WIDTH-20, 44)];
        _applyStatusBtn.backgroundColor = [UIColor LkbBtnColor];
        [_applyStatusBtn setTitle:@"退出群组" forState:UIControlStateNormal];
        [_applyStatusBtn addTarget:self action:@selector(ifaddGroup:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:_applyStatusBtn];
    }
    
    return cell;
}


//-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (indexPath.section == 1) {
//        ReportViewController *reportVC = [[ReportViewController alloc]init];
//        reportVC.objId =_groupIdStr ;
//        reportVC.reportType = @"2";
//        [self.navigationController pushViewController:reportVC animated:YES];
//
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 1) {
        ReportViewController *reportVC = [[ReportViewController alloc]init];
        reportVC.objId =_groupIdStr ;
        reportVC.reportType = @"2";
        [self.navigationController pushViewController:reportVC animated:YES];
    
    }
}

    
    
- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    if (!request.isLoadingMore) {
        [self.tableView.pullToRefreshView stopAnimating];
    } else {
        [self.tableView.infiniteScrollingView stopAnimating];
    }
    
    if (errorMessage) {
       [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    
    // 退组成功
    if ([request.url isEqualToString:LKB_Group_Logout_Url]) {
        LKBBaseModel *baseModel = (LKBBaseModel *)parserObject;
        if ([baseModel.success isEqualToString:@"1"]) {
            [self ShowProgressHUDwithMessage:baseModel.msg];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
//            AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
//            [appDelegate showUserTabBarViewController];
        }
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
