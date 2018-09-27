//
//  MessageCenterViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/27.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageCenterTableViewCell.h"

@interface MessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    UITableView *mainTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    mainTableV.delegate = self;
    mainTableV.dataSource = self;
    mainTableV.showsVerticalScrollIndicator = NO;
    mainTableV.estimatedRowHeight = 150;
    mainTableV.rowHeight = UITableViewAutomaticDimension;
    mainTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableV.sectionFooterHeight = 0.01;
    mainTableV.sectionHeaderHeight = 10;
    [self.view addSubview:mainTableV];
    self.mainTableView = mainTableV;
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.top.offset(0);
//        make.top.offse;
    }];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MessageCenterTableViewCell";
    MessageCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MessageCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
