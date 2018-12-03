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
#import "PlusSegmentMenu.h"
#import "SearchViewController.h"
#import "ManageChannelViewController.h"
#import "XLChannelControl.h"

@interface HomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIView *titleView;

@property (nonatomic, strong) PlusSegmentMenu *segmentMenu;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *vcViewArray;
@property (nonatomic, strong) UIButton *addButton;//添加

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titlesArray = [[NSMutableArray alloc] initWithObjects:@"要闻",@"河北",@"财经",@"娱乐",@"体育",@"社会",@"NBA",@"视频",@"汽车",@"图片",@"科技",@"军事",@"国际",@"数码",@"星座",@"电影",@"时尚",@"文化",@"游戏",@"教育",@"动漫",@"政务",@"纪录片",@"房产",@"佛学",@"股票",@"理财", nil];
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
    [navBtn addTarget:self action:@selector(jumpToSearchVc) forControlEvents:UIControlEventTouchUpInside];
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
    CGRect Rect = CGRectMake(0, Statusbar_Height+Nav_Height, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.segmentMenu = [[PlusSegmentMenu alloc]initWithFrame:Rect
                                       ControllerViewArray:self.vcViewArray
                                                TitleArray:self.titlesArray
                                           MaxShowTitleNum:6];
    __weak typeof(self) weakSelf = self;
    self.segmentMenu.addChannelBlock = ^{
        NSArray *arr2 = @[@"有声",@"家居",@"电竞",@"美容",@"电视剧",@"搏击",@"健康",@"摄影",@"生活",@"旅游",@"韩流",@"探索",@"综艺",@"美食",@"育儿"];
        [[XLChannelControl shareControl] showChannelViewWithInUseTitles:weakSelf.titlesArray unUseTitles:arr2 finish:^(NSArray *inUseTitles, NSArray *unUseTitles) {
//            NSLog(@"inUseTitles = %@",inUseTitles);
//            NSLog(@"unUseTitles = %@",unUseTitles);
        }];
    };
    [self.view addSubview:self.segmentMenu];
}

#pragma mark - 跳转到搜索页面
- (void)jumpToSearchVc {
    SearchViewController *searchVc = [[SearchViewController alloc] init];
    searchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
