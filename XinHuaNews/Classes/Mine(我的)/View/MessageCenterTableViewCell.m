
//
//  MessageCenterTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/27.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "MessageCenterTableViewCell.h"

@implementation MessageCenterTableViewCell

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
    CGFloat padding = 8.0f;
    
    UILabel *mainLab = [UILabel new];
    mainLab.numberOfLines = 0;
    mainLab.text = @"夜览|改革开放40年：从200人一部电话到一人一部手机；有利抢，无利躲，有些“油腻干部”热衷蹭扶贫；10月1日起去超市买东西，一定要看清这个标识>>";
    mainLab.font = [UIFont systemFontOfSize:NormalFontSize];
    [self.contentView addSubview:mainLab];
    self.mainLabel = mainLab;
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.right.offset(-padding);
        make.left.offset(padding);
        make.height.greaterThanOrEqualTo(@1);
    }];
    [self.mainLabel layoutIfNeeded];
    [self.mainLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.mainLabel.x_height + 10));
    }];
    
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"18-09-26 21:58";
    timeLab.textColor = DominantGrayColor;
    timeLab.font = [UIFont systemFontOfSize:TinyFontSize];
    [self.contentView addSubview:timeLab];
    self.timeLabel = timeLab;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainLabel.mas_left);
        make.height.equalTo(@12);
        make.width.equalTo(@200);
        make.bottom.offset(-padding);
        make.top.equalTo(self.mainLabel.mas_bottom).offset(padding);
    }];
    
    UIImageView *logoImageV = [UIImageView new];
    [logoImageV setImage:[UIImage imageNamed:@"messageCellLogo"]];
    [self.contentView addSubview:logoImageV];
    self.logoImageView = logoImageV;
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@20);
        make.bottom.equalTo(self.timeLabel.mas_bottom);
        make.right.offset(-padding);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
