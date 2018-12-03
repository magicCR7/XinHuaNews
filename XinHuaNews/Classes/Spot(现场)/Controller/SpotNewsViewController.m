//
//  SpotNewsViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/19.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SpotNewsViewController.h"
#import "OnePicTableViewCell.h"
#import "TwoPicNewsTableViewCell.h"
#import "PicNewsTableViewCell.h"
#import "UIView+Core.h"

@interface SpotNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UIView *littleView;
@property (nonatomic, strong) UILabel *headLittleLabel;

@end

@implementation SpotNewsViewController

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
    [self.view addSubview:mainTableV];
    self.mainTableView = mainTableV;
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self.view);
        make.bottom.offset(-Nav_Height - Statusbar_Height - TabBar_Height);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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

        return _littleView;
    } else if (section == 1||section == 2) {
        _headLittleLabel.text = @"  现场|回顾·15324人观看  ";
        _headLittleLabel.backgroundColor = RGB(125, 144, 160, 1);
        [_headLittleLabel layoutIfNeeded];
        [_headLittleLabel addRoundedCorners:UIRectCornerTopRight|UIRectCornerTopLeft  withRadii:CGSizeMake(5.0, 5.0) viewRect:CGRectMake(0, 0, _headLittleLabel.x_width, 25)];
        return _littleView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        static NSString *identifier = @"OnePicTableViewCell";
        OnePicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OnePicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        cell.timeLabel.text = @"明月几时有，把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇。";
        return cell;
    } else if (indexPath.section == 2) {
        static NSString *identifier = @"PicNewsTableViewCell";
        PicNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PicNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        return cell;
    }
    static NSString *identifier = @"TwoPicNewsTableViewCell";
    TwoPicNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TwoPicNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
