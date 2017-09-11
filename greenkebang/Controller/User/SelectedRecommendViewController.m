//
//  SelectedRecommendViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "SelectedRecommendViewController.h"
#import "SVPullToRefresh.h"
#import "MyUserInfoManager.h"
#import "SelectedRecommendCell.h"
#import "RecFriendModel.h"

static NSString* SelectedRecommendCellIdentifier = @"SelectedRecommendCellIdentifier";

@interface SelectedRecommendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    NSMutableArray *contacts;
    UIImageView *navBarHairlineImageView;

}

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic,strong)UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray* selectedArray;




@end

@implementation SelectedRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    self.title = @"精选推荐";
    
    contacts = [NSMutableArray array];
    self.dataArray = [[NSMutableArray alloc] init];
//    self.selectedCircleArray = [[NSMutableArray alloc] init];
//    self.selectedColumnArray = [[NSMutableArray alloc] init];
    self.selectedArray = [[NSMutableArray alloc] init];
    
    UIImageView * headerImage = [[UIImageView alloc]init];
    
    if (iPhone5) {
        
        headerImage.frame = CGRectMake(0, 0, kDeviceWidth, 162);

    }else if (iPhone6p,iPhone7p){
        
        
        headerImage.frame = CGRectMake(0, 0, kDeviceWidth, 210);

    }else {
        
        headerImage.frame = CGRectMake(0, 0, kDeviceWidth, 190);

    }
    
    headerImage.image = [UIImage imageNamed:@"SelectedRecommendBack"];
    
    [self.view addSubview:headerImage];
    
    
    
    
    //    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];

    // 左键按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    //    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-103.5, SCREEN_WIDTH, 0.5)];
    //    lineView.backgroundColor = CCCUIColorFromHex(0xd3d3d3);
    
    
    _joinButton = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 , SCREEN_WIDTH , 50)];
    _joinButton.backgroundColor = CCCUIColorFromHex(0x22a941);
    _joinButton.layer.borderColor =  [CCCUIColorFromHex(0xd3d3d3) CGColor];;
    _joinButton.layer.borderWidth = 0.5f;
    [_joinButton setTitle:@"选好了，进入绿科邦" forState:UIControlStateNormal];
    _joinButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [_joinButton addTarget:self action:@selector(joinButton:) forControlEvents:UIControlEventTouchUpInside];
    [_joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];

    [self.view  addSubview:_joinButton];
    // Do any additional setup after loading the view.
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}




-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)joinButton:(id)sender {
    
    NSString *userId;
    NSMutableArray *userIdArray = [NSMutableArray array];
    

    for (int i = 0; i<_selectedArray.count;i++ ) {
        friendModel *model = (friendModel *)_selectedArray[i];
        

        userId = model.objectId;
        

        [userIdArray addObject:userId];
    }
    
    NSString *circleStr = [userIdArray componentsJoinedByString:@","];
    
    NSLog(@"======================%@",circleStr);
    
    
    if (_selectedArray.count == 0) {
        
        AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate showUserTabBarViewController];


    }else {
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"groupId":circleStr, // 圈
                              @"token":[MyUserInfoManager shareInstance].token
                              };
        self.requestURL = LKB_Attention_Friend_Url;

        
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.navigationController.navigationBar.alpha=0;
    navBarHairlineImageView.hidden = YES;
    

    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[MyUserInfoManager shareInstance].token
                          };
    
    self.requestURL = LKB_Recommend_Friend_Url;

    [MobClick beginLogPageView:@"SelectedRecommendViewController"];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setClipsToBounds:NO];
    self.navigationController.navigationBar.alpha=1;

    [MobClick endLogPageView:@"SelectedRecommendViewController"];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
//    AttentionCell* cell = (AttentionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    SelectedRecommendCell *cell = (SelectedRecommendCell*)[collectionView dequeueReusableCellWithReuseIdentifier:SelectedRecommendCellIdentifier forIndexPath:indexPath];
;
    

    if (indexPath.row < _dataArray.count) {
        
        NSUInteger row = [indexPath row];
        friendModel *model = (friendModel *)_dataArray[indexPath.row];
        [cell configDiscoveryCellWithModel:model];
        

        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
            [dic setObject:@"NO" forKey:@"checked"];
            [cell setChecked:NO];
            
        }else {
            [dic setObject:@"YES" forKey:@"checked"];
            [cell setChecked:YES];
            
            
            

        }
        
    }
    
    
    [cell handlerButtonAction:^(NSInteger clickIndex) {
        
        if (clickIndex == 1 ) {
            
            NSUInteger row = [indexPath row];
            NSMutableDictionary *dic = [contacts objectAtIndex:row];
            
            if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
                [dic setObject:@"YES" forKey:@"checked"];
                [cell setChecked:YES];
                [_selectedArray addObject:_dataArray[indexPath.row]];
                
                

                
            }else {
                [dic setObject:@"NO" forKey:@"checked"];
                [cell setChecked:NO];
                [_selectedArray removeObject:_dataArray[indexPath.row]];
                

            }
        }

        
    }];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];

    return cell;
}
#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    
    if (iPhone5) {
        return CGSizeMake((kDeviceWidth-60)/3, 154);

    }
    else if (iPhone6p,iPhone7p) {
        
        return CGSizeMake((kDeviceWidth-60)/3, 222);

    }else {
        
        return CGSizeMake((kDeviceWidth-60)/3, 200);

    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.dataArray.count) {
        SelectedRecommendCell *cell = (SelectedRecommendCell*)[collectionView cellForItemAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];
        NSMutableDictionary *dic = [contacts objectAtIndex:row];
//        if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
//            [dic setObject:@"YES" forKey:@"checked"];
//            [cell setChecked:YES];
////            [_selectedArray addObject:_dataArray[indexPath.row]];
//        }else {
//            [dic setObject:@"NO" forKey:@"checked"];
//            [cell setChecked:NO];
////            [_selectedArray removeObject:_dataArray[indexPath.row]];
//        }
    }
    
}


#pragma mark - Getters & Setters

- (UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 20, 40, 25);
        
        if (iPhone5) {
            layout.minimumLineSpacing = 20;
            
        }else if (iPhone6p,iPhone7p) {
            layout.minimumLineSpacing = 20;
            
            
        }else {
            
            layout.minimumLineSpacing = 10;
            
            
        }

        layout.minimumInteritemSpacing = 5;
        
        if (iPhone5) {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 162, kDeviceWidth, KDeviceHeight - 162) collectionViewLayout:layout];

        }else if (iPhone6p,iPhone7p) {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 210, kDeviceWidth, KDeviceHeight - 210) collectionViewLayout:layout];

            
        }else {
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,190, kDeviceWidth, KDeviceHeight - 190) collectionViewLayout:layout];

            
        }
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.scrollEnabled = NO;
        
        
        
        
        UIView * lineView = [[UIView alloc]init];

        if (iPhone5) {
            
            lineView.frame = CGRectMake(14, (KDeviceHeight - 162 - 50) /2 , kDeviceWidth-28, 0.5);
        }else if (iPhone6p,iPhone7p) {
            
            lineView.frame = CGRectMake(14, (KDeviceHeight - 210 - 50) /2, kDeviceWidth-28, 0.5);

        }else {
            lineView.frame = CGRectMake(14, (KDeviceHeight - 190 - 50) /2 , kDeviceWidth-28, 0.5);
        }

        
        lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
        
        [_collectionView addSubview:lineView];
        
        [_collectionView registerClass:[SelectedRecommendCell class]
            forCellWithReuseIdentifier:SelectedRecommendCellIdentifier];
        
    }
    return _collectionView;
}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    
    if ([request.url isEqualToString:LKB_Recommend_Friend_Url]) {
        RecFriendModel *recFriendModel = (RecFriendModel *)parserObject;
        
        _dataArray = [NSMutableArray arrayWithArray:recFriendModel.data];
        for (int i = 0; i <self.dataArray.count; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if (i == 0) {
                
                [dic setValue:@"YES" forKey:@"checked"];
                


            }
            else {
                
                [dic setValue:@"NO" forKey:@"checked"];

            }
            

            [contacts addObject:dic];
        }
        
        
        [_selectedArray addObject:_dataArray[0]];
        
        [self.collectionView reloadData];

    }
    if ([request.url isEqualToString:LKB_Attention_Friend_Url]){
        
        AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate showUserTabBarViewController];
        
    }

    
    
    
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
