//
//  NewsVideoView.h
//  XinHuaNews
//
//  Created by Mc on 2018/9/21.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsVideoView : UIView

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *titleLabel;//
@property (nonatomic, strong) UILabel *lengthLabel;//视频时长
@property (nonatomic, strong) UILabel *timeLabel;//发布时间
@property (nonatomic, strong) UILabel *discussLabel;

@end
