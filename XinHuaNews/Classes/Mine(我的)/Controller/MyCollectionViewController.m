

//
//  MyCollectionViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/29.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "NewsTableViewCell.h"

@interface MyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *editingView;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self setupViews];
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    // Do any additional setup after loading the view.
}

- (void)setupViews {
    //编辑
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarItemClick:)];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:LittleFontSize],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:LittleFontSize],NSFontAttributeName, nil] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = item;
    
    
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
    
    //底部编辑
    _editingView = [[UIView alloc] init];
    [self.view addSubview:self.editingView];
    [self.editingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@35);
        make.bottom.equalTo(self.view).offset(35);
    }];
    
    UIButton *deleteBtn = [UIButton new];
    [deleteBtn setTitle:@"删除 (0)" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:DominantGrayColor forState:UIControlStateNormal];
    [_editingView addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerX.offset(0);
        make.width.equalTo(@150);
    }];
}

//开始编辑
- (void)rightBarItemClick:(UIBarButtonItem *)item{
    if ([item.title isEqualToString:@"编辑"]) {
        if (self.dataArray.count == 0) {
            return;
        }
        item.title = @"取消";
        [self.mainTableView setEditing:YES animated:YES];
        [self showEitingView:YES];
    }else{
        item.title = @"编辑";
        [self.mainTableView setEditing:NO animated:YES];
        
        [self showEitingView:NO];
    }
}
- (void)deleteCell:(UIButton *)sender {
    NSMutableIndexSet *insets = [[NSMutableIndexSet alloc] init];
    [[self.mainTableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [insets addIndex:obj.row];
    }];
    [self.mainTableView deleteRowsAtIndexPaths:[self.mainTableView indexPathsForSelectedRows] withRowAnimation:UITableViewRowAnimationFade];
        /** 数据清空情况下取消编辑状态*/
    if (self.dataArray.count == 0) {
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        [self.mainTableView setEditing:NO animated:YES];
        [self showEitingView:NO];
    }
}

- (void)showEitingView:(BOOL)isShow{
    [self.editingView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(isShow?0:35);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"NewsTableViewCell";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
