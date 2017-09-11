//
//  SComposePhotosView.h
//
//  Created by Mory on 16/3/12.
//  Copyright © 2016年 MCWonders. All rights reserved.
//


#import "MKComposePhotosView.h"

@implementation MKComposePhotosView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)setImage:(UIImage *)image
{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 60, 60)];
    imageView.backgroundColor = [UIColor orangeColor];
    imageView.image = image;
    [self addSubview:imageView];
    
    UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDelete.frame = CGRectMake(60-24,5, 24, 24);
    [btnDelete setImage:[UIImage imageNamed:@"aska_btn_Delete_nor"] forState:UIControlStateNormal];
    btnDelete.tag = self.index;
    [btnDelete addTarget:self
                  action:@selector(deletePhotoItem:)
        forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnDelete];

}

///删除图片的代理方法
-(void)deletePhotoItem:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(MKComposePhotosView:didSelectDeleBtnAtIndex:)]) {
        [self.delegate MKComposePhotosView:self didSelectDeleBtnAtIndex:sender.tag];
    }
}

@end
