//
//  NewCircleShareActionView.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/12/12.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "NewCircleShareActionView.h"


#import "WXApi.h"
#import "WeiboSDK.h"
#import "TencentOpenAPI/QQApiInterface.h"
#import "MyUserInfoManager.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "LKBVenderDefine.h"
#import "WXApi.h"
#import "MyUserInfoManager.h"
#import "UserGroupViewController.h"
#import "ContactsViewController.h"

#define Start_X 20.0f           // 第一个按钮的X坐标
#define Start_Y 30.0f           // 第一个按钮的Y坐标
#define Width_Space 50.0f        // 2个按钮之间的横间距
#define Height_Space 30.0f      // 竖间距
#define Button_Height 84.0f    // 高
#define Button_Width 69.0f      // 宽
//#define Button_Height 127.5    // 高
//#define Button_Width (kDeviceWidth -80) /3      // 宽

@implementation CircleShareModel
- (id)init
{
    self = [super init];
    if (!self) {
        self.title = @"绿科邦";
        self.imgUrl = @"";
        self.url = @"";
        self.shareText = @"";
    }
    return self;
    
}


@end


@implementation NewCircleShareActionView



- (instancetype)init
{
    self = [super init];
    if (!self)
        return nil;
    
    [self shareActionView];
    
    return self;
}

+ (NewCircleShareActionView *)sharedView {
    
    NewCircleShareActionView *newShare = [[NewCircleShareActionView alloc]init];
    
    static NewCircleShareActionView *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect rect = [[UIScreen mainScreen] bounds];
        share = [[NewCircleShareActionView alloc] initWithFrame:rect];
        
    });
    
    return newShare;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(30, 10, kDeviceWidth -60,315)];
    //    self = [super initWithFrame:frame];
    
    if (!self)
        return nil;
    [self shareActionView];
    
    return self;
}


- (void)shareActionView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]initWithArray:@[
                                                                        @"share_btn_circle_npr",
                                                                        @"share_btn_weibo_nor",
                                                                        @"share_btn_circleoffriends_nor",
                                                                        @"share_btn_qq_nor",
                                                                        @"share_btn_WeChat_nor",
                                                                        @"share_btn_qqspace_nor",
                                                                        ]];
    
    
    
    if (![WXApi isWXAppInstalled]  || ![WeiboSDK isWeiboAppInstalled] || ![QQApiInterface isQQInstalled] || ![QQApiInterface isQQSupportApi] ) {
        
        if (![WXApi isWXAppInstalled] ) {
            
            [imageArray removeObject:@"share_btn_WeChat_nor"];
            [imageArray removeObject:@"share_btn_circleoffriends_nor"];
            
            [imageArray removeObject:@"share_btn_other_nor"];
            
            if (![WeiboSDK isWeiboAppInstalled]) {
                
                [imageArray removeObject:@"share_btn_weibo_nor"];
                
            }
            
            if (![QQApiInterface isQQInstalled] || ![QQApiInterface isQQSupportApi]) {
                
                [imageArray removeObject: @"share_btn_qqspace_nor"];
                [imageArray removeObject:@"share_btn_qq_nor"];
            }
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:imageArray];
            
            for (int i = 0 ; i < [arr count]; i++) {
                
                
                NSString *str =[arr objectAtIndex:i];
                
                NSLog(@"<<<<<<<<<<%@",[arr objectAtIndex:i]);
                
                
                
                // 圆角按钮
                _shareImageButton = [[UIButton alloc] init];
                
                
                if (![WXApi isWXAppInstalled]  && ![WeiboSDK isWeiboAppInstalled] && ![QQApiInterface isQQInstalled] && ![QQApiInterface isQQSupportApi]) {
                    
                    NSInteger index = i ;
                    NSInteger page = i ;
                    
                    
                    if (iPhone5) {
                        _shareImageButton.frame = CGRectMake(page * (Button_Width +  (kDeviceWidth-20 - Button_Width * 3 )/4  )  +(kDeviceWidth -20 - Button_Width *3) /4 , (315 - Button_Height )/2, Button_Width, Button_Height);
                    }
                    
                    else {
                        _shareImageButton.frame = CGRectMake(page * (Button_Width +  (kDeviceWidth-20 - Button_Width * 3 )/4  ) +(kDeviceWidth-20 - Button_Width * 3 )/4  , (315 - Button_Height )/2, Button_Width, Button_Height);
                    }
                }
                else {
                    
                    NSInteger index = i % 2;
                    NSInteger page = i / 2;
                    
                    _shareImageButton.frame = CGRectMake(page * (Button_Width + (kDeviceWidth -20 - Button_Width *3) /4) +(kDeviceWidth -20 - Button_Width *3) /4, index  * (Button_Height + (315 - Button_Height *2) /3)+(315 - Button_Height *2) /3, Button_Width, Button_Height);
                }
                _shareImageButton.backgroundColor = [UIColor whiteColor];
                
                [_shareImageButton setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
                
                [_shareImageButton addTarget:self action:@selector(shareActionView:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [self addSubview:_shareImageButton];
                
                
            }
        }
        
        else if  (![WeiboSDK isWeiboAppInstalled]) {
            
            [imageArray removeObject:@"share_btn_weibo_nor"];
            if (![WXApi isWXAppInstalled] ) {
                
                [imageArray removeObject:@"share_btn_WeChat_nor"];
                [imageArray removeObject:@"share_btn_circleoffriends_nor"];
                
                [imageArray removeObject:@"share_btn_other_nor"];
                
            }
            
            if (![QQApiInterface isQQInstalled] || ![QQApiInterface isQQSupportApi]) {
                
                [imageArray removeObject: @"share_btn_qqspace_nor"];
                [imageArray removeObject:@"share_btn_qq_nor"];
            }
            
            
            
            
            
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:imageArray];
            
            for (int i = 0 ; i < [arr count]; i++) {
                
                
                NSString *str =[arr objectAtIndex:i];
                
                NSLog(@"<<<<<<<<<<%@",[arr objectAtIndex:i]);
                
                
                
                // 圆角按钮
                _shareImageButton = [[UIButton alloc] init];
                
                
                if (![WXApi isWXAppInstalled]  && ![WeiboSDK isWeiboAppInstalled] && ![QQApiInterface isQQInstalled] && ![QQApiInterface isQQSupportApi]) {
                    
                    NSInteger index = i ;
                    NSInteger page = i ;
                    
                    
                    if (iPhone5) {
                        _shareImageButton.frame = CGRectMake(page * (Button_Width +  (kDeviceWidth -20 - Button_Width * 3 )/4  )  +(kDeviceWidth -20 - Button_Width *3) /4 , (315 - Button_Height )/2, Button_Width, Button_Height);
                    }
                    
                    else {
                        _shareImageButton.frame = CGRectMake(page * (Button_Width +  (kDeviceWidth-20 - Button_Width * 3 )/4  ) +(kDeviceWidth-20 - Button_Width * 3 )/4  , (315 - Button_Height )/2, Button_Width, Button_Height);
                    }
                }
                else {
                    
                    NSInteger index = i % 2;
                    NSInteger page = i / 2;
                    
                    _shareImageButton.frame = CGRectMake(page * (Button_Width + (kDeviceWidth -20 - Button_Width *3) /4) +(kDeviceWidth -20 - Button_Width *3) /4, index  * (Button_Height + (315 - Button_Height *2) /3)+(315 - Button_Height *2) /3, Button_Width, Button_Height);
                }
                _shareImageButton.backgroundColor = [UIColor whiteColor];
                
                [_shareImageButton setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
                
                [_shareImageButton addTarget:self action:@selector(shareActionView:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [self addSubview:_shareImageButton];
                
                
            }
        }
        
        
        
        
        else if  (![QQApiInterface isQQInstalled] || ![QQApiInterface isQQSupportApi]) {
            
            [imageArray removeObject: @"share_btn_qqspace_nor"];
            [imageArray removeObject:@"share_btn_qq_nor"];
            
            if (![WXApi isWXAppInstalled] ) {
                
                [imageArray removeObject:@"share_btn_WeChat_nor"];
                [imageArray removeObject:@"share_btn_circleoffriends_nor"];
                
                [imageArray removeObject:@"share_btn_other_nor"];
                
            }
            if (![WeiboSDK isWeiboAppInstalled]) {
                
                [imageArray removeObject:@"share_btn_weibo_nor"];
                
            }
            
            
            
            
            
            
            
            
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:imageArray];
            
            for (int i = 0 ; i < [arr count]; i++) {
                
                
                NSString *str =[arr objectAtIndex:i];
                
                NSLog(@"<<<<<<<<<<%@",[arr objectAtIndex:i]);
                
                
                
                // 圆角按钮
                _shareImageButton = [[UIButton alloc] init];
                
                
                if (![WXApi isWXAppInstalled]  && ![WeiboSDK isWeiboAppInstalled] && ![QQApiInterface isQQInstalled] && ![QQApiInterface isQQSupportApi]) {
                    
                    NSInteger index = i ;
                    NSInteger page = i ;
                    
                    if (iPhone5) {
                        _shareImageButton.frame = CGRectMake(page * (Button_Width +  (kDeviceWidth-20 - Button_Width * 3 )/4  )  +(kDeviceWidth -20 - Button_Width *3) /4 , (315 - Button_Height )/2, Button_Width, Button_Height);
                    }
                    else {
                        _shareImageButton.frame = CGRectMake(page * (Button_Width +  (kDeviceWidth-20 - Button_Width * 3 )/4  ) +(kDeviceWidth-20 - Button_Width * 3 )/4  , (315 - Button_Height )/2, Button_Width, Button_Height);
                        
                    }
                    
                }
                else {
                    
                    NSInteger index = i % 2;
                    NSInteger page = i / 2;
                    
                    _shareImageButton.frame = CGRectMake(page * (Button_Width + (kDeviceWidth -20 - Button_Width *3) /4) +(kDeviceWidth -20 - Button_Width *3) /4, index  * (Button_Height + (315 - Button_Height *2) /3)+(315 - Button_Height *2) /3, Button_Width, Button_Height);
                }
                _shareImageButton.backgroundColor = [UIColor whiteColor];
                
                [_shareImageButton setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
                
                [_shareImageButton addTarget:self action:@selector(shareActionView:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [self addSubview:_shareImageButton];
                
                
            }
        }
        
        
        
        
        
        
    }
    
    
    else {
        
        for (int i = 0 ; i < [imageArray count]; i++) {
            
            
            NSString *str =[imageArray objectAtIndex:i];
            
            NSLog(@"<<<<<<<<<<%@",[imageArray objectAtIndex:i]);
            
            NSInteger index = i % 2;
            NSInteger page = i / 2;
            
            // 圆角按钮
            _shareImageButton = [[UIButton alloc] init];
            
            _shareImageButton.frame = CGRectMake(page * (Button_Width + (kDeviceWidth -60 - Button_Width *3) /4) +(kDeviceWidth -60 - Button_Width *3) /4, index  * (Button_Height + (315 - Button_Height *2) /3) +(315 - Button_Height *3) /4+ 30, Button_Width, Button_Height);
            
            
            _shareImageButton.backgroundColor = [UIColor whiteColor];
            
            [_shareImageButton setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
            
            [_shareImageButton addTarget:self action:@selector(shareActionView:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_shareImageButton];
            
        }
        
    }
    
    
}



- (void)shareActionView:(UIButton*)sender {
    
    
    
    
    NSMutableArray *shareNames = [[NSMutableArray alloc] initWithCapacity:9];
    
    
    NSString *url = [MyUserInfoManager shareInstance].shaUrl;
    NSString *title = [MyUserInfoManager shareInstance].shaTitle;
    NSString *shareText = [MyUserInfoManager shareInstance].shaDes;
    //    NSString *desc =[MyUserInfoManager shareInstance].shaDes;
    
    // 群组
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"share_btn_group_nor"]]) {
        
        if([_delegate respondsToSelector:@selector(newCircleShareActionView:didatterntion:)])
        {
            [_delegate newCircleShareActionView:self didatterntion:0];
        }
        
        
    }
    // 好友
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"share_btn_circle_npr"]] ) {
        
        if([_delegate respondsToSelector:@selector(newCircleShareActionView:didatterntion:)])
        {
            [_delegate newCircleShareActionView:self didatterntion:1];
        }
    }
    //微信
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"share_btn_WeChat_nor"]]) {
        
        
        
        if([_delegate respondsToSelector:@selector(newCircleShareActionView:didatterntion:)])
        {
            [_delegate newCircleShareActionView:self didatterntion:2];
        }
        
        
    }
    // 朋友圈
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"share_btn_circleoffriends_nor"]]) {
        
        [shareNames addObject:UMShareToWechatTimeline];
        
        
        if([_delegate respondsToSelector:@selector(newCircleShareActionView:didatterntion:)])
        {
            [_delegate newCircleShareActionView:self didatterntion:3];
        }
    }
    // 微博
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"share_btn_weibo_nor"]]) {
        
        
        [shareNames addObject:UMShareToSina];
        
        if([_delegate respondsToSelector:@selector(newCircleShareActionView:didatterntion:)])
        {
            [_delegate newCircleShareActionView:self didatterntion:4];
        }
        
    }
    // QQ空间
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"share_btn_qqspace_nor"]]) {
        
        [shareNames addObject:UMShareToQzone];
        
        if([_delegate respondsToSelector:@selector(newCircleShareActionView:didatterntion:)])
        {
            [_delegate newCircleShareActionView:self didatterntion:5];
        }
        
        
    }
    // QQ
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"share_btn_qq_nor"]]) {
        
        [shareNames addObject:UMShareToQQ];
        
        if([_delegate respondsToSelector:@selector(newCircleShareActionView:didatterntion:)])
        {
            [_delegate newCircleShareActionView:self didatterntion:6];
        }
        
        
    }
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"share_btn_copylink_nor"]]) {
        
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        NSString *string = [MyUserInfoManager shareInstance].shaUrl;
        [pab setString:string];
        if (pab == nil) {
            [MBProgressHUD showMessag:@"复制失败" toView:self ];
        }else
        {
            [MBProgressHUD showSuccess:@"已复制" toView:self];
            
            NSLog(@"-----------=================%@==================",string);
        }
    }
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"share_btn_other_nor"]]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"该功能暂未开发，点别的试试吧~" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
}



-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}













@end
