//
//  TrendsRootViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 12/23/15.
//  Copyright © 2015 transfar. All rights reserved.
//
#import "MJRefresh.h"
#import "TrendsRootViewController.h"
#import "UITableView+DataSourceBlocks.h"
#import "UITableView+DelegateBlocks.h"
#import "TableViewWithBlock.h"
#import "VVeboTableView.h"
@interface TrendsRootViewController ()<MJRefreshBaseViewDelegate>
//@interface NewsViewController ()<BannerViewDelegate,  MJRefreshBaseViewDelegate, CategoryLabelDelegate,>
{
    NSMutableArray *newsArr;
    NSString *errorInfo;
    
    MJRefreshHeaderView *header;
    MJRefreshFooterView *footer;
    
    NSMutableArray *categoryArray;
    NSString *currentSelectedCategory;
    UITableViewHeaderFooterView *myHeader;
    
    UIImageView *rotationImageView;
}

@property (strong, nonatomic)  UIView *sliderView;
@property (strong, nonatomic)  UIScrollView *headScrollView;
@property (strong, nonatomic)  TableViewWithBlock *newsTableView;

@end
@implementation TrendsRootViewController
{
    NSString *beginId;
    
    CGFloat imgArrowWidth;
    CGFloat imgArrowHeight;
    bool haveHeadAd;
    bool isFooterEnd;
    VVeboTableView *tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableView = [[VVeboTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    [self.view addSubview:tableView];
    
    // Do any additional setup after loading the view.
    
//    [self initTableView];
    
    header = [MJRefreshHeaderView header];
    header.scrollView = self.newsTableView;
    header.delegate = self;
    
    footer = [MJRefreshFooterView footer];
    footer.scrollView = self.newsTableView;
    footer.delegate = self;

}

- (void)initTableView
{
    [self.newsTableView initTableViewDataSourceAndDelegate:^(UITableView *tableView) {
       return (NSInteger)1;
    }setNumberOfRowsBlock:^NSInteger(UITableView *tableView, NSInteger section) {
        if (newsArr.count == 0) {
            return (NSInteger)1;
        }
        else
        {
            if (haveHeadAd) {
                return (NSInteger)newsArr.count - 1;
            } else {
                return (NSInteger)newsArr.count;
            }
        }

    } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        static NSString *CELLNONE = @"CELLNONE";
        
         UITableViewCell *cell;
        if (newsArr.count == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLNONE];
            [cell setBackgroundColor:[UIColor whiteColor]];
            cell.textLabel.text = kNoContentMSG;
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            return cell;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;


    } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        
    } setHeightForRowBlock:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 150;
    }];
 }

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [header free];
    [footer free];
}

- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    //    DLog(@"refreshViewEndRefreshing complete");
}

- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    //    DLog(@"refreshViewEndRefreshing complete");
}

-(TableViewWithBlock *)newsTableView
{
    if (!_newsTableView) {
        _newsTableView = [[TableViewWithBlock alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _newsTableView.backgroundColor = [UIColor whiteColor];
        _newsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _newsTableView;

}
@end
