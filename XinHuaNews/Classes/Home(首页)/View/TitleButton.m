//
//  TitleButton.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/14.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

//重写highlight方法 令按钮无法进入高亮状态
- (void)setHighlighted:(BOOL)highlighted{
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:DominantGrayColor forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
    }
    return self;
}

@end
