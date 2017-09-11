//
//  JHEmotionListView.m
//  emotions
//
//  Created by zhou on 16/7/5.
//  Copyright © 2016年 zhou. All rights reserved.
//

// 每一页的表情个数
#define JHEmotionPageSize 20

#import "JHEmotionListView.h"
#import "UIView+Extension.h"
#import "JHEmotionPageView.h"

@interface JHEmotionListView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation JHEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //1.uiscrollView
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        self.scrollView = scrollView;
//        scrollView.backgroundColor = [UIColor redColor];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
         // 去除垂直方向的滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        // 去除水平方向的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        //2,pageControl
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.userInteractionEnabled = NO;
        // 当只有1页时，自动隐藏pageControl
        pageControl.hidesForSinglePage = YES;

        // 设置内部的圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
    }
    
    return self;
}
// 根据emotions，创建对应个数的表情
- (void)setEmotions:(NSMutableArray *)emotions
{
    _emotions = emotions;
    
    // 删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = (emotions.count + JHEmotionPageSize - 1)/JHEmotionPageSize;
    //1，设置页数
    self.pageControl.numberOfPages = count;
//    self.pageControl.numberOfPages = count > 1? count : 0;
    
    //2.创建用来显示每一页表情的控件
    for (int i = 0; i < count; i++) {
        JHEmotionPageView *pageView = [[JHEmotionPageView alloc]init];
        //计算每一页表情的范围
        NSRange range;
        range.location = i * JHEmotionPageSize;
        //left：剩余的表情个数
        NSUInteger left = emotions.count - range.location;
        if (left > JHEmotionPageSize) {
            range.length = JHEmotionPageSize;
        }else{
            range.length = left;
        }
        //设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //1.pageControl
    self.pageControl.emojiwidth = self.emojiwidth;
    self.pageControl.emojiheight = 35;
    self.pageControl.emojix = 0;
    self.pageControl.emojiy = self.emojiheight - self.pageControl.emojiheight;
    
    //2.scrollView
    self.scrollView.emojiwidth = self.emojiwidth;
    self.scrollView.emojix = 0;
    self.scrollView.emojiy = 0;
    self.scrollView.emojiheight = self.pageControl.emojiy;
    
//    3.设置scrollView内部的每一页尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i < count; i++) {
        JHEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.emojiheight = self.scrollView.emojiheight;
        pageView.emojiwidth = self.scrollView.emojiwidth;
        pageView.emojix = pageView.emojiwidth * i;
        pageView.emojiy = 0;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.emojiwidth * count, 0);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.emojiwidth;
    
    self.pageControl.currentPage = (int)(pageNo + 0.5);
    
}
// 随机颜色
- (UIColor*)randomColor
{
    
    CGFloat r = arc4random() % 256 / 255.0;
    CGFloat g = arc4random() % 256 / 255.0;
    CGFloat b = arc4random() % 256 / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
@end
