
//
//  SuggestionViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/30.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "SuggestionViewController.h"
#import "PhoneModel.h"
#import "PlaceholderTextView.h"


@interface SuggestionViewController ()<UITextViewDelegate>

@property (nonatomic, copy) NSString *phoneModelStr;
@property (nonatomic, copy) NSString *phoneVersionStr;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) PlaceholderTextView *textView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@end

@implementation SuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    _phoneModelStr = [PhoneModel getPhoneModel];
    _phoneVersionStr = [[UIDevice currentDevice] systemVersion];
    self.view.backgroundColor = RGB(239, 239, 239, 1);
    [self setupViews];
}

- (void)setupViews {
    
    //发送
    _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarItemClick:)];
    [_rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:LittleFontSize],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [_rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:LittleFontSize],NSFontAttributeName, nil] forState:UIControlStateHighlighted];
    [_rightItem setTintColor:DominantGrayColor];
    self.navigationItem.rightBarButtonItem = _rightItem;
    
    
    UIView *mainV = [UIView new];
    mainV.layer.masksToBounds = YES;
    mainV.layer.cornerRadius = 5;
    mainV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainV];
    self.mainView = mainV;
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(Statusbar_Height + Nav_Height + 10);
        make.right.offset(-10);
        make.height.equalTo(@200);
    }];
    
    //字数Label
    _countLabel = [UILabel new];
    _countLabel.text = @"0/300";
    _countLabel.textColor = DominantGrayColor;
    _countLabel.textAlignment = NSTextAlignmentRight;
    _countLabel.font = [UIFont systemFontOfSize:LittleFontSize];
    [self.mainView addSubview:_countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(-10);
        make.height.equalTo(@(NormalFontSize));
        make.width.greaterThanOrEqualTo(@20);
    }];
    
    _textView = [PlaceholderTextView new];
    _textView.placeholder = @"请输入您的反馈，我们将为您不断改进";
    _textView.delegate = self;
    _textView.placeholderColor = DominantGrayColor;
    _textView.font = [UIFont systemFontOfSize:NormalFontSize];
    [self.mainView addSubview:_textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-30);
    }];
    
    _detailLabel = [UILabel new];
    _detailLabel.text = [NSString stringWithFormat:@"设备：%@ 系统：%@ 版本：5.1.0",_phoneModelStr,_phoneVersionStr];
    _detailLabel.textColor = DominantGrayColor;
    _detailLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    [self.view addSubview:_detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView);
        make.top.equalTo(self.mainView.mas_bottom).offset(10);
        make.height.equalTo(@(LittleFontSize));
        make.width.greaterThanOrEqualTo(@100);
    }];
}

- (void)rightBarItemClick:(UIBarButtonItem *)sender {
    
}

#pragma mark - textViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length != 0) {
        [_rightItem setTintColor:DominantColor];
    } else {
        [_rightItem setTintColor:DominantGrayColor];
    }
    _countLabel.text = [NSString stringWithFormat:@"%lu/300", (unsigned long) textView.text.length];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    if (range.location >= 300)
    {
        return  NO;
    }
    else
    {
        return YES;
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
