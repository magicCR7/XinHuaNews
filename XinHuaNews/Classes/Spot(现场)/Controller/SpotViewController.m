//
//  SpotViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/13.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SpotViewController.h"
#import "LySegmentMenu.h"
#import "SpotNewsViewController.h"
#import "SpotHeraldViewController.h"
#import "SearchViewController.h"

@interface SpotViewController ()

@property (nonatomic, strong) NSMutableArray *vcViewArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) LySegmentMenu *segmentMenu;

@end

@implementation SpotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"现场";
   self.titleArray = [[NSArray alloc] initWithObjects:@"热门",@"时政",@"经济",@"国际",@"文教",@"科技",@"社会",@"体育",@"军事", nil];
    [self setupViews];
}

- (void)setupViews {
    //右上方搜索
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 20,20);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(jumpToSearchVc) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    //左上方预告
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 20,20);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"spotClock"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(jumpToHeraldVc) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.vcViewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.titleArray.count; i++) {
        SpotNewsViewController *newsVc = [[SpotNewsViewController alloc]init];
        [self addChildViewController:newsVc];
        [self.vcViewArray addObject:newsVc.view];
    }
    CGRect Rect = CGRectMake(0, Nav_Height+Statusbar_Height, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.segmentMenu = [[LySegmentMenu alloc]initWithFrame:Rect
                                       ControllerViewArray:self.vcViewArray
                                                TitleArray:self.titleArray
                                           MaxShowTitleNum:6];
    self.segmentMenu.layer.shadowColor = [UIColor blackColor].CGColor;
    self.segmentMenu.layer.shadowOpacity = 0.1f;
    self.segmentMenu.layer.shadowRadius = 1.0;
    self.segmentMenu.layer.shadowOffset = CGSizeMake(0, 2);
    [self.view addSubview:self.segmentMenu];
}

- (void)jumpToHeraldVc {
    SpotHeraldViewController *heraldVc = [[SpotHeraldViewController alloc] init];
    heraldVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:heraldVc animated:YES];
}

- (void)jumpToSearchVc {
    SearchViewController *searchVc = [[SearchViewController alloc] init];
    searchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
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
