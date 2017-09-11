//
//  UserHeaderView.m
//  greenkebang
//
//  Created by 郑渊文 on 9/9/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "UserHeaderView.h"
#import <UIImageView+WebCache.h>

@implementation UserHeaderView


- (instancetype)init
{
    self = [super init];
    if (!self)
        return nil;
    [self configSubViews];
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
        return nil;
    [self configSubViews];
    return self;
}

- (void)configDiscoveryRecommCellWithModel:(UserCenterModel*)model
{
  
    
       [self.myIcon sd_setImageWithURL:[model.image lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    _textLabel.text = model.contactName;
    _attententionLab.text =[NSString stringWithFormat:@"关注 %@  |  粉丝 %@",model.attentionNum,model.fansNum];
    if (model.singleDescription.length==0||[model.singleDescription isEqualToString:@"(null)"]) {
        _myWorlds.text = @"无";
    }
    _myWorlds.text = [NSString stringWithFormat:@"%@",model.singleDescription];
}
#pragma mark - Subviews
- (void)configSubViews
{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.myIcon];
    [self addSubview:self.textLabel];
    [self addSubview:self.attententionLab];
    [self addSubview:self.myWorlds];
    [self addSubview:self.attentionBtn];
    
    [_myIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.top).offset(42).priorityLow();
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(61, 61));
        
    }];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.equalTo(_myIcon.bottom).offset(10);
    }];
    [_attententionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.equalTo(_textLabel.bottom).offset(10);
    }];
    [_myWorlds mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.equalTo(_attententionLab.bottom).offset(10);
    }];
    [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.equalTo(_myWorlds.bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    
}
#pragma mark - Setter & Getter
- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 1;
//        _textLabel.text = @"李铁蛋";
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _textLabel;
}

#pragma mark - Setter & Getter
- (UILabel *)attententionLab
{
    if (!_attententionLab) {
        _attententionLab = [[UILabel alloc] init];
        _attententionLab.numberOfLines = 1;
        
        _attententionLab.font = [UIFont systemFontOfSize:14];
         _attententionLab.textColor = [UIColor titleColor];
        _attententionLab.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _attententionLab;
}
#pragma mark - Setter & Getter
- (UILabel *)myWorlds
{
    if (!_myWorlds) {
        _myWorlds = [[UILabel alloc] init];
        _myWorlds.numberOfLines = 1;
//        _myWorlds.text = @"农业新人，请多多指教！";
        _myWorlds.font = [UIFont systemFontOfSize:10];
        _myWorlds.textColor = [UIColor titleColor];
        _myWorlds.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _myWorlds;
}

#pragma mark - Setter & Getter
- (UIImageView *)myIcon
{
    if (!_myIcon) {
        _myIcon = [[UIImageView alloc] init];
//        _myIcon.backgroundColor = [UIColor redColor];
//        NSString *imageUrl = @"http://7xjm08.com2.z0.glb.qiniucdn.com/CC9DABED334FD3EFCC5A036D7700D899.jpg";
//        [_myIcon sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:YQNormalPlaceImage];
    }
    return _myIcon;
}
#pragma mark - Setter & Getter
- (UIButton *)attentionBtn
{
    if (!_attentionBtn) {
        _attentionBtn = [[UIButton alloc] init];
        [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
//        [_attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_attentionBtn addTarget:self action:@selector(attention:) forControlEvents:UIControlEventTouchUpInside];
        _attentionBtn.backgroundColor = [UIColor LkbBtnColor];
    }
    return _attentionBtn;
}

-(void)attention:(id)sender
{
    if([_delegate respondsToSelector:@selector(userHeaderView:didatterntion:)])
    {
        [_delegate userHeaderView:self didatterntion:nil];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
