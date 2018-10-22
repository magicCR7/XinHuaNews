//
//  SearchResultViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/18.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SearchResultViewController.h"
#import "UITextField+Placeholder.h"

@interface SearchResultViewController ()

@property (nonatomic, strong) UIView *navView;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self setNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

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
    seachText.text = self.searchTextStr;
    [topView addSubview:seachText];
    [seachText mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (void)back {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
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
