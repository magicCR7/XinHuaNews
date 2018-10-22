//
//  SubCenterLeftTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/16.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SubCenterLeftTableViewCell.h"

@implementation SubCenterLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UILabel *midLab = [UILabel new];
    midLab.text = @"视点";
    midLab.textAlignment = NSTextAlignmentCenter;
    midLab.font = [UIFont systemFontOfSize:LittleFontSize];
    [self.contentView addSubview:midLab];
    self.midLabel = midLab;
    [self.midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.height.equalTo(@40);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _midLabel.textColor = DominantColor;
        _midLabel.font = [UIFont systemFontOfSize:NormalFontSize weight:NormalFontSize];
    } else {
        _midLabel.textColor = [UIColor blackColor];
        _midLabel.font = [UIFont systemFontOfSize:LittleFontSize];
    }
}

@end
