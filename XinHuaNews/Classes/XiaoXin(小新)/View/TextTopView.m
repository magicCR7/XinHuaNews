//
//  TextTopView.m
//  XinHuaNews
//
//  Created by Mc on 2018/11/22.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "TextTopView.h"
#import "UIView+Core.h"

@interface  TextTopView()

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation TextTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIScrollView *mainScrollV = [UIScrollView new];
    mainScrollV.showsHorizontalScrollIndicator = NO;
    [self addSubview:mainScrollV];
    [mainScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.mainScrollView = mainScrollV;
    
    CGFloat padding = 10;
    CGFloat btnWidth = 75;
    CGFloat btnHeight = 36;
    _dataArray = [[NSArray alloc] initWithObjects:@"查天气",@"搜美食",@"看电影",@"买机票",@"订酒店",@"斗地主", nil];
    mainScrollV.contentSize = CGSizeMake(_dataArray.count*(padding+btnWidth), 0);
    for (int i=0; i<_dataArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*(padding+btnWidth)+padding, 5, btnWidth, btnHeight)];
        [btn setTitle:[NSString stringWithFormat:@"%@",_dataArray[i]] forState:UIControlStateNormal];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:NormalFontSize];
        btn.backgroundColor = DominantColor;
        [btn addRoundedCorners:UIRectCornerTopRight|UIRectCornerTopLeft|UIRectCornerBottomLeft  withRadii:CGSizeMake(btnHeight/2, btnHeight/2) viewRect:CGRectMake(0, 0, btnWidth, btnHeight)];
        [mainScrollV addSubview:btn];
    }
}

@end
