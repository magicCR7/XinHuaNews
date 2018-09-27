//
//  MineViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/13.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "SettingViewController.h"
#import "MessageCenterViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *settingButton;
@property (nonatomic, strong) NSArray *section0TitleAry;//第一个section的标题数组
@property (nonatomic, strong) NSArray *section0ImageAry;//第一个section的图片数组
@property (nonatomic, strong) NSArray *section1TitleAry;//第二个section的标题数组
@property (nonatomic, strong) NSArray *section1ImageAry;//第二个section的图片数组


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _section0TitleAry = [[NSArray alloc] initWithObjects:@"我的订阅",@"我的关注",@"我的收藏", nil];
    _section0ImageAry = [[NSArray alloc] initWithObjects:@"mineDingYue",@"mineGuanZhu",@"mineShouCang", nil];
    _section1TitleAry = [[NSArray alloc] initWithObjects:@"我的评论",@"我的提问", nil];
    _section1ImageAry = [[NSArray alloc] initWithObjects:@"minePingLun",@"mineTiWen", nil];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)setupViews {
    UITableView *mainTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    mainTableV.delegate = self;
    mainTableV.dataSource = self;
    mainTableV.showsVerticalScrollIndicator = NO;
//    mainTableV.estimatedRowHeight = 150;
//    mainTableV.rowHeight = UITableViewAutomaticDimension;
    mainTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableV.sectionFooterHeight = 10;
    mainTableV.sectionHeaderHeight = 0;
    [self.view addSubview:mainTableV];
    self.mainTableView = mainTableV;
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.offset(0);
        make.top.offset(-Statusbar_Height);
    }];

}

- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [UIView new];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.shadowColor = DominantColor.CGColor;
        _whiteView.layer.shadowOpacity = 0.5f;
//        _whiteView.layer.shadowRadius = 5.0;
        _whiteView.layer.shadowOffset = CGSizeMake(2, 0);
//        _whiteView.layer.masksToBounds = YES;
        _whiteView.layer.cornerRadius = 5;
        
        //头像
        _headImageView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head_image"]];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 30;
        [_whiteView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(15);
            make.width.height.equalTo(@70);
        }];
        
        _nameLabel = [UILabel new];
        [_nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:HugeFontSize]];
        _nameLabel.text = @"188****1234";
        [_whiteView addSubview:_nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(30);
            make.left.equalTo(self.headImageView.mas_right).offset(10);
            make.height.equalTo(@20);
            make.width.greaterThanOrEqualTo(@20);
        }];
        
        //消息按钮
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageButton.tag = 101;
        [_messageButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_messageButton setTitle:@"消息中心" forState:UIControlStateNormal];
        _messageButton.titleLabel.font = [UIFont systemFontOfSize:LittleFontSize];
        [_messageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_messageButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
        _messageButton.imageEdgeInsets = UIEdgeInsetsMake(-10, 20, 10, -20);
        _messageButton.titleEdgeInsets = UIEdgeInsetsMake(40, -20, 3, 10);
        [self.whiteView addSubview:_messageButton];
        [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.whiteView.mas_centerX).offset(-30);
            make.width.equalTo(@80);
            make.height.equalTo(@70);
            make.bottom.equalTo(self.whiteView.mas_bottom).offset(-10);
        }];
        
        
        //设置按钮
        _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingButton.tag = 102;
        [_settingButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_settingButton setTitle:@"设置中心" forState:UIControlStateNormal];
        _settingButton.titleLabel.font = [UIFont systemFontOfSize:LittleFontSize];
        [_settingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_settingButton setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        _settingButton.imageEdgeInsets = UIEdgeInsetsMake(-10, 20, 10, -20);
        _settingButton.titleEdgeInsets = UIEdgeInsetsMake(40, -20, 3, 10);
        [self.whiteView addSubview:_settingButton];
        [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteView.mas_centerX).offset(30);
            make.width.equalTo(@80);
            make.height.equalTo(@70);
            make.bottom.equalTo(self.whiteView.mas_bottom).offset(-10);
        }];
        
        //分割线
        UIView *lineView = [UIView new];
        lineView.backgroundColor = RGB(96, 96, 96, 0.1);
        [self.whiteView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.whiteView.mas_centerX);
            make.width.equalTo(@0.7);
            make.top.equalTo(self.messageButton.mas_top).offset(17);
            make.bottom.equalTo(self.messageButton.mas_bottom).offset(-17);
        }];
    }
    return _whiteView;
}

#pragma mark - 按钮点击
- (void)buttonClicked:(UIButton *)sender {
    /*
     tag:101 消息中心 102 设置中心
     */
    switch (sender.tag) {
        case 101:{
            MessageCenterViewController *messageVc = [[MessageCenterViewController alloc] init];
            messageVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:messageVc animated:YES];
        }break;
        case 102:{
            SettingViewController *settingVc = [[SettingViewController alloc] init];
            settingVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingVc animated:YES];
        }break;
            
        default:
            break;
    }
}

#pragma mark - TableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //headerView
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor clearColor];
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    backgroundView.backgroundColor = DominantColor;
    [headerView addSubview:backgroundView];

    self.whiteView.frame = CGRectMake(10, Statusbar_Height+Nav_Height, SCREEN_WIDTH - 20, 170);
    [headerView addSubview:self.whiteView];


    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return (180+Statusbar_Height+Nav_Height);
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:{
            return _section0ImageAry.count;
        }break;
        case 1:{
            return _section1ImageAry.count;
        }break;
        case 2:{
            return 1;
        }break;
            
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MineTableViewCell";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    switch (indexPath.section) {
        case 0:{
            cell.titleLabel.text = _section0TitleAry[indexPath.row];
            [cell.iconImageView setImage:[UIImage imageNamed:_section0ImageAry[indexPath.row]]];
            }break;
        case 1:{
            cell.titleLabel.text = _section1TitleAry[indexPath.row];
            [cell.iconImageView setImage:[UIImage imageNamed:_section1ImageAry[indexPath.row]]];
        }break;
            
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(tintColor)]) {
        //        if (tableView == self.tableView) {
        CGFloat cornerRadius = 10.f;
        cell.backgroundColor = UIColor.clearColor;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
        BOOL addLine = NO;
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            addLine = YES;
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
        } else {
            CGPathAddRect(pathRef, nil, bounds);
            addLine = YES;
        }
        layer.path = pathRef;
        CFRelease(pathRef);
        //颜色修改
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.f].CGColor;
        layer.strokeColor=[UIColor clearColor].CGColor;
        if (addLine == YES) {
            CALayer *lineLayer = [[CALayer alloc] init];
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
//            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
            [layer addSublayer:lineLayer];
        }
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        [testView.layer insertSublayer:layer atIndex:0];
        testView.backgroundColor = UIColor.clearColor;
        cell.backgroundView = testView;
    }
}



@end
