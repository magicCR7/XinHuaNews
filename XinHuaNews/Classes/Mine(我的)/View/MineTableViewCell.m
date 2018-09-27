
//
//  MineTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/26.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *iconImageV = [UIImageView new];
    [iconImageV setImage:[UIImage imageNamed:@"mineYiJian"]];
    [self.contentView addSubview:iconImageV];
    self.iconImageView = iconImageV;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(25);
        make.bottom.offset(-20);
        make.width.height.equalTo(@18);
    }];
    
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"意见反馈";
    titleLab.textColor = [UIColor darkGrayColor];
    titleLab.font = [UIFont systemFontOfSize:NormalFontSize];
    [self.contentView addSubview:titleLab];
    self.titleLabel = titleLab;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.top.bottom.equalTo(self.iconImageView);
        make.height.greaterThanOrEqualTo(@40);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
