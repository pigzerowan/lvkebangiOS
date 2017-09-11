//
//  DiscoverPublishQuestionViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/22.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHEmotionTextView.h"

@interface DiscoverPublishQuestionViewController : BaseViewController

@property(nonatomic, strong)UIButton *publish;
@property(nonatomic, strong)UIButton *chooseCircle;
@property(nonatomic, strong)UIImageView *circleImage;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)JHEmotionTextView *describeTextView;
@property(nonatomic, strong)NSString *groupId;
@property(nonatomic, strong)NSString *VCType; // 1 提问页面 
@property (nonatomic, assign) BOOL flag;



- (BOOL)stringContainsEmoji:(NSString *)string;


@end


