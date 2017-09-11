//
//  CustomChatShareBubbleView.h
//  greenkebang
//
//  Created by 郑渊文 on 7/28/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMChatBaseBubbleView.h"


extern NSString *const LalalaShareName;

@interface CustomChatShareBubbleView : EMChatBaseBubbleView<UIActionSheetDelegate>

@property(nonatomic,copy)UIImageView * headImage;
@property(nonatomic,copy)UILabel * myTitle;
@property(nonatomic,copy)UILabel * myDescrible;
@property(nonatomic,copy)UIView * lineView;
@property(nonatomic,copy)UILabel * fromLable;
@property(nonatomic,copy)NSDictionary * modelDic;
@end
