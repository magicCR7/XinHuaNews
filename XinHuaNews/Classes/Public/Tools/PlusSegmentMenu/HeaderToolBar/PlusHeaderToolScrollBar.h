//
//  PlusHeaderToolScrollBar
//  LyScrollMenu
//
//  Created by Lying on 16/6/27.
//  Copyright © 2016年 Lying. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlusHeaderToolScrollBar;

@protocol HeaderToolBarDelegate <NSObject>

/**
 *  点击按钮事件，返回当前按钮的标题和下标
 *
 *  @param title         按钮标题
 *  @param index         按钮下标
 */
- (void)PlusHeaderToolScrollBar:(PlusHeaderToolScrollBar *)headerToolBar didSelectItemWithTitle:(NSString *)title withIndex:(NSInteger)index;

@end


@interface PlusHeaderToolScrollBar : UIScrollView

/**
 *  配置显示的标题
 *
 *  @param titleAry 标题数组
 */
- (void)configWithTitleArray:(NSArray *)titleAry MaxShowNum:(NSInteger)maxNum;

/**
 *  设置被选中的item
 */
- (void)changeSelectItemWithIndex:(NSInteger)index;
- (void)indicatorChange:(float)point;

@property (nonatomic, weak) id<HeaderToolBarDelegate> customDelegate;

@end
