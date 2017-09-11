//
//  ContentTableViewCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/20.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindSearchModel.h"
@interface ContentTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;


- (void)configSeperateContentCellWithModel:(FindSearchModelDetailModel *)model;

@end
