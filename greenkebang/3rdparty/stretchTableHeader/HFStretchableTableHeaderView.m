//
//  StretchableTableHeaderView.m
//  StretchableTableHeaderView
//

#import "HFStretchableTableHeaderView.h"


@interface HFStretchableTableHeaderView()
{
    CGRect initialFrame;
    CGFloat defaultViewHeight;
    UIVisualEffectView * visualEffectView; //毛玻璃效果
    UIView * blurImageBackView;// 毛玻璃上面的黑色

}
@end


@implementation HFStretchableTableHeaderView

@synthesize tableView = _tableView;
@synthesize view = _view;
@synthesize emptyTableHeaderView = _emptyTableHeaderView;




- (void)stretchHeaderForTableView:(UITableView*)tableView withView:(UIView*)view subViews:(UIView*)subview
{
    _tableView = tableView;
    _view      = view;
    _emptyTableHeaderView = subview;
    
    initialFrame       = _view.frame;
    defaultViewHeight  = initialFrame.size.height ;
    
//    UIView *emptyTableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 305)];
//    emptyTableHeaderView.backgroundColor = [UIColor clearColor];
    
    
    _tableView.tableHeaderView = _emptyTableHeaderView;
    
//    _tableView.tableHeaderView.frame = CGRectMake(0, 0, kDeviceWidth, 305);
    
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualEffectView.frame = initialFrame;
    
    blurImageBackView = [[UIView alloc]init];
    blurImageBackView.backgroundColor = [UIColor blackColor];
    blurImageBackView.frame = initialFrame;
    blurImageBackView.alpha = 0.1;
    
//    [_view addSubview:visualEffectView];
//    [visualEffectView addSubview:blurImageBackView];


    [_tableView addSubview:_view];
    [_tableView addSubview:visualEffectView];
    [_tableView addSubview:blurImageBackView];

//    [visualEffectView addSubview:blurImageBackView];


    [_tableView addSubview:subview];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    CGRect f     = _view.frame;
    f.size.width = _tableView.frame.size.width;
    _view.frame  = f;
    
    if(scrollView.contentOffset.y < 0)
    {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
       
        initialFrame.origin.y = - offsetY * 1;
        initialFrame.origin.x = - offsetY / 2;
        
        initialFrame.size.width  = _tableView.frame.size.width + offsetY;
        initialFrame.size.height = defaultViewHeight + offsetY;
        
        _view.frame = initialFrame;
        visualEffectView.frame = initialFrame;
        blurImageBackView .frame = initialFrame;
        
    }

}


- (void)resizeView
{
    initialFrame.size.width = _tableView.frame.size.width;
    _view.frame = initialFrame;
}


@end
