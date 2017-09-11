//
//  UserInforTopicTableView.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol PushTopicController <NSObject>
//
//-(void)pushNextViewController:(NSString *)object;
//
//@end


@interface UserInforTopicTableView : UITableView
@property(nonatomic, strong)NSMutableArray *dataArray;
+ (UserInforTopicTableView *)topicTableView;

//@property(weak, nonatomic)id<PushTopicController>pushNextDelegate;
@end
