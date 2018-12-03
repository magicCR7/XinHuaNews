//
//  TwoPicNewsTableViewCell.h
//  XinHuaNews
//
//  Created by Mc on 2018/10/22.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "PublicNewsTableViewCell.h"

@interface TwoPicNewsTableViewCell : PublicNewsTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *lineImageView;

@end
