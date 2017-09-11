
#import "UIViewController+Helper.h"

@implementation UIViewController (Helper)

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
- (void)showAlert:(NSString*)msg title:(NSString*)title
{
    UIAlertView* alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:msg
                          delegate:nil
                          cancelButtonTitle:@"关闭"
                          otherButtonTitles:nil];
    [alert show];
}
- (void)callPhoneNumber:(NSString*)phoneNum
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSString *callString = [NSString stringWithFormat:@"tel:%@",phoneNum];
    NSURL *telURL =[NSURL URLWithString:callString];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}
@end
