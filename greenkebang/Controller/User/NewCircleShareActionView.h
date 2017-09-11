//
//  NewCircleShareActionView.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/12.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialControllerService.h"
#import "SRRefreshView.h"

@class NewCircleShareActionView;

extern NSString* const ActivityShareTitle;


typedef void(^SGAlertActionHandler)(NSInteger index, NSString *name);


@protocol NewCircleShareActionViewDelegete <NSObject>

@optional
- (void)newCircleShareActionView:(NewCircleShareActionView *)UserHeaderView didatterntion:(NSInteger)index;

@end

@interface CircleShareModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *shareText;

@end



@interface NewCircleShareActionView : UIView
@property(strong,nonatomic) UIButton *shareImageButton;
@property (strong, nonatomic) NSArray *imageArray;

@property(nonatomic,assign) id<NewCircleShareActionViewDelegete> delegate;
@property (strong, nonatomic)CircleShareModel *shareDta;


/**
 *  获取单例
 */
+ (NewCircleShareActionView *)sharedView;
/**
 *  弹出分享列表
 *
 *  @param controller 来源controller
 *  @param title      分享弹狂标题
 *  @param shareData  分享数据源
 *  @param handler    点击回调
 
 
 */


//- (void)handlerButtonAction:(MyclickBlock)block;

+ (void)showShareMenuWithAlertView:(UIViewController *)controller
                             title:(NSString *)title
                         shareData:(CircleShareModel *)shareData
                    selectedHandle:(SGAlertActionHandler)handler;


- (void)shareWithFormView:(UIViewController *)controller shareData:(CircleShareModel *)shareData plantNameIndex:(NSString *)platformName;



@end
