//
//  FarmerCircleViewController.h
//  greenkebang
//
//  Created by 郑渊文 on 7/19/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFActionSheet.h"

@interface FarmerCircleViewController :  BaseViewController<ZFActionSheetDelegate,UIGestureRecognizerDelegate>

@property (copy, nonatomic) NSString* toRequestURL;
@property (strong, nonatomic)ZFActionSheet *actionSheet;
@property (strong, nonatomic)ZFActionSheet *actionshare;
@property (copy, nonatomic)NSString* ifJion;
@property (copy, nonatomic)NSString* circleId;// 圈Id
@property (strong, nonatomic) NSString *circleDetailId;// 圈子详情id
@property (strong, nonatomic) NSString *mytitle;
@property (strong, nonatomic) NSString *describle;
@property (strong, nonatomic) NSString *userAvatar;
@property (strong, nonatomic) NSString *urlStr;
@property (strong, nonatomic) NSString *groupAvatar;// 圈头像
@property (strong, nonatomic) NSString *shareCover;// 分享字典里的图片
@property (strong, nonatomic) NSString *toUserId;// 传过来的userid
@property (strong, nonatomic) NSString *intrioduceStr;//圈子简介
@property (strong, nonatomic) NSArray * memberArr;
@property (copy, nonatomic) NSString * memberNum;

@property (assign, nonatomic)CGFloat oneImageWidth;
@property (assign, nonatomic)CGFloat oneImageHeight;
@property (copy, nonatomic) NSString * type;
@property (assign, nonatomic) NSInteger StartsectionIdex;
@property (copy, nonatomic) UIButton * joinButton;
@property (copy, nonatomic) UIButton * topButton;
@property (weak, nonatomic) UIView *scrollView;
@property (retain, nonatomic)UIView *overLay;
@property (assign, nonatomic)BOOL isHidden;
@property (retain, nonatomic)UIPanGestureRecognizer *panGesture;
@property(nonatomic, strong)NSString *shareType;

@end
