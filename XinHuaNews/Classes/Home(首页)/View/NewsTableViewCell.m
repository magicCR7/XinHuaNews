//
//  NewsTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/19.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化子视图
        [self setupViews];
    }
    return self;
}

//#pragma mark - 重写frame
//- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 10;
//    frame.origin.y += 10;
//    frame.size.height -= 20;
//    frame.size.width -= 20;
//    [super setFrame:frame];
//}

- (void)setupViews {
    float padding = 8.0;

    UIImageView *newsImageV = [UIImageView new];
    [newsImageV setImage:[UIImage imageNamed:@"3"]];
    [self.contentView addSubview:newsImageV];
    self.newsImageView = newsImageV;
    
    [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.width.equalTo(@130);
        make.height.equalTo(@110);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"习近平致信祝贺2018世界人工智能大会开幕";
    titleLabel.numberOfLines = 0;
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:NormalFontSize]];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.top.equalTo(self.newsImageView.mas_top).offset(padding);
        make.height.greaterThanOrEqualTo(@16);
        make.right.equalTo(self.newsImageView.mas_left).offset(-padding);
    }];
    
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"18-09-17";
    timeLab.textColor = DominantGrayColor;
    timeLab.font = [UIFont systemFontOfSize:TinyFontSize];
    [self.contentView addSubview:timeLab];
    self.timeLabel = timeLab;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.offset(-padding);
        make.width.greaterThanOrEqualTo(@20);
        make.height.equalTo(@15);
    }];
    
    //专题
    UILabel *topicLab = [UILabel new];
    topicLab.hidden = YES;
    topicLab.textColor = [UIColor redColor];
    topicLab.textAlignment = NSTextAlignmentCenter;
    topicLab.font = [UIFont boldSystemFontOfSize:TinyFontSize];
    topicLab.text = @"专题";
    topicLab.layer.masksToBounds = YES;
    topicLab.layer.cornerRadius = 2.0;
    topicLab.layer.borderColor = [UIColor redColor].CGColor;
    topicLab.layer.borderWidth = 1.0;
    [self.contentView addSubview:topicLab];
    self.topicLabel = topicLab;
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.timeLabel);
        make.width.equalTo(@35);
        make.right.equalTo(self.titleLabel);
    }];
    
    //评论数
    UILabel *numLab = [UILabel new];
    numLab.textColor = DominantGrayColor;
    numLab.text = @"835 评";
    numLab.font = [UIFont systemFontOfSize:TinyFontSize];
    [self.contentView addSubview:numLab];
    self.discussNumLabel = numLab;
    [self.discussNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.topicLabel);
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
