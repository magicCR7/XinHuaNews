//
//  SubscribeTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/29.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SubscribeTableViewCell.h"

@implementation SubscribeTableViewCell

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
    UIImageView *leftImageV = [UIImageView new];
    [leftImageV setImage:[UIImage imageNamed:@"xinHuaShiDian"]];
    [self.contentView addSubview:leftImageV];
    self.leftImageView = leftImageV;
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.height.width.equalTo(@40);
    }];
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"新华视点";
    titleLab.textColor = [UIColor blackColor];
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:NormalFontSize]];
    [self.contentView addSubview:titleLab];
    self.titleLabel = titleLab;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.left.equalTo(self.leftImageView.mas_right).offset(10);
        make.width.greaterThanOrEqualTo(@30);
        make.top.offset(15);
    }];

    UILabel *detailLab = [UILabel new];
    detailLab.text = @"沈阳推广智能快件箱进小区 打通快递最后100米";
    detailLab.textColor = DominantGrayColor;
    detailLab.font = [UIFont systemFontOfSize:SmallFontSize];
    [self.contentView addSubview:detailLab];
    self.detailLabel = detailLab;
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.height.equalTo(@12);
        make.right.offset(-10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
        make.bottom.offset(-8);
    }];
    
    UILabel *rightLab = [UILabel new];
    rightLab.text = @"新华号";
    rightLab.textAlignment = NSTextAlignmentCenter;
    rightLab.layer.masksToBounds = YES;
    rightLab.layer.cornerRadius = 2;
    rightLab.layer.borderWidth = 1;
    rightLab.layer.borderColor = DominantColor.CGColor;
    rightLab.textColor = DominantColor;
    rightLab.font = [UIFont systemFontOfSize:TinyFontSize];
    [self.contentView addSubview:rightLab];
    self.rightLabel = rightLab;
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.height.equalTo(@(SmallFontSize));
        make.width.greaterThanOrEqualTo(@20);
    }];
    [self.rightLabel layoutIfNeeded];
    [self.rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.rightLabel.x_width + 5));
    }];
    
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"10:33";
    timeLab.textColor = DominantGrayColor;
    timeLab.font = [UIFont systemFontOfSize:SmallFontSize];
    [self.contentView addSubview:timeLab];
    self.timeLabel = timeLab;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@12);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.offset(-10);
        make.width.greaterThanOrEqualTo(@10);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
