//
//  UserInforColumnTableView.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol PushColumnController <NSObject>
//
//-(void)pushNextColumnViewController:(NSString *)objectId;
//
//@end
@interface UserInforColumnTableView : UITableView
@property(nonatomic, strong)NSMutableArray *dataArray;
+ (UserInforColumnTableView *)columnTableView;

//@property(weak, nonatomic)id<PushColumnController>pushNextColumnDelegate;

@end
