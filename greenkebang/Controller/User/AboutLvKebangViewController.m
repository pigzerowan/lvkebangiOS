//
//  AboutLvKebangViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 10/20/15.
//  Copyright © 2015 transfar. All rights reserved.
//

#import "AboutLvKebangViewController.h"

@interface AboutLvKebangViewController ()
{
    
     UIImageView *navBarHairlineImageView;
}

@property (strong, nonatomic)UIImageView *logoImageView;
@property (nonatomic, copy) NSString* appVersion;
@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* appVersionLable;
@property (nonatomic, strong) UILabel* introduceLable;

@end



@implementation AboutLvKebangViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于绿科邦";
    NSDictionary* infoDic = [[NSBundle mainBundle] infoDictionary];
    _appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
//    // 隐藏导航下的线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ;
    UIImageView *backgroundImg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backgroundImg.image = [UIImage imageNamed:@"login-bakground"];
//    [self.view addSubview:backgroundImg];
    
    
    [self initSubViews];
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

    // Do any additional setup after loading the view.
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    navBarHairlineImageView.hidden = YES;

    [MobClick beginLogPageView:@"AboutLvKebangViewController"];
    //    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"AboutLvKebangViewController"];
}


-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initSubViews
{
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.nameLable];
    [self.view addSubview:self.appVersionLable];
    [self.view addSubview:self.introduceLable];
    
    
    CGFloat padding = iPhone4 ? 24 : 44;
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(padding);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_logoImageView.bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
    }];

    [_appVersionLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLable.bottom).offset(1);
        make.centerX.mas_equalTo(self.view);
    }];
    [_introduceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_appVersionLable.bottom).offset(50);
         make.left.mas_equalTo(self.view).offset(16);
        make.centerX.mas_equalTo(self.view);
    }];
}


#pragma mark - Getters & Setters
- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about_img_logo"]];
    }
    return _logoImageView;
}

- (UILabel *)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.font = [UIFont systemFontOfSize:16];
        _nameLable.textColor = CCCUIColorFromHex(0x333333);
        _nameLable.text = @" ";
    }
    return _nameLable;
}
- (UILabel *)appVersionLable
{
    if (!_appVersionLable) {
        _appVersionLable = [[UILabel alloc] init];
        _appVersionLable.font = [UIFont systemFontOfSize:12];
        _appVersionLable.textColor = CCCUIColorFromHex(0xaaaaaa);
        _appVersionLable.text = [NSString stringWithFormat:@"v%@",_appVersion];
    }
    return _appVersionLable;
}
- (UILabel *)introduceLable
{
    if (!_introduceLable) {
        _introduceLable = [[UILabel alloc] init];
        _introduceLable.numberOfLines = 0;
        _introduceLable.font = [UIFont systemFontOfSize:15];
        NSString *textStr  =  @"国内首家新农业 B2B 集中采购、社区交流平台，聚合“B2B交易系统”、“新农圈”、“专栏”、“锄禾说”、“星创学堂”等特色功能。其中B2B交易系统采用封闭式会员制，通过严格审核筛选出一批追求生态、健康、智慧、创意农业的卖家、买家和经纪人，确保让每一笔交易靠谱、便利又实惠。 “新农圈”等社区功能提供精准行业社交，让你随时随地了解行业动态，发现生意伙伴，第一时间促成交易。缺人脉、找平台、做农业的你不可错过。";
        _introduceLable.textColor = CCCUIColorFromHex(0x555555);
        
        // 调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3.5];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
        _introduceLable.attributedText = attributedString;
        
        [_introduceLable sizeToFit];
        
        
    }
    return _introduceLable;
}


@end
