//
//  RecommendationView.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/10.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "RecommendationView.h"

@implementation RecommendationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        self.backgroundColor = [UIColor whiteColor];
        //v.layer.masksToBounds=YES;这行去掉
        self.layer.cornerRadius = 5;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1,1);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 5;
        
    }
    return self;
}

- (void)setupViews {
    UIImageView *iconImageV = [UIImageView new];
    [iconImageV setImage:[UIImage imageNamed:@"xinHuaShiDian"]];
    iconImageV.layer.masksToBounds = YES;
    iconImageV.layer.cornerRadius = 20;
    [self addSubview:iconImageV];
    self.iconImageView = iconImageV;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.centerX.offset(0);
        make.width.height.equalTo(@40);
    }];
    
    UILabel *nameLab = [UILabel new];
    nameLab.text = @"新华视点";
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = [UIFont systemFontOfSize:SmallFontSize];
    [self addSubview:nameLab];
    self.nameLabel = nameLab;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        make.width.equalTo(@(self.x_width - 20));
        make.height.equalTo(@(LittleFontSize));
    }];
    
    UILabel *countLab = [UILabel new];
    countLab.text = @"48497人订阅";
    countLab.textColor = DominantGrayColor;
    countLab.textAlignment = NSTextAlignmentCenter;
    countLab.font = [UIFont systemFontOfSize:SmallFontSize];
    [self addSubview:countLab];
    self.countLabel = countLab;
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(3);
        make.width.equalTo(@(self.x_width - 20));
        make.height.equalTo(@(LittleFontSize));
    }];
    
    UIButton *botBtn = [UIButton new];
    botBtn.backgroundColor = DominantColor;
    [botBtn setTitle:@"+订阅" forState:UIControlStateNormal];
    botBtn.titleLabel.font = [UIFont systemFontOfSize:LittleFontSize];
    botBtn.layer.masksToBounds = YES;
    botBtn.layer.cornerRadius = 15;
    [self addSubview:botBtn];
    self.botButton = botBtn;
    [self.botButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@70);
        make.height.equalTo(@30);
        make.centerX.offset(0);
        make.bottom.offset(-10);
    }];
    
}

- (void)subBtnClicked:(UIButton *)sender {
    sender.selected =! sender.selected;
    if (sender.selected) {
        sender.backgroundColor = RGB(125, 143, 158, 1);
        [sender setTitle:@"已订阅" forState:UIControlStateSelected];
    } else {
        sender.backgroundColor = DominantColor;
    }
}

@end
