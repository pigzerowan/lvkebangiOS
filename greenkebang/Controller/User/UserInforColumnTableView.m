//
//  UserInforColumnTableView.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforColumnTableView.h"
#import "MyColumnIntroduceCell.h"
#import "ColumnModel.h"
#import "ColumnListViewController.h"
#import "UserRootViewController.h"

NSString * const columnCellIdentifier = @"ColumnPepleTableViewCellIdentifier";

@interface UserInforColumnTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation UserInforColumnTableView

+ (UserInforColumnTableView *)columnTableView {
    
    UserInforColumnTableView *userInforTV = [[UserInforColumnTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-64) style:UITableViewStylePlain];
    userInforTV.backgroundColor = [UIColor clearColor];
    userInforTV.dataSource = userInforTV;
    userInforTV.delegate = userInforTV;
    userInforTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    return userInforTV;
    
    
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    static NSString *ColumnIntroduce =@"ColumnIntroduce";

    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ColumnIntroduce];
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

    if (indexPath.row < self.dataArray.count) {
        
        ColumnIntroduceModel *MyColumnIntroduceModel = (ColumnIntroduceModel *)_dataArray[indexPath.row];

        cell = [tableView dequeueReusableCellWithIdentifier:columnCellIdentifier];

        
        if (!cell) {
            
            cell =  [[MyColumnIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:columnCellIdentifier];
        }
        
        MyColumnIntroduceCell* simplescell = (MyColumnIntroduceCell *)cell;
        simplescell.selectionStyle = UITableViewCellSelectionStyleNone;
        [simplescell configColumnIntroduceCellWithModel:MyColumnIntroduceModel];
        [simplescell setNeedsUpdateConstraints];
        [simplescell updateConstraintsIfNeeded];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.f;
    
}


- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
//        ColumnIntroduceModel *topic = (ColumnIntroduceModel *)_dataArray[indexPath.row];
//    if (_pushNextColumnDelegate) {
//        [self.pushNextColumnDelegate pushNextColumnViewController:topic.featureId];
//    }

    UserRootViewController *controller ;
    
    id next =[self nextResponder];
    while (![next isKindOfClass:[UserRootViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[UserRootViewController class]]) {
        controller = (UserRootViewController *)next;
        
        ColumnIntroduceModel *topic = (ColumnIntroduceModel *)_dataArray[indexPath.section];
        
        
        
        NSLog(@"--------------------------%@", [topic valueForKey:@"featureId"]);
        
        ColumnListViewController *ColumnListViewVC = [[ColumnListViewController alloc] init];
        ColumnListViewVC.featureId = [topic valueForKey:@"featureId"];
        //    ColumnListViewVC.title = topic.featureName;
        //    ColumnListViewVC.featureAvatar = topic.featureAvatar;
        //    ColumnListViewVC.featureDesc = topic.featureDesc;
        //    ColumnListViewVC.themUrl = topic.userId;
        ColumnListViewVC.hidesBottomBarWhenPushed = YES;
        [controller.navigationController pushViewController:ColumnListViewVC animated:YES];
        
    }


}


@end
