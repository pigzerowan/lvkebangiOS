//
//  HoeStandingCell.m
//  greenkebang
//
//  Created by 徐丽霞 on 16/7/19.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import "HoeStandingCell.h"
#import <UIImageView+WebCache.h>

@implementation HoeStandingCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createUI];
    }
    return self;
}

- (void)configHoeListTableCellWithGoodModel:(HoeListModelDetailModel *)admirGood {
    
    
    [self.headerImage sd_setImageWithURL:[admirGood.cover lkbImageUrlChuHeShuoCover] placeholderImage:YQNormalPlaceImage];
    
    
    _authorLabel.text = admirGood.source;
    
    _titleLabel.text = admirGood.title;
    //    _contentLabel.text = admirGood.remark;
    _goodNum.text = admirGood.starNum;
    _joinNum.hidden = YES;
    
}

- (void)configActivityListTableCellWithGoodModel:(ActivityListDetailModel *)admirGood {
    
    [self.headerImage sd_setImageWithURL:[admirGood.img lkbImageUrlActivityCover] placeholderImage:YQNormalPlaceImage];

    
    _authorLabel.hidden = YES;
    _goodImage.hidden = YES;
    _goodNum.hidden = YES;
    _back.hidden = YES;
    _titleLabel.text = admirGood.name;
    _contentLabel.text = admirGood.context;
    
    NSLog(@"-------------------------------------%@",admirGood.status);
    
    // 即将开始
    if ([admirGood.status isEqualToString:@"0"]) {
        _joinNum.text = [NSString stringWithFormat:@"%@人已报名",admirGood.countNum];
    }
    if ([admirGood.status isEqualToString:@"3"]) {
        _joinNum.text = [NSString stringWithFormat:@"%@人正在参与",admirGood.countNum];
    }
    if ([admirGood.status isEqualToString:@"2"]) {
        _joinNum.text = [NSString stringWithFormat:@"共%@人参与",admirGood.countNum];
    }



    
}



//重点在这里
- (void)createUI{
    
    self.contentView.backgroundColor = CCCUIColorFromHex(0xf7f7f7);
    //创建一个UIView比self.contentView小一圈
    if (iPhone5) {
        self.bgView  = [[UIView alloc] initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH -32, 162)];
        
    }
    else if (iPhone6p){
        self.bgView  = [[UIView alloc] initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH -32, 260)];
        
    }else {
        self.bgView  = [[UIView alloc] initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH -32, 181)];
        
    }
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 4;

    //给bgView边框设置阴影
    self.bgView.layer.shadowOffset = CGSizeMake(0,2);
    self.bgView.layer.shadowOpacity = 0.05;
    self.bgView.layer.shadowRadius = 3;
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (iPhone5) {
        _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 32, 99)];

    }
    else if (iPhone6p){
        _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -32, 197)];

    }
    else {
        
        _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -32, 117)];

    }
    _headerImage.layer.cornerRadius = 4;
    _headerImage.backgroundColor = CCCUIColorFromHex(0xdddddd);

    
    _back =[[UIImageView alloc]init];
    
    if (iPhone5) {
        _back.frame = CGRectMake(0, 0, SCREEN_WIDTH - 32, 99);
        
    }
    else if (iPhone6p){
        _back.frame = CGRectMake(0, 0, SCREEN_WIDTH -32, 197);
        
    }
    else {
        
        _back.frame = CGRectMake(0, 0, SCREEN_WIDTH -32, 117);
        
    }
    _back.image = [UIImage imageNamed:@"Discover-_bg"];

    
    
    if (iPhone5) {
        _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(14,79, SCREEN_WIDTH - 85 -20, 14)];
        
    }
    else if (iPhone6p){
        _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(14,177, SCREEN_WIDTH - 85 -20, 14)];
        
    }
    else {
        
        _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(14,97, SCREEN_WIDTH - 85 -20, 14)];
        
    }

    _authorLabel.font = [UIFont systemFontOfSize:11];
    _authorLabel.textColor = [UIColor whiteColor];
    
    if (iPhone5) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,114, SCREEN_WIDTH - 85 -20 -50-10 , 18)];
        
    }
    else if (iPhone6p){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,212, SCREEN_WIDTH - 85 -20 -50-10, 18)];
        
    }
    else {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,132, SCREEN_WIDTH - 85 -20 -50 - 10, 18)];
        
    }

    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = CCCUIColorFromHex(0x333333);

    if (iPhone5) {
        
        _goodImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 68, 113, 14, 14)];
        
    }
    else if (iPhone6p){
        _goodImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 68, 211, 14, 14)];
        
    }
    else {
        
        _goodImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 68, 131, 14, 14)];
        
    }
    _goodImage.image = [UIImage imageNamed:@"icon_like_nor"];
    
    
    if (iPhone5) {
        
        _goodNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -49, 112, 20, 20)];
        
    }
    else if (iPhone6p){
        _goodNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -49, 210, 20, 20)];
        
    }
    else {
        
        _goodNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -49, 130, 20, 20)];
        
    }
    _goodNum.textColor = CCCUIColorFromHex(0x999999);
    _goodNum.font = [UIFont systemFontOfSize:11];
    
    if (iPhone5) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 134, 230, 20)];
    }
    else if (iPhone6p){
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 232, 230, 20)];
        
    }
    else {
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 152,210, 20)];
        
    }

    _contentLabel.font = [UIFont systemFontOfSize:11];
    _contentLabel.textColor = CCCUIColorFromHex(0x999999);
    

    if (iPhone5) {
        
        _joinNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH  - 32 - 100 -14,114, 100, 18)];
        
    }
    else if (iPhone6p){
        _joinNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH  - 20 - 100,212, 100, 18)];
        
    }
    else {
        
        _joinNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH  - 32 - 100 -14,132, 100, 18)];
        
    }

    _joinNum.font  = [UIFont systemFontOfSize:11];
    _joinNum.textAlignment = NSTextAlignmentRight;
    _joinNum.textColor = CCCUIColorFromHex(0x999999);
    

    
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.headerImage];
    [self.headerImage addSubview:_back];
    [self.headerImage addSubview:self.authorLabel];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.goodImage];
    [self.bgView addSubview:self.goodNum];
    [self.bgView addSubview:self.contentLabel];
    [self.bgView addSubview:self.joinNum];

}

+ (CGFloat)getHeight{
    //在这里能计算高度，动态调整
    if (iPhone5) {
        return 162;
    }
    else if (iPhone6p) {
        return 260;
    }
    else {
        return 181;
    }
}



















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
