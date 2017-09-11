//
//  SetGroupTagsViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 2/1/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "SetGroupTagsViewController.h"
#import "HKKTagWriteView.h"
#import "SetGroupTagsViewController.h"

@interface SetGroupTagsViewController ()
<
HKKTagWriteViewDelegate
>
@property (nonatomic, strong) HKKTagWriteView *tagWriteView;
@property (nonatomic, strong) NSString *groupTags;

@end
@implementation SetGroupTagsViewController
- (void)viewDidLoad

{
    [super viewDidLoad];
    self.title = @"群组标签";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_pre"]style:UIBarButtonItemStyleDone target:self action:@selector(BackButton:)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishButton:)];
    self.navigationItem.rightBarButtonItem = right;
    self.view.backgroundColor = [UIColor whiteColor];

    // 键盘回收
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view, typically from a nib.
    _tagWriteView = [[HKKTagWriteView alloc]initWithFrame:CGRectMake(10, 10, kDeviceWidth, 40)];
    
    _tagWriteView.delegate = self;
    [_tagWriteView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_tagWriteView];
    //    [_tagWriteView addTags:@[@"hello", @"UX", @"congratulation", @"google", @"ios", @"android"]];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    
}


- (void)tap:(UITapGestureRecognizer *)recognizer
{

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HKKTagWriteViewDelegate
- (void)tagWriteView:(HKKTagWriteView *)view didMakeTag:(NSString *)tag
{
    NSLog(@"added tag = %@", _tagWriteView.tags);
    
    
    _groupTags = [_tagWriteView.tags componentsJoinedByString:@","];
    
    
}

- (void)tagWriteView:(HKKTagWriteView *)view didRemoveTag:(NSString *)tag
{
    NSLog(@"removed tag = %@", tag);
    _groupTags = [_tagWriteView.tags componentsJoinedByString:@","];
}


- (void)BackButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)sendeGrouptasgBlock:(SetGrouptagsBlock)block
{
    _setGrouptagsBlock=block;
}

// 完成按钮
- (void)finishButton:(id)sender {
    
    
    if (_setGrouptagsBlock) {
        _setGrouptagsBlock(_groupTags);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
