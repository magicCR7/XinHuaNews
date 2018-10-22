//
//  SearchHistoryTableViewCell.h
//  XinHuaNews
//
//  Created by Mc on 2018/10/17.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHistoryTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@property(nonatomic, copy)void(^deleteHistoryBlock)(void) ;

@end
