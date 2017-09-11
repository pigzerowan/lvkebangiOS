//
//  ChooseGroupTypeViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 2/1/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "ChooseGroupTypeViewController.h"
#import "DerectManager.h"
#import "MyUserInfoManager.h"
static NSString* CellIdentifier = @"CellIdentifier";

@interface ChooseGroupTypeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSArray* dataArray;
@end
@implementation ChooseGroupTypeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择行业";
    self.view.backgroundColor = [UIColor whiteColor];
    [self cofigSubviews];
    _dataArray = [NSArray arrayWithObjects:@"农业",@"食品",@"环保",@"健康",@"生物", nil];
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
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_setGroupTypeBlock) {
        _setGroupTypeBlock(_dataArray[indexPath.row]);
    }
    

    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)sendeGrouptypeBlock:(SetGroupTypeBlock)block
{
    _setGroupTypeBlock=block;
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
