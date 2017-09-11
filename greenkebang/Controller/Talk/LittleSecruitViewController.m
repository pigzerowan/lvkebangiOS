#import "LittleSecruitViewController.h"
#import "SecretTableViewCell.h"
#import "SecretModel.h"
#import "UIImageView+EMWebCache.h"
#import "InsightDetailViewController.h"
#import "QADetailViewController.h"
#import "YQWebDetailViewController.h"
static NSString* XCellIdentifier = @"LittleSecruitCellIdentifier";

@interface LittleSecruitViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;


@end

@implementation LittleSecruitViewController

#pragma mark - Life cycle
- (void)dealloc
{
    [NOTIFICENTER removeObserver:self];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    [self initializePageSubviews];

}

-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.secretAarry.count;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    SecretTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:XCellIdentifier];
    
    if (indexPath.section < self.secretAarry.count) {
        NSDictionary *dic =  _secretAarry[indexPath.section];
        [cell.coverImageView sd_setImageWithURL:dic[@"imgUrl"] placeholderImage:LKBSecruitPlaceImage];
         cell.titleLabel.text = dic[@"title"];
    }
    
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < self.secretAarry.count) {
        NSDictionary *dic =  _secretAarry[indexPath.section];
        NSString *str = dic[@"url"];
        if ([str rangeOfString:@"http://www.greentechplace.com/jianjie/"].location!=NSNotFound ) {
            //        simpleGood *topic = (NewInsightModel *)_dataArray[indexPath.row];
            NSArray *strarray = [str componentsSeparatedByString:@".h"];
            NSString *str = strarray[0];
            
            NSArray *strarray2 = [str componentsSeparatedByString:@"e/"];
            NSString *idStr = strarray2[1];
            InsightDetailViewController *BlogVC = [[InsightDetailViewController alloc] init];
            BlogVC.hidesBottomBarWhenPushed = YES;
            BlogVC.topicId = idStr;
            
            [self.navigationController pushViewController:BlogVC animated:YES];
        }
     else  if ([str rangeOfString:@"http://www.greentechplace.com/wenda/"].location!=NSNotFound ) {
            //        simpleGood *topic = (NewInsightModel *)_dataArray[indexPath.row];
            NSArray *strarray = [str componentsSeparatedByString:@".h"];
            NSString *str = strarray[0];
            
            NSArray *strarray2 = [str componentsSeparatedByString:@"a/"];
            NSString *idStr = strarray2[1];
            QADetailViewController *BlogVC = [[QADetailViewController alloc] init];
            BlogVC.hidesBottomBarWhenPushed = YES;
            BlogVC.questionId = idStr;
            
            [self.navigationController pushViewController:BlogVC animated:YES];
     }
     else  if ([str rangeOfString:@"http://www.greentechplace.com/huati/"].location!=NSNotFound ) {
         //        simpleGood *topic = (NewInsightModel *)_dataArray[indexPath.row];
         NSArray *strarray = [str componentsSeparatedByString:@".h"];
         NSString *str = strarray[0];
         
         NSArray *strarray2 = [str componentsSeparatedByString:@"i/"];
         NSString *idStr = strarray2[1];
//         TopicDetaillViewController *BlogVC = [[TopicDetaillViewController alloc] init];
//         BlogVC.hidesBottomBarWhenPushed = YES;
//         BlogVC.topicId = idStr;
//         
//         [self.navigationController pushViewController:BlogVC animated:YES];
     }
        
        else
     {
        YQWebDetailViewController* webDetailVC = [[YQWebDetailViewController alloc] init];
        webDetailVC.urlStr = str;
        webDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webDetailVC animated:YES];
     }
  }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
    timeView.backgroundColor = [UIColor clearColor];
    
    UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, kDeviceWidth-200, 20)];
    timeLable.backgroundColor =  CCColorFromRGBA(203, 203, 203, 1);
//    CCColorFromRGBA(228, 227, 228, 1);
    timeLable.textAlignment = NSTextAlignmentCenter;
    timeLable.layer.cornerRadius = 10;
    timeLable.layer.borderWidth  = 1.0f;
    timeLable.layer.cornerRadius = 5.0f;
    timeLable.clipsToBounds = YES;
    timeLable.layer.borderColor  = [UIColor clearColor].CGColor;
    timeLable.font = [UIFont systemFontOfSize:10];
    timeLable.textColor = [UIColor whiteColor];
    timeLable.text = self.timeArray[section];
    
    [timeView addSubview:timeLable];
    return timeView;
}


#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.view addSubview:self.tableView];

}
#pragma mark - Getters & Setters
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.rowHeight = 220;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = CCColorFromRGBA(238, 238, 238, 1);
//        [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[SecretTableViewCell class] forCellReuseIdentifier:XCellIdentifier];
    }
    return _tableView;
}

#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeAll;
}
#endif
@end
