#import "CityViewController.h"
#import <CoreLocation/CoreLocation.h>


static NSString* CellIdentifier = @"cityCellIdentifier";
static NSString* const strLoc = @"定";

@interface CityViewController () <UISearchDisplayDelegate, CLLocationManagerDelegate> {
    CLLocationManager* locationManager;
}
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) UISearchDisplayController* searchDisplayController;

@property (nonatomic, strong) NSString* locationCity;
@property (nonatomic, strong) NSMutableDictionary* cities;

@property (nonatomic, strong) NSMutableArray* keys; //城市首字母
@property (nonatomic, strong) NSMutableArray* arrayCitys; //城市数据
@property (nonatomic, strong) NSMutableArray* arrayHotCity;

@property (nonatomic, strong) NSArray* searchResults;

@property (nonatomic, assign) BOOL isShowSearch;
@property (nonatomic, assign) BOOL isEndLocation;

@end

@implementation CityViewController

@synthesize searchDisplayController;
#pragma mark - Life cycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didLeftBarButtonItemAction:)];
    [self initializePageSubviews];
    if ([CLLocationManager locationServicesEnabled]) {
        _locationCity = @"";
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers; // 越精确，越耗电！
        if (IOS8) {
            //使用期间
            [locationManager requestWhenInUseAuthorization];
        }

        [locationManager startUpdatingLocation]; // 开始
    }
    else {
        _locationCity = @"无法定位当前城市";
        (self.cities)[strLoc] = @[ _locationCity ];
    }
    [self getCityData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getCityData
{
    self.arrayHotCity = [NSMutableArray arrayWithObjects:@"杭州市", @"上海市", @"北京市", @"深圳市", @"天津市", @"重庆市", @"青岛市", nil];
    self.keys = [NSMutableArray array];

    NSString* path = [[NSBundle mainBundle] pathForResource:@"citydict"
                                                     ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];

    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];

    //添加定位城市
    [self.keys insertObject:strLoc atIndex:0];
    (self.cities)[strLoc] = @[ _locationCity ];

    //添加热门城市
    NSString* strHot = @"热";
    [self.keys insertObject:strHot atIndex:1];
    (self.cities)[strHot] = _arrayHotCity;

    self.arrayCitys = [NSMutableArray array];
    self.searchResults = [NSMutableArray array];

    NSArray* allCitys = [_cities allValues];
    for (NSArray* array in allCitys) {
        for (NSString* str in array) {
            [self.arrayCitys addObject:str];
        }
    }

    /** // block 方式遍历 速度比for...in 稍慢一点
     [_cities enumerateKeysAndObjectsUsingBlock:^(id key, id dicobj,   BOOL *stop) {
     [dicobj enumerateObjectsUsingBlock:^(id arrayobj, NSUInteger idx, BOOL *stop) {
     NSLog(@"idx = %d and obj = %@", idx, arrayobj);
     [self.arrayCitys addObject:arrayobj];
     }];
     }];
     */
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }
    else {
        return _keys.count;
    }
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return _searchResults.count;
    }
    else {
        NSString* key = _keys[section];
        NSArray* citySection = _cities[key];
        return citySection.count;
    }
}
- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    else {
        return _keys;
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView == self.searchDisplayController.searchResultsTableView ? 0 : 22;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [[UIView alloc] init];
    }
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
    bgView.backgroundColor = [UIColor colorWithRed:230.0 / 255.0 green:230.0 / 255.0 blue:230.0 / 255.0 alpha:0.7f];

    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 250, 22)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];

    NSString* key = _keys[section];

    if ([key rangeOfString:@"定"].location != NSNotFound) {
        titleLabel.text = @"定位城市";
    }
    else if ([key rangeOfString:@"热"].location != NSNotFound) {
        titleLabel.text = @"热门城市";
    }
    else {
        titleLabel.text = key;
    }
    [bgView addSubview:titleLabel];

    return bgView;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.font = [UIFont systemFontOfSize:16];

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = _searchResults[indexPath.row];
    }
    else {
        NSString* key = _keys[indexPath.section];
        cell.textLabel.text = _cities[key][indexPath.row];
    }

    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString* cityName = @"";
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cityName = _searchResults[indexPath.row];
        if (self.finishedSelectBlock) {
            self.finishedSelectBlock(cityName);
        }
        [self cancelCityViewController];
    }
    else {
        if (indexPath.section == 0 && indexPath.row == 0) {
            if ([_locationCity isEqualToString:@"无法定位当前城市"] || [_locationCity isEqualToString:@""]) {
                return;
            }
        }

        NSString* key = _keys[indexPath.section];
        cityName = _cities[key][indexPath.row];
        if (self.finishedSelectBlock) {
            self.finishedSelectBlock(cityName);
        }
        [self cancelCityViewController];
    }
}
#pragma mark - Search Delegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController*)controller
{
    _isShowSearch = YES;
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController*)controller
{
    if (_isEndLocation) {
        [self.tableView reloadData];
        _isEndLocation = !_isEndLocation;
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController*)controller shouldReloadTableForSearchString:(NSString*)searchString
{
    // 创建谓词判断工具
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@", searchString];
    self.searchResults = [_arrayCitys filteredArrayUsingPredicate:predicate];
    NSSet* set = [NSSet setWithArray:self.searchResults];
    self.searchResults = [set allObjects];
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K contains[cd] %@",name, searchString];
    //   self.searchResults = [NSMutableArray arrayWithArray:[_arrayCitys filteredArrayUsingPredicate:predicate]];

    return YES;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error
{
    _locationCity = @"无法定位当前城市";
    (self.cities)[strLoc] = @[ _locationCity ];
    [self.tableView reloadData];
}
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
    case kCLAuthorizationStatusNotDetermined:
        if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
        break;
    default:
        break;
    }
}
- (void)locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation
{
    if (newLocation) {
        [locationManager stopUpdatingLocation];
    }

    CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray* placemarks, NSError* error) {
                       for (CLPlacemark* placemark in placemarks) {
                           NSDictionary* dic = [placemark addressDictionary];
                           if (dic[@"City"]) {
                               _locationCity = dic[@"City"];
                           }
                           else {
                               _locationCity = @"无法定位当前城市";
                           }
                           (self.cities)[strLoc] = @[ _locationCity ];
                       }
                       _isEndLocation = YES;
                       if (!_isShowSearch) {
                           [self.tableView reloadData];
                       }
                   }];
}

#pragma mark - Navigation methods
- (void)didLeftBarButtonItemAction:(id)sender
{
    [self cancelCityViewController];
}
- (void)cancelCityViewController
{
    [_searchBar resignFirstResponder];
    
    if (self.navigationController.viewControllers.count <= 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - Page subviews
- (void)initializePageSubviews
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 44)];
    self.tableView.tableHeaderView = self.searchBar;
    self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    self.searchDisplayController.delegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
}
#pragma mark - Getters & Setters

@end
