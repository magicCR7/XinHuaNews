//
//  NewsTableViewCell.h
//  XinHuaNews
//
//  Created by Mc on 2018/9/19.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "PublicNewsTableViewCell.h"

@interface NewsTableViewCell : PublicNewsTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *discussNumLabel;
@property (nonatomic, strong) UILabel *topicLabel;
@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UIView *mainView;

@end
