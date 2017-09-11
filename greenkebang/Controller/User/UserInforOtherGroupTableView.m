//
//  UserInforOtherGroupTableView.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/9.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforOtherGroupTableView.h"
#import "GroupTableViewCell.h"
#import "GroupDetaillModel.h"
#import "UserRootViewController.h"
#import "FarmerCircleViewController.h"
#import "ToUserManager.h"
#import "CircleIfJoinManager.h"
NSString * const UserOtherGroupCellIdentifier = @"UserOtherGroupCellIdentifier";

@interface UserInforOtherGroupTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation UserInforOtherGroupTableView
+ (UserInforOtherGroupTableView *)otherGroupTableView {
    
    UserInforOtherGroupTableView *userInforTV = [[UserInforOtherGroupTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-64) style:UITableViewStylePlain];
    userInforTV.backgroundColor = [UIColor clearColor];
    userInforTV.dataSource = userInforTV;
    userInforTV.delegate = userInforTV;
    userInforTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    return userInforTV;

}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    static NSString* otherCellIdentifier = @"otherPepleTableViewCellIdentifier";
    
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherCellIdentifier];
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.textLabel.text = kNoContentMSG;
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.backgroundColor =[UIColor whiteColor];
        
        return cell;
    }

    
    if (indexPath.row < self.dataArray.count ) {
        
        GroupDetailModel *findPeoleModel = (GroupDetailModel *)_dataArray[indexPath.row ];
        
        cell = [tableView dequeueReusableCellWithIdentifier:UserOtherGroupCellIdentifier];
        
        
        if (!cell) {
            
            cell =  [[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserOtherGroupCellIdentifier];
        }
        
        GroupTableViewCell* simplescell = (GroupTableViewCell *)cell;
        
        [simplescell configUserInforGroupCellWithModel:findPeoleModel];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count ;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
    
}


- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserRootViewController *controller ;
    
    id next =[self nextResponder];
    while (![next isKindOfClass:[UserRootViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[UserRootViewController class]]) {
        controller = (UserRootViewController *)next;
        GroupDetailModel *findPeoleModel = (GroupDetailModel *)_dataArray[indexPath.row ];
        
        FarmerCircleViewController * farmerVC = [[FarmerCircleViewController alloc]init];
        
        farmerVC.circleId = findPeoleModel.groupId;
        farmerVC.toUserId = [ToUserManager shareInstance].userId;
        farmerVC.mytitle = findPeoleModel.groupName;
        farmerVC.ifJion = findPeoleModel.isJoin;
        farmerVC.type= @"1";
        

        [CircleIfJoinManager shareInstance].ifJoin = findPeoleModel.isJoin;

        farmerVC.type = @"1";

        farmerVC.hidesBottomBarWhenPushed = YES;
        [controller.navigationController pushViewController:farmerVC animated:YES];
    }
    
    
}


@end
