//
//  CircleIntrduceViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 10/8/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "CircleIntrduceViewController.h"
#import "SenderSuccessViewController.h"
#import "MyUserInfoManager.h"
#import "IntrduceCircleManager.h"
#import "ZFActionSheet.h"
#import "CircleImageManager.h"
#import "TabbarManager.h"
@interface CircleIntrduceViewController ()<UITextViewDelegate,ZFActionSheetDelegate>
{
    int    _limitLength;
    UIButton *btn;
}

@property(nonatomic,strong)UILabel *CircleLable;
@property (strong, nonatomic)UIImageView *titleImg;
@property (strong, nonatomic)UITextView *intrduceCircleTextView;
@property (strong, nonatomic)UIButton *nextBtn;
@property (strong, nonatomic)UIImageView *lineImg;
@property (strong, nonatomic)UILabel *lastValue;
@property (strong, nonatomic)ZFActionSheet *actionSheet;

@end

@implementation CircleIntrduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImageView *)findBottomLineInView:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findBottomLineInView:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
    
    UIImageView *navBarBottomLine = [self findBottomLineInView:self.navigationController.navigationBar];
    navBarBottomLine.hidden = YES;
    
    [_intrduceCircleTextView becomeFirstResponder];
    
    [MobClick beginLogPageView:@"CircleIntrduceViewController"];

    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"CircleIntrduceViewController"];
}





- (UIStatusBarStyle)preferredStatusBarStyle
{
    //    //返回白色
    //    return UIStatusBarStyleLightContent;
    //返回黑色
    return UIStatusBarStyleDefault;
}

-(void)backToMain
{
//    [self.navigationController popViewControllerAnimated:YES];
    
    [_intrduceCircleTextView resignFirstResponder];

    _actionSheet = [ZFActionSheet actionSheetWithTitle:@"退出后资料信息将不被保存" confirms:@[@"放弃创建",@"继续创建"] cancel:@"取消" style:ZFActionSheetStyleDefault];
    _actionSheet.delegate = self;
    [_actionSheet showInView:self.view.window];
}

#pragma mark - ZFActionSheetDelegate
- (void)clickAction:(ZFActionSheet *)actionSheet atIndex:(NSUInteger)index
{
    NSLog(@"选中了 %zd",index);
    
    
    if (index==1) {
        
    }else
    {
        if ([[TabbarManager shareInstance].createCirleVcType isEqualToString:@"1"]) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            [TabbarManager shareInstance].createCirleVcType = nil;
            [CircleImageManager shareInstance].CircleImage = nil;
        }else {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]                                              animated:YES];
            
            
        }
    }
}


-(void)initSubViews
{
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [backBtn setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    [self.navigationController.navigationBar setBarTintColor:CCCUIColorFromHex(0x323436)];
    
    UIImage *image = [UIImage imageNamed: @"NavBarImage.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    self.navigationItem.titleView = imageView;
    
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//    [self.view addGestureRecognizer:tap];
    
    
    
    [self.view addSubview:self.CircleLable];
    [self.view addSubview:self.lineImg];
    [self.view addSubview:self.intrduceCircleTextView];
    
    //    [self.view addSubview:self.nextBtn];
    
    //    CGFloat padding = iPhone4 ? 24 : 44;
    
    [_CircleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(19);
        make.left.mas_equalTo(self.view.left).offset(16);
        make.size.mas_equalTo(CGSizeMake(280, 20));
    }];
    

    [_intrduceCircleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_CircleLable.bottom).offset(17);
        make.left.mas_equalTo(self.view).offset(11);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(200);

//        make.centerX.mas_equalTo(_CircleLable);
//        make.size.mas_equalTo(CGSizeMake(kDeviceWidth, 200));
    }];
    

}

- (void)initTopView
{
    self.intrduceCircleTextView.inputAccessoryView = [self topView];
}

- (UIView *)topView
{
    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
    topview.backgroundColor = [UIColor whiteColor];
    
    CGFloat buttonWidth = 66;
    CGFloat buttonHeight = 33;
    CGFloat rightDistance =14;
    
    
    _lastValue = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-rightDistance-buttonWidth-66,(CGRectGetHeight(topview.frame)-buttonHeight)/2.0, 60, buttonHeight)];
    _lastValue.backgroundColor = [UIColor clearColor];
    _lastValue.textColor = CCCUIColorFromHex(0xf47474);
    _lastValue.font = [UIFont systemFontOfSize:14];
    _lastValue.textAlignment = NSTextAlignmentRight;
    
    [topview addSubview:_lastValue];
    
    
    
    UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    upBtn.frame = CGRectMake(10 , (CGRectGetHeight(topview.frame)-buttonHeight)/2.0, buttonWidth, buttonHeight);
    [upBtn.layer setMasksToBounds:YES];
    [upBtn setTitle:@"上一步" forState:UIControlStateNormal];
    [upBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    upBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [upBtn addTarget:self action:@selector(upBtnbtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [topview addSubview:upBtn];

    
    
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kDeviceWidth-rightDistance-buttonWidth , (CGRectGetHeight(topview.frame)-buttonHeight)/2.0, buttonWidth, buttonHeight);
    [btn setBackgroundColor:CCCUIColorFromHex(0x22a941)];
    btn.layer.cornerRadius = 3.5;
    [btn.layer setMasksToBounds:YES];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    //    btn.enabled = NO;
    
    if ([IntrduceCircleManager shareInstance].IntrduceCircleStr == nil || [[IntrduceCircleManager shareInstance].IntrduceCircleStr isEqualToString:@""]) {
        btn.userInteractionEnabled=NO;
        btn.alpha=0.4;
        
    }
    else {
        btn.userInteractionEnabled=YES;
        btn.alpha=1;
    }
    [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [topview addSubview:btn];
    
    return topview;
}


#pragma mark - buttonEvent

- (void)upBtnbtnEvent:(UIButton *)button
{
    [self resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
     [IntrduceCircleManager shareInstance].IntrduceCircleStr = _intrduceCircleTextView.text;
    
}



#pragma mark - buttonEvent

- (void)btnEvent:(UIButton *)button
{
    [self resignFirstResponder];
    
    
    if (_intrduceCircleTextView.text.length == 0) {
        [XHToast showTopWithText:@"请输入圈子简介" topOffset:60.0];
    }
    
    else
    {
    
    self.requestParas =  @{@"userId":[[MyUserInfoManager shareInstance]userId],
                           @"groupName":_cirCleNameText,
                        @"avatar":_imageUrl,
                           @"groupDesc":_intrduceCircleTextView.text,
                           @"token":[[MyUserInfoManager shareInstance]token]};
    
    self.requestURL = LKB_CREAT_CIRCLE_LAST_COVER;
    }
    
    
}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{
    
    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    
    if ([request.url isEqualToString:LKB_CREAT_CIRCLE_LAST_COVER]) {
        
        
        LKBBaseModel * base = (LKBBaseModel *)parserObject;
        
        if ([base.msg isEqualToString:@"创建圈子成功！"]) {
            
            [CircleImageManager shareInstance ].CircleImage = nil;
            
            SenderSuccessViewController*photonViewController = [[SenderSuccessViewController alloc]init];
                        [self.navigationController pushViewController:photonViewController animated:YES];
        }
        
    }
    
}

//判断是否超出最大限额 140
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    
    
//    NSString *str = [NSString stringWithFormat:@"%@", textView.text];
//    if (str.length > 100)
//    {
//        int value =  100 - str.length ;
//                    NSString *str2 = [NSString stringWithFormat:@"%d",value];
//                    [_lastValue setText:str2];
//        
//                    btn.userInteractionEnabled = NO;
//                    btn.alpha = 0.4;
//        
//                    
//                    return YES;
//    }
//    
//    else if  (textView.text.length == 0)
//    {
//        [_lastValue setText:@""];
//        
//        btn.userInteractionEnabled = NO;
//        btn.alpha = 0.4;
//        
//    
//        return YES;
//    }
//    else {
//        
//                    [_lastValue setText:@""];
//                    btn.userInteractionEnabled = YES;
//                    btn.alpha = 1;
//        
//        
//                    return YES;
//                }
//    
//
    if (textView.text.length==1&&[text isEqualToString:@""]) {
        [_lastValue setText:@""];
        btn.userInteractionEnabled = NO;
        btn.alpha = 0.4;
    }else
    {
        if (textView.text.length>1& range.length > 0&&textView.text.length - range.length + text.length <100) {
            
            [_lastValue setText:@""];
            btn.userInteractionEnabled = YES;
            btn.alpha = 1;
            //删除字符肯定是安全的
        }
        if (textView.text.length - range.length + text.length > 100) {
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"超出最大可输入长度" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];//如果输入的文字大于140 则提示 <span style="font-family: Arial, Helvetica, sans-serif;">"超出最大可输入长度" 并不能继续输入文字</span>
            //
            //            [alert show];
            
            int value =  100 - textView.text.length - range.length - text.length ;
            NSString *str = [NSString stringWithFormat:@"%d",value];
            [_lastValue setText:str];
            
            btn.userInteractionEnabled = NO;
            btn.alpha = 0.4;
            
            
            return YES;
        }
        else {
            
            if (textView.text.length == 0) {
                btn.userInteractionEnabled = NO;
                btn.alpha = 0.4;

                
            }
            else {
                
                [_lastValue setText:@""];
                btn.userInteractionEnabled = YES;
                btn.alpha = 1;

            }
            
            
            
            return YES;
        }

        
       
    }
    

     return YES;

    
// if (textView.text.length>1& range.length > 0&&textView.text.length - range.length + text.length <100) {
//        
//      [_lastValue setText:@""];
//      btn.userInteractionEnabled = YES;
//      btn.alpha = 1;
//        //删除字符肯定是安全的
//        return YES;
//    }
//    else {
//        if (textView.text.length - range.length + text.length > 100) {
////            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"超出最大可输入长度" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];//如果输入的文字大于140 则提示 <span style="font-family: Arial, Helvetica, sans-serif;">"超出最大可输入长度" 并不能继续输入文字</span>
////            
////            [alert show];
//            
//            int value =  100 - textView.text.length - range.length + text.length ;
//            NSString *str = [NSString stringWithFormat:@"%d",value];
//            [_lastValue setText:str];
//            
//            btn.userInteractionEnabled = NO;
//            btn.alpha = 0.4;
//            
//            
//            return YES;
//        }
//        else {
//            
//            [_lastValue setText:@""];
//            btn.userInteractionEnabled = YES;
//            btn.alpha = 1;
//
//            
//            return YES;
//        }
//    }

}

//- (void)tap:(UITapGestureRecognizer *)recognizer
//{
//    [_intrduceCircleTextView resignFirstResponder];
//}






- (void)limitTextLength:(int)length
{
    _limitLength = length;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitEvent) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)limitEvent
{
    if ([self.intrduceCircleTextView.text length] > _limitLength) {
        self.intrduceCircleTextView.text = [self.intrduceCircleTextView.text substringToIndex:_limitLength];
    }
    
    if ([self.intrduceCircleTextView.text length]!=0) {
        btn.userInteractionEnabled = YES;
        btn.alpha = 1;
    } else
    {
        btn.userInteractionEnabled = NO;
        btn.alpha = 0.4;
        
    }
    
    
    
}

#pragma mark - Getters & Setters
- (UITextView*)intrduceCircleTextView
{
    if (!_intrduceCircleTextView) {
      
        _intrduceCircleTextView = [[UITextView alloc] init];
        _intrduceCircleTextView.font = [UIFont systemFontOfSize:15];

        _intrduceCircleTextView.textColor = CCCUIColorFromHex(0x333333);
        if ([IntrduceCircleManager shareInstance].IntrduceCircleStr != nil) {
            _intrduceCircleTextView.text = [IntrduceCircleManager shareInstance].IntrduceCircleStr;
        }
        _intrduceCircleTextView.delegate = self;
        [_intrduceCircleTextView setTintColor:[UIColor LkbgreenColor]];
        _intrduceCircleTextView.selectedRange=NSMakeRange(0,0) ;
        _intrduceCircleTextView.textAlignment = NSTextAlignmentLeft;

        [self initTopView];
        
        
    }
    return _intrduceCircleTextView;
}

//-(void)textViewDidChange:(UITextView *)textView
//
//{
//    
//    //    textview 改变字体的行间距
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    
//    paragraphStyle.lineSpacing = 3.5;// 字体的行间距
//     NSDictionary *attributes = @{
//                                 
//                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
//                                 
//                                 NSParagraphStyleAttributeName:paragraphStyle
//                                 
//                                 };
//    
//    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
//    
//    
//    
//}




- (UIImageView *)titleImg
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-textview"]];
    }
    return _titleImg;
}


- (UIImageView *)lineImg
{
    if (!_lineImg) {
        _lineImg = [[UIImageView alloc] init];
        _lineImg.backgroundColor = [UIColor LkbBtnColor];
    }
    return _lineImg;
}


- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.layer.masksToBounds = YES;
//        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"login-btn-normal"] forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:CCCUIColorFromHex(0x22a941)];

        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextBtn addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (UILabel*)CircleLable
{
    if (!_CircleLable) {
        _CircleLable = [[UILabel alloc] init];
        _CircleLable.textAlignment = NSTextAlignmentLeft;
        _CircleLable.numberOfLines = 1;
        _CircleLable.text = @"简介";
        _CircleLable.font = [UIFont systemFontOfSize:18];
        _CircleLable.textColor = CCCUIColorFromHex(0x555555);
        _CircleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _CircleLable;
}

-(void)nextClicked:(id)sender
{
    
    if(_intrduceCircleTextView.text.length==0)
    {
        [self ShowProgressHUDwithMessage:@"请输入手机号码"];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
