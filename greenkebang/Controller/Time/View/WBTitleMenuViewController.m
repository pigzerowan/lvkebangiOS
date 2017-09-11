//
//  WBTitleMenuViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/23.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBTitleMenuViewController.h"
@interface WBTitleMenuViewController ()
@property (nonatomic, strong) NSArray * groups;
@property (nonatomic, strong) NSArray * groupsImage;

@end

static NSString *cellID = @"SelectCell";

@implementation WBTitleMenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.groups = @[@"发布动态",@"创建圈子"];
    self.groupsImage = @[@"release",@"create"];

}



- (void)viewWillAppear:(BOOL)animated {
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    if (self.groups.count ==0 || self.groups ==nil) {
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
    return self.groups.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 43;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, 150, 10)];
    titleLabel.text = [self.groups objectAtIndex:indexPath.row];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = CCCUIColorFromHex(0xffffff);
    
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, kDeviceWidth, 0.5)];
    lineView.backgroundColor = CCCUIColorFromHex(0x4f5252);
    
    [cell.contentView addSubview:lineView];

    [cell.contentView addSubview:titleLabel];
    
//    cell.textLabel.text = [self.groups objectAtIndex:indexPath.row];
//    cell.textLabel.frame = CGRectMake(0, 0, 150, 10);
//    cell.textLabel.font = [UIFont systemFontOfSize:15];
//    cell.textLabel.textColor = CCCUIColorFromHex(0xffffff);
//    [cell.imageView setImage:[self.groupsImage objectAtIndex:indexPath.row]];
    
    cell.imageView.image = [UIImage imageNamed:_groupsImage[indexPath.row]];
    cell.imageView.frame = CGRectMake(16, 0, 18, 18);
//    cell.imageView.image = [self.groupsImage objectAtIndex:indexPath.row];
//    cell.textLabel.text = group.groupName;
    cell.backgroundColor = [UIColor clearColor];
    cell.separatorInset = UIEdgeInsetsMake(cell.separatorInset.top, 0, cell.separatorInset.bottom, cell.separatorInset.right);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dropdownMenuView) {
        [self.dropdownMenuView dismiss];
    }
    if (self.delegate) {
        NSString *title = self.groups[indexPath.row];
        [self.delegate selectAtIndexPath:indexPath title:title];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
