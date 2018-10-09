//
//  SubscribeViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/13.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SubscribeViewController.h"
#import "NewsTableViewCell.h"

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

#pragma mark - 顶部按钮点击事件
- (void)topButtonClicked:(UIButton *)sender {
    if (sender.tag == 101) {
        
    } else if (sender.tag == 102) {
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"NewsTableViewCell";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
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
