//
//  AdTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/21.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "AdTableViewCell.h"

@implementation AdTableViewCell

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
    UIImageView *adImageV = [UIImageView new];
    [adImageV setImage:[UIImage imageNamed:@"ad"]];
    [self.contentView addSubview:adImageV];
    self.adImageView = adImageV;
    [self.adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.height.equalTo(@80);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
