//
//  SystemDynamicViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SystemDynamicViewController.h"
#import "LoveTableFooterView.h"
#import "SystemInformsCell.h"
#import "SystemInformsModel.h"
#import "MyUserInfoManager.h"
#import "SVPullToRefresh.h"
#import "ZFActionSheet.h"

NSString * const SystemDynamicCellIdentifier = @"SystemDynamicCellIdentifier";

@interface SystemDynamicViewController ()<UITableViewDataSource,UITableViewDelegate,ZFActionSheetDelegate>
{
    UIImageView * WithoutInternetImage;
    UIButton *tryAgainButton;
    
}


@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (strong, nonatomic)ZFActionSheet *actionSheet;


@end

@implementation SystemDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统通知";
    self.view.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    self.dataArray = [[NSMutableArray alloc] init];

    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10,22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    UIButton *clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10,40, 22)];
    [clearBtn addTarget:self action:@selector(clearBtn) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
//    clearBtn.titleLabel.textColor = CCCUIColorFromHex(0x69c21b);
//    [clearBtn setTintColor:CCCUIColorFromHex(0x69c21b)];
    [clearBtn setTitleColor:CCCUIColorFromHex(0x69c21b) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:clearBtn];

    WithoutInternetImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Network-error"]];
    
    WithoutInternetImage.frame = CGRectMake((kDeviceWidth - 161.5)/2 , 155,161.5, 172);
    
    tryAgainButton = [[UIButton alloc]init];
    
    tryAgainButton.frame = CGRectMake((kDeviceWidth - 135)/2, 374, 135, 33);
    tryAgainButton.backgroundColor = CCCUIColorFromHex(0x01b654);
    tryAgainButton.layer.cornerRadius = 3.0f;
    [tryAgainButton setTitle:@"刷新" forState:UIControlStateNormal];
    [tryAgainButton setTitleColor:CCCUIColorFromHex(0xffffff) forState:UIControlStateNormal];
    tryAgainButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [tryAgainButton addTarget:self action:@selector(tryAgainButton:) forControlEvents:UIControlEventTouchUpInside];
    WithoutInternetImage.hidden = YES ;
    tryAgainButton.hidden = YES;
    
    [self.view addSubview:WithoutInternetImage];
    [self.view addSubview:tryAgainButton];

    [self initializePageSubviews];

}
-(void)clearBtn
{
    _actionSheet = [ZFActionSheet actionSheetWithTitle:nil confirms:@[@"清空此列表"] cancel:@"取消" style:ZFActionSheetStyleDefault];
    _actionSheet.delegate = self;
    [_actionSheet showInView:self.view.window];
}

- (void)clickAction:(ZFActionSheet *)actionSheet atIndex:(NSUInteger)index
{
    NSLog(@"选中了 %zd",index);
    
    self.requestParas = @{@"userId": [[MyUserInfoManager shareInstance]userId],//@"2",
                          @"token": [[MyUserInfoManager shareInstance]token],//@"2ade3777aa9742dda8263b7cb789d57c"
                          };
    
    self.requestURL = LKB_System_Informs_Clear;

    
}




- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];
    
    self.requestParas = @{@"userId": [[MyUserInfoManager shareInstance]userId],//@"2",
                          @"token": [[MyUserInfoManager shareInstance]token],//@"2ade3777aa9742dda8263b7cb789d57c"
                          };
    
    self.requestURL = LKB_System_Informs;

    
    if (self.dataArray.count == 0) {
        
        LoveTableFooterView* footerVew = [[LoveTableFooterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 54)];
        footerVew.textLabel.text=@"已经到底了";
        self.tableView.tableFooterView = footerVew;
        self.tableView.tableFooterView.hidden = YES;
    }
    
    
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = CCCUIColorFromHex(0xf7f7f7f7);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SystemInformsCell class] forCellReuseIdentifier:SystemDynamicCellIdentifier];

    }
    return _tableView;
}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // 设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor navbarColor]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
}



-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString *SlideBarCell =@"SlideBarCell";
    
    SystemInformsCell* simplescell = [tableView dequeueReusableCellWithIdentifier:SystemDynamicCellIdentifier];
    simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SlideBarCell];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView * loadingImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Without-notice"]];
        
        loadingImage.frame = CGRectMake((kDeviceWidth - 161.5) / 2 , 155, 161.5, 172 );
        
        [cell addSubview:loadingImage];
        
        return cell;
    }
    if (indexPath.row < self.dataArray.count) {
        
        SystemInformsDetailModel * model = (SystemInformsDetailModel *)_dataArray[indexPath.row];
        
        [simplescell configSystemInformsCellWithGoodModel:model];

        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return simplescell;

//    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_dataArray.count == 0) {
        
        return 1;
        
    }
    else {
        return self.dataArray.count ;

    }
    
    
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_dataArray.count == 0) {
        return KDeviceHeight;
        
    }
    else {

        SystemInformsCell *cell = [tableView dequeueReusableCellWithIdentifier:SystemDynamicCellIdentifier];

        [cell configSystemInformsCellWithGoodModel:self.dataArray[indexPath.row]];
        return cell.cellHeight;
//        return 150;

    }
   

//    return 150;
    
}





- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
//    if (!request.isLoadingMore) {
//        
//        [self.tableView.pullToRefreshView stopAnimating];
//    } else {
//        
//        [self.tableView.infiniteScrollingView stopAnimating];
//        
//    }
    if (errorMessage) {
        
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        
        if ([errorMessage isEqualToString:@"没有网络，连接失败"]) {
            
            
            [self.tableView removeFromSuperview];
            WithoutInternetImage.hidden = NO;
            tryAgainButton.hidden = NO;
            
            
            
        }
        

        return;
    }

    
    if ([request.url isEqualToString:LKB_System_Informs]) {
        
        SystemInformsModel *topicModel = (SystemInformsModel *)parserObject;
        
        NSLog(@"=====================%@",topicModel.data);
        
        _dataArray = [NSMutableArray arrayWithArray:topicModel.data];
        [self.tableView reloadData];
    }
    
    if ([request.url isEqualToString:LKB_System_Informs_Clear]) {
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        
        if ([Model.success isEqualToString:@"1"]) {
            [XHToast showTopWithText:Model.msg topOffset:60.0];
            
            [_dataArray removeAllObjects];
            
            [_tableView reloadData];

        }
        
        
    }


}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
