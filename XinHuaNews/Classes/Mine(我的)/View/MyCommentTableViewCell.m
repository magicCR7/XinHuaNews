//
//  MyCommentTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/29.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "MyCommentTableViewCell.h"

@interface MyCommentTableViewCell()

@property (nonatomic, strong) UIView *bottomView;

@end

@implementation MyCommentTableViewCell

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
    UIImageView *headerImageV = [UIImageView new];
    headerImageV.layer.masksToBounds = YES;
    headerImageV.layer.cornerRadius = 20;
    [headerImageV setImage:[UIImage imageNamed:@"3"]];
    [self.contentView addSubview:headerImageV];
    self.headerImageView = headerImageV;
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(padding);
        make.height.width.equalTo(@35);
    }];
    
    UILabel *nameLab = [UILabel new];
    nameLab.text = @"188****1234";
    nameLab.textColor = DominantColor;
    nameLab.font = [UIFont systemFontOfSize:SmallFontSize];
    [self.contentView addSubview:nameLab];
    self.nameLabel = nameLab;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).offset(5);
        make.top.equalTo(self.headerImageView).offset(2);
        make.width.greaterThanOrEqualTo(@20);
        make.height.equalTo(@14);
    }];
    
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"2018-09-20 14:22";
    timeLab.font = [UIFont systemFontOfSize:TinyFontSize];
    timeLab.textColor = DominantGrayColor;
    [self.contentView addSubview:timeLab];
    self.timeLabel = timeLab;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.height.equalTo(@12);
        make.bottom.equalTo(self.headerImageView).offset(-2);
        make.width.greaterThanOrEqualTo(@20);
    }];
    
//    评论内容
    UILabel *detailLab = [UILabel new];
    detailLab.text = @"五十六个民族是一家";
    detailLab.font = [UIFont systemFontOfSize:NormalFontSize];
    [self.contentView addSubview:detailLab];
    self.detailLabel = detailLab;
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel);
        make.top.equalTo(self.headerImageView.mas_bottom).offset(padding);
        make.height.equalTo(@(NormalFontSize));
        make.right.offset(-padding);
    }];
    
    UIView *bottomV = [UIView new];
    bottomV.backgroundColor = RGB(239, 239, 239, 1);
    [self.contentView addSubview:bottomV];
    self.bottomView = bottomV;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailLabel).offset(2);
        make.height.equalTo(@(LittleFontSize*2 + 12));
        make.right.offset(-padding);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(8);
        make.bottom.offset(-5);
    }];
    
    UIView *lineView = [UIView new];
    lineView.layer.masksToBounds = YES;
    lineView.layer.cornerRadius = 1.5f;
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.equalTo(@3);
    }];
    
    //文章标题
    UILabel *titleLab = [UILabel new];
    titleLab.numberOfLines = 2;
    titleLab.text = @"纵马如飞 高空炫技：带你看新疆最“好玩”的运动会";
    titleLab.font = [UIFont systemFontOfSize:LittleFontSize];
    titleLab.textColor = DominantGrayColor;
    [self.bottomView addSubview:titleLab];
    self.titleLabel = titleLab;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.top.offset(3);
        make.right.offset(-3);
        make.height.greaterThanOrEqualTo(@(SmallFontSize));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
