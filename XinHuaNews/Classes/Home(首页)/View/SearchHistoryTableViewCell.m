//
//  SearchHistoryTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/17.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SearchHistoryTableViewCell.h"

@implementation SearchHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"人大代表";
    titleLab.font = [UIFont systemFontOfSize:LittleFontSize];
    [self.contentView addSubview:titleLab];
    self.titleLabel = titleLab;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(18);
        make.width.greaterThanOrEqualTo(@20);
        make.height.equalTo(@40);
        make.top.bottom.offset(0);
    }];
    
    UIButton *deleteBtn = [UIButton new];
    [deleteBtn addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setImage:[UIImage imageNamed:@"delete_x"] forState:UIControlStateNormal];
    [self.contentView addSubview:deleteBtn];
    self.deleteButton = deleteBtn;
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.width.equalTo(@20);
        make.right.offset(-12);
    }];
}

- (void)deleteButtonClicked:(UIButton *)sender {
    if (self.deleteHistoryBlock) {
        self.deleteHistoryBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
