//
//  WtDynamicPhotoCell.m
//  DynamicPhoto
//
//  Created by imac on 14-7-27.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "WtDynamicPhotoCell.h"

@implementation WtDynamicPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
        self.backgroundColor = [UIColor greenColor];
    
    }
    return self;
}

-(void)initSubView
{
    [self.contentView addSubview: self.photoImageView];
    [self.contentView addSubview:self.ddBtn];
    [self.contentView addSubview:self.closeBtn];
}


- (UIImageView*)photoImageView
{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth( self.contentView.bounds), CGRectGetHeight( self.contentView.bounds))];
        _photoImageView.clipsToBounds = YES;
        _photoImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _photoImageView;
}
- (UIButton*)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth( self.contentView.bounds)-10,5,10, 10)];
         _closeBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _closeBtn.clipsToBounds = YES;
        _closeBtn.hidden = YES;
        [_closeBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        _closeBtn.contentMode = UIViewContentModeScaleAspectFill;

    }
    return _closeBtn;
}

- (UIButton*)ddBtn
{
    if (!_ddBtn) {
        _ddBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
        _ddBtn.clipsToBounds = YES;
          _ddBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        [_ddBtn setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
        _ddBtn.contentMode = UIViewContentModeScaleAspectFill;

    }
    return _ddBtn;
}




- (void)addBtnAction:(UIButton *)sender {
}
@end
