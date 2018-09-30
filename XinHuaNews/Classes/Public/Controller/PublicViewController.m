//
//  PublicViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/13.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "PublicViewController.h"

@interface PublicViewController ()

@end

@implementation PublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setBackButton];
    self.view .backgroundColor = [UIColor whiteColor];
    [self setNoDataViews];
    // Do any additional setup after loading the view.
}

- (void)setNoDataViews {
    _noDataImageView = [UIImageView new];
    _noDataImageView.hidden = YES;
    [_noDataImageView setImage:[UIImage imageNamed:@"noDataImage"]];
    [self.view addSubview:_noDataImageView];
    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(100);
        make.height.equalTo(@160);
        make.width.equalTo(@230);
    }];
    
    _noDataLabel = [UILabel new];
    _noDataLabel.hidden = YES;
    _noDataLabel.text = @"暂无订阅内容~";
    _noDataLabel.textAlignment = NSTextAlignmentCenter;
    _noDataLabel.font = [UIFont systemFontOfSize:LargeFontSize];
    _noDataLabel.textColor = DominantGrayColor;
    [self.view addSubview:_noDataLabel];
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(@100);
        make.centerX.offset(0);
        make.top.equalTo(self.noDataImageView.mas_bottom).offset(20);
        make.height.equalTo(@20);
    }];
    
    _noDataButton = [UIButton new];
    _noDataButton.hidden = YES;
    _noDataButton.layer.masksToBounds = YES;
    _noDataButton.layer.cornerRadius = 17;
    [_noDataButton setTitle:@"去发现" forState:UIControlStateNormal];
    _noDataButton.titleLabel.font = [UIFont systemFontOfSize:LargeFontSize];
    _noDataButton.backgroundColor = DominantGrayColor;
    [self.view addSubview:_noDataButton];
    [_noDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.noDataLabel.mas_bottom).offset(100);
        make.height.equalTo(@34);
        make.width.equalTo(@110);
    }];
    
}

- (void)setBackButton {
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            leftBtn.frame = CGRectMake(0, 0, 25,25);
            [leftBtn setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
            [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        }
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
