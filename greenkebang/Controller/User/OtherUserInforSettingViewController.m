//
//  OtherUserInforSettingViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/10.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "OtherUserInforSettingViewController.h"
#import "MyUserInfoManager.h"
#import "UserInforModel.h"

static NSString* OtherCellIdentifier = @"UserInforOtherSettingCellIdentifier";

@interface OtherUserInforSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OtherUserInforSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tableView];

    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_pre"]style:UIBarButtonItemStyleDone target:self action:@selector(BackButton:)];
    self.navigationItem.leftBarButtonItem = left;
    
    
    self.requestParas = @{@"userId":_userId,
                          @"ownerId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[MyUserInfoManager shareInstance].token
                          };
    
    self.requestURL = LKB_User_Infor_Url;


    // Do any additional setup after loading the view.
}


- (void)BackButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
        _tableView.dataSource = self;
        _tableView.delegate= self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OtherCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = false;
        
    }
    return _tableView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 52;
    
}

// 区尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, KDeviceHeight - 116 - 64*5 -10, kDeviceWidth, 125)];
    view.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 8, kDeviceWidth, 125 )];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel* introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 18, 100, 25)];
    introduceLabel.text = @"个人简介";
    introduceLabel.textColor = CCCUIColorFromHex(0x888888);
    introduceLabel.font = [UIFont systemFontOfSize:15];
    [backView addSubview:introduceLabel];
    
    
    _introduceTextView = [[UITextView alloc]initWithFrame:CGRectMake(100, 18, kDeviceWidth -100 -16, 107)];
    _introduceTextView.backgroundColor = [UIColor clearColor];
    _introduceTextView.font = [UIFont systemFontOfSize:15];
    
    _introduceTextView.editable = NO;
    //    _wordNumberlLabel.backgroundColor = [UIColor magentaColor];
    [view addSubview:backView];
    
    
    [view addSubview:_introduceTextView];
    
    
    return view;
}


- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
         return 125;

}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:OtherCellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OtherCellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"昵称"; // 888888
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = CCCUIColorFromHex(0x888888);
        _nameTextField = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, kDeviceWidth -100, 52)];
        //            _nameTextField.backgroundColor = [UIColor magentaColor];
        [cell.contentView addSubview:_nameTextField];
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"性别"; // f7f7f7
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = CCCUIColorFromHex(0x888888);
        _SexLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, kDeviceWidth-100, 52)];
        //            _SexLabel.backgroundColor = [UIColor magentaColor];
//        _SexLabel.text = @"请点击选择性别";
        _SexLabel.textColor = CCCUIColorFromHex(0xf7f7f7);
        [cell.contentView addSubview:_SexLabel];
        
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"擅长领域";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = CCCUIColorFromHex(0x888888);
        _goodFiled = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, kDeviceWidth -100, 52)];
        //            _goodTextFieldf.backgroundColor = [UIColor cyanColor];
        [cell.contentView addSubview:_goodFiled];
        
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"所在区域";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = CCCUIColorFromHex(0x888888);
        _areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, kDeviceWidth -100, 52)];
        _areaLabel.textColor = [UIColor blackColor];
        //            _areaLabel.backgroundColor = [UIColor cyanColor];
        [cell.contentView addSubview:_areaLabel];
        
    }
    if (indexPath.row == 4) {
        cell.textLabel.text = @"职业身份";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = CCCUIColorFromHex(0x888888);
        _identity = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, kDeviceWidth -100, 52)];
        //            _occupationTextField.backgroundColor = [UIColor cyanColor];
        [cell.contentView addSubview:_identity];
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(16, 52, SCREEN_WIDTH -32, 1)];
    lineView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    [cell addSubview:lineView];
    
    return cell;
}
- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage {
    if (errorMessage) {
        [self ShowProgressHUDwithMessage:errorMessage];
    }
    
    if (self.requestURL == LKB_User_Infor_Url) {
        
        UserInforModel *userInfor = (UserInforModel*)parserObject;
        UserInforModellIntroduceModel *model =userInfor.data;
        
        
        _nameTextField.text = model.userName;
        self.title = model.userName;
        // 性别
        if ([model.gender isEqualToString: @"0"]) {
            _SexLabel.text = @"男";
            _SexLabel.textColor = [UIColor blackColor];
        }
        else if ([model.gender isEqualToString: @"0"]) {
            _SexLabel.text = @"女";
            _SexLabel.textColor = [UIColor blackColor];

        }
        else {
            
            _SexLabel.text = @"未填写";
        }
        
        if ([model.address isEqualToString:@""]||model.address ==nil) {
            _areaLabel.text = @"未填写";
        }
        else {
            _areaLabel.text = model.address;

        }
        if ([model.goodFiled isEqualToString:@""]||model.goodFiled ==nil) {
            _goodFiled.text = @"未填写";
        }
        else {
            
            _goodFiled.text = model.goodFiled;
        }
        if ([model.identity isEqualToString:@""]||model.identity ==nil) {
            _identity.text = @"未填写";
        }
        else {
            
            _identity.text = model.identity;
        }

        
        if ([model.remark isEqualToString:@""]||model.remark == nil) {
            _introduceTextView.text = @"未填写";
        }
        else {
        _introduceTextView.text = model.remark;
            _userRemark = model.remark;
            
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
