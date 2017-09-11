//
//  SearchSeperateViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/14.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SearchOtherControllerType) {
    
//    /**< 内容*/
//    SearchConnectOtherControllerTypeContent = 0,
    /**< 群组*/
    SearchGroupOtherControllerTypeGroup = 1,
    /**< 人物*/
    SearchPeopleOtherControllerTypePeople,
};

@interface SearchSeperateViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataArray;

@property (assign, nonatomic) SearchOtherControllerType controllerType;

- (instancetype)initWithSearchOtherControllerType:(SearchOtherControllerType)controllerType;
@end
