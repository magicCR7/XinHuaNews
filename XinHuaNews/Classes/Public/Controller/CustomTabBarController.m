//
//  CustomTabBarController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/13.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "CustomTabBarController.h"
#import "HomeViewController.h"
#import "SpotViewController.h"
#import "SubscribeViewController.h"
#import "MineViewController.h"
#import "CustomeTabBar.h"
#import "UIImage+Image.h"

@interface CustomTabBarController ()

@property (nonatomic, assign) NSInteger indexFlag;

@end

@implementation CustomTabBarController

+(void)load{
    UITabBarItem * item=[UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary* attrs =[[NSMutableDictionary alloc]init];
    attrs[NSForegroundColorAttributeName] = DominantColor;
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    NSMutableDictionary* attrsNor =[[NSMutableDictionary alloc]init];
    attrsNor[NSFontAttributeName]=[UIFont systemFontOfSize:10.0];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupAllChildViewController];
    [self setupAllTittleButton];
    
    //自定义tabbar
    [self setupTabBar];
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    /** 给 tabBarButton 加动画 */
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        //执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [arry addObject:btn];
            }
        }
        //添加动画
        [self addScaleAnimtaionWithArr:arry index:index];
//        [self addUpTranslationAnimtaionWithArr:arry index:index];
        
        self.indexFlag = index;
    }
}

//动画
- (void)addScaleAnimtaionWithArr:(NSMutableArray *)arry index:(NSInteger)index
{
    //放大效果，并回到原位
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = NO;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:1.2];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.0];     //结束伸缩倍数
    [[arry[index] layer] addAnimation:animation forKey:nil];
}


-(void)setupTabBar{
    CustomeTabBar * tabBar=[[CustomeTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupAllChildViewController{
    
    //首页
    HomeViewController * homeVc=[[HomeViewController alloc]init];
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:homeVc];
    [self addChildViewController:nav];
    
    //现场
    SpotViewController * spotVc=[[SpotViewController alloc]init];
    UINavigationController * nav1=[[UINavigationController alloc]initWithRootViewController:spotVc];
    [self addChildViewController:nav1];
    //订阅号
    SubscribeViewController * subscribeVc=[[SubscribeViewController alloc]init];
    UINavigationController * nav3=[[UINavigationController alloc]initWithRootViewController:subscribeVc];
    [self addChildViewController:nav3];
    //我
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([MineViewController class]) bundle:nil];
//    //加载箭头指向控制器
//    MineViewController * meVc= [storyboard instantiateInitialViewController];
    MineViewController * meVc=[[MineViewController alloc]init];
    UINavigationController * nav4=[[UINavigationController alloc]initWithRootViewController:meVc];
    [self addChildViewController:nav4];
    
}
//设置tabbar上按钮内容
-(void)setupAllTittleButton{
    //0
    UINavigationController *nav=self.childViewControllers[0];
    nav.tabBarItem.title=@"首页";
    nav.tabBarItem.image=[UIImage imageNamed:@"home_gray"];
    nav.tabBarItem.selectedImage=[UIImage imageOriginalWithName:@"home_blue"];
    
    //1
    UINavigationController *nav1=self.childViewControllers[1];
    nav1.tabBarItem.title=@"现场";
    nav1.tabBarItem.image=[UIImage imageNamed:@"spot_gray"];
    nav1.tabBarItem.selectedImage=[UIImage imageOriginalWithName:@"spot_blue"];
    
    //3
    UINavigationController *nav3=self.childViewControllers[2];
    nav3.tabBarItem.title=@"订阅号";
    nav3.tabBarItem.image=[UIImage imageNamed:@"subscribe_gray"];
    nav3.tabBarItem.selectedImage=[UIImage imageOriginalWithName:@"subscribe_blue"];
    
    //4
    UINavigationController *nav4=self.childViewControllers[3];
    nav4.tabBarItem.title=@"我的";
    nav4.tabBarItem.image=[UIImage imageNamed:@"mine_gray"];
    nav4.tabBarItem.selectedImage=[UIImage imageOriginalWithName:@"mibe_blue"];
    
}

@end
