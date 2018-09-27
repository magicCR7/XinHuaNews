//
//  UIImage+Image.h
//  XinHuaNews
//
//  Created by Mc on 2018/9/13.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+(UIImage *)imageOriginalWithName:(NSString *)imageName;

- (instancetype)circleImage;

+ (instancetype)circleImageNamed:(NSString *)name;

//通过颜色创建图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize;

@end
