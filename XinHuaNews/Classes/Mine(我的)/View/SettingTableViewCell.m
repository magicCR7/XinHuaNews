
//
//  SettingTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/27.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

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
    UILabel *rightLabel = [[UILabel alloc] init]; //定义一个在cell最右边显示的label
    rightLabel.hidden = YES;
    rightLabel.font = [UIFont boldSystemFontOfSize:LittleFontSize];
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.textColor = DominantGrayColor;
    [self.contentView addSubview:rightLabel];
    self.rightLabel = rightLabel;
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@15);
        make.width.greaterThanOrEqualTo(@20);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
