//
//  SmallAreaViewController.m
//  WheatPlan
//
//  Created by 郑渊文 on 6/23/15.
//  Copyright (c) 2015 IOSTeam. All rights reserved.
//

#import "SmallAreaViewController.h"
#import "ChooseAreaCell.h"
#import "areaManager.h"
#import "AreaModel.h"
#import "MyUserInfoManager.h"

@interface SmallAreaViewController ()
{
    UIButton *backBtn;
    
}
@property(nonatomic,copy)UITableView *myTable;
@property(nonatomic,copy)NSMutableArray *areaNameArray;
@property(nonatomic,copy)NSMutableArray *araeaIdArray;
@end

@implementation SmallAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _areaNameArray = [NSMutableArray array];
    _araeaIdArray = [NSMutableArray array];
    self.requestParas = @{@"areaId":_areaId,
                          };
    self.requestURL = LKB_Center_Arealist_Url;
    
    [self initSubViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSubViews
{
    
    self.navigationItem.title = @"选择地区";
 
    
    _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-74) style:UITableViewStylePlain];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    [self.view addSubview:_myTable];
}



- (void)actionFetchRequest:(YQRequestModel*)request result:(LKBBaseModel*)parserObject
              errorMessage:(NSString*)errorMessage
{
    if (errorMessage) {
     [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    
    if ([request.url isEqualToString:LKB_Center_Arealist_Url]) {
        AreaModel *areaModel = (AreaModel *)parserObject;
        
        if(areaModel.data)
        {
            _areaNameArray = [NSMutableArray arrayWithArray:areaModel.data];
        }
        [self.myTable reloadData];
        if (areaModel.data.count == 0) {
            //            [self.tableView.infiniteScrollingView endScrollAnimating];
            
        }
    }else
        
        if ([request.url isEqualToString:LKB_Center_Setarea_Url]) {
            LKBBaseModel *areaModel = (LKBBaseModel *)parserObject;
            
            if(areaModel.msg){
                [self ShowProgressHUDwithMessage:areaModel.msg];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _areaNameArray.count;
}


#pragma mark--- tableViewDelegate 区尾的高度

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 40;
    
}
#pragma mark--- tableViewDelegate cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *NOTIFY = @"cell";
    ChooseAreaCell *cell = (ChooseAreaCell *)[tableView dequeueReusableCellWithIdentifier:NOTIFY];
    if (cell==nil) {
        cell=[[ChooseAreaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NOTIFY];
        
    }
    
     AreaDetailModel *areaDetail = (AreaDetailModel *)_areaNameArray[indexPath.row];
    
    NSString *areaName = [areaManager shareInstance].areaName;
    if(areaName == nil)
        cell.SelectedimgView.hidden = true;
    else
    {
        if([areaName isEqualToString:areaDetail.areaName]){
            cell.SelectedimgView.hidden = false;
            cell.areaLable.textColor = [UIColor orangeColor];}
        else{
            cell.SelectedimgView.hidden = true;
            cell.areaLable.textColor = [UIColor blackColor];
        }
    }
   
    cell.textLabel.text = areaDetail.areaName;
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AreaDetailModel *areaDetail = (AreaDetailModel *)_areaNameArray[indexPath.row];
    [areaManager shareInstance].areaName = areaDetail.areaName;
    [areaManager shareInstance].areaId = areaDetail.areaId;
    NSLog(@"传了个什么值回去呢%@",[areaManager shareInstance].areaId);
    
    self.requestParas = @{@"areaId":[areaManager shareInstance].areaId,
                          @"userId":[MyUserInfoManager shareInstance].userId
 };
    self.requestURL = LKB_Center_Setarea_Url;

    [_myTable reloadData];

}


-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
