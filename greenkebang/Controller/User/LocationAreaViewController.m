//
//  LocationViewController.m
//  WheatPlan
//
//  Created by 郑渊文 on 6/23/15.
//  Copyright (c) 2015 IOSTeam. All rights reserved.
//

#import "LocationAreaViewController.h"
#import "SmallAreaViewController.h"
#import "ChooseAreaCell.h"
#import "areaManager.h"
#import "AreaModel.h"

@interface LocationAreaViewController ()

@property(nonatomic,strong)UITableView *myTable;
@property(nonatomic,strong)NSMutableArray *areaNameArray;
@property(nonatomic,strong)NSMutableArray *araeaIdArray;
@property(nonatomic,strong)NSMutableArray *araeaPathIdArray;
@end

@implementation LocationAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _areaNameArray = [NSMutableArray array];
    _araeaIdArray = [NSMutableArray array];
    _araeaPathIdArray = [NSMutableArray array];
    self.requestParas = @{@"areaId":@"",
                          };
    self.requestURL = LKB_Center_Arealist_Url;
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    [self initSubViews];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initSubViews
{
    
    self.navigationItem.title = @"选择地区";

    _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStylePlain];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    [self.view addSubview:_myTable];
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
    NSString *areaName = [areaManager shareInstance].areaName;
    if(areaName == nil)
        cell.SelectedimgView.hidden = true;
    else
    {
        if([areaName isEqualToString:[_areaNameArray objectAtIndex:indexPath.row]]){
            cell.SelectedimgView.hidden = false;
            cell.areaLable.textColor = [UIColor orangeColor];}
        else{
            cell.SelectedimgView.hidden = true;
            cell.areaLable.textColor = [UIColor blackColor];
        }
    }
    AreaDetailModel *areaDetail = (AreaDetailModel *)_areaNameArray[indexPath.row];
    
    
    cell.textLabel.text = areaDetail.areaName;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AreaDetailModel *areaDetail = (AreaDetailModel *)_areaNameArray[indexPath.row];
    [areaManager shareInstance].areaName = areaDetail.areaName;
    
    [_myTable reloadData];
    SmallAreaViewController *sugVC = [[SmallAreaViewController alloc]init];
   sugVC. areaId = areaDetail.areaId;
    [self.navigationController pushViewController:sugVC animated:YES];

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
    }
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
