//
//  SecretTableViewCell.m
//  greenkebang
//
//  Created by 郑渊文 on 11/30/15.
//  Copyright © 2015 transfar. All rights reserved.
//
#import "SecretModel.h"
#import "SecretTableViewCell.h"
#import "UIImageView+EMWebCache.h"

@interface SecretTableViewCell ()
@property (strong, nonatomic) UIView* textBackView;
@property (strong, nonatomic) UIView* toReadView;
@end
@implementation SecretTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubview];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.layer.borderWidth=1;
        self.layer.borderColor = CCColorFromRGBA(242, 243, 247, 1).CGColor;
        self.layer.cornerRadius = 0.5f;
        
    }
    return self;
}

//#pragma mark - Public methods
//- (void)configDiscoveryRecommCellWithModel:(SecretModel *)simleTopic
//{
//    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:simleTopic.imgUrl] placeholderImage:LKBSecruitPlaceImage];
////    [self.coverImageView sd_setImageWithURL:simleTopic.imgUrl placeholderImage:LKBSecruitPlaceImage];
//    self.titleLabel.text = simleTopic.title;
//    
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
//}

#pragma mark - Event response
- (void)loveButtonDidClicked:(id)sender
{
    
}

#pragma maek - SubViews
- (void)configureSubview
{

    [self.contentView addSubview:self.textBackView];
    [self.contentView addSubview:self.coverImageView];
    
    [self.contentView addSubview:self.toReadView];
    [self.toReadView addSubview:self.readLabel];
    [self.textBackView addSubview:self.titleLabel];
    [self.textBackView addSubview:self.numLabel];
    [self.textBackView addSubview:self.loveButton];
    self.numLabel.hidden = YES;
}
- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [_textBackView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.left.right.mas_equalTo(self.contentView);

            make.size.mas_equalTo(CGSizeMake(kDeviceWidth, 40));
        }];
        
        [_coverImageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_textBackView.bottom).offset(10);
            //             make.bottom.mas_equalTo(self.contentView);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(120);
        }];

        [_loveButton mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(_textBackView);
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.right.mas_equalTo(_loveButton.left).offset(-2);
            make.centerY.mas_equalTo(_textBackView);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.mas_equalTo(10).priorityLow();
            make.right.mas_equalTo(_numLabel.left);
            make.centerY.mas_equalTo(_textBackView);
        }];
        [_toReadView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(_coverImageView.bottom);
            make.size.mas_equalTo(CGSizeMake(kDeviceWidth, 40));
        }];

        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - Getters & Setters
- (UIView*)textBackView
{
    if (!_textBackView) {
        _textBackView = [[UIView alloc] init];
        _textBackView.backgroundColor = [UIColor whiteColor];
    }
    return _textBackView;
}

- (UIView*)toReadView
{
    if (!_toReadView) {
        _toReadView = [[UIView alloc] init];
        _toReadView.backgroundColor = [UIColor whiteColor];
    }
    return _toReadView;
}


- (UIImageView*)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.clipsToBounds = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLabel;
}

- (UILabel*)readLabel
{
    if (!_readLabel) {
        _readLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth/2,30 )];
        _readLabel.numberOfLines = 1;
        _readLabel.font = [UIFont systemFontOfSize:14];
        _readLabel.textColor = [UIColor blackColor];
        _readLabel.text = @"阅读全文";
        _readLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _readLabel;
}

- (UILabel*)numLabel
{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.numberOfLines = 1;
        _numLabel.font = [UIFont systemFontOfSize:14];
        _numLabel.textColor = [UIColor spotColor];
        _numLabel.textAlignment = NSTextAlignmentRight;
        _numLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _numLabel;
}
- (UIButton*)loveButton
{
    if (!_loveButton) {
        _loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loveButton setImage:[UIImage imageNamed:@"yq_love_small.png"] forState:UIControlStateNormal];
        _loveButton.hidden = YES;
        [_loveButton setImage:[UIImage imageNamed:@"yq_love_small_select.png"] forState:UIControlStateSelected];
        [_loveButton addTarget:self action:@selector(loveButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveButton;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


@end
