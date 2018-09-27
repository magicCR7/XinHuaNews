//
//  PublicNewsTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/20.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "PublicNewsTableViewCell.h"

@implementation PublicNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setShadow];
    }
    return self;
}

#pragma mark - 重写frame
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

- (void)setShadow {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentView.layer.shadowOpacity = 0.3f;
//    self.contentView.layer.shadowRadius = 1.0;
    self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
