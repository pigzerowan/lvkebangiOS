//
//  DiscoverPublishQuestionViewController.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/22.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "DiscoverPublishQuestionViewController.h"
#import "DiscoverChooseCircleViewController.h"
#import "MKComposePhotosView.h"
#import "MKMessagePhotoView.h"
#import "TDSystemService.h"
#import "MyUserInfoManager.h"
#import "DerectManager.h"
#import "UIView+LQXkeyboard.h"

#import "MBProgressHUD+Add.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"

#import "XHMessageTextView.h"


#import "JHToolBar.h"
#import "UIView+Extension.h"
#import "JHEmotionKeyboard.h"
#import "JHEmotion.h"
#import "JHEmotionTextView.h"
#import "JHTextPart.h"
#import "JHEmotionTool.h"






@interface DiscoverPublishQuestionViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate,TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,JHToolBarDelegate>
{
    
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
    LxGridViewFlowLayout *_layout;
    
}

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic, strong) UIButton *emojiButton;


@property (nonatomic, strong) JHToolBar *toolbar;//自定义的toolBar

@property (nonatomic,assign) CGFloat keyboardH;//系统键盘的高度

@property (nonatomic,assign) BOOL switchingKeybaord;//是否切换键盘

@property (nonatomic, strong) JHEmotionKeyboard *emotionKeyboard;//自定义表情键盘




@end

@implementation DiscoverPublishQuestionViewController

- (JHEmotionKeyboard *)emotionKeyboard
{
    if (_emotionKeyboard == nil) {
        _emotionKeyboard = [[JHEmotionKeyboard alloc]init];
        _emotionKeyboard.emojiwidth = self.view.emojiwidth;
        _emotionKeyboard.emojiheight = self.keyboardH;
    }
    return _emotionKeyboard;
}

- (UIImagePickerController *)imagePickerVc {
    
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //处理键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //处理表情选中的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionDidSelect:) name:@"JHEmotionDidSelectNotification" object:nil];
    //删除文字
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionDidDelete) name:@"JHEmotionDidDeleteNotification" object:nil];

    
    [self.view addSubview:self.chooseCircle];
    [self.chooseCircle addSubview:self.circleImage];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.describeTextView];
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    [self configCollectionView];
    
    [self.describeTextView becomeFirstResponder];//让运行的时候，键盘就弹出，因为要拿到自定义键盘的高度keyboardH，如果开始没有弹出键盘，那么运行就点击表情键盘的时候，是没有键盘高度的，那么自定义的键盘就回一直没有高度，因为自定义键盘只会创建一次

    //创建toolBar
    [self toolBarCommon];


    
    // 左键返回
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    if ([_VCType isEqualToString:@"1"]) {
        [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];

    }
    else {
        [backBtn setImage:[UIImage imageNamed:@"nav_close_pre"] forState:UIControlStateNormal];

    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    // 发布按钮
    _publish = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -48 - 8 , 8, 48, 33)];
    _publish.layer.cornerRadius = 3;
    _publish.backgroundColor = CCCUIColorFromHex(0x22a941);
    [_publish setTitle:@"发布" forState:UIControlStateNormal];
    _publish.enabled = NO;
    [_publish addTarget:self action:@selector(publishButton:) forControlEvents:UIControlEventTouchUpInside];
    _publish.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.navigationController.navigationBar addSubview:_publish];
    
    

    // 键盘回收
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] init ];
    [_tapGestureRecognizer addTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    _tapGestureRecognizer.cancelsTouchesInView = NO;
    _tapGestureRecognizer.delegate = self;
    //将触摸事件添加到当前view
//    [self.view addGestureRecognizer:_tapGestureRecognizer];
    
    


    // 观察键盘变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDismiss:) name:UIKeyboardWillHideNotification object:nil];

    
    UISwipeGestureRecognizer  *slider = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
    slider.direction=UISwipeGestureRecognizerDirectionDown| UISwipeGestureRecognizerDirectionUp;
    slider.delegate = self;
//    [self.view addGestureRecognizer:slider];


    // Do any additional setup after loading the view.
}


/**
 *  删除文字
 */
- (void)emotionDidDelete
{
    [self.describeTextView deleteBackward];
}
/**
 *  表情被选中了
 */
- (void)emotionDidSelect:(NSNotification *)notification
{
    JHEmotion *emotion = notification.userInfo[@"JHSelectEmotionKey"];
    [self.describeTextView insertEmotion:emotion];
}
/**
 *  处理键盘的方法
 *
 *  @param notification <#notification description#>
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if (self.switchingKeybaord) return;
    
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardH = keyboardF.size.height;
    
    // 执行动画
//    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.emojiheight) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.emojiy = self.view.emojiheight - self.toolbar.emojiheight;
        } else {
            self.toolbar.emojiy = keyboardF.origin.y - self.toolbar.emojiheight;
        }
//    }];
    
}


/**
 *  创建工具条
 */
- (void)toolBarCommon
{
    JHToolBar *toolBar = [[JHToolBar alloc]init];
    self.toolbar = toolBar;
    toolBar.frame = CGRectMake(0, self.view.emojiheight - 44 -144 , self.view.emojiwidth, 44);
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
}
/**
 *  点击工具条的代理方法
 *
 *  @param toolBar toolBar
 *  @param tag     点击工具条上的按钮的tag
 */
- (void)toolBar:(JHToolBar *)toolBar ButtonTag:(NSUInteger)tag
{
    switch (tag) {
        case 0: // 拍照
            
            break;
            
        case 1: // 相册
            
            break;
            
        case 2: // @
            
            break;
            
        case 3: // #
            
            break;
            
        case 4: // 表情\键盘
            [self switchKeyboard];
            break;
    }
    
}
/**
 *  切换 表情／键盘
 */
- (void)switchKeyboard
{
    if (self.describeTextView.inputView == nil) {//切换成表情键盘
        
        self.describeTextView.inputView = self.emotionKeyboard;
        
        self.toolbar.showKeyboardButton = YES;//显示成键盘按钮
        
    }else//切换成系统键盘
    {
        self.describeTextView.inputView = nil;
        self.toolbar.showKeyboardButton = NO;//显示成表情按钮
    }
    
    // 开始切换键盘
    self.switchingKeybaord = YES;
    
    // 退出键盘
    [self.describeTextView endEditing:YES];
    
    
    //    [self.view endEditing:YES];
    //    [self.view.window endEditing:YES];
    //    [self.textView resignFirstResponder];
    // 结束切换键盘
    self.switchingKeybaord = NO;//这行代码要放在下面的  弹出键盘  的前面，不然会出现bug
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 弹出键盘
        [self.describeTextView becomeFirstResponder];
        

        
        
    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}






- (void)handleSwipes:(UISwipeGestureRecognizer *) sender {
    
    [_describeTextView resignFirstResponder];

}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_describeTextView resignFirstResponder];
}


//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    
//    [_describeTextView becomeFirstResponder];

//    //获取键盘信息
    NSDictionary *userInfo = [aNotification userInfo];
    //获取键盘的高度
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    
    
    if (iPhone5) {
        _collectionView.frame = CGRectMake(16,175,kDeviceWidth, 80);

    }
    else if (iPhone6p) {
        _collectionView.frame = CGRectMake(16, kbSize.height +50,kDeviceWidth, 80);
    }
    else {
        _collectionView.frame = CGRectMake(16, kbSize.height +6,kDeviceWidth, 80);

    }
    
    if (iPhone5) {
        
        if ([_VCType isEqualToString:@"1"]) {
            
            _describeTextView.frame = CGRectMake(13, 111, SCREEN_WIDTH - 32, 138);
            
        }
        else {
            _describeTextView.frame = CGRectMake(13, 64, SCREEN_WIDTH - 32, 175);
            
        }

    }
    else if (iPhone6p) {
        
        if ([_VCType isEqualToString:@"1"]) {
            
            _describeTextView.frame = CGRectMake(13, 111, SCREEN_WIDTH - 32, kbSize.height );
            
        }
        else {
            _describeTextView.frame = CGRectMake(13, 64, SCREEN_WIDTH - 32, kbSize.height +55);
            
        }

    }
    else {
        
        if ([_VCType isEqualToString:@"1"]) {
            
            _describeTextView.frame = CGRectMake(13,111, SCREEN_WIDTH - 32, kbSize.height -47);
            
        }
        else {
            _describeTextView.frame = CGRectMake(13, 64, SCREEN_WIDTH - 32, kbSize.height );
        }

    }
    
    
}

//当键盘将要退出时调用
- (void)keyboardWillDismiss:(NSNotification *)aNotification {
//    //键盘退出的时候，将视图的位置调回原来的位置
//    [_describeTextView resignFirstResponder];
    
    [self.describeTextView endEditing:YES];


    _collectionView.frame = CGRectMake(16,KDeviceHeight -144,kDeviceWidth, 80);

    if ([_VCType isEqualToString:@"1"]) {
        
        _describeTextView.frame = CGRectMake(13, 111, SCREEN_WIDTH - 32, KDeviceHeight -200);
        
    }
    else {
        _describeTextView.frame = CGRectMake(13, 0, SCREEN_WIDTH - 32, KDeviceHeight - 150);
        
    }

}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    // 隐藏导航下的线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:CCCUIColorFromHex(0x333333),NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    [MobClick beginLogPageView:@"DiscoverPublishQuestionViewController"];

    
    if ([DerectManager shareInstance].DirectionStr != nil) {
        
        [_chooseCircle setTitle:[DerectManager shareInstance].DirectionStr forState:UIControlStateNormal];
        [_chooseCircle setTitleColor:CCCUIColorFromHex(0x333333) forState:UIControlStateNormal];
        if ([_VCType isEqualToString:@"1"]) {
            
            _groupId = [DerectManager shareInstance].directionId;

        }
    }
    
    if ([_VCType isEqualToString:@"2"]) {
        
        _chooseCircle.hidden = YES;
        _lineView.hidden = YES;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = CCCUIColorFromHex(0xe4e4e4);
        [self.view addSubview:line];
    }
    else {
        _chooseCircle.hidden = NO;
        _lineView.hidden = NO;

        
    }

    
    
    if ([_VCType isEqualToString:@"2"]) {
        
        if ([_describeTextView.text isEqualToString:@"在此输入详细内容，您可以发布提问、话题，让更多人关注您！"]) {
            
            
            if (_selectedPhotos.count == 0) {
                
                _publish.enabled = NO;
                [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
                
            }else {
                
                _publish.enabled = YES;
                [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 1) forState:UIControlStateNormal];

                
            }

        }
        else {
            
            if (_selectedPhotos.count == 0) {
                
                _publish.enabled = NO;
                [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
            }
            else {
                
                _publish.enabled = YES;
                [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 1) forState:UIControlStateNormal];

            }
            
        }
        
    }else {
        
        if ([_chooseCircle.titleLabel.text isEqualToString:@"选择圈子"] ) {
            
            if (_selectedPhotos.count == 0) {
                
                _publish.enabled = NO;
                [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];

            }
            
            
            
        }
        else {
            
            if (_selectedPhotos.count == 0) {
                
                
                if (![_describeTextView.text isEqualToString:@"在此输入详细内容，您可以发布提问、话题，让更多人关注您！"] ) {
                    
                    if (![_describeTextView.text isEqualToString:@""]) {
                        
                        _publish.enabled = YES;
                        [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 1) forState:UIControlStateNormal];

                    }
                    else {
                        _publish.enabled = NO;
                        [_publish setTitleColor:CCColorFromRGBA(255, 255, 255,0.5) forState:UIControlStateNormal];

                    }
                    

                }
                else {
                    _publish.enabled = NO;
                    [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];

                    
                }
                
                
            }else {
                
                _publish.enabled = YES;
                [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 1) forState:UIControlStateNormal];
                

            }

            
            
        }
        
        
    }
    
//    if ([MyUserInfoManager shareInstance].touchtoCircle) {
//        [self setEdgesForExtendedLayout:UIRectEdgeNone];
//    }else
//    {
        [self setEdgesForExtendedLayout:UIRectEdgeAll];
//    }
    
//        [self.navigationController.navigationBar setClipsToBounds:NO];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.modalPresentationCapturesStatusBarAppearance = NO;
    
//

    
    [self.navigationController.navigationBar addSubview:_publish];
}




-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
 
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = YES;
    
    
    [_publish removeFromSuperview];
    
    [MobClick endLogPageView:@"DiscoverPublishQuestionViewController"];

}





-(void)backToMain
{
    [DerectManager shareInstance].DirectionStr  = nil;

    [self.navigationController popViewControllerAnimated:YES];
    
}

// 发布
-(void)publishButton:(id)sender
{
    
    
//    if ([self stringContainsEmoji:_describeTextView.text] == YES) {
//        
//        [XHToast showTopWithText:@"不支持输入表情" topOffset:60.0];
//
//    }
//    else {
    

        
        if ([_describeTextView.text isEqualToString:@"在此输入详细内容，您可以发布提问、话题，让更多人关注您！"]) {
            _describeTextView.text = @"";
        }
        
        if (_selectedPhotos.count == 0) {
            
            
            
            
            self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                  @"groupId":_groupId,
                                  @"content":_describeTextView.text,
                                  @"token":[MyUserInfoManager shareInstance].token
                                  };
            self.requestURL = LKB_Circle_Publish_Url;
            
        }
        
        else {
            [TDSystemService uploadPublishQAImages:_selectedPhotos progress:^(CGFloat progress) {
                
                NSLog(@"qin niu --%f",progress);
                
            }success:^(NSArray*urlArr) {
                
                NSLog(@"qin niu --%@",urlArr);
                
                NSMutableArray *arr = [[NSMutableArray alloc]init];
                
                for(NSString * Urlstr in urlArr){
                    
                    NSUInteger length = [@"static/group_topic/" length];
                    NSString * urlStr = [Urlstr substringFromIndex:length];
                    [arr addObject:urlStr];
                }
                
                
                NSString *str = [arr componentsJoinedByString:@","];
                NSLog(@"====================%@",str);
                
                
                self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                                      @"groupId":_groupId,
                                      @"content":_describeTextView.text,
                                      @"images":str,
                                      @"token":[MyUserInfoManager shareInstance].token
                                      };
                self.requestURL = LKB_Circle_Publish_Url;
                
            }failure:^{
                
                NSLog(@" --->> error:");
                
            }];
            
            
        }

//    }
    
    
    
    
    
    
}








- (UIButton *)chooseCircle {
    
    if (!_chooseCircle) {
        
        _chooseCircle = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
        _chooseCircle.backgroundColor = [UIColor whiteColor];
        [_chooseCircle setTitle:@"选择圈子" forState:UIControlStateNormal];
        _chooseCircle.titleLabel.font = [UIFont systemFontOfSize:16];
        _chooseCircle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _chooseCircle.contentEdgeInsets = UIEdgeInsetsMake(0,16, 0, 0);
        [_chooseCircle setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
        [_chooseCircle addTarget:self action:@selector(chooseCircleButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _chooseCircle;
}

-(void)chooseCircleButton:(id)sender
{
    DiscoverChooseCircleViewController *choseVC = [[DiscoverChooseCircleViewController alloc]init];
    
    if (![_chooseCircle.titleLabel.text isEqualToString:@"选择圈子"]) {
        
        [DerectManager shareInstance].DirectionStr = _chooseCircle.titleLabel.text ;
    }
    
    NSLog(@"=====================================%@",_chooseCircle.titleLabel.text);
    
    [self.navigationController pushViewController:choseVC animated:YES];
    
    
}




- (UIImageView *)circleImage {
    
    if (!_circleImage) {
        _circleImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 27, 15,6, 10.5)];
        [_circleImage setImage:[UIImage imageNamed:@"icon_arrow_r"]];
    }
    return _circleImage;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH , 0.5)];
        _lineView.backgroundColor = CCCUIColorFromHex(0xe4e4e4);

    }
    return _lineView;
}


- (JHEmotionTextView *)describeTextView {
    
    if (!_describeTextView) {
        _describeTextView = [[JHEmotionTextView alloc]init];
        if ([_VCType isEqualToString:@"1"]) {
            _describeTextView.frame = CGRectMake(13, 111, SCREEN_WIDTH - 32, 300);

        }
        else {
            _describeTextView.frame = CGRectMake(13, 0, SCREEN_WIDTH - 32, 300);

        }
        
        _describeTextView.backgroundColor = [UIColor whiteColor];
        _describeTextView.delegate = self;
        _describeTextView.text = @"在此输入详细内容，您可以发布提问、话题，让更多人关注您！";
        _describeTextView.font = [UIFont systemFontOfSize:16];
        _describeTextView.textColor = CCCUIColorFromHex(0x999999);
        [[[_describeTextView textInputMode] primaryLanguage] isEqualToString:@"emoji"];

    }
    return _describeTextView;
}







// 判断是否有表情
- (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

// 实现正文的placeholder
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    
    
    if ([textView.text isEqualToString:@"在此输入详细内容，您可以发布提问、话题，让更多人关注您！"]) {
        
        textView.text = @"";
        textView.textColor = CCCUIColorFromHex(0x333333);
        
        if ([_VCType isEqualToString:@"2"]) {
            
            if ([_describeTextView.text isEqualToString:@"在此输入详细内容，您可以发布提问、话题，让更多人关注您！"]) {
                
                _publish.enabled = NO;
                [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
            }
            else {
                
                if (_selectedPhotos.count == 0) {
                    
                    _publish.enabled = NO;
                    [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
                    
                }else {
                    
                    _publish.enabled = YES;
                    [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 1) forState:UIControlStateNormal];
                    
                    
                }
            }
            
        }else {
            
            if ([_chooseCircle.titleLabel.text isEqualToString:@"选择圈子"]) {
                
                _publish.enabled = NO;
                [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
                
            }
            else {
                
                if (_selectedPhotos.count == 0) {
                    
                    _publish.enabled = NO;
                    [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];

                }else {
                    
                    _publish.enabled = YES;
                    [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 1) forState:UIControlStateNormal];
                    
                }
                
                
                
                
            }
            
            
        }
        
    }
    
}

//在结束编辑的代理方法中进行如下操作
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length<1) {
        
        textView.text = @"";
        
    }
    
}



- (void)textViewDidChange:(UITextView *)textView{
    
    
    
    if ([_VCType isEqualToString:@"2"]) {
        
        if (textView.text.length == 0) {
            _publish.enabled = NO;
            [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
            
            
        }else {
            
            
            _publish.enabled = YES;
            
            [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 1) forState:UIControlStateNormal];
            
            
        }

        
        
    }
    else {
        
        if ([_chooseCircle.titleLabel.text isEqualToString:@"选择圈子"]) {
            _publish.enabled = NO;
            
            
        }
        else {
            
            if (textView.text.length == 0) {
                _publish.enabled = NO;
                [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
                
                
            }else {
                _publish.enabled = YES;
                
                [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 1) forState:UIControlStateNormal];
                
                
            }
            
        }

        
    }
    
    
    
}



- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage {
    if (errorMessage) {
      [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    if ([request.url isEqualToString:LKB_Circle_Publish_Url]){
        
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        
        NSLog(@"！！！！！！========%@===============",Model.msg);
        
        
        if ([Model.success isEqualToString:@"1"]) {
            
            [self ShowProgressHUDwithMessage:@"发布成功"];
            
//            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)ShowProgressHUDwithMessage:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.dimBackground = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

// 发布照片的控件

- (void)configCollectionView {
    _layout = [[LxGridViewFlowLayout alloc] init];
    _margin = 4;
    //    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
    _itemWH = 60;
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    _layout.minimumInteritemSpacing = _margin;
    _layout.minimumLineSpacing = _margin;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(16,KDeviceHeight- 80 - 8 -64,kDeviceWidth, 80) collectionViewLayout:_layout];

    // CGRectMake(0,KDeviceHeight- 80 - 8 -64,kDeviceWidth, 80)
    CGFloat rgb = 244 / 255.0;
    //    _collectionView.alwaysBounceVertical = YES;
    _collectionView.alwaysBounceHorizontal = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        
        cell.imageView.image = [UIImage imageNamed:@"release_btn_addimages_nor"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
        
        cell.deleteBtn.tag = indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        BOOL showSheet = NO;// < 显示一个sheet,把拍照按钮放在外面
        if (showSheet) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
            [sheet showInView:self.view];
        } else {
            if (_selectedPhotos.count == 9) {
                UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"最多只能选择9张哦~" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleDefault handler:nil];
                [alertVC addAction:okAction];
                [self presentViewController:alertVC animated:YES completion:nil];
            }
            else {
                [self pushImagePickerController];
                
            }
        }
    } else { // preview photos or video / 预览照片或者视频
        id asset = _selectedAssets[indexPath.row];
        BOOL isVideo = NO;
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = asset;
            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = asset;
            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
        }
        if (isVideo) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
            imagePickerVc.allowPickingOriginalPhoto = YES;
            imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                _selectedPhotos = [NSMutableArray arrayWithArray:photos];
                _selectedAssets = [NSMutableArray arrayWithArray:assets];
                _isSelectOriginalPhoto = isSelectOriginalPhoto;
                _layout.itemCount = _selectedPhotos.count;
                [_collectionView reloadData];
                _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.item >= _selectedPhotos.count || destinationIndexPath.item >= _selectedPhotos.count) return;
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    if (image) {
        [_selectedPhotos exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [_selectedAssets exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [_collectionView reloadData];
    }
}

#pragma mark - TZImagePickerController
- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    // 1.如果你需要将拍照按钮放在外面，不要传这个参数
    imagePickerVc.selectedAssets = _selectedAssets; // optional, 可选的
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
#pragma mark - 到这里为止
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        NSLog(@"---------------------------%@",photos);
        
        NSLog(@">>>>>>>>>>>>>>>>>>>>---------------------------%@",assets);
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS8Later) {
        // 无权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^{
            [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                    [tzImagePickerVc hideProgressHUD];
                    TZAssetModel *assetModel = [models firstObject];
                    if (tzImagePickerVc.sortAscendingByModificationDate) {
                        assetModel = [models lastObject];
                    }
                    [_selectedAssets addObject:assetModel.asset];
                    [_selectedPhotos addObject:image];
                    [_collectionView reloadData];
                }];
            }];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=Photos"]];
        }
    }
}

#pragma mark - TZImagePickerControllerDelegate


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    _layout.itemCount = _selectedPhotos.count;
    [_collectionView reloadData];
}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    _layout.itemCount = _selectedPhotos.count;
    [_collectionView reloadData];
}


#pragma mark Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    _layout.itemCount = _selectedPhotos.count;
    
    if (_selectedPhotos.count == 0) {
        
        _publish.enabled = NO;
        [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
    }
    else {
        
        _publish.enabled = YES;
        [_publish setTitleColor:CCColorFromRGBA(255, 255, 255, 1) forState:UIControlStateNormal];
        
    }
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
