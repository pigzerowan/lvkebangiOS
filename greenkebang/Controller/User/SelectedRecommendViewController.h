//
//  SelectedRecommendViewController.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedRecommendViewController : BaseViewController
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic) NSMutableArray* selectedCircleArray;
@property (strong, nonatomic) NSMutableArray* selectedColumnArray;
@property (strong, nonatomic) UIButton* joinButton;

@end
