//
//  XiaoXinViewController.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/13.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "XiaoXinViewController.h"
#import "WeChatCell.h"
#import "MessageModel.h"
#import "ConstantPart.h"
#import "TextTopView.h"

@interface XiaoXinViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) TextTopView *textTopView;
@property (nonatomic, strong) NSMutableArray<MessageModel *> *arrList;
@property (nonatomic, strong) UITextField *bottomTextField;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, strong) UIButton *voiceButton;

@end

@implementation XiaoXinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrList = [[NSMutableArray alloc] init];
    [self allocList];
    [self setupViews];
    //kvo键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)setupViews {
    _mainView = [UIView new];
    [self.view addSubview:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIView *topV = [UIView new];
    topV.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:topV];
    self.topView = topV;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@64);
        make.top.left.right.equalTo(self.mainView);
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
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"小新";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:HugeFontSize];
    [self.topView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.equalTo(self.closeButton.mas_centerY);
        make.height.equalTo(@30);
        make.width.greaterThanOrEqualTo(@50);
    }];
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.equalTo(@45);
    }];
    
    //语音按钮
    UIButton *voiceBtn = [UIButton new];
    [voiceBtn setImage:[UIImage imageNamed:@"voice-blue"] forState:UIControlStateNormal];
    [_bottomView addSubview:voiceBtn];
    self.voiceButton = voiceBtn;
    [voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.bottom.offset(-10);
        make.width.equalTo(@25);
    }];
    
    //文本框
    UIView *textView = [UIView new];
    [self.bottomView addSubview:textView];
    textView.layer.masksToBounds = YES;
    textView.layer.cornerRadius = 5.0f;
    textView.layer.borderColor = RGB(134, 142, 151).CGColor;
    textView.layer.borderWidth = 1.0f;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.bottom.offset(-7);
        make.top.offset(7);
        make.left.equalTo(self.voiceButton.mas_right).offset(10);
    }];

    
    _bottomTextField = [UITextField new];
    _bottomTextField.delegate = self;
    _bottomTextField.placeholder = @" 请输入信息";
    [_bottomTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textView addSubview:_bottomTextField];
    [_bottomTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(3);
        make.left.offset(7);
        make.bottom.right.offset(-3);
    }];
    
    //文本框上方滑动区域
    _textTopView = [TextTopView new];
    _textTopView.backgroundColor = RGB(244, 244, 244);
    [self.mainView addSubview:_textTopView];
    [self.textTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.height.equalTo(@50);
    }];
    
    _mainTableView=[[UITableView alloc] init];
    _mainTableView.backgroundColor = RGB(244, 244, 244);
    _mainTableView.separatorColor=[UIColor clearColor];
    _mainTableView.delegate=self;
    _mainTableView.dataSource=self;
    [self.mainView addSubview:_mainTableView];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
        make.left.right.offset(0);
        make.bottom.equalTo(self.textTopView.mas_top);
    }];
    
    
    
//    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.offset(-SCREEN_HEIGHT+300);
//    }];
}

-(void)allocList{
    MessageModel *model=[[MessageModel alloc] init];
    model.showMessageTime=YES;
    model.messageTime=@"11:22";
    model.messageText=@"你好你好你好";
    model.messageSenderType=MessageSenderTypeHantu;
    model.messageType=MessageTypeText;
    [_arrList addObject:model];
    
    model=[[MessageModel alloc] init];
    model.showMessageTime=YES;
    model.messageTime=@"11:25";
    model.messageText=@"你好";
    model.messageSenderType=MessageSenderTypeUser;
    model.messageType=MessageTypeText;
    [_arrList addObject:model];
    
    model=[[MessageModel alloc] init];
    model.showMessageTime=NO;
    model.messageText=@"天气如何";
    model.messageSenderType=MessageSenderTypeUser;
    model.messageType=MessageTypeText;
    [_arrList addObject:model];

    model=[[MessageModel alloc] init];
    model.showMessageTime=NO;
    model.messageSenderType=MessageSenderTypeHantu;
    model.messageType=MessageTypeWeather;
    [_arrList addObject:model];
    
    model=[[MessageModel alloc] init];
    model.showMessageTime=YES;
    model.messageTime = @"12:43";
    model.messageText=@"最近有啥好电影";
    model.messageSenderType=MessageSenderTypeUser;
    model.messageType=MessageTypeText;
    [_arrList addObject:model];
    
    model=[[MessageModel alloc] init];
    model.showMessageTime=NO;
    model.messageSenderType=MessageSenderTypeHantu;
    model.messageType=MessageTypeScrollList;
    [_arrList addObject:model];
    
    model=[[MessageModel alloc] init];
    model.showMessageTime=NO;
    model.messageText=@"我要订机票";
    model.messageSenderType=MessageSenderTypeUser;
    model.messageType=MessageTypeText;
    [_arrList addObject:model];
    
    model=[[MessageModel alloc] init];
    model.showMessageTime=NO;
    model.messageText=@"为您找到以下消息";
    model.messageSenderType=MessageSenderTypeHantu;
    model.messageType=MessageTypeText;
    [_arrList addObject:model];
    
    model=[[MessageModel alloc] init];
    model.showMessageTime=NO;
    model.messageSenderType=MessageSenderTypeHantu;
    model.messageType=MessageTypeAd;
    [_arrList addObject:model];
    
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)keyboardWillShow:(NSNotification *)noti{
    NSDictionary *info = [noti userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    _keyboardHeight = keyboardSize.height;
    [UIView animateWithDuration:2 animations:^{
        [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-self.keyboardHeight);
        }];
    }];
    
}
- (void)keyboardWillHide:(NSNotification *)noti{
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_bottomTextField resignFirstResponder];
    return YES;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"notice_hidden" object:nil];
    
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_arrList count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = _arrList[indexPath.row];
    if (model.messageType == MessageTypeWeather) {
        return 310;
    } else if (model.messageType == MessageTypeScrollList) {
        return 130;
    } else if (model.messageType == MessageTypeAd) {
        return 210;
    }
    return [WeChatCell tableHeightWithModel:_arrList[indexPath.row]];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeChatCell *cell=[WeChatCell cellWithTableView:_mainTableView messageModel:_arrList[indexPath.row]];
    cell.backgroundColor = RGB(244, 244, 244);
    
    [cell setDoubleClickBlock:^(MessageModel *model) {
        NSLog(@"%@-----",model.messageText);
    }];
    
    [cell setSingleblock:^(MessageModel *model) {
        if (model.messageType==MessageTypeVoice) {
            
        }else if (model.messageType==MessageTypeImage){
            
        }

    }];
//
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        if (_arrList.count>0) {
            [_mainTableView setContentOffset:CGPointMake(0, _mainTableView.contentSize.height -_mainTableView.bounds.size.height) animated:YES];
            
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
