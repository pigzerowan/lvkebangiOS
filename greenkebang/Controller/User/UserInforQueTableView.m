//
//  UserInforQueTableView.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "UserInforQueTableView.h"
#import "QuestionModel.h"
#import "UserNoImageDetailCell.h"
#import "UserAutoLayoutDefautCell.h"
#import "UserRootViewController.h"
#import "QADetailViewController.h"
NSString * const UserQuestionWithNoImageDetailCellIdentifier = @"UserQuestionWithNoImageDetail";
static NSString* UserQuestionAutoLayoutDefautCellIdentifier = @"UserQuestionAutoLayoutDefautCellIdentifier";

@interface UserInforQueTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation UserInforQueTableView
+ (UserInforQueTableView *)qusetionTableView {
    
    UserInforQueTableView *userInforTV = [[UserInforQueTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-64) style:UITableViewStylePlain];
    userInforTV.backgroundColor = [UIColor clearColor];
    userInforTV.dataSource = userInforTV;
    userInforTV.delegate = userInforTV;
    userInforTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    return userInforTV;

    
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *QuestionCell =@"QuestionCell";
    
    UITableViewCell *cell;
    if (_dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QuestionCell];
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
        
//        UserDynamicModelIntroduceModel *insight = (UserDynamicModelIntroduceModel *)_dataArray[indexPath.row];
        QuestionModelIntroduceModel *insight = (QuestionModelIntroduceModel *)_dataArray[indexPath.row];

        
        if ([NSStrUtil isEmptyOrNull:insight.cover]) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:UserQuestionWithNoImageDetailCellIdentifier];
            if (!cell) {
                
                // 4
                cell = [[UserNoImageDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:UserQuestionWithNoImageDetailCellIdentifier];
                
                
            }
            UserNoImageDetailCell *tbCell = (UserNoImageDetailCell *)cell;
            
            [tbCell configNoImageDetailQuestionTableCellWithModel:insight];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
        
        else{
            cell = [tableView dequeueReusableCellWithIdentifier:UserQuestionAutoLayoutDefautCellIdentifier];
            if (!cell) {
                // 5
                cell = [[UserAutoLayoutDefautCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:UserQuestionAutoLayoutDefautCellIdentifier];
            }
            UserAutoLayoutDefautCell *tbCell = (UserAutoLayoutDefautCell *)cell;
            [tbCell configUserQuestionTableCellWithModel:insight];
            [tbCell setNeedsUpdateConstraints];
            [tbCell updateConstraintsIfNeeded];
        }
        
    }
    
   cell.selectionStyle = UITableViewCellSelectionStyleNone;

     return cell;



}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_dataArray.count == 0) {
        return 1;
    }
    else {
    return _dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _dataArray.count) {
        
//        UserDynamicModelIntroduceModel *useInforModel = self.dataArray[indexPath.row];
        QuestionModelIntroduceModel *questionModel =(QuestionModelIntroduceModel *)_dataArray[indexPath.row];

        //        if ([useInforModel.type isEqualToString:@"2"]) {
        if ([NSStrUtil isEmptyOrNull:questionModel.cover]) {
            return [UserNoImageDetailCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                UserNoImageDetailCell *cell = (UserNoImageDetailCell *)sourceCell;
                // 配置数据
                [cell configNoImageDetailQuestionTableCellWithModel:questionModel];
            } cache:^NSDictionary *{
                return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"userQuestion%@",questionModel.questionId],
                         kHYBCacheStateKey : @"expanded",
                         // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                         // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                         kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                         };
            }];
            
        }
                    else
                    {
        
                        NSString *stateKey = nil;
        
                        // 5
                        return [UserAutoLayoutDefautCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                            UserAutoLayoutDefautCell *cell = (UserAutoLayoutDefautCell *)sourceCell;
                            // 配置数据
                            [cell configUserQuestionTableCellWithModel:questionModel];
                        } cache:^NSDictionary *{
                            return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"userQuestion%@", questionModel.title],
                                     kHYBCacheStateKey : @"expanded",
                                     // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                                     // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                                     kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                                     };
                        }];
        
        
 }
    }
    
    else
    {
        return 528;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UserRootViewController *controller ;
    
    id next =[self nextResponder];
    while (![next isKindOfClass:[UserRootViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[UserRootViewController class]]) {
        controller = (UserRootViewController *)next;
        
        QuestionModelIntroduceModel *questionModel =(QuestionModelIntroduceModel *)_dataArray[indexPath.row];
        
        NSLog(@"--------------------------%@",questionModel.questionId);
        
        QADetailViewController *QADetailVC = [[QADetailViewController alloc] init];
        QADetailVC.questionId = questionModel.questionId;
        QADetailVC.hidesBottomBarWhenPushed = YES;
        
        [controller.navigationController pushViewController:QADetailVC animated:YES];

    }

    
}


@end
