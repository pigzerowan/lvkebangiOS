//
//  UserInforSettingViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/6.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInforSettingViewController : BaseViewController
@property (strong, nonatomic) UIImage *headImg; // 头像图片
@property (nonatomic, copy) NSURL *photoUrl;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIButton *saveButton;
@property(nonatomic, strong)UIButton *CancelButton;
@property(nonatomic, strong)UIButton *skipButton;
@property(nonatomic, strong)  NSString *sexTemp;// 性别判断


@property (nonatomic, strong)UIButton *headerButton;
@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UILabel *SexLabel;
@property (nonatomic, strong)UITextField *goodFiled;// 擅长领域
@property (nonatomic, strong)UILabel *areaLabel;
@property (nonatomic, strong)UITextField *identity; // 职业身份
@property (nonatomic, strong)UITextView *introduceTextView;
@property (strong, nonatomic) UILabel * wordNumberlLabel; // 字数统计
@property (strong, nonatomic) NSString *attentionNum; // 0 上一层是注册的页面  1 是我的界面

@property (strong, nonatomic) NSString *headerImg;// 上层页面的头像
@property (strong, nonatomic) NSString * nameStr;
@property (strong, nonatomic) NSString * genderStr;
@property (strong, nonatomic) NSString * goodFiledStr;
@property (strong, nonatomic) NSString * addressStr;
@property (strong, nonatomic) NSString * identityStr;
@property (strong, nonatomic) NSString * remarkStr;
@end
