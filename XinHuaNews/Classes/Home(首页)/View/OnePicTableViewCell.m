//
//  OnePicTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/25.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "OnePicTableViewCell.h"

@implementation OnePicTableViewCell

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
    CGFloat padding = 10.0f;
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"纸短情长——定制属于你的中秋独家记忆";
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:NormalFontSize]];
    [self.contentView addSubview:titleLab];
    self.titleLabel = titleLab;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(padding);
        make.right.offset(-padding);
        make.height.greaterThanOrEqualTo(@(NormalFontSize));
    }];

    UIImageView *mainImageV = [UIImageView new];
    [mainImageV setImage:[UIImage imageNamed:@"zhongQiu"]];
    [self.contentView addSubview:mainImageV];
    self.mainImageView = mainImageV;
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(padding);
        make.height.equalTo(@200);
    }];
    
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"18-09-24";
    timeLab.textColor = DominantGrayColor;
    timeLab.font = [UIFont systemFontOfSize:TinyFontSize];
    [self.contentView addSubview:timeLab];
    self.timeLabel = timeLab;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainImageView.mas_bottom).offset(padding);
        make.left.offset(padding);
        make.height.equalTo(@12);
        make.width.greaterThanOrEqualTo(@20);
        make.bottom.offset(-padding);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
