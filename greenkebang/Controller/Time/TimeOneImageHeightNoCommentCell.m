//
//  TimeOneImageHeightNoCommentCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/9/22.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "TimeOneImageHeightNoCommentCell.h"
#import <UIImageView+WebCache.h>
#import "NSDate+TimeAgo.h"
#import "NSDate+TimeInterval.h"

@implementation TimeOneImageHeightNoCommentCell
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        [self configureSubview];
        
    }
    
    return self;
}


- (void)configTimeOneImageHeightNoCommentCellTimeNewDynamicDetailModel:(NewDynamicDetailModel *)model {

    UIImageView *headerImge = [[UIImageView alloc]init];
    
    
    [headerImge sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
    [_headImageView setImage:headerImge.image forState:UIControlStateNormal];
    
//    [_coverListImage sd_setImageWithURL:[model.coverList[0] lkbImageUrlAllCover] placeholderImage:YQNormalBackGroundPlaceImage];
    
    NSLog(@"================================%@",model.objectId);
    
    
    NSLog(@"================================%@",model.imageInfo);

    if ([model.images isEqualToString:@""] || model.imageInfo == nil) {
        
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(171, 171));
        }];

        
        
    }else
    {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:model.imageInfo options:NSJSONWritingPrettyPrinted error:nil];
    NSDictionary *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"++++++++++++++++++++++++++++++%@",jsonStr);
    CGFloat width = [[jsonStr objectForKey:@"width"] floatValue];
    CGFloat height = [[jsonStr objectForKey:@"height"] floatValue];
    
    
    NSLog(@"+++++++%f+++++++++++%f+++++++++++",width,height);
  


    if ( width / height > 1 && width / height < 4 /3) {
        
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake((171 * width) /height, 171));
        }];
        
    }
    if(width / height < 1 && width / height > 3 /4) {
        
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(171, (171 * height) /width));
        }];
        
    }
    if(width / height < 3 /4) {
        
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(171, 228));
        }];
        
    }
    if (width / height > 4 /3) {
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(228, 171));
        }];
        
        
    }
    if (height / width > 4 /3) {
        
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(171, 228));
        }];
        
    }


    if (height / width == 1)  {
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(171, 171));
        }];
        
        
    }
    

    }
    
    _nameLabel.text = model.userName;
    
    _goodsDesLabel.text = model.summary;
    
    if ([model.summary isEqualToString:@""]) {
        
        
        [_goodsDesLabel mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_headImageView.bottom).offset(5);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(self.contentView).offset(-14);
            
        }];

    }
    else {
        
        [_goodsDesLabel mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_headImageView.bottom).offset(12);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(self.contentView).offset(-14);
            
        }];

    }
    [_circleNameButton setTitle:model.groupName forState:UIControlStateNormal];
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:model.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    
    if ([model.isStar isEqualToString:@"1"]) {
        
        [_goodImageView setImage:[UIImage imageNamed:@"icon_like_nor"]];
        
    }
    else {
        
        [_goodImageView setImage:[UIImage imageNamed:@"comment_btn_like_pre"]];
        
    }

    if ([model.starNum isEqualToString:@"0"]) {
        _attentionNumLable.text = @"";
    }
    else {
        _attentionNumLable.text = model.starNum;
    }
    if ([model.replyNum isEqualToString:@"0"]) {
        
        _comentNumLable.text = @" ";
    }
    else {
        _comentNumLable.text = model.replyNum;
    }
    NSArray *imagesstr = [model.images componentsSeparatedByString:@","];
    
    if ([model.starNum isEqualToString:@"0"]) {
        
        [_goodImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(0);
            //            make.width.height.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
        
        
        [_headerImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(10);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            //            make.width.height.mas_equalTo(0);
            make.height.mas_equalTo(0);
            //            make.width.mas_equalTo(0);
            
        }];
        [_headerImage_2 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(20);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            //            make.width.height.mas_equalTo(0);
            make.height.mas_equalTo(0);
            //            make.width.mas_equalTo(0);
            
            
        }];
        [_headerImage_3 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(32);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            //            make.width.height.mas_equalTo(0);
            make.height.mas_equalTo(0);
            //            make.width.mas_equalTo(0);
            
            
        }];
        [_headerImage_4 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(44);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            //            make.width.height.mas_equalTo(0);
            make.height.mas_equalTo(0);
            //            make.width.mas_equalTo(0);
            
            
        }];
        
    }
    else {
        
        
        [_goodImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(19);
            make.width.height.mas_equalTo(12);
        }];
        
        
        
        [_headerImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(10);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.width.height.mas_equalTo(20);
        }];
        [_headerImage_2 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(24);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.width.height.mas_equalTo(20);
        }];
        [_headerImage_3 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(38);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.width.height.mas_equalTo(20);
        }];
        [_headerImage_4 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(52);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.width.height.mas_equalTo(20);
        }];

        
        if (model.userAvatars.count ==1) {
            _headerImage.hidden = NO;
            [_headerImage sd_setImageWithURL:[model.userAvatars[0] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            _headerImage_2.hidden = YES;
            _headerImage_3.hidden = YES;
            _headerImage_4.hidden = YES;
            
        }
        if (model.userAvatars.count ==2){
            _headerImage.hidden = NO;
            _headerImage_2.hidden = NO;
            [_headerImage sd_setImageWithURL:[model.userAvatars[0] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_2 sd_setImageWithURL:[model.userAvatars[1] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            _headerImage_3.hidden = YES;
            _headerImage_4.hidden = YES;
            
            
        }
        if (model.userAvatars.count ==3){
            _headerImage.hidden = NO;
            _headerImage_2.hidden = NO;
            _headerImage_3.hidden = NO;
            [_headerImage sd_setImageWithURL:[model.userAvatars[0] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_2 sd_setImageWithURL:[model.userAvatars[1] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_3 sd_setImageWithURL:[model.userAvatars[2] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            _headerImage_4.hidden = YES;
            
        }
        if (model.userAvatars.count == 4 ){
            _headerImage.hidden = NO;
            _headerImage_2.hidden = NO;
            _headerImage_3.hidden = NO;
            _headerImage_4.hidden = NO;
            [_headerImage sd_setImageWithURL:[model.userAvatars[0] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_2 sd_setImageWithURL:[model.userAvatars[1] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_3 sd_setImageWithURL:[model.userAvatars[2] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_4 sd_setImageWithURL:[model.userAvatars[3] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            
            
        }
        
    }
    
    [self configureSubview];



    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

- (void)configFarmerOneImageHeightNoCommentCellTimeNewDynamicDetailModel:(NewDynamicDetailModel *)model {

    UIImageView *headerImge = [[UIImageView alloc]init];
    
    
    [headerImge sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
    [_headImageView setImage:headerImge.image forState:UIControlStateNormal];
//    [_coverListImage sd_setImageWithURL:[model.coverList[0] lkbImageUrlAllCover] placeholderImage:YQNormalBackGroundPlaceImage];
    
    
    NSLog(@"================================%@",model.objectId);
    
    
    NSLog(@"================================%@",model.imageInfo);

    
    if ([model.images isEqualToString:@""] || model.imageInfo == nil) {
        
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(171, 171));
        }];
        
        
        
    }else
    {

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:model.imageInfo options:NSJSONWritingPrettyPrinted error:nil];
    NSDictionary *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"++++++++++++++++++++++++++++++%@",jsonStr);
    CGFloat width = [[jsonStr objectForKey:@"width"] floatValue];
    CGFloat height = [[jsonStr objectForKey:@"height"] floatValue];
    
    
    NSLog(@"+++++++%f+++++++++++%f+++++++++++",width,height);
    
    
    
    if ( width / height > 1 && width / height < 4 /3) {
        
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake((171 * width) /height, 171));
        }];
        
    }
    if(width / height < 1 && width / height > 3 /4) {
        
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(171, (171 * height) /width));
        }];
        
    }
    if(width / height < 3 /4) {
        
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(171, 228));
        }];
        
    }
    if (width / height > 4 /3) {
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(228, 171));
        }];
        
        
    }
    if (height / width > 4 /3) {
        
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(171, 228));
        }];
        
    }
    if (height / width == 1) {
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(171, 171));
        }];
        
        
    }
    }

    _nameLabel.text = model.userName;
    
    _goodsDesLabel.text = model.summary;
    
    if ([model.summary isEqualToString:@""]) {
        
        
        [_goodsDesLabel mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_headImageView.bottom).offset(5);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(self.contentView).offset(-14);
            
        }];
        
    }
    else {
        
        [_goodsDesLabel mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_headImageView.bottom).offset(12);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(self.contentView).offset(-14);
            
        }];
        
    }

    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:model.pubDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    
    if ([model.isStar isEqualToString:@"1"]) {
        
        [_goodImageView setImage:[UIImage imageNamed:@"icon_like_nor"]];
        
    }
    else {
        
        [_goodImageView setImage:[UIImage imageNamed:@"comment_btn_like_pre"]];
        
    }

    if ([model.starNum isEqualToString:@"0"]) {
        _attentionNumLable.text = @"";
    }
    else {
        _attentionNumLable.text = model.starNum;
    }
    if ([model.replyNum isEqualToString:@"0"]) {
        _comentNumLable.text = @"";
    }
    else {
        _comentNumLable.text = model.replyNum;
    }
    
    NSArray *imagesstr = [model.images componentsSeparatedByString:@","];
    if ([model.starNum isEqualToString:@"0"]) {
        
        [_goodImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(0);
            make.height.mas_equalTo(0);
        }];
        
        
        [_headerImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(10);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.height.mas_equalTo(0);
        }];
        
        [_headerImage_2 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(24);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.height.mas_equalTo(0);
        }];
        
        [_headerImage_3 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(38);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.height.mas_equalTo(0);
        }];
        
        [_headerImage_4 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(52);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.height.mas_equalTo(0);
        }];
        
        
        
    }else {
        
        [_goodImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(19);
            make.width.height.mas_equalTo(12);
        }];
        
        
        
        [_headerImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(10);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.width.height.mas_equalTo(20);
        }];
        [_headerImage_2 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(24);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.width.height.mas_equalTo(20);
        }];
        [_headerImage_3 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(38);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.width.height.mas_equalTo(20);
        }];
        [_headerImage_4 mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_goodImage.right).offset(52);
            make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
            make.width.height.mas_equalTo(20);
        }];

        
        if (model.userAvatars.count ==1) {
            _headerImage.hidden = NO;
            [_headerImage sd_setImageWithURL:[model.userAvatars[0] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            _headerImage_2.hidden = YES;
            _headerImage_3.hidden = YES;
            _headerImage_4.hidden = YES;
            
        }
        if (model.userAvatars.count ==2){
            _headerImage.hidden = NO;
            _headerImage_2.hidden = NO;
            [_headerImage sd_setImageWithURL:[model.userAvatars[0] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_2 sd_setImageWithURL:[model.userAvatars[1] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            _headerImage_3.hidden = YES;
            _headerImage_4.hidden = YES;
            
            
        }
        if (model.userAvatars.count ==3){
            _headerImage.hidden = NO;
            _headerImage_2.hidden = NO;
            _headerImage_3.hidden = NO;
            [_headerImage sd_setImageWithURL:[model.userAvatars[0] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_2 sd_setImageWithURL:[model.userAvatars[1] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_3 sd_setImageWithURL:[model.userAvatars[2] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            _headerImage_4.hidden = YES;
            
        }
        if (model.userAvatars.count == 4 ){
            _headerImage.hidden = NO;
            _headerImage_2.hidden = NO;
            _headerImage_3.hidden = NO;
            _headerImage_4.hidden = NO;
            [_headerImage sd_setImageWithURL:[model.userAvatars[0] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_2 sd_setImageWithURL:[model.userAvatars[1] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_3 sd_setImageWithURL:[model.userAvatars[2] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            [_headerImage_4 sd_setImageWithURL:[model.userAvatars[3] lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
            
            
        }
        
    }
    


    
    _circleNameButton.hidden = YES;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}


- (void)configAttentionTopicOneImageDetailModel:(AttentionContentsListModel *)model{
    
    UIImageView *headerImge = [[UIImageView alloc]init];
    
    
    [headerImge sd_setImageWithURL:[model.userAvatar lkbImageUrl4] placeholderImage:YQNormalBackGroundPlaceImage];
    [_headImageView setImage:headerImge.image forState:UIControlStateNormal];
    //    [_coverListImage sd_setImageWithURL:[model.coverList[0] lkbImageUrlAllCover] placeholderImage:YQNormalBackGroundPlaceImage];
    
    
    NSLog(@"================================%@",model.objectId);
    
    
    NSLog(@"================================%@",model.imageInfo);
    
    
    if ([model.images isEqualToString:@""] || model.imageInfo == nil) {
        
        [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
            make.left.mas_equalTo(_headImageView);
            make.size.mas_equalTo(CGSizeMake(171, 171));
        }];
        
        
        
    }else
    {
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:model.imageInfo options:NSJSONWritingPrettyPrinted error:nil];
        NSDictionary *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"++++++++++++++++++++++++++++++%@",jsonStr);
        CGFloat width = [[jsonStr objectForKey:@"width"] floatValue];
        CGFloat height = [[jsonStr objectForKey:@"height"] floatValue];
        
        
        NSLog(@"+++++++%f+++++++++++%f+++++++++++",width,height);
        
        
        
        if ( width / height > 1 && width / height < 4 /3) {
            
            [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
                make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
                make.left.mas_equalTo(_headImageView);
                make.size.mas_equalTo(CGSizeMake((171 * width) /height, 171));
            }];
            
        }
        if(width / height < 1 && width / height > 3 /4) {
            
            [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
                make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
                make.left.mas_equalTo(_headImageView);
                make.size.mas_equalTo(CGSizeMake(171, (171 * height) /width));
            }];
            
        }
        if(width / height < 3 /4) {
            
            [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
                make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
                make.left.mas_equalTo(_headImageView);
                make.size.mas_equalTo(CGSizeMake(171, 228));
            }];
            
        }
        if (width / height > 4 /3) {
            [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
                make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
                make.left.mas_equalTo(_headImageView);
                make.size.mas_equalTo(CGSizeMake(228, 171));
            }];
            
            
        }
        if (height / width > 4 /3) {
            
            [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
                make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
                make.left.mas_equalTo(_headImageView);
                make.size.mas_equalTo(CGSizeMake(171, 228));
            }];
            
        }
        if (height / width == 1) {
            [_coverListImage mas_remakeConstraints:^(MASConstraintMaker* make) {
                make.top.mas_equalTo(_goodsDesLabel.bottom).offset(10);
                make.left.mas_equalTo(_headImageView);
                make.size.mas_equalTo(CGSizeMake(171, 171));
            }];
            
            
        }
    }
    
    _nameLabel.text = model.userName;
    
    _goodsDesLabel.text = model.topicContent;
    
    if ([model.summary isEqualToString:@""]) {
        
        
        [_goodsDesLabel mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_headImageView.bottom).offset(5);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(self.contentView).offset(-14);
            
        }];
        
    }
    else {
        
        [_goodsDesLabel mas_remakeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_headImageView.bottom).offset(12);
            make.left.mas_equalTo(_headImageView);
            make.right.mas_equalTo(self.contentView).offset(-14);
            
        }];
        
    }
    
    
    NSDate *createDate = [NSDate dateFormJavaTimestamp:model.topicDate];
    self.loveTimeLabel.text = [createDate timeAgo];
    
    [_goodImage mas_remakeConstraints:^(MASConstraintMaker* make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(0);
        make.height.mas_equalTo(0);
    }];
    
    
    [_headerImage mas_remakeConstraints:^(MASConstraintMaker* make) {
        make.left.mas_equalTo(_goodImage.right).offset(10);
        make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
        make.height.mas_equalTo(0);
    }];
    
    [_headerImage_2 mas_remakeConstraints:^(MASConstraintMaker* make) {
        make.left.mas_equalTo(_goodImage.right).offset(24);
        make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
        make.height.mas_equalTo(0);
    }];
    
    [_headerImage_3 mas_remakeConstraints:^(MASConstraintMaker* make) {
        make.left.mas_equalTo(_goodImage.right).offset(38);
        make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
        make.height.mas_equalTo(0);
    }];
    
    [_headerImage_4 mas_remakeConstraints:^(MASConstraintMaker* make) {
        make.left.mas_equalTo(_goodImage.right).offset(52);
        make.top.mas_equalTo(_comentNumLable.mas_bottom).offset(15);
        make.height.mas_equalTo(0);
    }];
    
    [_circleNameButton setTitle:model.groupName forState:UIControlStateNormal];


    _goodImageView.hidden = YES;
    _attentionNumLable.hidden = YES;
    _comentNumLable.hidden = YES;
    _goodImageView.hidden = YES;
    _headerImage.hidden = YES;
    _headerImage_2.hidden = YES;
    _headerImage_3.hidden = YES;
    _headerImage_4.hidden = YES;
    _squeBtn.hidden = YES;
    _repleyImageView.hidden = YES;
    _shareBtn.hidden = YES;
    _squeImage.hidden = YES;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

    
}







- (void)configureSubview
{
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.squeBtn];
    [self.contentView addSubview:self.squeImage];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.circleNameButton];
    [self.contentView addSubview:self.loveTimeLabel];
    [self.contentView addSubview:self.goodImageView];
    [self.contentView addSubview:self.repleyImageView];
    [self.contentView addSubview:self.comentNumLable];
    [self.contentView addSubview:self.attentionNumLable];
    [self.contentView addSubview:self.goodsDesLabel];
    [self.contentView addSubview:self.coverListImage];

    [self.contentView addSubview:self.goodBtn];
    [self.contentView addSubview:self.repleyBtn];
    
    [self.contentView addSubview:self.goodImage];
    [self.contentView addSubview:self.headerImage];
    [self.contentView addSubview:self.headerImage_2];
    [self.contentView addSubview:self.headerImage_3];
    [self.contentView addSubview:self.headerImage_4];
    [self.contentView addSubview:self.lastView];
    [self.contentView addSubview:self.shareBtn];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    //     应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    //    self.goodsTitleLabel.preferredMaxLayoutWidth = w - 110;
    
    
    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.goodsDesLabel.preferredMaxLayoutWidth = w-20 ;
    self.goodsDesLabel.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
    //                                   initWithTarget:self
    //                                   action:@selector(onTap)];
    //    [self.goodsDesLabel addGestureRecognizer:tap];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lastView;
    self.hyb_bottomOffsetToCell = 0;
    
}


- (void)updateConstraints
{
    
    CGFloat padding = iPhone5_Before ? 13 : 15;
    if (!self.didSetupConstraints) {
        
        [_headImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(14);
            make.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(_headImageView.right).offset(8).priorityLow();
            make.right.mas_equalTo(_squeImage.left).offset(-10);
            make.centerY.mas_equalTo(_headImageView);
        }];
        
        
        
        [_squeImage mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(self.contentView.right).offset(-19);
            make.size.mas_equalTo(CGSizeMake(12, 12));
            make.top.mas_equalTo(22);
        }];
        
        [_squeBtn mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(self.contentView.right).offset(0);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.top.mas_equalTo(0);
        }];
        
        
        [_circleNameButton mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_coverListImage.bottom).offset(11);
            make.left.mas_equalTo(_headImageView);
            make.height.mas_equalTo(22);

        }];
        
        
        
        
        if (_circleNameButton.hidden == YES) {
            
            [_loveTimeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
                make.top.mas_equalTo(_coverListImage.mas_bottom).offset(11);
                make.left.mas_equalTo(_headImageView);
                make.size.mas_equalTo(CGSizeMake(90, 22));
                
            }];
            
            
        }
        else {
            [_loveTimeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
                make.top.mas_equalTo(_coverListImage.mas_bottom).offset(11);
                make.left.mas_equalTo(_circleNameButton.right).offset(7);
                make.centerY.mas_equalTo(_circleNameButton);
            }];
            
        }
        
        
        [_goodImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_coverListImage.mas_bottom).offset(15);
            
            make.right.mas_equalTo(_attentionNumLable.left).offset(-8);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        [_attentionNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(_repleyImageView.left).offset(-24);
            make.top.mas_equalTo(_coverListImage.mas_bottom).offset(15);
            make.height.mas_equalTo(15);
        }];
        
        
        [_repleyImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(_comentNumLable.left).offset(-8);
            
            make.top.mas_equalTo(_coverListImage.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        
        [_comentNumLable mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(_shareBtn.left).offset(-24);
            make.height.mas_equalTo(15);
            make.top.mas_equalTo(_coverListImage.mas_bottom).offset(15);
        }];
        [_goodBtn mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.mas_equalTo(_coverListImage.mas_bottom).offset(0);
            
            make.right.mas_equalTo(self.contentView.right).offset(-74);
            
            make.size.mas_equalTo(CGSizeMake(46, 30));
        }];
        
        [_repleyBtn mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(self.contentView.right).offset(-28);
            
            make.top.mas_equalTo(_coverListImage.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(46, 30));
        }];
        
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(self.contentView.right).offset(-0);
            
            make.top.mas_equalTo(_coverListImage.mas_bottom).offset(8);
            make.size.mas_equalTo(CGSizeMake(28, 30));
        }];
        
        
        
        [_lastView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(self.contentView);
            make.top.mas_equalTo(_goodImage.mas_bottom).offset(15);
            make.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(10);
        }];
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


// 头像
- (UIButton*)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIButton alloc] init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 15;
        _headImageView.clipsToBounds = YES;
//        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_headImageView addTarget:self action:@selector(userInfobutton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _headImageView;
}
- (void)OneImageHeightNoCommenthandlerButtonAction:(BottomBuyClickBlock)block {
    
    self.clickBlock = block;
}

-(void)pushToChoose:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(2);
    }
    
}


-(void)userInfobutton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }
    
}
-(void)circleNameButton:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(3);
    }
    
}
// 名字
- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}

// 内容
- (UILabel*)goodsDesLabel
{
    if (!_goodsDesLabel) {
        _goodsDesLabel = [[UILabel alloc] init];
        _goodsDesLabel.numberOfLines = 6;
        _goodsDesLabel.font = [UIFont systemFontOfSize:16];
        _goodsDesLabel.lineBreakMode = 3;
        _goodsDesLabel.textColor = [UIColor colorWithHex:0x333333];
        _goodsDesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _goodsDesLabel;
}


//- (UIImageView *)coverListImage {
//    
//    if (!_coverListImage) {
//        _coverListImage = [[UIImageView alloc]init];
//        _coverListImage.backgroundColor = CCCUIColorFromHex(0xdddddd);
//        _coverListImage.clipsToBounds = YES;
//        _coverListImage.contentMode = UIViewContentModeScaleAspectFill;
//        _coverListImage.userInteractionEnabled = YES;
//    }
//    return _coverListImage;
//}

- (UIView *)coverListImage {
    
    if (!_coverListImage) {
        _coverListImage = [[UIView alloc]init];
//        _coverListImage.backgroundColor = CCCUIColorFromHex(0xdddddd);
        
    }
    return _coverListImage;
}

// 圈名称
- (UIButton *)circleNameButton {
    
    if (!_circleNameButton) {
        _circleNameButton = [[UIButton alloc] init];
        [_circleNameButton setTitleColor:CCCUIColorFromHex(0x22a941) forState:UIControlStateNormal];
        _circleNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _circleNameButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _circleNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_circleNameButton addTarget:self action:@selector(circleNameButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _circleNameButton;
    
}


// 时间
- (UILabel*)loveTimeLabel
{
    if (!_loveTimeLabel) {
        _loveTimeLabel = [[UILabel alloc] init];
        _loveTimeLabel.numberOfLines = 0;
        _loveTimeLabel.font = [UIFont systemFontOfSize:12];
        _loveTimeLabel.textColor = [UIColor colorWithHex:0xaaaaaa];
        _loveTimeLabel.textAlignment = NSTextAlignmentLeft;
        _loveTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _loveTimeLabel;
}

- (UIImageView *)goodImageView {
    
    if (!_goodImageView) {
        _goodImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_like_nor"]];
    }
    return _goodImageView;
    
}

// 点赞数
- (UILabel*)attentionNumLable
{
    if (!_attentionNumLable) {
        _attentionNumLable = [[UILabel alloc] init];
        _attentionNumLable.numberOfLines = 1;
        _attentionNumLable.font = [UIFont systemFontOfSize:12];
        _attentionNumLable.textColor = [UIColor colorWithHex:0x999999];
        _attentionNumLable.lineBreakMode = NSLineBreakByTruncatingTail;
        _attentionNumLable.textAlignment = NSTextAlignmentRight;

    }
    return _attentionNumLable;
}

// 评论数
- (UILabel*)comentNumLable
{
    if (!_comentNumLable) {
        _comentNumLable = [[UILabel alloc] init];
        _comentNumLable.numberOfLines = 1;
        _comentNumLable.font = [UIFont systemFontOfSize:12];
        _comentNumLable.textColor = [UIColor colorWithHex:0x999999];
        _comentNumLable.textAlignment = NSTextAlignmentLeft;
        _comentNumLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _comentNumLable;
}

// 评论图标
- (UIImageView*)repleyImageView
{
    if (!_repleyImageView) {
        _repleyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_comment"]];
    }
    return _repleyImageView;
}



// 举报
- (UIButton*)squeBtn
{
    if (!_squeBtn) {
        _squeBtn = [[UIButton alloc] init];
        _squeImage.backgroundColor = [UIColor clearColor];
        [_squeBtn addTarget:self action:@selector(pushToChoose:)  forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _squeBtn;
}
- (UIImageView*)squeImage
{
    if (!_squeImage) {
        _squeImage = [[UIImageView alloc] init];
        [_squeImage setImage:[UIImage imageNamed:@"square_btn_arrow_nor"]];
        
    }
    return _squeImage;
}
- (UIButton *)goodBtn {
    
    if (!_goodBtn) {
        
        _goodBtn = [[UIButton alloc]init];
        [_goodBtn addTarget:self action:@selector(goodBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _goodBtn;
    
}
- (void)goodBtn:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(4);
    }
    
}


- (UIButton *)repleyBtn {
    
    if (!_repleyBtn) {
        _repleyBtn = [[UIButton alloc]init];
        [_repleyBtn addTarget:self action:@selector(repleyBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _repleyBtn;
}
- (void)repleyBtn:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(5);
    }
    
}
- (UIImageView *)goodImage {
    
    if (!_goodImage) {
        
        _goodImage = [[UIImageView alloc] init];
        [_goodImage setImage:[UIImage imageNamed:@"icon_like_dynamic"]];
        
    }
    return _goodImage;
}


- (UIImageView *)headerImage {
    
    if (!_headerImage) {
        
        _headerImage = [[UIImageView alloc] init];
        _headerImage.backgroundColor = CCCUIColorFromHex(0x999999);
        CALayer *cicleLayer = [_headerImage layer];
        [cicleLayer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [cicleLayer setCornerRadius:10.0];
        //设置边框线的宽
        [cicleLayer setBorderWidth:0.5];
        //设置边框线的颜色
        [cicleLayer setBorderColor:CCCUIColorFromHex(0xe4e4e4).CGColor];
        
    }
    return _headerImage;
}
- (UIImageView *)headerImage_2 {
    
    if (!_headerImage_2) {
        
        _headerImage_2 = [[UIImageView alloc] init];
        _headerImage_2.backgroundColor = CCCUIColorFromHex(0x999999);
        CALayer *cicleLayer = [_headerImage_2 layer];
        [cicleLayer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [cicleLayer setCornerRadius:10.0];
        //设置边框线的宽
        [cicleLayer setBorderWidth:0.5];
        //设置边框线的颜色
        [cicleLayer setBorderColor:CCCUIColorFromHex(0xe4e4e4).CGColor];
        
    }
    return _headerImage_2;
}
- (UIImageView *)headerImage_3 {
    
    if (!_headerImage_3) {
        
        _headerImage_3 = [[UIImageView alloc] init];
        _headerImage_3.backgroundColor = CCCUIColorFromHex(0x999999);
        CALayer *cicleLayer = [_headerImage_3 layer];
        [cicleLayer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [cicleLayer setCornerRadius:10.0];
        //设置边框线的宽
        [cicleLayer setBorderWidth:0.5];
        //设置边框线的颜色
        [cicleLayer setBorderColor:CCCUIColorFromHex(0xe4e4e4).CGColor];
        
    }
    return _headerImage_3;
}
- (UIImageView *)headerImage_4 {
    
    if (!_headerImage_4) {
        
        _headerImage_4 = [[UIImageView alloc] init];
        _headerImage_4.backgroundColor = CCCUIColorFromHex(0x999999);
        CALayer *cicleLayer = [_headerImage_4 layer];
        [cicleLayer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [cicleLayer setCornerRadius:10.0];
        //设置边框线的宽
        [cicleLayer setBorderWidth:0.5];
        //设置边框线的颜色
        [cicleLayer setBorderColor:CCCUIColorFromHex(0xe4e4e4).CGColor];
        
    }
    return _headerImage_4;
}


- (UIView *)lastView {
    
    if (!_lastView) {
        _lastView = [[UIView alloc]init];
        _lastView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    }
    return _lastView;
}

- (UIButton *)shareBtn {
    
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc]init];
//        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
//        [_shareBtn setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
//        _shareBtn.titleLabel.font =[UIFont systemFontOfSize:12];
        [_shareBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
        _shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [_shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(_shareBtn.imageView.frame.size.height ,-_shareBtn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//        [_shareBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0,-10,0.0, 5)];//图片距离右边框距离减少图片的宽度，其它不边
        [_shareBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}


- (void)shareBtn:(id)sender {
    
    if (self.clickBlock) {
        self.clickBlock(6);
    }
    
}





@end
