//
//  PicNewsTableViewCell.h
//  XinHuaNews
//
//  Created by Mc on 2018/9/20.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "PublicNewsTableViewCell.h"

@interface PicNewsTableViewCell : PublicNewsTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;//新闻标题
@property (nonatomic, strong) UILabel *authorLabel;//作者
@property (nonatomic, strong) UILabel *timeLabel;//时间
@property (nonatomic, strong) UIImageView *ltImageView;//左上图片
@property (nonatomic, strong) UIImageView *rtImageView;//右上图片
@property (nonatomic, strong) UIImageView *lbImageView;//左下图片
@property (nonatomic, strong) UIImageView *rbImageView;//右下图片
@property (nonatomic, strong) UILabel *detailLabel;

@end
