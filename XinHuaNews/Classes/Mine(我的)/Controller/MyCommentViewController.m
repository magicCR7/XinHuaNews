//
//  MyCommentViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/29.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "MyCommentViewController.h"
#import "MyCommentTableViewCell.h"

@interface MyCommentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation MyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的评论";
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
        make.right.left.bottom.top.offset(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MyCommentTableViewCell";
    MyCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
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
