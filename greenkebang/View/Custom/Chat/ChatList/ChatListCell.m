/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */


#import "ChatListCell.h"
#import "UIImageView+HeadImage.h"
#import "NSStrUtil.h"
#import "FileHelpers.h"

@interface ChatListCell (){
    UILabel *_timeLabel;
    UILabel *_unreadLabel;
    UILabel *_detailLabel;
    UIView *_lineView;
}

@end

@implementation ChatListCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 7, 80, 16)];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_timeLabel];
        
        _unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 20, 20)];
        _unreadLabel.backgroundColor = [UIColor redColor];
        _unreadLabel.textColor = [UIColor whiteColor];
        
        _unreadLabel.textAlignment = NSTextAlignmentCenter;
        _unreadLabel.font = [UIFont systemFontOfSize:11];
        _unreadLabel.layer.cornerRadius = 10;
        _unreadLabel.clipsToBounds = YES;
        [self.contentView addSubview:_unreadLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 175, 20)];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_detailLabel];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 1)];
        _lineView.backgroundColor = UIColorWithRGBA(207, 210, 213, 0.7);
        [self.contentView addSubview:_lineView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (![_unreadLabel isHidden]) {
        _unreadLabel.backgroundColor = [UIColor redColor];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (![_unreadLabel isHidden]) {
        _unreadLabel.backgroundColor = [UIColor redColor];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.imageView.frame;
    
    
//     [self.imageView sd_setImageWithURL:[_imageURL lkbImageUrl] placeholderImage:YQNormalPlaceImage];
    
    
    if (!hasCachedImage([_imageURL lkbImageUrl] )) {
       
        self.imageView.image =  [self imageFromURLString:[_imageURL lkbImageUrl] ];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[_imageURL lkbImageUrl] ,@"url",nil];
        [FileHelpers dispatch_process_with_thread:^{
            UIImage* ima = [self LoadImage:dic];
            return ima;
        } result:^(UIImage *ima){
            self.imageView.image =  ima;
        }];
        
    } else {
         UIImage *image = [UIImage imageWithContentsOfFile:pathForURL([_imageURL lkbImageUrl])];
        self.imageView.image = image;
    }
//
    
//   self.imageView.image =  [self imageFromURLString:[_imageURL lkbImageUrl] ];
//    [self.imageView imageWithImageUrl:_imageURL placeholderImage:YQNormalPlaceImage];
    self.imageView.frame = CGRectMake(10, 7, 45, 45);
    
//    self.textLabel.text = _name;
    [self.textLabel setTextWithUsername:_name];
    self.textLabel.frame = CGRectMake(65, 7, 175, 20);
    
    _detailLabel.text = _detailMsg;
    _timeLabel.text = _time;
    if (_unreadCount > 0) {
        if (_unreadCount < 9) {
            _unreadLabel.font = [UIFont systemFontOfSize:13];
        }else if(_unreadCount > 9 && _unreadCount < 99){
            _unreadLabel.font = [UIFont systemFontOfSize:12];
        }else{
            _unreadLabel.font = [UIFont systemFontOfSize:10];
        }
        [_unreadLabel setHidden:NO];
        [self.contentView bringSubviewToFront:_unreadLabel];
        _unreadLabel.text = [NSString stringWithFormat:@"%ld",(long)_unreadCount];
    }else{
        [_unreadLabel setHidden:YES];
    }
    
    frame = _lineView.frame;
    frame.origin.y = self.contentView.frame.size.height - 1;
    _lineView.frame = frame;
}


- (UIImage *) imageFromURLString: (NSURL *) urlstring
{
    // This call is synchronous and blocking
    return [UIImage imageWithData:[NSData
                                   dataWithContentsOfURL:urlstring]];
}

-(void)setName:(NSString *)name{
    _name = name;
}

-(void)setImageURL:(NSString *)imageURL{
    _imageURL = imageURL;
}
//-(void)setName:(NSString *)name{
//    _name = name;
//}

//加载图片
- (UIImage *)LoadImage:(NSDictionary*)aDic{
    //    NSString *str = [aDic objectForKey:@"url"];
    NSURL *aURL=[aDic objectForKey:@"url"];
    NSData *data=[NSData dataWithContentsOfURL:aURL];
    if (data == nil) {
        return nil;
    }
    UIImage *image=[UIImage imageWithData:data];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager createFileAtPath:pathForURL(aURL) contents:data attributes:nil];
    return image;
}



+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
