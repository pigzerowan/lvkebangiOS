//
//  UserInforTopicTableView.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforTopicTableView.h"
#import "ToPicModel.h"
#import "UserTopicImageButNoDetailCell.h"
#import "UserTopicNoImageNoDetailCell.h"
#import "UserRootViewController.h"
NSString * const UserTopicImageButNoDetailCellIdentifier = @"UserImageButNoDetailCellIdentifier";
NSString * const UserTopicNoImageNoDetailCellIdentifier = @"UserNoImageNoDetailCellIdentifier";

@interface UserInforTopicTableView ()<UITableViewDelegate,UITableViewDataSource,AttentionTopicCellDelegate>

@end

@implementation UserInforTopicTableView
+ (UserInforTopicTableView *)topicTableView {
    
    UserInforTopicTableView *userInforTV = [[UserInforTopicTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-64) style:UITableViewStylePlain];
    userInforTV.backgroundColor = [UIColor clearColor];
    userInforTV.dataSource = userInforTV;
         userInforTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    userInforTV.delegate = userInforTV;
    userInforTV.separatorStyle = UITableViewCellSeparatorStyleNone;

    return userInforTV;
    
    
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *SlideBarCell =@"SlideBarCell";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SlideBarCell];
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.textLabel.text = kNoContentMSG;
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        cell.backgroundColor =[UIColor magentaColor];
        
        return cell;
    }
    if (indexPath.row < self.dataArray.count) {
        
        PeoplestopicModel *peopleModel =(PeoplestopicModel *)_dataArray[indexPath.row];
        
        if ([NSStrUtil isEmptyOrNull:peopleModel.topicAvatar])
        {
            
            cell = [tableView dequeueReusableCellWithIdentifier:UserTopicNoImageNoDetailCellIdentifier];
            if (!cell) {
                // 1
                cell = [[UserTopicNoImageNoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:UserTopicNoImageNoDetailCellIdentifier];
                
            }
            UserTopicNoImageNoDetailCell *tbCell = (UserTopicNoImageNoDetailCell *)cell;
            tbCell.selectionStyle = UITableViewCellSelectionStyleNone;

            tbCell.attentionCellDelegate = self;
            [tbCell configNoImageNoDetailUserTopicTableCellWithGoodModel:peopleModel];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
        
        
        else
        {
            cell = [tableView dequeueReusableCellWithIdentifier:UserTopicImageButNoDetailCellIdentifier];
            if (!cell) {
                // 2
                cell = [[UserTopicImageButNoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:UserTopicImageButNoDetailCellIdentifier];
            }
            UserTopicImageButNoDetailCell *tbCell = (UserTopicImageButNoDetailCell *)cell;
            
            tbCell.selectionStyle = UITableViewCellSelectionStyleNone;

            [tbCell configUserTableCellWithModel:peopleModel];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
        
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    
    if (_dataArray.count==0) {
        return 1;
    }
    else
    {
        return _dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_dataArray.count!=0&& indexPath.row < _dataArray.count) {
        
        PeoplestopicModel *peopleModel =(PeoplestopicModel *)_dataArray[indexPath.row];
        if ([NSStrUtil isEmptyOrNull:peopleModel.topicAvatar]) {
            
            // 1
            return [UserTopicNoImageNoDetailCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                UserTopicNoImageNoDetailCell *cell = (UserTopicNoImageNoDetailCell *)sourceCell;
                // 配置数据
                [cell configNoImageNoDetailUserTopicTableCellWithGoodModel:peopleModel];
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"user%@",peopleModel.topicId],
                         kHYBCacheStateKey : @"expanded",
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                         };
            }];

 
        }
        else
        {
            
 
            // 2
            return [UserTopicImageButNoDetailCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                UserTopicImageButNoDetailCell *cell = (UserTopicImageButNoDetailCell *)sourceCell;
                // 配置数据
                [cell configUserTableCellWithModel:peopleModel];
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"user%@",peopleModel.topicId],
                         kHYBCacheStateKey : @"expanded",
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                         };
            }];

        }
    }
    else {
    return 258;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    PeoplestopicModel *peopleModel =(PeoplestopicModel *)_dataArray[indexPath.row];
//    if (_pushNextDelegate) {
//        [_pushNextDelegate pushNextViewController:peopleModel.topicId];
//    }
//    [self pushNextViewController:TopicVC];
    
    UserRootViewController *controller ;
    
    id next =[self nextResponder];
    while (![next isKindOfClass:[UserRootViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[UserRootViewController class]]) {
        controller = (UserRootViewController *)next;
        
        PeoplestopicModel *peopleModel =(PeoplestopicModel *)_dataArray[indexPath.row];
        
        NSLog(@"--------------------------%@",peopleModel.topicId);
        
//        TopicDetaillViewController *TopicVC = [[TopicDetaillViewController alloc] init];
//        TopicVC.hidesBottomBarWhenPushed = YES;
//        TopicVC.topicId = peopleModel.topicId;
//        
//        [controller.navigationController pushViewController:TopicVC animated:YES];
        
    }

}




@end
