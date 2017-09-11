//
//  MyQuestionViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "MyQuestionViewController.h"
#import "MyQuestionTableViewCell.h"
#import "SVPullToRefresh.h"
#import "MyUserInfoManager.h"
#import "QADetailViewController.h"

static NSString* KDCellIdentifier = @"FindPepleTableViewCellIdentifier";

@interface MyQuestionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@end

@implementation MyQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    self.tableView.backgroundColor =  UIColorWithRGBA(237, 238, 239, 1);
    self.dataArray = [[NSMutableArray alloc] init];
//        [self initializeData];
    [self initializePageSubviews];


    // Do any additional setup after loading the view.
}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[MyQuestionTableViewCell class] forCellReuseIdentifier:KDCellIdentifier];
    }
    return _tableView;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyQuestionTableViewCell * simplescell = [tableView dequeueReusableCellWithIdentifier:KDCellIdentifier];
    
    if (indexPath.row < self.dataArray.count) {
        QuestionModelIntroduceModel *question =(QuestionModelIntroduceModel *)_dataArray[indexPath.row];
        [simplescell configQuestionCellWithModel:question];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return simplescell;

}


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < self.dataArray.count) {
        QuestionModelIntroduceModel *question = (QuestionModelIntroduceModel *)_dataArray[indexPath.row];
        QADetailViewController *QADetailVC = [[QADetailViewController alloc] init];
        QADetailVC.questionId = question.questionId;
        [self.navigationController pushViewController:QADetailVC animated:YES];
    }
    
}
#pragma mark - Page subviews
- (void)initializeData
{
    self.dataArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        [self.dataArray addObject:[NSNull null]];
    }
}



- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf fetchDataWithIsLoadingMore:NO];
        
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf fetchDataWithIsLoadingMore:YES];
    }];
    self.tableView.showsInfiniteScrolling = YES;
    [self.tableView triggerPullToRefresh];
    
    if (self.dataArray.count == 0) {
        //                LoveTableFooterView *footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        //                footerVew.addFriendBlock = ^(){
        //                    NSLog(@"addFriendClicked");
        //                };
        //                self.tableView.tableFooterView = footerVew;
    }
    
}


- (void)fetchDataWithIsLoadingMore:(BOOL)isLoadingMore
{
    NSInteger currPage = [[self.requestParas objectForKey:@"page"] integerValue];
    if (!isLoadingMore) {
        currPage = 1;
    } else {
        ++ currPage;
    }
    
    self.requestParas = @{@"userId":_therquestUrl,
                          @"ownerId":[[MyUserInfoManager shareInstance]userId],
                          @"page":@(currPage),
                          @"token":[[MyUserInfoManager shareInstance]token],
                          isLoadingMoreKey:@(isLoadingMore)};
    
    self.requestURL = LKB_Question_Url;
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        if (!isLoadingMore) {
    //            [self.tableView.pullToRefreshView stopAnimating];
    //        }
    //        else {
    //            //            [self.dataArray addObject:[NSNull null]];
    //            [self.tableView.infiniteScrollingView stopAnimating];
    //        }
    //        [self.tableView reloadData];
    //    });
    
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
    
    //    if ([request.url isEqualToString:LKB_Question_Url]) {
    QuestionModel *questionModel = (QuestionModel *)parserObject;
    NSLog(@"========%@===============",questionModel.data);
    if (!request.isLoadingMore) {
        if(questionModel.data)
        {
            _dataArray = [NSMutableArray arrayWithArray:questionModel.data];
        }
    } else {
        [_dataArray addObjectsFromArray:questionModel.data];
    }
    [self.tableView reloadData];
    if (questionModel.data.count == 0) {
        //[self.tableView.infiniteScrollingView endScrollAnimating];
    } else {
        self.tableView.showsInfiniteScrolling = YES;
        [self.tableView.infiniteScrollingView beginScrollAnimating];
    }
    //    }
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
