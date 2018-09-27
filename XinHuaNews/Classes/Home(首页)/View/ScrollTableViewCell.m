//
//  ScrollTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/21.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "ScrollTableViewCell.h"
#import "NewsVideoView.h"

@interface ScrollTableViewCell()<UIScrollViewDelegate>

@property (nonatomic, strong) NewsVideoView *videoView;
@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation ScrollTableViewCell

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
    self.clipsToBounds = YES;
    CGFloat padding = 12.0f;
    //titleLab
    UILabel *titleLab = [UILabel new];
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:LargeFontSize]];
    titleLab.text = @"现场云";
    [self.contentView addSubview:titleLab];
    self.titleLabel = titleLab;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(padding);
        make.right.offset(-padding);
        make.height.equalTo(@20);
    }];
    
    UIButton *moreBtn = [UIButton new];
    [moreBtn setTitle:@"更多 >" forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    [moreBtn setTitleColor:DominantGrayColor forState:UIControlStateNormal];
    [self.contentView addSubview:moreBtn];
    self.moreButton = moreBtn;
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-padding);
        make.top.bottom.equalTo(self.titleLabel);
        make.width.equalTo(@40);
    }];

    //scrollView
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    //    scrollV.backgroundColor = [UIColor lightGrayColor];
    scrollV.delegate = self;
    scrollV.pagingEnabled = true;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.clipsToBounds = NO;
    scrollV.contentSize = CGSizeMake((self.x_width) * 4, 0);
    [self.contentView addSubview:scrollV];
    self.mainScrollView = scrollV;
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(padding);
        make.left.offset(5);
        make.right.offset(0);
        make.height.equalTo(@230);
        make.bottom.offset(-20);
    }];
    
    //imageview
    for (int i =0; i<4; i++) {
        NewsVideoView *videoV = [[NewsVideoView alloc]initWithFrame:CGRectMake(10 + i * (self.x_width), 0, self.x_width -20, 230)];
        [self.mainScrollView addSubview:videoV];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
