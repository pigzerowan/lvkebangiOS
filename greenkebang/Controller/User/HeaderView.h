//
//  HeaderView.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/4/19.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInforModel.h"
#import "TLDisplayView.h"

typedef void(^HYBExpandBlock) (BOOL isExpand);

@interface HeaderView : UIView<TLDisplayViewDelegate>

@property (nonatomic, weak) NSLayoutConstraint *headerTopConstraint;

@property (nonatomic, strong)UIButton * headerImageButton;
@property (nonatomic, strong)UIImage *headerImage;
@property (nonatomic, strong)UILabel * hadAttentionLabel;
@property (nonatomic, strong)UIButton * hadAttentionButton;
@property (nonatomic, strong)UILabel * beAttentionedLabel;
@property (nonatomic, strong)UIButton * beAttentionedButton;
@property (nonatomic, strong)UILabel * attentionContentLabel;
@property (nonatomic, strong)UIButton * attentionContentButton;
@property (nonatomic, strong)UILabel *describeLabel;
@property (nonatomic, strong)UIButton *OpenButton;
@property (nonatomic, strong)NSString *userId;
@property (nonatomic, strong)NSString *remark;
@property (nonatomic, strong)NSString *type;
@property (nonatomic, copy) NSURL *photoUrl;

@property (nonatomic, strong)UITapGestureRecognizer *Tap;

@property (nonatomic, assign)BOOL isExpandedNow;

@property(nonatomic, copy)HYBExpandBlock expandBlock;

- (void)configMyInforRecommCellWithModel:(UserInforModel*)model;


@end
