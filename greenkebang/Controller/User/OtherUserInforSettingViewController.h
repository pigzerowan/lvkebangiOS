//
//  OtherUserInforSettingViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/10.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherUserInforSettingViewController : BaseViewController
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)  NSString *sexTemp;// 性别判断


@property (nonatomic, strong)UILabel *nameTextField;
@property (nonatomic, strong)UILabel *SexLabel;
@property (nonatomic, strong)UILabel *goodFiled;// 擅长领域
@property (nonatomic, strong)UILabel *areaLabel;
@property (nonatomic, strong)UILabel *identity; // 职业身份
@property (nonatomic, strong)UITextView *introduceTextView;

@property(nonatomic, strong)  NSString *userId;// 性别判断
@property(nonatomic, strong)  NSString *userRemark;

@end
