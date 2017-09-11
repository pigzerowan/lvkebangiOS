//
//  UserInforQueTableView.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/4.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol PushQuestionController <NSObject>
//
//-(void)pushNextQuestionViewController:(NSString *)objectId;
//
//@end

@interface UserInforQueTableView : UITableView
+ (UserInforQueTableView *)qusetionTableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
//@property(weak, nonatomic)id<PushQuestionController>pushNextQuestionDelegate;


@end
