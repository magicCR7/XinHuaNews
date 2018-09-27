//
//  SettingViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/26.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SettingViewController.h"
#import "FileTool.h"
#import "SettingTableViewCell.h"

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *section1TitleAry;
@property (nonatomic, strong) NSArray *section2TitleAry;
@property (assign,nonatomic) NSInteger totalSize;
@property (nonatomic, copy) NSString *netStatusStr;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setupViews];
    _netStatusStr = @"仅WiFi下";
    _section1TitleAry = [[NSArray alloc] initWithObjects:@"正文字号",@"夜间模式",@"无图模式",@"直播自动播放",@"退出直播时小窗播放", nil];
    _section2TitleAry = [[NSArray alloc] initWithObjects:@"清理缓存",@"版本更新",@"关于", nil];
}

- (void)setupViews {
    UITableView *mainTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    mainTableV.delegate = self;
    mainTableV.dataSource = self;
    mainTableV.showsVerticalScrollIndicator = NO;
    //    mainTableV.estimatedRowHeight = 150;
    //    mainTableV.rowHeight = UITableViewAutomaticDimension;
//    mainTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableV.sectionFooterHeight = 0.01;
    mainTableV.sectionHeaderHeight = 10;
    [self.view addSubview:mainTableV];
    self.mainTableView = mainTableV;
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.offset(0);
        make.top.offset(-Statusbar_Height);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.01;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0.01;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:{
            return 1;
        }break;
        case 1:{
            return _section1TitleAry.count;
        }break;
        case 2:{
            return _section2TitleAry.count;
        }break;
            
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SettingTableViewCell";
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
//    UILabel *rightLabel = [[UILabel alloc] init]; //定义一个在cell最右边显示的label
//    rightLabel.text = _netStatusStr;
//    rightLabel.font = [UIFont boldSystemFontOfSize:LittleFontSize];
//    [rightLabel sizeToFit];
//    rightLabel.backgroundColor = [UIColor clearColor];
//    rightLabel.frame =CGRectMake(SCREEN_WIDTH -rightLabel.x_width - 10, (50 - rightLabel.x_height)/2, rightLabel.x_width, rightLabel.x_height);
//    rightLabel.backgroundColor = [UIColor clearColor];
//    rightLabel.textColor = DominantGrayColor;
    switch (indexPath.section) {
        case 0:{
            cell.textLabel.text = @"账号设置";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }break;
        case 1:{
            if (indexPath.row == 0) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            } else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4) {
                UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                switchView.onTintColor = DominantColor;
                switchView.tag = indexPath.row;
                if (indexPath.row == 4) {
                    [switchView setOn:YES];
                }
                [switchView addTarget:self action:@selector(swicthValueChange:) forControlEvents:UIControlEventValueChanged];
                cell.accessoryView = switchView;
            } else if (indexPath.row == 3) {
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = _netStatusStr;
//                [cell.contentView addSubview:_rightLabel];
            }
            cell.textLabel.text = _section1TitleAry[indexPath.row];
        }break;
        case 2:{
            if (indexPath.row == 0) {
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = [self sizeStr];
            } else if (indexPath.row == 1) {
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = @"V5.1.0";
            } else if (indexPath.row == 2) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textLabel.text = _section2TitleAry[indexPath.row];
        }
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            
        }break;
        case 1:{
            if (indexPath.row == 0) {
                
            } else if (indexPath.row == 3) {
                [self showActionSheet];
            }
        }break;
        case 2:{
            switch (indexPath.row) {
                case 0:{//清除缓存
                    if (_totalSize == 0) {
                        [self showAlertController:@"无需清理"];
                    } else {
                        [FileTool removeDirectoryPath:CachePath];
                        _totalSize = 0;
                        [self showAlertController:@"清理成功"];
                        [self.mainTableView reloadData];
                    }
                }break;
                case 1:{
                    
                }break;
                case 2:{
                    
                }break;
                    
                default:
                    break;
            }
        }break;
            
        default:
            break;
    }
}

#pragma mark - valueChange
- (void)swicthValueChange:(UISwitch *)sender {
    
}

//提示框
- (void)showAlertController:(NSString *)str {
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [controller addAction:act1];
    [self presentViewController:controller animated:YES completion:^{
        
    }];

}

//底部提示框
- (void)showActionSheet {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:nil
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet] ;
    [alert addAction:[UIAlertAction
                      actionWithTitle:@"从不"
                      style:UIAlertActionStyleDefault
                      handler:^(UIAlertAction *
                                _Nonnull action) {
                          self.netStatusStr = @"从不";
                          [self.mainTableView reloadData];
                      }]] ;
    
    [alert addAction:[UIAlertAction
                      actionWithTitle:@"仅WiFi下"
                      style:UIAlertActionStyleDefault
                      handler:^(UIAlertAction *
                                _Nonnull action) {
                          self.netStatusStr = @"仅WiFi下";
                          [self.mainTableView reloadData];
                      }]] ;
    [alert addAction:[UIAlertAction
                      actionWithTitle:@"所有网络下"
                      style:UIAlertActionStyleDefault
                      handler:^(UIAlertAction *
                                _Nonnull action) {
                          self.netStatusStr = @"所有网络下";
                          [self.mainTableView reloadData];
                      }]] ;
    
    
    
    [alert addAction:[UIAlertAction
                      actionWithTitle:@"取消"
                      style:UIAlertActionStyleCancel
                      handler:^(UIAlertAction *
                                _Nonnull action) {
                          
                      }]] ;

    [self
     presentViewController:alert
     animated:YES
     completion:^{
     }] ;
}

//计算缓存
- (NSString *)sizeStr{
    
    NSInteger totalSize = _totalSize;
    NSString *sizeStr;
//    if (totalSize > 1000*1000) {
        //MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%.1fMB",sizeF];
//    }else if (totalSize > 1000){
//        //KB
//        CGFloat sizeF = totalSize / 1000.0;
//        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
//    }else if (totalSize > 0){
//        //b
//        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
//    }
    return sizeStr;
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
