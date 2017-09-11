//
//  AttentionDefaultViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 12/14/15.
//  Copyright © 2015 transfar. All rights reserved.
//
#define Start_X 25.0f           // 第一个按钮的X坐标
#define Start_Y 74.0f           // 第一个按钮的Y坐标
#define Width_Space 25.0f        // 2个按钮之间的横间距
#define Height_Space 35.0f      // 竖间距
#define Button_Height 72.0f    // 高
#define Button_Width 72.0f      // 宽


static NSString* CellIdentifier = @"DiscoveryWaterfallCell";

#import "AttentionCell.h"
#import "MyUserInfoManager.h"
#import "AttentionDefaultViewController.h"
#import "RecFriendModel.h"
#import "LKBLoginModel.h"

@interface AttentionDefaultViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    UIButton *aBt;
    NSMutableArray *contacts;
}
@property (strong, nonatomic)UIButton *attentionBtn;
@property(nonatomic,strong)UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic) NSMutableArray* selectedArray;

@end
@implementation AttentionDefaultViewController

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
    self.title = @"推荐好友";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor =CCColorFromRGBA(227, 42, 97, 1);
    contacts = [NSMutableArray array];
    self.dataArray = [[NSMutableArray alloc] init];
    self.selectedArray = [[NSMutableArray alloc] init];

    [self.view addSubview:self.collectionView];
    
    _attentionBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, KDeviceHeight-120, kDeviceWidth-20, 40)];
    _attentionBtn.layer.masksToBounds = YES;
    [_attentionBtn setBackgroundImage:[UIImage imageNamed:@"login-btn-normal"] forState:UIControlStateNormal];
    [_attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_attentionBtn addTarget:self action:@selector(attentionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

     [self.view addSubview:_attentionBtn];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"token":[MyUserInfoManager shareInstance].token
                          };
    
    self.requestURL = LKB_Recommend_Friend_Url;
}



- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{    if (errorMessage) {
      [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    if ([request.url isEqualToString:LKB_Recommend_Friend_Url]) {
        RecFriendModel *recFriendModel = (RecFriendModel *)parserObject;
        
        _dataArray = [NSMutableArray arrayWithArray:recFriendModel.data];
        self.selectedArray = [NSMutableArray arrayWithArray:_dataArray];
        for (int i = 0; i <self.dataArray.count; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:@"YES" forKey:@"checked"];
            [contacts addObject:dic];
        }
        [self.collectionView reloadData];
    }
    
    if ([request.url isEqualToString:LKB_Attention_Friend_Url]){

        
        AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate showUserTabBarViewController];

    }
    
 }


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    AttentionCell* cell = (AttentionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                                                                      forIndexPath:indexPath];
    if (indexPath.row < _dataArray.count) {
        
        NSUInteger row = [indexPath row];
        friendModel *model = (friendModel *)_dataArray[indexPath.row];
        [cell configDiscoveryOtherFallCellWithModel:model];
        
        

        
        
        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
            [dic setObject:@"NO" forKey:@"checked"];
            [cell setChecked:NO];
            
        }else {
            [dic setObject:@"YES" forKey:@"checked"];
            [cell setChecked:YES];
        }
      
    }
    return cell;
}
#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    return CGSizeMake((kDeviceWidth-90)/3, 110);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.dataArray.count) {
        AttentionCell *cell = (AttentionCell*)[collectionView cellForItemAtIndexPath:indexPath];
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

}


#pragma mark - Getters & Setters

- (UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(25, 20, 40, 25);
        layout.minimumLineSpacing = 25;
        layout.minimumInteritemSpacing = 5;
            _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        

        
        [_collectionView registerClass:[AttentionCell class]
            forCellWithReuseIdentifier:CellIdentifier];

    }
    return _collectionView;
}

- (UIButton *)attentionBtn
{
    if (!_attentionBtn) {
        _attentionBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, KDeviceHeight-150, kDeviceWidth-20, 40)];
        _attentionBtn.layer.masksToBounds = YES;
        [_attentionBtn setBackgroundImage:[UIImage imageNamed:@"login-btn-normal"] forState:UIControlStateNormal];
        [_attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionBtn addTarget:self action:@selector(attentionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attentionBtn;
}

-(void)attentionBtnClicked:(id)sender
{
    NSString *userId;
    NSMutableArray *userIdArray = [NSMutableArray array];

    for (int i = 0; i<_selectedArray.count;i++ ) {
        friendModel *model = (friendModel *)_selectedArray[i];
        userId = model.userId;
        [userIdArray addObject:userId];
    }
    
    NSString *str = [userIdArray componentsJoinedByString:@","];
    self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                          @"userIds":str,
                          @"token":[MyUserInfoManager shareInstance].token
                          };
    self.requestURL = LKB_Attention_Friend_Url;
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
