//
//  PlaceholderTextView.h
//  XinHuaNews
//
//  Created by Mc on 2018/9/30.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
