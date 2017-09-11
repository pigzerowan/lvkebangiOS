//
//  ChooseAreaCell.m
//  WheatPlan
//
//  Created by 郑渊文 on 6/23/15.
//  Copyright (c) 2015 IOSTeam. All rights reserved.
//

#import "ChooseAreaCell.h"

@implementation ChooseAreaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubviews];
    }
    
    return self;
}


- (void)addSubviews
{
    _SelectedimgView = [[UIImageView alloc] init];
    _SelectedimgView.frame = CGRectMake(280, 20, 18, 15);
    _SelectedimgView.image = [UIImage imageNamed:@"iocn_right"];
    [self.contentView addSubview:_SelectedimgView];
    
    _areaLable = [[UILabel alloc] init];
    _areaLable.frame = CGRectMake(20, 5, 200,40);
    _areaLable.font = [UIFont systemFontOfSize:15.0];
    // _numLable.textColor = [ComponentsFactory createColorByHex:@"#4b4b4b"];
    [self.contentView addSubview:_areaLable];

}


@end
