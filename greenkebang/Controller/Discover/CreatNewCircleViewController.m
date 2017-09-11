//
//  CreatNewCircleViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 10/7/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "CreatNewCircleViewController.h"
#import "VPViewController.h"
#import "MyUserInfoManager.h"
#import "ZFActionSheet.h"
#import "TabbarManager.h"
#import "CircleImageManager.h"
@interface CreatNewCircleViewController ()<UITextFieldDelegate,ZFActionSheetDelegate>
{
    int    _limitLength;
    UIButton *btn;
}

@property(nonatomic,strong)UILabel *CircleLable;
@property (strong, nonatomic)UIImageView *titleImg;
@property (strong, nonatomic)UITextField *pushCircleName;
@property (strong, nonatomic)UIButton *nextBtn;
@property (strong, nonatomic)UIImageView *lineImg;
@property (assign, nonatomic)BOOL canedit;
@property (strong, nonatomic)ZFActionSheet *actionSheet;

@end

@implementation CreatNewCircleViewController

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
    [MobClick beginLogPageView:@"CreatNewCircleViewController"];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"CreatNewCircleViewController"];
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
    
    
    
    if ([self.pushCircleName.text length]!=0) {
        
        [_pushCircleName resignFirstResponder];
        
        _actionSheet = [ZFActionSheet actionSheetWithTitle:@"退出后资料信息将不被保存" confirms:@[@"放弃创建",@"继续创建"] cancel:@"取消" style:ZFActionSheetStyleDefault];
        
        
        _actionSheet.delegate = self;
        [_actionSheet showInView:self.view.window];

    }
    else if ([[TabbarManager shareInstance].createCirleVcType isEqualToString:@"1"]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [TabbarManager shareInstance].createCirleVcType = nil;
        [CircleImageManager shareInstance].CircleImage = nil;
    }
    else {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]                                              animated:YES];


        
    }
    

}

#pragma mark - ZFActionSheetDelegate
- (void)clickAction:(ZFActionSheet *)actionSheet atIndex:(NSUInteger)index
{
    NSLog(@"选中了 %zd",index);
    
    
    if (index==1) {
        
    }else
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]                                              animated:YES];

    }
}

-(void)initSubViews
{
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn setTitleColor:CCCUIColorFromHex(0x999999) forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    [self.navigationController.navigationBar setBarTintColor:CCCUIColorFromHex(0x323436)];
    
    UIImage *image = [UIImage imageNamed: @"NavBarImage.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    self.navigationItem.titleView = imageView;
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    

    
    [self.view addSubview:self.CircleLable];
    [self.view addSubview:self.lineImg];
    [self.view addSubview:self.pushCircleName];

    [self.view addSubview:self.nextBtn];
    
    //    CGFloat padding = iPhone4 ? 24 : 44;
    
    [_CircleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(88);
        make.centerX.mas_equalTo(self.view.centerX);
        make.size.mas_equalTo(CGSizeMake(280, 40));
    }];
    

    
    
    [_pushCircleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_CircleLable.bottom).offset(40);
        make.left.mas_equalTo(_CircleLable.left).offset(10);
        make.right.mas_equalTo(_CircleLable.right).offset(-10);

        make.centerX.mas_equalTo(_CircleLable.centerX);
        make.height.mas_offset(30);

    }];
    
    
    [_lineImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pushCircleName.bottom).offset(2);
        make.centerX.mas_equalTo(_CircleLable.centerX);
        make.left.mas_equalTo(self.view).offset(27);
        make.right.mas_equalTo(self.view).offset(-27);
        make.height.mas_offset(1);


    }];
    
    

    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-8);
        make.right.mas_equalTo(self.view).offset(-14);
        make.size.mas_equalTo(CGSizeMake(66, 33));

    }];
    
}

- (void)initTopView
{
    
  
    self.pushCircleName.inputAccessoryView = [self topView];
}

- (UIView *)topView
{
    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
    topview.backgroundColor = [UIColor whiteColor];
    
    CGFloat buttonWidth = 66;
    CGFloat buttonHeight = 33;
    CGFloat rightDistance = 14;
    


    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kDeviceWidth-rightDistance-buttonWidth , (CGRectGetHeight(topview.frame)-buttonHeight)/2.0, buttonWidth, buttonHeight);
    [btn setBackgroundColor:CCCUIColorFromHex(0x22a941)];
    btn.layer.cornerRadius = 3.5;
    [btn.layer setMasksToBounds:YES];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
//    btn.enabled = NO;
    btn.userInteractionEnabled=NO;
    btn.alpha=0.4;
    [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
        [topview addSubview:btn];

    return topview;
}


#pragma mark - buttonEvent

- (void)btnEvent:(UIButton *)button
{
    [self resignFirstResponder];
    
    
    
    self.requestParas =  @{@"userId":[[MyUserInfoManager shareInstance]userId],
                           @"groupName":_pushCircleName.text,
                           @"token":[[MyUserInfoManager shareInstance]token]};
    
    self.requestURL = LKB_CREAT_CIRCLE_COVER;
    

}


- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage
{

    
    if (errorMessage) {
        [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }

    if ([request.url isEqualToString:LKB_CREAT_CIRCLE_COVER]) {
        
        
        LKBBaseModel * base = (LKBBaseModel *)parserObject;

        if ([base.msg isEqualToString:@"操作成功！"]) {
            VPViewController*photonViewController = [[VPViewController alloc]init];
            photonViewController.cirleName = _pushCircleName.text;
            [self.navigationController pushViewController:photonViewController animated:YES];
        }

    }
    
}


- (void)tap:(UITapGestureRecognizer *)recognizer
{
    [_pushCircleName resignFirstResponder];
}



-(void)textFiledEditChanged:(NSNotification *)obj{
    
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        int chNum =0;
        for (int i=0; i<toBeString.length; ++i)
        {
            NSRange range = NSMakeRange(i, 1);
            NSString *subString = [toBeString substringWithRange:range];
            const char *cString = [subString UTF8String];
            if (strlen(cString) == 3)
            {
                NSLog(@"汉字:%@",subString);
                chNum ++;
            }
        }
        
        if (chNum>=9) {
            _canedit =NO;
        }
        
        if (!position) {
            if (toBeString.length > 10) {
                textField.text = [toBeString substringToIndex:10];
                _canedit =YES;
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > 20) {
            textField.text = [toBeString substringToIndex:20];
            _canedit =NO;
        }
    }
    
    if ([self.pushCircleName.text length] > _limitLength) {
        self.pushCircleName.text = [self.pushCircleName.text substringToIndex:_limitLength];
    }
    
    if ([self.pushCircleName.text length]!=0) {
        btn.userInteractionEnabled = YES;
        _nextBtn.alpha =1;
        btn.alpha =1;
        _nextBtn.userInteractionEnabled = YES;

    } else
    {
        btn.userInteractionEnabled = NO;
        _nextBtn.alpha =0.4;
        btn.alpha =0.4;
        _nextBtn.userInteractionEnabled = NO;

    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (toBeString.length<=10) {
        _canedit =YES;
    }
    if (_canedit==NO) { //如果输入框内容大于20则弹出警告
        return NO;
    }
    return YES;
}


- (void)limitTextLength:(int)length
{
    _limitLength = length;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:_pushCircleName];
}

- (void)limitEvent
{
    if ([self.pushCircleName.text length] > _limitLength) {
        self.pushCircleName.text = [self.pushCircleName.text substringToIndex:_limitLength];
    }
    
    if ([self.pushCircleName.text length]!=0) {
        btn.userInteractionEnabled = YES;
        btn.alpha = 1;
    } else
    {
        btn.userInteractionEnabled = NO;
        btn.alpha = 0.4;
        
    }
    
    
    
}

#pragma mark - Getters & Setters
- (UITextField*)pushCircleName
{
    if (!_pushCircleName) {
        _pushCircleName = [[UITextField alloc] init];
        _pushCircleName.delegate = self;
        [self limitTextLength:10];
        [_pushCircleName becomeFirstResponder];
        _pushCircleName.textAlignment = NSTextAlignmentCenter;
        _pushCircleName.placeholder = @"填写圈子名称，不超过10个字";
          [_pushCircleName setTintColor:[UIColor LkbgreenColor]];
//        [_textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//        _pushCircleName.returnKeyType = UIReturnKeyNext;
        [self initTopView];
        
    }
    return _pushCircleName;
}

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
        [_nextBtn setBackgroundColor:CCCUIColorFromHex(0x22a941)];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.alpha = 0.4;
        _nextBtn.userInteractionEnabled = NO;
        _nextBtn.layer.cornerRadius = 3.5;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _nextBtn;
}

- (UILabel*)CircleLable
{
    if (!_CircleLable) {
        _CircleLable = [[UILabel alloc] init];
        _CircleLable.textAlignment = NSTextAlignmentCenter;
        _CircleLable.numberOfLines = 1;
        _CircleLable.text = @"圈子名称";
        _CircleLable.font = [UIFont systemFontOfSize:40];
        _CircleLable.textColor = CCCUIColorFromHex(0x999999);
        _CircleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _CircleLable;
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
