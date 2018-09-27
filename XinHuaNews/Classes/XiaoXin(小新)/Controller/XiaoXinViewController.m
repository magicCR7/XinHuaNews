//
//  XiaoXinViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/13.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "XiaoXinViewController.h"

@interface XiaoXinViewController ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation XiaoXinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)setupViews {
    UIView *topV = [UIView new];
    topV.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:topV];
    self.topView = topV;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@64);
        make.top.left.right.equalTo(self.view);
    }];
    
    UIButton *closeBtn = [UIButton new];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:closeBtn];
    self.closeButton = closeBtn;
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY).offset(10);
        make.left.offset(10);
        make.height.width.equalTo(@20);
    }];
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
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
