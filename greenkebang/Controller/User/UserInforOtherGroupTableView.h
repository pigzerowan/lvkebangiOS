//
//  UserInforOtherGroupTableView.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/9.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInforOtherGroupTableView : UITableView
@property (nonatomic, strong)NSMutableArray *dataArray;
+ (UserInforOtherGroupTableView *)otherGroupTableView;
@end
