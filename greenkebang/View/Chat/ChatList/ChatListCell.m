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
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-92, 12, 80, 16)];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor textGrayColor];
        [self.contentView addSubview:_timeLabel];
        
        _unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-34, 31, 18, 18)];
//        _unreadLabel.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:88.0/255.0 blue:36.0/255.0 alpha:1];
        _unreadLabel.textColor = [UIColor whiteColor];
        
        _unreadLabel.textAlignment = NSTextAlignmentCenter;
        _unreadLabel.font = [UIFont systemFontOfSize:10];
        _unreadLabel.layer.cornerRadius = 9;
        _unreadLabel.clipsToBounds = YES;
        [self.contentView addSubview:_unreadLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(69, 33, kDeviceWidth - 119, 20)];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = [UIColor textGrayColor];
        [self.contentView addSubview:_detailLabel];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(69, 0, kDeviceWidth, 0.5)];
        _lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
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
        _unreadLabel.backgroundColor = CCCUIColorFromHex(0xf35824);
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (![_unreadLabel isHidden]) {
        _unreadLabel.backgroundColor = CCCUIColorFromHex(0xf35824);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.imageView.frame;
    
    
//     [self.imageView sd_setImageWithURL:[_imageURL lkbImageUrl] placeholderImage:YQNormalPlaceImage];
//    
//    if ([_type isEqualToString:@"1"]) {
//        if ([_imageURL isEqualToString:@""]==NO) {
//            if (!hasCachedImage([_imageURL lkbImageUrl5] )) {
//                
//                self.imageView.image =  [self imageFromURLString:[_imageURL lkbImageUrl5] ];
//                NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[_imageURL lkbImageUrl5] ,@"url2",nil];
//                [FileHelpers dispatch_process_with_thread:^{
//                    UIImage* ima = [self LoadImage:dic];
//                    
//                    return ima;
//                    
//                } result:^(UIImage *ima){
//                    self.imageView.image =  ima;
//                    
//                }];
//                
//            } else {
//                UIImage *image = [UIImage imageWithContentsOfFile:pathForURL([_imageURL lkbImageUrl5])];
//                self.imageView.image = image;
//            }
//            
//        }
//        
//        
//        else  {
//            self.imageView.image =  LKBSecruitPlaceImage;
//        }
//
//    }
//    
//    
//    else
//    {
//    
//    if ([_imageURL isEqualToString:@""]==NO) {
//        if (!hasCachedImage([_imageURL lkbImageUrl4] )) {
//            
//            self.imageView.image =  [self imageFromURLString:[_imageURL lkbImageUrl4] ];
//            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[_imageURL lkbImageUrl4] ,@"url",nil];
//            [FileHelpers dispatch_process_with_thread:^{
//                UIImage* ima = [self LoadImage:dic];
//                
//                return ima;
//                
//            } result:^(UIImage *ima){
//                self.imageView.image =  ima;
//                
//            }];
//            
//        } else {
//            UIImage *image = [UIImage imageWithContentsOfFile:pathForURL([_imageURL lkbImageUrl4])];
//            self.imageView.image = image;
//        }
//
//    }
//    
//    
//    else  {
//         self.imageView.image =  LKBSecruitPlaceImage;
//    }
//    }
   //
    
//   self.imageView.image =  [self imageFromURLString:[_imageURL lkbImageUrl4] ];
//    [self.imageView imageWithImageUrl:_imageURL placeholderImage:YQNormalPlaceImage];
    self.imageView.frame = CGRectMake(10,12, 45,45 );
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 22.5;
//         [self.imageView sd_setImageWithURL:[_imageURL lkbImageUrl4] placeholderImage:YQUserPlaceImage];
    
//    self.textLabel.text = _name;
    [self.textLabel setTextWithUsername:_name];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    self.textLabel.frame = CGRectMake(69, 13, kDeviceWidth -138, 20);
    
    
    NSString *str = [self filterHTML:_detailMsg];
    
    _detailLabel.text = str;
    _timeLabel.text = _time;
    if (_unreadCount > 0) {
        if (_unreadCount < 9) {
            _unreadLabel.font = [UIFont systemFontOfSize:10];
        }else if(_unreadCount > 9 && _unreadCount < 99){
            _unreadLabel.font = [UIFont systemFontOfSize:10];
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


-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
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
//
//-(void)setImageURL:(NSString *)imageURL{
//    _imageURL = imageURL;
//}
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
