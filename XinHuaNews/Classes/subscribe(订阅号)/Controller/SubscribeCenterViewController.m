
//
//  SubscribeCenterViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/11.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SubscribeCenterViewController.h"
#import "SubCenterTableViewCell.h"
#import "SubCenterLeftTableViewCell.h"

@interface SubscribeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) NSArray *leftDataArray;
@property (nonatomic, strong) NSDictionary *dataDictionary;//数据字典
@property (nonatomic, strong) NSMutableArray *rightDataArray;

@end

@implementation SubscribeCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订阅中心";
    [self setupViews];
    _dataDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@[@"新华视点",@"新华体育",@"新华网"], @"推荐",@"时政",@"时政", @"国际",@"国际", @"财经",@"财经", @"财经",@"财经", @"视频",@"视频",@[@"新华图集",@"动图"],@"图集", @"军事",@"军事", @"社会",@"社会", @"科技",@"科技", @"高校",@"高校", @"服务",@"服务", @"评论",@"评论", @"财富",@"财富", @"商业",@"商业", @"全媒平台",@"全媒平台", nil];
    _leftDataArray = [[NSArray alloc] init];
    _leftDataArray = [_dataDictionary allKeys];
//    _leftDataArray = [[NSArray alloc] initWithObjects:@"推荐", @"时政", @"国际", @"财经", @"体育", @"视频", @"图集", @"军事", @"社会", @"科技", @"高校", @"服务", "评论", "财富","商业", @"全媒平台", nil];
}

- (void)setupViews {
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.showsVerticalScrollIndicator = YES;
    //    mainTableV.estimatedRowHeight = 150;
    //    mainTableV.rowHeight = UITableViewAutomaticDimension;
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    leftTableView.sectionFooterHeight = 0.01;
    leftTableView.sectionHeaderHeight = 0.01;
    [self.view addSubview:leftTableView];
    self.leftTableView = leftTableView;
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.equalTo(@100);
    }];
    
    //分割线
    UIView *lineV = [UIView new];
    lineV.backgroundColor = lineColor;
    [self.view addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.leftTableView);
        make.width.equalTo(@1.5);
        make.left.equalTo(self.leftTableView.mas_right);
    }];
    
    
    //右侧
    UITableView *rightTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.showsVerticalScrollIndicator = NO;
    //    mainTableV.estimatedRowHeight = 150;
    //    mainTableV.rowHeight = UITableViewAutomaticDimension;
    rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rightTableView.sectionFooterHeight = 0.01;
    rightTableView.sectionHeaderHeight = 0.01;
    [self.view addSubview:rightTableView];
    self.rightTableView = rightTableView;
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.leftTableView);
        make.left.equalTo(lineV.mas_right);
        make.right.offset(0);
    }];
    
    
    [self.leftTableView reloadData];
    
    [self.leftTableView layoutIfNeeded];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return _leftDataArray.count;
    } else {
        return _rightDataArray.count;
//        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        static NSString *identifier = @"SubCenterLeftTableViewCell";
        SubCenterLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[SubCenterLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.midLabel.text = _leftDataArray[indexPath.row];
        return cell;
    }
    
    static NSString *identifier = @"SubCenterTableViewCell";
    SubCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SubCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.titleLabel.text = _rightDataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        self.rightDataArray = [[NSMutableArray alloc] init];
        self.rightDataArray = [self getRightDataArray:self.rightDataArray andDic:_dataDictionary andKeyString:_leftDataArray[indexPath.row]];
        [self.rightTableView reloadData];
    }
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
            self.rightDataArray = [[NSMutableArray alloc] init];
            self.rightDataArray = [self getRightDataArray:self.rightDataArray andDic:_dataDictionary andKeyString:_leftDataArray[0]];
            [self.rightTableView reloadData];
        }
    }
}

- (NSMutableArray *)getRightDataArray:(NSMutableArray *)dataArray andDic:(NSDictionary *)dic andKeyString:(NSString *)keyStr {
    if ([[dic valueForKey:keyStr] isKindOfClass:[NSString class]]) {
        [dataArray addObject:keyStr];
    } else if ([[dic valueForKey:keyStr] isKindOfClass:[NSArray class]]) {
        dataArray = [[dic valueForKey:keyStr] mutableCopy];
    }
    return dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
