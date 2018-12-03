//
//  TwoPicNewsTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/22.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "TwoPicNewsTableViewCell.h"

@implementation TwoPicNewsTableViewCell

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
    //titleLabel
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"春风拂面 阳光明媚:带你看最生动美丽的野外美景";
    titleLabel.numberOfLines = 0;
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:NormalFontSize]];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(padding);
        make.top.equalTo(self.contentView.mas_top).offset(padding);
        make.right.equalTo(self.contentView.mas_right).offset(-padding);
        make.height.greaterThanOrEqualTo(@50);
    }];
    
    //authorLab
    UILabel *authorLab = [UILabel new];
    authorLab.text = @"新华社";
    authorLab.textColor = DominantColor;
    authorLab.font = [UIFont systemFontOfSize:SmallFontSize];
    [self.contentView addSubview:authorLab];
    self.authorLabel = authorLab;
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(padding);
        make.left.equalTo(self.titleLabel.mas_left);
        make.height.equalTo(@12);
        make.width.greaterThanOrEqualTo(@10);
    }];
    
    //timeLab
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"发布于 26分钟前";
    timeLab.textColor = DominantGrayColor;
    timeLab.font = [UIFont systemFontOfSize:SmallFontSize];
    [self.contentView addSubview:timeLab];
    self.timeLabel = timeLab;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(padding);
        make.right.offset(-padding);
        make.height.equalTo(@12);
        make.width.greaterThanOrEqualTo(@10);
    }];
    
    //lineImage
    UIImageView *lineImageV = [UIImageView new];
    [lineImageV setImage:[UIImage imageNamed:@"news_line"]];
    [self.contentView addSubview:lineImageV];
    self.lineImageView = lineImageV;
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorLabel.mas_bottom).offset(padding);
        make.left.right.offset(0);
        make.height.equalTo(@12);
    }];
    
    //左上图
    UIImageView *leftImageV = [UIImageView new];
    [leftImageV setImage:[UIImage imageNamed:@"3"]];
    [self.contentView addSubview:leftImageV];
    self.leftImageView = leftImageV;
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@140);
        make.left.offset(0);
        make.right.equalTo(self.contentView.mas_centerX).offset(-1);
        make.top.equalTo(self.lineImageView.mas_bottom).offset(padding);
    }];
    
    //右上图
    UIImageView *rightImageV = [UIImageView new];
    [rightImageV setImage:[UIImage imageNamed:@"3"]];
    [self.contentView addSubview:rightImageV];
    self.rightImageView = rightImageV;
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@140);
        make.right.offset(0);
        make.left.equalTo(self.contentView.mas_centerX).offset(1);
        make.top.equalTo(self.lineImageView.mas_bottom).offset(padding);
    }];
    
    
    
    //    detailLab
    UILabel *detailLab = [UILabel new];
    detailLab.text = @"蒲公英是多年生宿根性植物，野生条件下二年生植株就能开花结籽，初夏为开花结数随生长年限而增多。";
    detailLab.font = [UIFont systemFontOfSize:LittleFontSize];
    detailLab.numberOfLines = 0;
    [self.contentView addSubview:detailLab];
    self.detailLabel = detailLab;
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImageView.mas_bottom).offset(padding);
        make.left.equalTo(self.contentView.mas_left).offset(padding);
        make.right.equalTo(self.contentView.mas_right).offset(-padding);
        make.height.greaterThanOrEqualTo(@34);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-padding);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
