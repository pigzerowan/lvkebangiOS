//
//  LoveTableFooterView.m
#import "LoveTableFooterView.h"

@implementation LoveTableFooterView
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
#pragma mark - Event response
- (void)addFriendButtonDidClicked:(id)sender
{

}
#pragma mark - Subviews
- (void)configSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        
        
//        make.right.mas_equalTo(self);
    }];
    }
#pragma mark - Setter & Getter
- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 1;
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.textColor = [UIColor lightGrayColor];
        _textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//        _textLabel.text = @"没有更多数据了哦...";
    }
    return _textLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
