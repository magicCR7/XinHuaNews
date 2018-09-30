//
//  MySubscribeViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/28.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "MySubscribeViewController.h"
#import "SubscribeAccountViewController.h"
#import "GovermentAccountViewController.h"

@interface MySubscribeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *subscribeButton;
@property (nonatomic, strong) UIButton *govermentButton;
@property (nonatomic, strong) UIView *leftBlueLine;
@property (nonatomic, strong) UIView *rightBlurLine;

@end

@implementation MySubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订阅";
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)setupViews {
    SubscribeAccountViewController *subscribeVc = [[SubscribeAccountViewController alloc] init];
    [self addChildViewController:subscribeVc];
    GovermentAccountViewController *govermentVc = [[GovermentAccountViewController alloc] init];
    [self addChildViewController:govermentVc];
    [self topView];
    
    UIScrollView *mainScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Statusbar_Height + Nav_Height + 40, SCREEN_WIDTH, SCREEN_HEIGHT - 60)];
    mainScrollV.delegate = self;
    mainScrollV.pagingEnabled = YES;
    mainScrollV.showsHorizontalScrollIndicator = NO;
    mainScrollV.showsVerticalScrollIndicator = NO;
    mainScrollV.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    subscribeVc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, mainScrollV.x_height);
    govermentVc.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, mainScrollV.x_height);
    [mainScrollV addSubview:subscribeVc.view];
    [mainScrollV addSubview:govermentVc.view];
    [self.view addSubview:mainScrollV];
    self.mainScrollView = mainScrollV;
    
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, Statusbar_Height + Nav_Height, SCREEN_WIDTH, 40)];
        _topView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_topView];
        
        _subscribeButton = [UIButton new];
        [_subscribeButton addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _subscribeButton.tag = 101;
        [_subscribeButton setTitle:@"订阅号" forState:UIControlStateNormal];
        [_subscribeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_subscribeButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:LargeFontSize]];
        [self.topView addSubview:_subscribeButton];
        [self.subscribeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(0);
            make.right.equalTo(self.topView.mas_centerX);
            make.height.equalTo(@38);
        }];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = lineColor;
        [self.topView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0.8);
            make.bottom.offset(-6);
            make.height.equalTo(@20);
            make.left.equalTo(self.subscribeButton.mas_right);
        }];
        
        _govermentButton = [UIButton new];
        [_govermentButton addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _govermentButton.tag = 102;
        [_govermentButton setTitle:@"政务号" forState:UIControlStateNormal];
        [_govermentButton setTitleColor:DominantGrayColor forState:UIControlStateNormal];
        [_govermentButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:LargeFontSize]];
        [self.topView addSubview:_govermentButton];
        [self.govermentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.offset(0);
            make.left.equalTo(lineView.mas_right);
            make.height.equalTo(@38);
        }];
        
        UIView *bottomLine = [UIView new];
        bottomLine.backgroundColor = lineColor;
        [self.topView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.equalTo(@0.6);
        }];
        
        _leftBlueLine = [UIView new];
        _leftBlueLine.backgroundColor = DominantColor;
        [self.topView addSubview:_leftBlueLine];
        [_leftBlueLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.subscribeButton.mas_centerX);
            make.height.equalTo(@2);
            make.width.equalTo(@20);
            make.bottom.offset(0);
        }];
        
        _rightBlurLine = [UIView new];
        _rightBlurLine.hidden = YES;
        _rightBlurLine.backgroundColor = DominantColor;
        [self.topView addSubview:_rightBlurLine];
        [_rightBlurLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.govermentButton.mas_centerX);
            make.height.equalTo(@2);
            make.width.equalTo(@20);
            make.bottom.offset(0);
        }];
    }
    return _topView;
}

#pragma mark - 顶部按钮点击 切换页面
- (void)topButtonClicked:(UIButton *)sender {
    if (sender.tag == 101) {
        self.mainScrollView.contentOffset = CGPointMake(0, 0);
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.govermentButton setTitleColor:DominantGrayColor forState:UIControlStateNormal];
        _leftBlueLine.hidden = NO;
        _rightBlurLine.hidden = YES;
    } else if (sender.tag == 102) {
        self.mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        [self.subscribeButton setTitleColor:DominantGrayColor forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftBlueLine.hidden = YES;
        _rightBlurLine.hidden = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.mainScrollView.contentOffset.x == 0) {
        [self.subscribeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.govermentButton setTitleColor:DominantGrayColor forState:UIControlStateNormal];
        _leftBlueLine.hidden = NO;
        _rightBlurLine.hidden = YES;
    } else {
        [self.subscribeButton setTitleColor:DominantGrayColor forState:UIControlStateNormal];
        [self.govermentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftBlueLine.hidden = YES;
        _rightBlurLine.hidden = NO;
    }
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
