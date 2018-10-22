//
//  SpotHeraldTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/19.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SpotHeraldTableViewCell.h"

@interface SpotHeraldTableViewCell()

@property (nonatomic, strong) UIButton *orderButton;

@end

@implementation SpotHeraldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UILabel *titleLab = [UILabel new];
    titleLab.numberOfLines = 2;
    titleLab.text = @"“一带一路”倡议五周年|河内轻轨建设者筑梦一带一路";
    titleLab.font = [UIFont systemFontOfSize:NormalFontSize weight:NormalFontSize];
    [self.contentView addSubview:titleLab];
    self.titleLabel = titleLab;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(8);
        make.width.equalTo(@(self.contentView.x_width*3/4));
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = lineColor;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.width.equalTo(@1);
        make.height.equalTo(@90);
        make.top.offset(8);
        make.bottom.offset(-8);
    }];
    
    //视频直播
    UIButton *liveBtn = [UIButton new];
    [liveBtn setTitle:@" 视频直播" forState:UIControlStateNormal];
    [liveBtn setTitleColor:DominantGrayColor forState:UIControlStateNormal];
    [liveBtn setImage:[UIImage imageNamed:@"videoLive"] forState:UIControlStateNormal];
    liveBtn.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    [self.contentView addSubview:liveBtn];
    self.liveButton = liveBtn;
    [self.liveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.bottom.offset(-8);
        make.width.greaterThanOrEqualTo(@20);
        make.height.equalTo(@(SmallFontSize));
    }];
    
    //时间
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"18-12-08 09:30";
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.font = [UIFont systemFontOfSize:LittleFontSize];
    [self.contentView addSubview:timeLab];
    self.timeLabel = timeLab;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.height.equalTo(@(LittleFontSize));
        make.right.offset(0);
    }];
    
    //预约
    UIButton *orderBtn = [UIButton new];
    orderBtn.backgroundColor = DominantColor;
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    [orderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [orderBtn setTitle:@"+订阅" forState:UIControlStateNormal];
    orderBtn.layer.masksToBounds = YES;
    orderBtn.layer.cornerRadius = 12;
    [self.contentView addSubview:orderBtn];
    self.orderButton = orderBtn;
    [self.orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@24);
        make.bottom.offset(-15);
        make.centerX.equalTo(self.timeLabel);
    }];
}

- (void)orderBtnClicked:(UIButton *)sender {
    sender.selected =! sender.selected;
    if (sender.selected) {
        sender.backgroundColor = RGB(125, 143, 158, 1);
        [sender setTitle:@"已预约" forState:UIControlStateSelected];
    } else {
        sender.backgroundColor = DominantColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
