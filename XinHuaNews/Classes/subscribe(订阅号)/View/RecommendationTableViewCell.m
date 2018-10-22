//
//  RecommendationTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/10.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "RecommendationTableViewCell.h"
#import "RecommendationView.h"

@interface RecommendationTableViewCell()

@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation RecommendationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
//    frame.origin.y += 10;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIScrollView *mainScrollV = [UIScrollView new];
    mainScrollV.clipsToBounds = NO;
    mainScrollV.backgroundColor = [UIColor clearColor];
    mainScrollV.contentSize = CGSizeMake(110*5+10, 0);
//    mainScrollV.contentOffset = CGPointMake(10, 0);
    mainScrollV.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    [self.contentView addSubview:mainScrollV];
    self.mainScrollView = mainScrollV;
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.height.equalTo(@150);
    }];
    for (int i=0; i < 5; i++) {
        RecommendationView *recommendationV = [[RecommendationView alloc] initWithFrame:CGRectMake(10+i*(100+10), 1, 100, 138)];
        
        [self.mainScrollView addSubview:recommendationV];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
