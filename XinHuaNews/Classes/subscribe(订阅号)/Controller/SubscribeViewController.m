//
//  SubscribeViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/13.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SubscribeViewController.h"
#import "NewsTableViewCell.h"
#import "RecommendationTableViewCell.h"
#import "MySubscribeViewController.h"
#import "SubscribeCenterViewController.h"
#import "SearchViewController.h"

@interface SubscribeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UIButton *mySubscribeButton;
@property (nonatomic, strong) UIButton *moreSubscibeButton;

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订阅号";
    [self setupViews];
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 20,20);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(jumpToSearch) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    // Do any additional setup after loading the view.
}

- (void)setupViews {
    UIView *topV = [UIView new];
    topV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topV];
    self.topView = topV;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(Statusbar_Height + Nav_Height);
        make.height.equalTo(@40);
    }];
    
    _mySubscribeButton = [UIButton new];
    [_mySubscribeButton addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mySubscribeButton setImage:[UIImage imageNamed:@"mySubscribe"] forState:UIControlStateNormal];
    _mySubscribeButton.tag = 101;
    [_mySubscribeButton setTitle:@" 我的订阅" forState:UIControlStateNormal];
    [_mySubscribeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _mySubscribeButton.titleLabel.font = [UIFont systemFontOfSize:LargeFontSize];
    [self.topView addSubview:_mySubscribeButton];
    [self.mySubscribeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.right.equalTo(self.topView.mas_centerX);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = lineColor;
    [self.topView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@0.8);
        make.top.offset(8);
        make.bottom.offset(-8);
        make.left.equalTo(self.mySubscribeButton.mas_right);
    }];
    
    _moreSubscibeButton = [UIButton new];
    [_moreSubscibeButton addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _moreSubscibeButton.tag = 102;
    [_moreSubscibeButton setImage:[UIImage imageNamed:@"moreSubscribe"] forState:UIControlStateNormal];
    [_moreSubscibeButton setTitle:@" 更多订阅" forState:UIControlStateNormal];
    [_moreSubscibeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _moreSubscibeButton.titleLabel.font = [UIFont systemFontOfSize:LargeFontSize];

    [self.topView addSubview:_moreSubscibeButton];
    [self.moreSubscibeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.left.equalTo(lineView.mas_right);
    }];
    
    UITableView *mainTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    mainTableV.delegate = self;
    mainTableV.dataSource = self;
    mainTableV.showsVerticalScrollIndicator = NO;
    //    mainTableV.estimatedRowHeight = 150;
    //    mainTableV.rowHeight = UITableViewAutomaticDimension;
    mainTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableV.sectionFooterHeight = 0;
    mainTableV.sectionHeaderHeight = 0;
    [self.view addSubview:mainTableV];
    self.mainTableView = mainTableV;
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.offset(0);
        make.top.equalTo(self.topView.mas_bottom);
    }];
}

#pragma mark - 跳转进入搜索页面
- (void)jumpToSearch {
    SearchViewController *searchVc = [[SearchViewController alloc] init];
    searchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
}

#pragma mark - 顶部按钮点击事件
- (void)topButtonClicked:(UIButton *)sender {
    if (sender.tag == 101) {
        MySubscribeViewController *subscribeVc = [[MySubscribeViewController alloc] init];
        subscribeVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subscribeVc animated:YES];
    } else if (sender.tag == 102 || sender.tag == 103) {
        SubscribeCenterViewController *centerVc = [[SubscribeCenterViewController alloc] init];
        centerVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:centerVc animated:YES];
    }
}

#pragma mark - tableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *headerView = [UIView new];
        headerView.backgroundColor = [UIColor clearColor];
        UIView *leftLineV = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 5, 20)];
        leftLineV.backgroundColor = DominantColor;
        leftLineV.layer.masksToBounds = YES;
        leftLineV.layer.cornerRadius = 2.5f;
        [headerView addSubview:leftLineV];
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.text = @"推荐订阅";
        titleLab.font = [UIFont systemFontOfSize:HugeFontSize];
        [headerView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftLineV.mas_right).offset(10);
            make.centerY.equalTo(leftLineV);
            make.height.equalTo(@(HugeFontSize));
            make.width.equalTo(@200);
        }];
        
        UIButton *rightBtn = [UIButton new];
        [rightBtn setTitle:@"更多>" forState:UIControlStateNormal];
        rightBtn.tag = 103;
        [rightBtn addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:LittleFontSize];
        [rightBtn setTitleColor:DominantGrayColor forState:UIControlStateNormal];
        [headerView addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.centerY.equalTo(titleLab);
            make.height.equalTo(@20);
            make.width.greaterThanOrEqualTo(@20);
        }];
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 60;
    }
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"NewsTableViewCell";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if (indexPath.section == 1) {
        static NSString *identifier = @"RecommendationTableViewCell";
        RecommendationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[RecommendationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        return cell;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
