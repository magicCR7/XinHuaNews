//
//  NewsVideoView.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/21.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "NewsVideoView.h"

@implementation NewsVideoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    CGFloat padding = 8.0f;
    NSInteger width = self.x_width;
    UIImageView *mainImageV = [UIImageView new];
    [mainImageV setImage:[UIImage imageNamed:@"3"]];
    mainImageV.layer.masksToBounds = YES;
    mainImageV.layer.cornerRadius = 5;
    [self addSubview:mainImageV];
    self.mainImageView = mainImageV;
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
        make.height.equalTo(@170);
        make.top.left.right.equalTo(self);
    }];
    
    //lengthLab
    UILabel *lengthLab = [UILabel new];
    lengthLab.text = @"01:16";
    lengthLab.textAlignment = NSTextAlignmentCenter;
    lengthLab.layer.masksToBounds = YES;
    lengthLab.layer.cornerRadius = 5.0;
    lengthLab.backgroundColor = RGB(0, 0, 0, 0.3);
    lengthLab.textColor = [UIColor whiteColor];
    lengthLab.font = [UIFont systemFontOfSize:TinyFontSize];
    [self.mainImageView addSubview:lengthLab];
    self.lengthLabel = lengthLab;
    [self.lengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-padding);
        make.bottom.offset(-padding);
        make.width.equalTo(@40);
        make.height.equalTo(@18);
    }];
    
    UIImageView *playImageV = [UIImageView new];
    [playImageV setImage:[UIImage imageNamed:@"video_play"]];
    [self.mainImageView addSubview:playImageV];
    [playImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.bottom.offset(0);
        make.height.width.equalTo(@45);
    }];
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"现场云 | 赏花赏月赏秋香";
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:NormalFontSize]];
    [self addSubview:titleLab];
    self.titleLabel = titleLab;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.mainImageView);
        make.top.equalTo(self.mainImageView.mas_bottom).offset(padding);
        make.height.equalTo(@18);
    }];
    
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"18-09-20";
    timeLab.textColor = DominantGrayColor;
    timeLab.font = [UIFont systemFontOfSize:TinyFontSize];
    [self addSubview:timeLab];
    self.timeLabel = timeLab;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.height.equalTo(@13);
        make.width.greaterThanOrEqualTo(@10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(padding);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    UILabel *numLab = [UILabel new];
    numLab.text = @"835 评论";
    numLab.textColor = DominantGrayColor;
    numLab.font = [UIFont systemFontOfSize:TinyFontSize];
    [self addSubview:numLab];
    self.discussLabel = numLab;
    [self.discussLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.timeLabel);
        make.right.equalTo(self.titleLabel.mas_right);
        make.width.greaterThanOrEqualTo(@10);
    }];
    

}

@end
