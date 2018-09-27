//
//  MainViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/13.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleButton.h"
#import "UniversalNewsViewController.h"
#import "LySegmentMenu.h"

@interface HomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIView *titleView;

@property (nonatomic,weak) UIScrollView *scrollView;
//下划线
@property (nonatomic,weak) UIView *titleUnderline;
//记录上一次点击的标题按钮
@property (nonatomic ,strong) TitleButton *previousClickedTittleButton;
@property (nonatomic, strong) LySegmentMenu *segmentMenu;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *vcViewArray;
@property (nonatomic, strong) UIButton *addButton;//添加

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titlesArray = [[NSMutableArray alloc] initWithObjects:@"全部",@"学习",@"国际",@"财经",@"图片",@"山东", nil];
    [self setupViews];
}

- (void)setupViews {
    //创建导航按钮
    UIView *navV= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Nav_Height)];
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame = CGRectMake(0, 7, navV.x_width - 15, Nav_Height-14);
    navBtn.layer.masksToBounds = YES;
    navBtn.layer.cornerRadius = 3.0;
    navBtn.layer.borderWidth = 1.0;
    navBtn.layer.borderColor = [DominantGrayColor CGColor];
    navBtn.titleLabel.font = [UIFont systemFontOfSize:LittleFontSize];
    navBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [navBtn setTitle:@"输入搜索关键词" forState:UIControlStateNormal];
    [navBtn setImage:[UIImage imageNamed:@"search_gray"] forState:UIControlStateNormal];
    navBtn.imageEdgeInsets = UIEdgeInsetsMake(5, -SCREEN_WIDTH/2 - 10, 5, 8);
    navBtn.titleEdgeInsets = UIEdgeInsetsMake(5, -SCREEN_WIDTH/2 - 10, 5, 0);
    [navBtn setTitleColor:DominantGrayColor forState:UIControlStateNormal];
    [navV addSubview:navBtn];
    self.searchButton = navBtn;
    self.navView = navV;
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = self.navView;
    
    
    self.vcViewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.titlesArray.count; i++) {
        UniversalNewsViewController *newsVc = [[UniversalNewsViewController alloc]init];
        [self addChildViewController:newsVc];
        [self.vcViewArray addObject:newsVc.view];
    }
    //分页栏
    CGRect Rect = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.segmentMenu = [[LySegmentMenu alloc]initWithFrame:Rect
                                       ControllerViewArray:self.vcViewArray
                                                TitleArray:self.titlesArray
                                           MaxShowTitleNum:6];
//    self.segmentMenu.topView.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.segmentMenu.topView.layer.shadowOpacity = 0.3f;
//    self.segmentMenu.topView.layer.shadowRadius = 1.0;
//    self.segmentMenu.topView.layer.shadowOffset = CGSizeMake(-3, 1);
    [self.view addSubview:self.segmentMenu];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
