//
//  ChangeChooseViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 11/2/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "ChangeChooseViewController.h"
#import "DerectManager.h"
#import "DirectModel.h"
static NSString* CellIdentifier = @"CellIdentifie222r";
@interface ChangeChooseViewController ()

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end


@implementation ChangeChooseViewController


- (void)actionFetchRequest:(YQRequestModel*)request result:(LKBBaseModel*)parserObject
              errorMessage:(NSString*)errorMessage
{
    if (errorMessage) {
       [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    
    if ([request.url isEqualToString:LKB_Center_Industrylist_Url]) {
        DirectModel *areaModel = (DirectModel *)parserObject;
        
        if(areaModel.data)
        {
            _dataArray = [NSMutableArray arrayWithArray:areaModel.data];
        }
        [self.tableView reloadData];
        if (areaModel.data.count == 0) {
            //            [self.tableView.infiniteScrollingView endScrollAnimating];
            
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择行业";
    self.view.backgroundColor = [UIColor whiteColor];
    [self cofigSubviews];
    _dataArray = [NSMutableArray array];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    self.requestURL = LKB_Center_Industrylist_Url;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cofigSubviews
{
    [self.view addSubview:self.tableView];
}
-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}



- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    DirectDetailModel *areaDetail = (DirectDetailModel *)_dataArray[indexPath.row];
    [DerectManager shareInstance].DirectionStr = areaDetail.className;
    cell.textLabel.text = areaDetail.className;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DirectDetailModel *areaDetail = (DirectDetailModel *)_dataArray[indexPath.row];
    [DerectManager shareInstance].DirectionStr = areaDetail.className;
    [DerectManager shareInstance].directionId = areaDetail.classId;
 
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}





@end
