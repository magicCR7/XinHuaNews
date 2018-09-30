//
//  MyCommentTableViewCell.h
//  XinHuaNews
//
//  Created by Mc on 2018/9/29.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *detailLabel;//评论内容
@property (nonatomic, strong) UILabel *titleLabel;//文章标题

@end
