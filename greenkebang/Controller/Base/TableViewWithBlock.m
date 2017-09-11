//
//  TableViewWithBlock.m
//  ComboBox
//
//  Created by Eric Che on 7/17/13.
//  Copyright (c) 2013 Eric Che. All rights reserved.
//

#import "TableViewWithBlock.h"
#import "UITableView+DataSourceBlocks.h"
#import "UITableView+DelegateBlocks.h"

@implementation TableViewWithBlock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)initTableViewDataSourceAndDelegate:(UITableViewNumberOfRowsInSectionBlock)numOfRowsBlock setCellForIndexPathBlock:(UITableViewCellForRowAtIndexPathBlock)cellForIndexPathBlock setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock setHeightForRowBlock:(UITableViewHeightForRowAtIndexPathBlock)heightForRowBlock{
   
    self.numberOfRowsInSectionBlock=numOfRowsBlock;
    self.cellForRowAtIndexPath=cellForIndexPathBlock;
    self.didDeselectRowAtIndexPathBlock=didSelectRowBlock;
    self.heightForRowAtIndexPathBlock = heightForRowBlock;
    self.dataSource=self;
    self.delegate=self;
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)initTableViewDataSourceAndDelegate:(UITableViewNumberOfSectionsInTableViewBlock)numberOfSectionsBlock setNumberOfRowsBlock:(UITableViewNumberOfRowsInSectionBlock)numOfRowsBlock setCellForIndexPathBlock:(UITableViewCellForRowAtIndexPathBlock)cellForIndexPathBlock setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock setHeightForRowBlock:(UITableViewHeightForRowAtIndexPathBlock)heightForRowBlock{
    
    self.numberOfSectionsBlock = numberOfSectionsBlock;
    self.numberOfRowsInSectionBlock=numOfRowsBlock;
    self.cellForRowAtIndexPath=cellForIndexPathBlock;
    self.didDeselectRowAtIndexPathBlock=didSelectRowBlock;
    self.heightForRowAtIndexPathBlock = heightForRowBlock;
    self.dataSource=self;
    self.delegate=self;
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)onHeightForHeaderInSectionBlock:(UITableViewHeightForHeaderInSectionBlock)block
{
    self.heightForHeaderBlock = block;
}

-(void)onViewForHeaderInSectionBlock:(UITableViewViewForHeaderInSectionBlock)block
{
    self.viewForHeaderInSectionBlock = block;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellForRowAtIndexPath(tableView,indexPath);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView  {
    if (self.numberOfSectionsBlock) {
        return self.numberOfSectionsBlock(tableView);
    } else {
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numberOfRowsInSectionBlock(tableView,section);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.didDeselectRowAtIndexPathBlock(tableView,indexPath);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
//    if (cell) {
//        return cell.frame.size.height;
//    }
//    return 0;
    return self.heightForRowAtIndexPathBlock(tableView,indexPath);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.heightForHeaderBlock) {
        return self.heightForHeaderBlock(tableView,section);
    } else {
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.viewForHeaderInSectionBlock) {
        return self.viewForHeaderInSectionBlock(tableView,section);
    } else {
        return nil;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
////    if (self.viewForHeaderBlock)
//    if ([self tableView:self heightForHeaderInSection:1] > 0)
//    {
//        CGFloat sectionHeaderHeight = [self tableView:self heightForHeaderInSection:1];
//        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
//}

@end
