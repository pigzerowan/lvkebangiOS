//
//  TalkSettingViewControllrt.m
//  greenkebang
//
//  Created by 郑渊文 on 10/20/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "TalkSettingViewControllrt.h"


static NSString* CellIdentifier = @"CellIdentifier";
@interface TalkSettingViewControllrt ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSArray* dataArray;


@end

@implementation TalkSettingViewControllrt
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"私信设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self cofigSubviews];
    _dataArray = [NSArray arrayWithObjects:@"所有人",@"已关注的人",nil];
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
