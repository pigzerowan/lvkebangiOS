//
//  TranceApplyViewController.m
//  greenkebang
//
//  Created by 郑渊文 on 10/13/16.
//  Copyright © 2016 transfar. All rights reserved.
//

#import "TranceApplyViewController.h"
#import "MaterialTextField.h"
#import "MaterialTextField.h"
#import "TDSystemService.h"
#import "MyUserInfoManager.h"
#import "SenderSuccessViewController.h"
#import "PermissionToApplyViewController.h"
typedef NS_ENUM(NSInteger, PhotoType)
{
    PhotoTypeIcon,
    PhotoTypeRectangle,
    PhotoTypeRectangle1
};


NSString *const MFDemoErrorDomain = @"MFDemoErrorDomain";
NSInteger const MFDemoErrorCode = 100;






@interface TranceApplyViewController () <UITextFieldDelegate,UIScrollViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate,UIGestureRecognizerDelegate>


@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) UIButton *publish;

@property (strong, nonatomic)  UIView *topView;
@property (strong, nonatomic)  UIScrollView *myScrollerView;
@property (strong, nonatomic)  NSArray *titleArr;
@property (strong, nonatomic)  MFTextField *ComplanytextField;
@property (strong, nonatomic)  MFTextField *ContactPeopletextField;
@property (strong, nonatomic)  MFTextField *ContactPhonetextField;
@property (strong, nonatomic)  MFTextField *BelieaveCodetextField;
@property (strong, nonatomic)  MFTextField *OwnerPeopletextField;
@property (strong, nonatomic)  MFTextField *OwnerCardtextField;
@property (strong, nonatomic)  UILabel *ownerLable;
@property (copy, nonatomic)  NSString *cardFrontImageUrl;
@property (copy, nonatomic)  NSString *cardConImageUrl;
@property (copy, nonatomic)  NSString *certImageUrl;
@property (strong, nonatomic)  UIImageView *cardImageIcon;
@property (strong, nonatomic)  UIImageView *cardImageIcon2;
@property (strong, nonatomic)  UIImageView *certyImgae;
@property (strong, nonatomic)  UILabel *certyLable;

@property (copy, nonatomic)  NSString *btnType;


@property (nonatomic, assign) PhotoType type;

@end

@implementation TranceApplyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"会员申请";
        [self initTopView];
    [self initSubViews];

    
    _btnType = @"1";
    _publish = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_publish sizeToFit];
    [_publish setTitle:@"提交" forState:UIControlStateNormal];
    [_publish setTitleColor:CCCUIColorFromHex(0x69c21b) forState:UIControlStateNormal];
      [_publish setFrame:CGRectMake(0, 2, 60, 28)];
    //        [_publishButton setImage:[UIImage imageNamed:@"publish_Question"] forState:UIControlStateNormal];
    [_publish addTarget:self action:@selector(publishButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_publish];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
    
    
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"TranceApplyViewController"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"TranceApplyViewController"];
}



// 发布
-(void)publishButton:(id)sender
{
    
//    if ([_btnType isEqualToString:@"1"]) {
//        if ([self validateComplanytextFieldIsValid] == YES&&[self validateContactPeopletextFieldIsValid] == YES&&[self validateContactPhonetextFieldIsValid] == YES&&
//            //        [self validateBelieaveCodetextFieldIsValid] == YES&&
//            //        [self validateOwnerPeopletextFieldIsValid] == YES
//            //        &&[self validateOwnerCardtextFieldIsValid] == YES
//            //        &&_cardConImageUrl!=nil
//            //        &&_cardFrontImageUrl!=nil&&
//            _btnType!=nil) {
//            
//            self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
//                                  @"company":_ComplanytextField.text,
//                                  @"telephone":_ContactPhonetextField.text,
//                                  @"idCardImage":@"",
//                                  @"token":[[MyUserInfoManager shareInstance]token],
//                                  @"type":_btnType,
//                                  @"linkUser":_ContactPeopletextField.text,
//                                  @"legalPerson":@"",
//                                  @"idCard":@"",
//                                  
//                                  @"groupNum":@"",
//                                  @"applySource":@"1",
//                                  @"licenseImage":_certImageUrl
//                                  
//                                  };
//            self.requestURL = LKB_jiaoyiShenhe_Url;
//            
//            
//            NSLog(@"开始上传");
//            
//        }
//        
//        else {
//            
//            [self ShowProgressHUDwithMessage:@"请检查是否输入正确"];
//            NSLog(@"可能有部分没有输入正确");
//            
//            
//        }
//
//    }


    if ([self validateComplanytextFieldIsValid] == YES&&[self validateContactPeopletextFieldIsValid] == YES&&[self validateContactPhonetextFieldIsValid] == YES&&
//        [self validateBelieaveCodetextFieldIsValid] == YES&&
//        [self validateOwnerPeopletextFieldIsValid] == YES
//        &&[self validateOwnerCardtextFieldIsValid] == YES
//        &&_cardConImageUrl!=nil
//        &&_cardFrontImageUrl!=nil&&
        _certImageUrl!=nil) {
        
        self.requestParas = @{@"userId":[[MyUserInfoManager shareInstance]userId],
                              @"company":_ComplanytextField.text,
                              @"telephone":_ContactPhonetextField.text,
                              @"idCardImage":@"",
                              @"token":[[MyUserInfoManager shareInstance]token],
                              @"type":@"1",
                              @"linkUser":_ContactPeopletextField.text,
                              @"legalPerson":@"",
                              @"idCard":@"",
                              
                              @"groupNum":@"",
                              @"applySource":@"1",
                              @"licenseImage":_certImageUrl
                     
                              };
        self.requestURL = LKB_jiaoyiShenhe_Url;
        
        
  NSLog(@"开始上传");
        
    }
    
    else {
        
        [self ShowProgressHUDwithMessage:@"请检查是否输入正确"];
        NSLog(@"可能有部分没有输入正确");
        
        
    }
    
    
    
}




- (void)actionFetchRequest:(YQRequestModel *)request result:(LKBBaseModel *)parserObject
              errorMessage:(NSString *)errorMessage {
    if (errorMessage) {
       [XHToast showTopWithText:errorMessage topOffset:60.0];
        return;
    }
    if ([request.url isEqualToString:LKB_jiaoyiShenhe_Url]){
        
        LKBBaseModel *Model = (LKBBaseModel *)parserObject;
        
        NSLog(@"！！！！！！========%@===============",Model.msg);

        if ([Model.success isEqualToString:@"1"]) {
            
            [self ShowProgressHUDwithMessage:@"提交成功"];
            
            
            SenderSuccessViewController *tosuccessVC= [[SenderSuccessViewController alloc]init];
            
//            PermissionToApplyViewController *tosuccessVC= [[PermissionToApplyViewController alloc]init];
            [self.navigationController pushViewController:tosuccessVC animated:YES];
 
        }else
        {
            [self ShowProgressHUDwithMessage:Model.msg];

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


- (void)initTopView{
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.alpha = .8;
    
    _titleArr = @[@"我是经纪人",@"我是买家",@"我是卖家"];
    for (int i = 0; i < _titleArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + i * ((kDeviceWidth - 50)/3 + 10) , 30, (kDeviceWidth - 50)/3, 50);
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.showsTouchWhenHighlighted = YES;
        //设置tag值
        btn.tag = i + 100;
        
        
        if (btn.tag ==100) {
            btn.selected = YES;
            _btnType = @"0";
        }else
        {
        
        btn.selected = NO;
        }
        [btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"unselect_tranceBtn"] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"select_tranBtn"] forState:UIControlStateSelected];
        [_topView addSubview:btn];
    }

}





- (void)choose:(UIButton *)sender{
    for (int i = 0; i < _titleArr.count; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:100 + i];
        [btn setSelected:NO];
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    _btnType = [NSString stringWithFormat:@"%d",button.tag-100];
    
//    if ([_btnType isEqualToString:@"1"]) {
//        _certyImgae.hidden=YES;
//    }else
//    {
//        _certyImgae.hidden=NO;
//    }
}



- (void)selectedIcon
{
    self.type = PhotoTypeIcon;
    

    
    [_ComplanytextField resignFirstResponder];
     [_ContactPeopletextField resignFirstResponder];
     [_ContactPhonetextField resignFirstResponder];
     [_BelieaveCodetextField resignFirstResponder];
     [_OwnerPeopletextField resignFirstResponder];
     [_OwnerCardtextField resignFirstResponder];
    
    
     [self callActionSheetFunc];
//    [self editImageSelected];
}

- (void)selectedRectangle{
    self.type = PhotoTypeRectangle;
    
    [_ComplanytextField resignFirstResponder];
    [_ContactPeopletextField resignFirstResponder];
    [_ContactPhonetextField resignFirstResponder];
    [_BelieaveCodetextField resignFirstResponder];
    [_OwnerPeopletextField resignFirstResponder];
    [_OwnerCardtextField resignFirstResponder];
    
    
     [self callActionSheetFunc];
//    [self editImageSelected];
}

- (void)selectedRectangle1{
    self.type = PhotoTypeRectangle1;
    [_ComplanytextField resignFirstResponder];
    [_ContactPeopletextField resignFirstResponder];
    [_ContactPhonetextField resignFirstResponder];
    [_BelieaveCodetextField resignFirstResponder];
    [_OwnerPeopletextField resignFirstResponder];
    [_OwnerCardtextField resignFirstResponder];
    
    
     [self callActionSheetFunc];
//    [self editImageSelected];
}



- (void)callActionSheetFunc{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择",  nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",  nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    switch (self.type) {
        case PhotoTypeIcon:
            self.cardImageIcon.image = image;
  
        { [TDSystemService uploadShoppingMallImage:self.cardImageIcon.image progress:^(NSString *key, float percent) {
                NSLog(@"qin niu --%@",key);
            } success:^(NSString *url) {
                NSLog(@"qin niu --%@",url);
                _cardFrontImageUrl = url;
            } failure:^{
                NSLog(@" --->> error:");
            }];

        }
            break;
        case PhotoTypeRectangle:
            self.cardImageIcon2.image = image;
        {
            [TDSystemService uploadShoppingMallImage:self.cardImageIcon2.image progress:^(NSString *key, float percent) {
                NSLog(@"qin niu --%@",key);
            } success:^(NSString *url) {
                NSLog(@"qin niu --%@",url);
                _cardConImageUrl = url;
            } failure:^{
                NSLog(@" --->> error:");
            }];
        }
            break;
        case PhotoTypeRectangle1:
            self.certyImgae.image = image;
            
        {[TDSystemService uploadShoppingMallImage:self.certyImgae.image progress:^(NSString *key, float percent) {
                NSLog(@"qin niu --%@",key);
            } success:^(NSString *url) {
                NSLog(@"qin niu --%@",url);
                _certImageUrl = url;
            } failure:^{
                NSLog(@" --->> error:");
            }];

        }
            break;
        default:
            break;
    }
    

}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)clickPickImage:(id)sender {
    
    [self callActionSheetFunc];
}


-(void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initSubViews
{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
    //    [self.navigationController.navigationBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_write_nor"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    [self.view addSubview:self.myScrollerView];
//     [self.myScrollerView addSubview:self.topView];
    [self.myScrollerView addSubview:self.ComplanytextField];
    [self.myScrollerView addSubview:self.ContactPeopletextField];
    [self.myScrollerView addSubview:self.ContactPhonetextField];
//    [self.myScrollerView addSubview:self.BelieaveCodetextField];
//    [self.myScrollerView addSubview:self.OwnerPeopletextField];
//    [self.myScrollerView addSubview:self.OwnerCardtextField];
//        [self.myScrollerView addSubview:self.ownerLable];
//         [self.myScrollerView addSubview:self.cardImageIcon];
//        [self.myScrollerView addSubview:self.cardImageIcon2];
[self.myScrollerView addSubview:self.certyLable];
    [self.myScrollerView addSubview:self.certyImgae];
    
        UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedIcon)];
    tap0.delegate = self;
        [self.cardImageIcon addGestureRecognizer:tap0];
    
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedRectangle)];
    tap1.delegate = self;
        [self.cardImageIcon2 addGestureRecognizer:tap1];
    
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedRectangle1)];
     tap2.delegate = self;
        [self.certyImgae addGestureRecognizer:tap2];
    
        CGFloat padding = iPhone4 ? 44 : 55;
    
    [_ComplanytextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(self.view.left).offset(10);
        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-20, padding));
    }];
    
    
    [_ContactPeopletextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ComplanytextField.bottom).offset(10);
        make.left.mas_equalTo(self.view.left).offset(10);
        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-20, padding));
    }];
    [_ContactPhonetextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ContactPeopletextField.bottom).offset(10);
        make.left.mas_equalTo(self.view.left).offset(10);
        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-20, padding));
    }];
//    [_BelieaveCodetextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_ContactPhonetextField.bottom).offset(10);
//        make.left.mas_equalTo(self.view.left).offset(10);
//        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-20, padding));
//    }];
//    [_OwnerPeopletextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_BelieaveCodetextField.bottom).offset(10);
//        make.left.mas_equalTo(self.view.left).offset(10);
//        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-20, padding));
//    }];
//    [_OwnerCardtextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_OwnerPeopletextField.bottom).offset(10);
//        make.left.mas_equalTo(self.view.left).offset(10);
//        make.size.mas_equalTo(CGSizeMake(kDeviceWidth-20, padding));
//    }];
//        [_ownerLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_OwnerCardtextField.bottom).offset(10);
//            make.left.mas_equalTo(self.view.left).offset(10);
//            make.size.mas_equalTo(CGSizeMake(kDeviceWidth-20, 20));
//        }];
//        [_cardImageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_ownerLable.bottom).offset(10);
//            make.left.mas_equalTo(self.view.left).offset(10);
//            make.size.mas_equalTo(CGSizeMake((kDeviceWidth-30)/2, ((kDeviceWidth-30)/2)*0.75));
//        }];
//        [_cardImageIcon2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_ownerLable.bottom).offset(10);
//            make.left.mas_equalTo(_cardImageIcon.right).offset(10);
//            make.size.mas_equalTo(CGSizeMake((kDeviceWidth-30)/2, ((kDeviceWidth-30)/2)*0.75));
//        }];
    [_certyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ContactPhonetextField.bottom).offset(10);
        make.left.mas_equalTo(self.view.left).offset(10);
        make.size.mas_equalTo(CGSizeMake(280, 20));
    }];
    
    [_certyImgae mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_certyLable.bottom).offset(10);
        make.left.mas_equalTo(self.view.left).offset(10);
        make.size.mas_equalTo(CGSizeMake((kDeviceWidth-30)/2, ((kDeviceWidth-30)/2)*0.75));
    }];


}



#pragma mark - Getters & Setters
-(UIImageView *)cardImageIcon
{
    if (!_cardImageIcon) {
        _cardImageIcon = [[UIImageView alloc] init];
        _cardImageIcon.backgroundColor = [UIColor clearColor];
        _cardImageIcon.image = [UIImage imageNamed:@"front_image"];
        [_cardImageIcon setUserInteractionEnabled:YES];

    }
    return _cardImageIcon;
}

-(UIImageView *)cardImageIcon2
{
    if (!_cardImageIcon2) {
        _cardImageIcon2 = [[UIImageView alloc] init];
        _cardImageIcon2.backgroundColor = [UIColor clearColor];
        _cardImageIcon2.image = [UIImage imageNamed:@"con_Image_show"];
          [_cardImageIcon2 setUserInteractionEnabled:YES];

    }
    return _cardImageIcon2;
}
-(UIImageView *)certyImgae
{
    if (!_certyImgae) {
        _certyImgae = [[UIImageView alloc] init];
        _certyImgae.backgroundColor = [UIColor clearColor];
        _certyImgae.image = [UIImage imageNamed:@"applycircle"];
  [_certyImgae setUserInteractionEnabled:YES];
    }
    return _certyImgae;
}

-(UILabel *)ownerLable
{
    if (!_ownerLable) {
        _ownerLable = [[UILabel alloc] init];
        _ownerLable.backgroundColor = [UIColor clearColor];
        _ownerLable.text = @"法人身份证照片";
        _ownerLable.textColor = [UIColor lightGrayColor];
        _ownerLable.font = [UIFont systemFontOfSize:12];
        _ownerLable.textAlignment = NSTextAlignmentLeft;
        
    }
    return _ownerLable;
}
-(UILabel *)certyLable
{
    if (!_certyLable) {
        _certyLable = [[UILabel alloc] init];
        _certyLable.backgroundColor = [UIColor clearColor];
        _certyLable.text = @"营业执照";
        _certyLable.textColor = [UIColor lightGrayColor];
        _certyLable.font = [UIFont systemFontOfSize:12];
        _certyLable.textAlignment = NSTextAlignmentLeft;
        
    }
    return _certyLable;
}

- (UIScrollView*)myScrollerView
{
    if (!_myScrollerView) {
        _myScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
        _myScrollerView.delegate = self;
        _myScrollerView.backgroundColor = [UIColor whiteColor];
        _myScrollerView.contentSize = CGSizeMake(kDeviceWidth, KDeviceHeight+300) ;
    }
    return _myScrollerView;
}



- (MFTextField*)ComplanytextField
{
    if (!_ComplanytextField) {
        _ComplanytextField = [[MFTextField alloc] init];
        _ComplanytextField.delegate = self;
_ComplanytextField.clearButtonMode = UITextFieldViewModeAlways;
        _ComplanytextField.tintColor = [UIColor LkbBtnColor];
        _ComplanytextField.textColor = CCCUIColorFromHex(0x333333);
        _ComplanytextField.placeholderAnimatesOnFocus = YES;
             [_ComplanytextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        UIFontDescriptor * fontDescriptor = [self.ComplanytextField.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
        UIFont *font = [UIFont fontWithDescriptor:fontDescriptor size:self.ComplanytextField.font.pointSize];
        
        self.ComplanytextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"单位名称" attributes:@{NSFontAttributeName:font}];
        
    }
    return _ComplanytextField;
}

#pragma mark - Getters & Setters
- (MFTextField*)ContactPeopletextField
{
    if (!_ContactPeopletextField) {
        _ContactPeopletextField = [[MFTextField alloc] init];
        _ContactPeopletextField.delegate = self;
        _ContactPeopletextField.clearButtonMode = UITextFieldViewModeAlways;
        _ContactPeopletextField.tintColor = [UIColor mf_greenColor];
        _ContactPeopletextField.textColor = [UIColor mf_veryDarkGrayColor];
        _ContactPeopletextField.placeholderAnimatesOnFocus = YES;
        
            [_ContactPeopletextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UIFontDescriptor * fontDescriptor = [self.ContactPeopletextField.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
        UIFont *font = [UIFont fontWithDescriptor:fontDescriptor size:self.ContactPeopletextField.font.pointSize];
        
        self.ContactPeopletextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"联系人" attributes:@{NSFontAttributeName:font}];
        
    }
    return _ContactPeopletextField;
}

#pragma mark - Getters & Setters
- (MFTextField*)ContactPhonetextField{
    if (!_ContactPhonetextField) {
        _ContactPhonetextField = [[MFTextField alloc] init];
        _ContactPhonetextField.delegate = self;
        _ContactPhonetextField.clearButtonMode = UITextFieldViewModeAlways;

        _ContactPhonetextField.tintColor = [UIColor mf_greenColor];
        _ContactPhonetextField.textColor = [UIColor mf_veryDarkGrayColor];
        _ContactPhonetextField.placeholderAnimatesOnFocus = YES;
              [_ContactPhonetextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        UIFontDescriptor * fontDescriptor = [self.ContactPhonetextField.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
        UIFont *font = [UIFont fontWithDescriptor:fontDescriptor size:self.ContactPhonetextField.font.pointSize];
        
        self.ContactPhonetextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"联系人手机" attributes:@{NSFontAttributeName:font}];
        
    }
    return _ContactPhonetextField;
}

#pragma mark - Getters & Setters
- (MFTextField*)OwnerCardtextField{
    if (!_OwnerCardtextField) {
        _OwnerCardtextField = [[MFTextField alloc] init];
        _OwnerCardtextField.delegate = self;
        _OwnerCardtextField.clearButtonMode = UITextFieldViewModeAlways;
        _OwnerCardtextField.tintColor = [UIColor mf_greenColor];
        _OwnerCardtextField.textColor = [UIColor mf_veryDarkGrayColor];
        _OwnerCardtextField.placeholderAnimatesOnFocus = YES;
        
          [_OwnerCardtextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UIFontDescriptor * fontDescriptor = [self.OwnerCardtextField.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
        UIFont *font = [UIFont fontWithDescriptor:fontDescriptor size:self.OwnerCardtextField.font.pointSize];
        
        self.OwnerCardtextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"法人身份证" attributes:@{NSFontAttributeName:font}];
        
    }
    return _OwnerCardtextField;
}

- (MFTextField*)OwnerPeopletextField{
    if (!_OwnerPeopletextField) {
        _OwnerPeopletextField = [[MFTextField alloc] init];
        _OwnerPeopletextField.delegate = self;
        _OwnerPeopletextField.clearButtonMode = UITextFieldViewModeAlways;
        _OwnerPeopletextField.tintColor = [UIColor mf_greenColor];
        _OwnerPeopletextField.textColor = [UIColor mf_veryDarkGrayColor];
        _OwnerPeopletextField.placeholderAnimatesOnFocus = YES;
            [_OwnerPeopletextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        UIFontDescriptor * fontDescriptor = [self.OwnerPeopletextField.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
        UIFont *font = [UIFont fontWithDescriptor:fontDescriptor size:self.OwnerPeopletextField.font.pointSize];
        
        self.OwnerPeopletextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"法人代表" attributes:@{NSFontAttributeName:font}];
        
    }
    return _OwnerPeopletextField;
}

- (MFTextField*)BelieaveCodetextField{
    if (!_BelieaveCodetextField) {
        _BelieaveCodetextField = [[MFTextField alloc] init];
        _BelieaveCodetextField.delegate = self;
        _BelieaveCodetextField.clearButtonMode = UITextFieldViewModeAlways;
        _BelieaveCodetextField.tintColor = [UIColor mf_greenColor];
        _BelieaveCodetextField.textColor = [UIColor mf_veryDarkGrayColor];
        _BelieaveCodetextField.placeholderAnimatesOnFocus = YES;
        
         [_BelieaveCodetextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UIFontDescriptor * fontDescriptor = [self.BelieaveCodetextField.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
        UIFont *font = [UIFont fontWithDescriptor:fontDescriptor size:self.BelieaveCodetextField.font.pointSize];
        
        self.BelieaveCodetextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"组织机构代码/唯一社会信用代码" attributes:@{NSFontAttributeName:font}];
        
    }
    return _BelieaveCodetextField;
}
- (void)setupTextField5
{
    [self validateTextField5Animated:NO];
}

#pragma mark - Actions

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder]; return YES;
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.ComplanytextField) {
        [self validateComplanytextField];
    }
    else if (textField == self.ContactPeopletextField) {
        [self validateContactPeopletextField];
    }
    else if (textField == self.ContactPhonetextField) {
        [self validateContactPhonetextField];
    }
    else if (textField == self.BelieaveCodetextField) {
        [self validateBelieaveCodetextField];
    }
    else if (textField == self.OwnerPeopletextField) {
        [self validateOwnerPeopletextField];
    }
    else if (textField == self.OwnerCardtextField) {
//        [self validateTextField5Animated:YES];
         [self validateOwnerCardtextFiled];

    }
    
}
- (void)validateComplanytextField
{
    NSError *error = nil;
    if (![self validateComplanytextFieldIsValid]) {
        error = [self errorWithLocalizedDescription:@"单位名称：1-20个字."];
    }
    [self.ComplanytextField setError:error animated:YES];
}

- (void)validateContactPeopletextField
{
    NSError *error = nil;
    if (![self validateContactPeopletextFieldIsValid]) {
        error = [self errorWithLocalizedDescription:@"联系人：1-10个字."];
    }
    [self.ContactPeopletextField setError:error animated:YES];
}

- (void)validateContactPhonetextField
{
    NSError *error = nil;
    if (![self validateContactPhonetextFieldIsValid]) {
        error = [self errorWithLocalizedDescription:@"手机号未填或格式不正确."];
    }
    [self.ContactPhonetextField setError:error animated:YES];
}

- (void)validateBelieaveCodetextField
{
    NSError *error = nil;
    if (![self validateBelieaveCodetextFieldIsValid]) {
        error = [self errorWithLocalizedDescription:@"组织机构代码证：9位或18位字符"];
    }
    [self.BelieaveCodetextField setError:error animated:YES];
}



- (void)validateOwnerPeopletextField
{
    NSError *error = nil;
    if (![self validateOwnerPeopletextFieldIsValid]) {
        error = [self errorWithLocalizedDescription:@"法人代表：1-10个字"];
    }
    [self.OwnerPeopletextField setError:error animated:YES];
}

- (void)validateOwnerCardtextFiled
{
    NSError *error = nil;
    if (![self validateOwnerCardtextFieldIsValid]) {
        error = [self errorWithLocalizedDescription:@"身份证格式不正确."];
    }
    [self.OwnerCardtextField setError:error animated:YES];
}






//公司名字
-(BOOL)validateComplanytextFieldIsValid
{
    
    return self.ComplanytextField.text.length > 0 &&self.ComplanytextField.text.length<20;
}
//联系人
-(BOOL)validateContactPeopletextFieldIsValid
{
    
    return self.ContactPeopletextField.text.length > 0 &&self.ContactPeopletextField.text.length<11;
}



//手机格式
-(BOOL)validateContactPhonetextFieldIsValid
{
    
    return [self validateMobile:_ContactPhonetextField.text]==YES;
    

}


-(BOOL)validateBelieaveCodetextFieldIsValid
{
    
    return self.BelieaveCodetextField.text.length > 8 &&self.BelieaveCodetextField.text.length<19;
}


-(BOOL)validateOwnerPeopletextFieldIsValid
{
    
    return self.OwnerPeopletextField.text.length > 0 &&self.OwnerPeopletextField.text.length<11;
}


-(BOOL)validateOwnerCardtextFieldIsValid
{
    
    return [self validateIdentityCard:_OwnerCardtextField.text]==YES;
}

#pragma mark - Text field validation

- (void)validateTextField1
{
    NSError *error = nil;
    if (![self textField1IsValid]) {
        error = [self errorWithLocalizedDescription:@"Maximum of 6 characters allowed."];
    }
    [self.ContactPeopletextField setError:error animated:YES];
}

- (void)validateTextField2
{
    NSError *error = nil;
    if (![self textField2IsValid]) {
        error = [self errorWithLocalizedDescription:@"This is an error message that is really long and should wrap onto 2 or more lines."];
    }
    [self.ContactPhonetextField setError:error animated:YES];
}





- (void)validateTextField5Animated:(BOOL)animated
{
    NSError *error = nil;
    if (![self textField5IsValid]) {
        error = [self errorWithLocalizedDescription:@"An error message"];
    }
    [self.OwnerCardtextField setError:error animated:animated];
}

- (BOOL)textField1IsValid
{
    return self.ContactPeopletextField.text.length <= 6;
}

- (BOOL)textField2IsValid
{
    return self.ContactPhonetextField.text.length < 3;
}

- (BOOL)textField5IsValid
{
    return self.OwnerCardtextField.text.length > 0;
}

- (NSError *)errorWithLocalizedDescription:(NSString *)localizedDescription
{
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: localizedDescription};
       NSLog(@"%@",userInfo[@"NSLocalizedDescription"]);
    return [NSError errorWithDomain:MFDemoErrorDomain code:MFDemoErrorCode userInfo:userInfo];
 
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//验证身份证
- (BOOL) validateIdentityCard: (NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
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
