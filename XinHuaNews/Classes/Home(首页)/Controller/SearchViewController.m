//
//  SearchViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/16.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SearchViewController.h"
#import "UITextField+Placeholder.h"
#import "HotWordsTableViewCell.h"
#import "SearchHistoryTableViewCell.h"
#import <FMDatabase.h>
#import "SearchResultViewController.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat lastLabelWidth;
@property (nonatomic, strong) UILabel *hotWordsLabel;
@property (nonatomic, strong) UILabel *historyLabel;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *historyWordsArray;
@property (nonatomic, strong) UITextField *seacrhTextField;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    _dataArray = [[NSArray alloc] initWithObjects:@"慢读", @"早读", @"人大代表", @"巡视", @"共享单车", @"两会", @"新华社", @"房价", @"改革", @"夜览", nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavView];
    [self getHistoryWordsArray];
    [self setupViews];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.layer.masksToBounds = YES;
}

#pragma mark - 设置导航栏
- (void)setNavView {
    //创建导航按钮
    UIView *navV= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Nav_Height)];
    
    //边框View
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, navV.x_width - 58, Nav_Height-14)];
    topView.layer.masksToBounds = YES;
    topView.layer.cornerRadius = 5.0f;
    topView.layer.borderWidth = 1;
    topView.layer.borderColor = [DominantGrayColor CGColor];
    [navV addSubview:topView];
    
    //搜索图标
    UIImageView *searchImageV = [[UIImageView alloc] initWithFrame:CGRectMake(6, 3, topView.x_height - 6, topView.x_height - 6)];
    [searchImageV setImage:[UIImage imageNamed:@"search_gray"]];
    [topView addSubview:searchImageV];
    
    //语音图标
    UIImageView *voiceImageV = [[UIImageView alloc] initWithFrame:CGRectMake(topView.x_width - topView.x_height, 3, searchImageV.x_height, searchImageV.x_height)];
    [voiceImageV setImage:[UIImage imageNamed:@"voice"]];
    [topView addSubview:voiceImageV];
    
    //文本框
    UITextField *seachText = [[UITextField alloc] init];
    [seachText setPlaceholderColor:DominantGrayColor];
    seachText.font = [UIFont systemFontOfSize:LittleFontSize];
    seachText.placeholder = @"输入搜索关键词";
    [topView addSubview:seachText];
    self.seacrhTextField = seachText;
    [self.seacrhTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(3);
        make.bottom.offset(-3);
        make.right.equalTo(voiceImageV.mas_left).offset(-5);
        make.left.equalTo(searchImageV.mas_right).offset(5);
    }];
    
    //返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(navV.x_width - 50, 7, 35, topView.x_height)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn setTitleColor:DominantColor forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:NormalFontSize];
    [navV addSubview:backBtn];
    
    self.navView = navV;
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = self.navView;
}

- (void)setupViews {
    //导航栏阴影
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 0);
    self.navigationController.navigationBar.layer.shadowOpacity = 0.2;
    
    UITableView *mainTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    mainTableV.delegate = self;
    mainTableV.dataSource = self;
    mainTableV.showsVerticalScrollIndicator = NO;
    mainTableV.backgroundColor = [UIColor whiteColor];
    //    mainTableV.estimatedRowHeight = 150;
    //    mainTableV.rowHeight = UITableViewAutomaticDimension;
    mainTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableV.sectionFooterHeight = 0;
    mainTableV.sectionHeaderHeight = 0;
    [self.view addSubview:mainTableV];
    self.mainTableView = mainTableV;
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.top.left.offset(0);
    }];
}

//返回上个页面
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_historyWordsArray.count == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return _historyWordsArray.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    topView.backgroundColor = [UIColor yellowColor];
    UILabel *titleLab = [UILabel new];
    titleLab.textColor = DominantGrayColor;
    titleLab.font = [UIFont systemFontOfSize:NormalFontSize];
    [topView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.greaterThanOrEqualTo(@50);
        make.centerY.equalTo(topView);
        make.left.offset(10);
    }];
    
    if (section == 0) {
        titleLab.text = @"近期热词";
    } else if (section == 1) {
        titleLab.text = @"搜索历史";
        //添加垃圾箱图片
        UIButton *deleteBtn = [UIButton new];
        [deleteBtn addTarget:self action:@selector(deleteAllHistory) forControlEvents:UIControlEventTouchUpInside];
        [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [topView addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.right.offset(-10);
            make.height.width.equalTo(@20);
        }];
    }
    return topView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    } else if(section == 1) {
        return 60;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        static NSString *identifier = @"SearchHistoryTableViewCell";
        SearchHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[SearchHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        cell.titleLabel.text = _historyWordsArray[indexPath.row];
        __weak typeof(self)weakself = self;
        __weak typeof(SearchHistoryTableViewCell)*weakcell = cell;
        cell.deleteHistoryBlock = ^{
            [weakself.historyWordsArray removeObject:weakcell.titleLabel.text];
            [weakself deleteData:weakcell.titleLabel.text];
            [weakself.mainTableView reloadData];
        };
        return cell;
    }
    static NSString *identifier = @"HotWordsTableViewCell";
    HotWordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HotWordsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.dataArray = self.dataArray;
    }
     __weak typeof(self)weakself = self;
    cell.hotWordsBlock = ^(NSString *hotWordsStr) {

        if ([weakself.historyWordsArray containsObject:hotWordsStr]) {
            [weakself deleteData:hotWordsStr];
        }
        [weakself saveData:hotWordsStr];
        self.seacrhTextField.text = hotWordsStr;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            SearchResultViewController *resultVc = [[SearchResultViewController alloc] init];
            resultVc.searchTextStr = hotWordsStr;
            [self.navigationController pushViewController:resultVc animated:YES];
        });
    };
    return cell;
}

#pragma mark - 删除全部历史
- (void)deleteAllHistory {
    NSString *message = @"是否清楚所有搜索历史";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
    [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:LittleFontSize] range:NSMakeRange(0, message.length)];
    [messageAtt addAttribute:NSForegroundColorAttributeName value:DominantGrayColor range:NSMakeRange(0, message.length)];
    [alertController setValue:messageAtt forKey:@"attributedMessage"];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
     [cancelAction setValue:DominantGrayColor forKey:@"_titleTextColor"];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        for (NSString *historyStr in self.historyWordsArray) {
//            [self.historyWordsArray removeObject:historyStr];
//            [self deleteData:historyStr];
//        }
        for (int i = 0; i < self.historyWordsArray.count; i++) {
            [self deleteData:self.historyWordsArray[i]];
        }
        self.historyWordsArray = [[NSMutableArray alloc] init];
        [self.mainTableView reloadData];
    }];
    [okAction setValue:DominantColor forKey:@"_titleTextColor"];

    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 操作数据库
-(FMDatabase *)getDataBase {
    NSString *path =   NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"SearchHistory.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:filePath];
    [database open];
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS SearchHistoryBase (Title  NSString)";
    [database executeUpdate:sqlCreateTable];
    
    return database;
}

- (void)saveData:(NSString *)titleStr {
    FMDatabase *dataBase = [self getDataBase];
    [dataBase executeUpdate:@"INSERT INTO SearchHistoryBase (Title) VALUES (?);",titleStr];
}

- (void)deleteData:(NSString *)titleStr {
    FMDatabase *dataBase = [self getDataBase];
    [dataBase executeUpdate:@"DELETE FROM SearchHistoryBase WHERE Title = ?",titleStr];
}

//- (BOOL)compareTitle:(NSString *)title {
//    FMDatabase *dataBase = [self getDataBase];
//    FMResultSet *result = [dataBase executeQuery:@"SELECT * FROM SearchHistoryBase"];
//    while ([result next]) {
//        NSString *baseTitle = [result stringForColumn:@"Title"];
//        if ([baseTitle isEqualToString:title]) {
//            return YES;
//        }
//    }
//    return NO;
//}

- (void)getHistoryWordsArray {
    _historyWordsArray = [[NSMutableArray alloc] init];
    FMDatabase *dataBase = [self getDataBase];
    FMResultSet *result = [dataBase executeQuery:@"SELECT * FROM SearchHistoryBase"];
    while ([result next]) {
        NSString *baseTitle = [result stringForColumn:@"Title"];
        [_historyWordsArray addObject:baseTitle];
    }
    _historyWordsArray = (NSMutableArray *)[[_historyWordsArray reverseObjectEnumerator] allObjects];
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
