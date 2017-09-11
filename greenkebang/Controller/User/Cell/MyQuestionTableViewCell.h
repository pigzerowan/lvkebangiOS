//
//  MyQuestionTableViewCell.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/1/27.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionModel.h"

@interface MyQuestionTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *commentLabel;

- (void)configQuestionCellWithModel:(QuestionModelIntroduceModel *)model;

@end
