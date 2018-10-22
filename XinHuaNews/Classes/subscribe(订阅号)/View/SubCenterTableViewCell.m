//
//  SubCenterTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/12.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SubCenterTableViewCell.h"

@implementation SubCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIImageView *headerImageV = [UIImageView new];
    headerImageV.layer.masksToBounds = YES;
    headerImageV.layer.cornerRadius = 20.0f;
    [headerImageV setImage:[UIImage imageNamed:@"xinHuaShiDian"]];
    [self.contentView addSubview:headerImageV];
    self.headerImageView = headerImageV;
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@40);
        make.left.top.offset(10);
        make.bottom.offset(-10);
    }];
   
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"新华视点";
    titleLab.font = [UIFont systemFontOfSize:NormalFontSize weight:LargeFontSize];
    [self.contentView addSubview:titleLab];
    self.titleLabel = titleLab;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView);
        make.width.greaterThanOrEqualTo(@20);
        make.height.equalTo(@(LargeFontSize));
        make.left.equalTo(self.headerImageView.mas_right).offset(10);
    }];
    
    UIButton *subBtn = [UIButton new];
    subBtn.backgroundColor = DominantColor;
    subBtn.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    [subBtn addTarget:self action:@selector(subBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [subBtn setTitle:@"+订阅" forState:UIControlStateNormal];
    subBtn.layer.masksToBounds = YES;
    subBtn.layer.cornerRadius = 12;
    [self.contentView addSubview:subBtn];
    self.subButton = subBtn;
    [self.subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(self.headerImageView);
        make.height.equalTo(@24);
        make.width.equalTo(@60);
    }];
    
    UILabel *detailLab = [UILabel new];
    detailLab.text = @"新华社新华视点栏目，重大新闻权威首发，环球信息即时播报。见证中国发展，领略世界精彩";
    detailLab.textColor = DominantGrayColor;
    detailLab.font = [UIFont systemFontOfSize:SmallFontSize];
    [self.contentView addSubview:detailLab];
    self.detailLabel = detailLab;
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerImageView);
        make.right.equalTo(self.subButton.mas_left).offset(-20);
        make.height.equalTo(@(NormalFontSize));
        make.left.equalTo(self.headerImageView.mas_right).offset(10);
    }];
    
    
    
    UIView *bottomLineView = [UIView new];
    bottomLineView.backgroundColor = lineColor;
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.bottom.offset(0);
        make.height.equalTo(@(0.8));
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
