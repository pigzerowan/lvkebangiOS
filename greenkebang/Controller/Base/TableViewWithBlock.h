//
//  TableViewWithBlock.h
//  ComboBox
//
//  Created by Eric Che on 7/17/13.
//  Copyright (c) 2013 Eric Che. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+DataSourceBlocks.h"
#import "UITableView+DelegateBlocks.h"

@interface TableViewWithBlock : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)UITableViewCellForRowAtIndexPathBlock cellForRowAtIndexPath;
@property(nonatomic,copy)UITableViewNumberOfRowsInSectionBlock numberOfRowsInSectionBlock;
@property(nonatomic,copy)UITableViewDidDeselectRowAtIndexPathBlock didDeselectRowAtIndexPathBlock;
@property(nonatomic,copy)UITableViewHeightForRowAtIndexPathBlock heightForRowAtIndexPathBlock;
@property(nonatomic,copy)UITableViewNumberOfSectionsInTableViewBlock numberOfSectionsBlock;
@property(nonatomic,copy)UITableViewHeightForHeaderInSectionBlock heightForHeaderBlock;
@property(nonatomic,copy)UITableViewViewForHeaderInSectionBlock viewForHeaderInSectionBlock;

-(void)initTableViewDataSourceAndDelegate:(UITableViewNumberOfRowsInSectionBlock)numOfRowsBlock setCellForIndexPathBlock:(UITableViewCellForRowAtIndexPathBlock)cellForIndexPathBlock setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock setHeightForRowBlock:(UITableViewHeightForRowAtIndexPathBlock)heightForRowBlock;

-(void)initTableViewDataSourceAndDelegate:(UITableViewNumberOfSectionsInTableViewBlock)numberOfSectionsBlock setNumberOfRowsBlock:(UITableViewNumberOfRowsInSectionBlock)numOfRowsBlock setCellForIndexPathBlock:(UITableViewCellForRowAtIndexPathBlock)cellForIndexPathBlock setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock setHeightForRowBlock:(UITableViewHeightForRowAtIndexPathBlock)heightForRowBlock;

-(void)onHeightForHeaderInSectionBlock:(UITableViewHeightForHeaderInSectionBlock)block;

-(void)onViewForHeaderInSectionBlock:(UITableViewViewForHeaderInSectionBlock)block;
- (id)initWithFrame:(CGRect)frame;
@end
