//
//  WFBottomBarView.h
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WFBottomBarDelegate <NSObject>

@optional
- (void)selectBtn:(UIButton *)button;

@end

@interface WFBottomBarView : UIView

@property (nonatomic,assign) id<WFBottomBarDelegate>delegate;
@property (nonatomic,assign) BOOL nextArrowsEnable;
@property (nonatomic,assign) BOOL canStar;
@property (nonatomic,assign) BOOL canCollection;
@property (nonatomic,assign) BOOL canShare;

@property (nonatomic,copy)   UILabel *collLabel;// 收藏
@property (nonatomic,copy)   NSString *collNum;// 收藏
@property (nonatomic,copy)   UILabel *voteLabel; // 点赞
@property (nonatomic,copy)   NSString *voteNum; // 点赞
@property (nonatomic,copy)   NSString *commentNum; // 评论
@property (nonatomic,copy)   UILabel *shareLabel; // 点赞
@property (nonatomic,copy)   NSString *shareNum; // 分享

@end
