//
//  JHPageMenuView.h
//  JHPageMenuViewDemo
//
//  Created by 谭高丰 on 2017/9/21.
//  Copyright © 2017年 谭高丰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHPageMenuConstant.h"
#import "JHPageMenuItem.h"
@class JHPageMenuView, JHPageDecorateView;

@protocol JHPageMenuViewDataSource <NSObject>
@required
/**
 告知 "JHMenuView" 需要多少个菜单
 
 @param menuView JHPageMenuView
 @return 菜单个数
 */
- (NSInteger)numbersOfItemsInMenuView:(JHPageMenuView *)menuView;

/**
 告知 "JHMenuView" 每个菜单的内容视图
 
 @param menuView JHPageMenuView
 @param index 当前需要展示内容视图的位置
 @return 菜单内容视图
 */
- (JHPageMenuItem *)menuView:(JHPageMenuView *)menuView menuCellForItemAtIndex:(NSInteger)index;

@optional
/**
 告知 "JHMenuView" 的装饰器视图，如果实现了这个方法，且返回的装饰器视图不为nil，装饰器视图就会使用自定义的，设置的内置装饰器样式将不会生效

 @param menuView JHPageMenuView
 @return 装饰视图
 */
- (UIView *)decorateItemInMenuView:(JHPageMenuView *)menuView;

@end

@protocol JHPageMenuViewDelegate <NSObject>
@optional

/**
 当点击菜单子视图的时候，你可能需要做些事情，可以在这里面实现
 
 @param menuView JHPageMenuView
 @param index 当前点击的菜单视图的位置
 */
- (void)menuView:(JHPageMenuView *)menuView didSelectIndex:(NSInteger)index;

@end

@interface JHPageMenuView : UIView<JHPageMenuViewDelegate>

/** 代理 */
@property (nonatomic, weak) id<JHPageMenuViewDelegate> delegate;
@property (nonatomic, weak) id<JHPageMenuViewDataSource> dataSource;
/** 菜单视图 */
@property (nonatomic, strong) UICollectionView *menuCollectionView;
/** 菜单单元格大小 */
@property (nonatomic, assign) CGSize menuSize;
/** 菜单滚动方向，支持垂直和水平两个方向，默认为水平方向 */
@property (nonatomic, assign) JHPageMenuScrollDirection scrollDirection;
/** 内置的装饰器大小，不设置的话默认和菜单大小一致 */
@property (nonatomic, assign) CGSize decorateSize;
/** 内置的装饰器样式，默认为JHPageDecorateStyleDefault，当设置了自定义的装饰器时，设置的该属性不会生效 */
@property (nonatomic, assign) JHPageDecorateStyle decorateStyle;
/** 内置的装饰器样式的颜色，默认为红色 */
@property (nonatomic, strong) UIColor *decorateColor;

/**
 设置选中的菜单

 @param index 位置
 @param animation 装饰视图是否动画执行
 */
- (void)selectItemAtIndex:(NSInteger)index withAnimation:(BOOL)animation;

/**
 刷新数据，该方法会重新执行一遍代理方法，显示最新的数据
 
 如果第一次初始化，先设置属性再把分页菜单添加到父视图上，这个方法可以不用执行
 如果第一次初始化，先把分页菜单添加到父视图上，再设置属性，那么得执行这个方法，才能展示正确的数据
 如果中途数据改变或者属性改变了，都得执行一下该方法才能展示最新的设置和数据
 */
- (void)reloadData;

@end
