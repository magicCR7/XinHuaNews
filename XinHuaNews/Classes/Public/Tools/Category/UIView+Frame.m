//
//  UIView+Frame.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/14.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

//+ (instancetype)x_viewFromXib
//{
//    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
//}

-(void)setX_width:(CGFloat)x_width{
    CGRect rect=self.frame;
    rect.size.width=x_width;
    self.frame=rect;
}
-(CGFloat)x_width{
    return self.frame.size.width;
}

-(void)setX_height:(CGFloat)x_height{
    CGRect rect=self.frame;
    rect.size.height=x_height;
    self.frame=rect;
    
}
-(CGFloat)x_height{
    return self.frame.size.height;
}

-(CGFloat)x_x{
    return self.frame.origin.x;
}
-(void)setX_x:(CGFloat)x_x{
    CGRect rect=self.frame;
    rect.origin.x =x_x;
    self.frame=rect;
}

-(CGFloat)x_y{
    return  self.frame.origin.y;
}

-(void)setX_y:(CGFloat)x_y{
    CGRect rect=self.frame;
    rect.origin.y=x_y;
    self.frame=rect;
}

- (void)setX_centerX:(CGFloat)x_centerX{
    CGPoint center = self.center;
    center.x = x_centerX;
    self.center = center;
}

- (CGFloat)x_centerX{
    return self.center.x;
}

- (void)setX_centerY:(CGFloat)x_centerY{
    CGPoint center = self.center;
    center.y = x_centerY;
    self.center = center;
}
- (CGFloat)x_centerY{
    return  self.center.y;
}

@end
