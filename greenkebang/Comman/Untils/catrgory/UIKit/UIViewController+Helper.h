
#import <UIKit/UIKit.h>

@interface UIViewController (Helper)

- (void)setExtraCellLineHidden: (UITableView *)tableView;
- (void)showAlert:(NSString*)msg title:(NSString*)title;
- (void)callPhoneNumber:(NSString*)phoneNum;
@end
