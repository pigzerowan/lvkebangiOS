//
//  CustomChatShareBubbleView.m
//  greenkebang
//
//  Created by 郑渊文 on 7/28/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "CustomChatShareBubbleView.h"
#import "RobotManager.h"
#import "NSStrUtil.h"
NSString *const LalalaShareName = @"LalalaShareName";

@implementation CustomChatShareBubbleView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
   
       [self configureSubview];
    }
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize retSize = self.model.size;
    
    
//    return CGSizeMake(retSize.width + BUBBLE_VIEW_PADDING * 2 + BUBBLE_ARROW_WIDTH, 2 * BUBBLE_VIEW_PADDING + retSize.height);
    
       return CGSizeMake(200, 100);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    

}
#pragma maek - SubViews
- (void)configureSubview
{
    
    [self addSubview:self.headImage];
    [self addSubview:self.myTitle];
    [self addSubview:self.myDescrible];
    [self addSubview:self.lineView];
    [self addSubview:self.fromLable];
    
    
}


#pragma mark - Getters & Setters
- (UIImageView*)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10,40 ,40)];
        _headImage.clipsToBounds = YES;
        _headImage.contentMode = UIViewContentModeScaleAspectFill;
        _headImage.layer.masksToBounds =YES;
        _headImage.layer.cornerRadius =20;
        
    }
    return _headImage;
}
- (UILabel*)myTitle
{
    if (!_myTitle) {
        _myTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 130, 30)];
        _myTitle.numberOfLines = 1;
     
        _myTitle.font = [UIFont systemFontOfSize:14];
        _myTitle.textColor = [UIColor blackColor];
        _myTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _myTitle;
}


- (UILabel*)myDescrible
{
    if (!_myDescrible) {
        _myDescrible = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, 130, 30)];
        _myDescrible.numberOfLines = 1;
//        _myDescrible.text = @"作为光伏农业设备讨论区，擅长于";
        _myDescrible.font = [UIFont systemFontOfSize:12];
        _myDescrible.textColor = [UIColor lightGrayColor];
        _myDescrible.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _myDescrible;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 68, 195, 0.5)];
        _lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
        
    }
    return _lineView;
}

- (UILabel*)fromLable
{
    if (!_fromLable) {
        _fromLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 130, 30)];
        _fromLable.numberOfLines = 1;
//        _fromLable.text = @"绿科帮新农业圈";;
        _fromLable.font = [UIFont systemFontOfSize:11];
        _fromLable.textColor = [UIColor lightGrayColor];
        _fromLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _fromLable;
}


#pragma mark - setter

- (void)setModel:(MessageModel *)model
{
    [super setModel:model];
    
  ;

    NSLog(@"====%@====",self.model.content);
    
        _modelDic = [self dictionaryWithJsonString:self.model.content];
    
    
        NSString *imageUrl = _modelDic[@"cover"];
    
       _myTitle.text =_modelDic[@"title"];
    if ([_myTitle.text isEqualToString:@""]||! _myTitle.text ) {
        _myTitle.text = @"圈子详情";
    }
    
    
      _myDescrible.text = _modelDic[@"description"];
    
//    if (_modelDic[@"fromLable"] ) {
//        
        _fromLable.text = _modelDic[@"fromLable"];
//
//    }
 
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:YQNormalPlaceImage];
    

  }


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark - public

-(void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:LalalaShareName
                     userInfo:@{KMESSAGEKEY:self.modelDic}];
}


+(CGFloat)heightForBubbleWithObject:(MessageModel *)object
{
    CGSize retSize = object.size;
    
    
    
//    if (retSize.width == 0 || retSize.height == 0) {
//        retSize.width = MAX_SIZE;
//        retSize.height = MAX_SIZE;
//    }else if (retSize.width > retSize.height) {
//        CGFloat height =  MAX_SIZE / retSize.width  *  retSize.height;
//        retSize.height = height;
//        retSize.width = MAX_SIZE;
//    }else {
//        CGFloat width = MAX_SIZE / retSize.height * retSize.width;
//        retSize.width = width;
//        retSize.height = MAX_SIZE;
//    }
    return 100;
}

@end
