//
//  UITextField+Placeholder.m
//  XCMBuDeJie
//
//  Created by Mc on 2017/7/27.
//  Copyright © 2017年 Mc. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>
@implementation UITextField (Placeholder)

+(void)load{
   Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setXcm_PlaceholderMethod = class_getInstanceMethod(self, @selector(setXcm_Placeholder:));
    method_exchangeImplementations(setPlaceholderMethod, setXcm_PlaceholderMethod);
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    //用runtime给系统的类添加成员属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}
- (UIColor *)placeholderColor{
    return objc_getAssociatedObject(self,@"placeholderColor");
}

//设置占位文字 设置占位文字颜色
- (void)setXcm_Placeholder:(NSString *)placeholder{
    [self setXcm_Placeholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}
@end
