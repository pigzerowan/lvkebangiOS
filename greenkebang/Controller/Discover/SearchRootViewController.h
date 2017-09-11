//
//  SearchRootViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/14.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPagerController.h"

@interface SearchRootViewController : BaseViewController <UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSArray *classArray;
@property (strong, nonatomic) NSArray *dataArray;

@property (nonatomic, assign) BOOL variable;
@property (nonatomic, assign) BOOL showNavBar;

@end
