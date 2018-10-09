//
//  CustomeTabBar.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/13.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "CustomeTabBar.h"
#import "XiaoXinViewController.h"
#import "UIImage+Image.h"


@interface CustomeTabBar()

@property (nonatomic,weak) UIButton * plusButton;
//上一次点击的按钮
@property (nonatomic,weak) UIControl *previousClickedTabBarButton;
@end

@implementation CustomeTabBar

-(UIButton *)plusButton{
    if(_plusButton == nil){
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.adjustsImageWhenHighlighted = NO;
        [btn setImage:[UIImage imageNamed:@"xiaoXinLogo"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(jumpToXiaoXin) forControlEvents:UIControlEventTouchUpInside];
//        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
//        [btn sizeToFit];
        CGRect tempBounds = btn.bounds;
        tempBounds.size.height = 50;
        tempBounds.size.width = 50;
        btn.bounds=tempBounds;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 25;
        [self addSubview:btn];
        _plusButton=btn;
    }
    return _plusButton;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
    CGFloat btnW = self.x_width / (count+1);
    CGFloat btnH = self.x_height;
    CGFloat x = 0;
    int i=0;
    self.selectionIndicatorImage = [UIImage imageWithColor:RGB(63, 120, 217, 0.3)  size:CGSizeMake(btnW - 5, btnH - 3)];
    for( UIControl *tabBarButton in self.subviews){
        if([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            
            if (i == 0 && self.previousClickedTabBarButton == nil) {
                self.previousClickedTabBarButton = tabBarButton;
            }
            
            
            if (i==2) {
                i+=1;
            }
            x = i * btnW;
            tabBarButton.frame = CGRectMake(x, 0, btnW, btnH);
            i++;
            //监听点击
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
    //调整按钮位置
    self.plusButton.center=CGPointMake(self.x_width*0.5, self.x_height*0.3);
}

-(void)tabBarButtonClick:(UIControl *)tabBarButton{

    if (self.previousClickedTabBarButton == tabBarButton) {
        
        //发出通知 告知tabbar被重复点击了
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarButtonDidRepeatClickNotification" object:nil];
        
    }
    self.previousClickedTabBarButton = tabBarButton;
}

- (void)jumpToXiaoXin {
    XiaoXinViewController *xiaoXinVc = [[XiaoXinViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:xiaoXinVc animated:YES completion:nil];
}

@end
