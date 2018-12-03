
//
//  UniversalNewsViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/17.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "UniversalNewsViewController.h"
#import "CycleScrollView.h"
#import "NewsTableViewCell.h"
#import "PicNewsTableViewCell.h"
#import "UIView+Core.h"
#import "AdTableViewCell.h"
#import "ScrollTableViewCell.h"
#import "OnePicTableViewCell.h"

@interface UniversalNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UIView *littleView;
@property (nonatomic, strong) UILabel *headLittleLabel;//header小标题

@end

@implementation UniversalNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    UITableView *mainTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    mainTableV.delegate = self;
    mainTableV.dataSource = self;
    mainTableV.estimatedRowHeight = 150;
    mainTableV.rowHeight = UITableViewAutomaticDimension;
    mainTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableV.sectionFooterHeight = 0;
    mainTableV.sectionHeaderHeight = 0;
//    mainTableV.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, mainTableV.bounds.size.width, 0.01f)];
//    mainTableV.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, mainTableV.bounds.size.width, 0.01f)];
    [self.view addSubview:mainTableV];
    self.mainTableView = mainTableV;
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self.view);
        make.bottom.offset(-Nav_Height - Statusbar_Height - TabBar_Height);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            return 3;
        } break;
        case 1: {
            return 1;
        } break;
        case 2: {
            return 1;
        } break;
        case 3: {
            return 1;
        } break;
        case 4: {
            return 1;
        } break;
        default:
            break;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    _littleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    _littleView.backgroundColor = [UIColor clearColor];
    _headLittleLabel = [[UILabel alloc] init];
    _headLittleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    _headLittleLabel.backgroundColor = RGB(251, 97, 103, 1);
    _headLittleLabel.text = @" 现场|直播中·33675人观看 ";
    _headLittleLabel.textColor = [UIColor whiteColor];
    
    [_littleView addSubview:_headLittleLabel];
    [_headLittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(10);
        make.width.greaterThanOrEqualTo(@20);
        make.height.equalTo(@25);
    }];
    [_headLittleLabel layoutIfNeeded];
    [_headLittleLabel addRoundedCorners:UIRectCornerTopRight|UIRectCornerTopLeft  withRadii:CGSizeMake(5.0, 5.0) viewRect:CGRectMake(0, 0, _headLittleLabel.x_width, 25)];
    if (section == 0) {
        CycleScrollView *cycleView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200)];
        return cycleView;
    } else if (section == 1) {
        return _littleView;
    } else if (section == 2) {
        _headLittleLabel.text = @"  专题  ";
        _headLittleLabel.backgroundColor = RGB(222, 53, 62, 1);
        [_headLittleLabel layoutIfNeeded];
        [_headLittleLabel addRoundedCorners:UIRectCornerTopRight|UIRectCornerTopLeft  withRadii:CGSizeMake(5.0, 5.0) viewRect:CGRectMake(0, 0, _headLittleLabel.x_width, 25)];
        return _littleView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 200;
    } else if (section == 1) {
        return 25;
    } else if (section == 2) {
        return 25;
    }
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        static NSString *identifier = @"PicNewsTableViewCell";
        PicNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PicNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        return cell;
    } else if (indexPath.section == 3) {
        static NSString *identifier = @"AdTableViewCell";
        AdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[AdTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        return cell;
    } else if (indexPath.section == 2) {
        static NSString *identifier = @"ScrollTableViewCell";
        ScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ScrollTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        return cell;
    } else if (indexPath.section == 4) {
        static NSString *identifier = @"OnePicTableViewCell";
        OnePicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OnePicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        return cell;
    }
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
