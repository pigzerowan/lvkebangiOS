//
//  NewShareActionView.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/5/23.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialControllerService.h"
#import "SRRefreshView.h"
@class NewShareActionView;

extern NSString* const ActivityShareTitle;


typedef void(^SGAlertActionHandler)(NSInteger index, NSString *name);


@protocol NewShareActionViewDelegete <NSObject>

@optional
- (void)newShareActionView:(NewShareActionView *)UserHeaderView didatterntion:(NSInteger)index;

@end

@interface ShareModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *shareText;

@end


@interface NewShareActionView : UIView
@property(strong,nonatomic) UIButton *shareImageButton;
@property (strong, nonatomic) NSArray *imageArray;
@property(nonatomic,assign) id<NewShareActionViewDelegete> delegate;
@property (strong, nonatomic)ShareModel *shareDta;


/**
 *  获取单例
 */
+ (NewShareActionView *)sharedView;
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
                         shareData:(ShareModel *)shareData
                    selectedHandle:(SGAlertActionHandler)handler;


- (void)shareWithFormView:(UIViewController *)controller shareData:(ShareModel *)shareData plantNameIndex:(NSString *)platformName;




@end
