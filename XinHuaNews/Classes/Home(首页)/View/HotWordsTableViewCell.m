
//
//  HotWordsTableViewCell.m
//  XinHuaNews
//
//  Created by Mc on 2018/10/17.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "HotWordsTableViewCell.h"

@interface HotWordsTableViewCell()

@property (nonatomic, assign) int lineNum;
@property (nonatomic, strong) UIView *mainView;

@end

@implementation HotWordsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    _lineNum = ceil(dataArray.count/5.0);
    [self setupViews];
}

- (void)setupViews {
    float btnHeight = 23.0f;
    float horizonGap = 15.0f;
    float  verticalGap = 8.0f;
    float viewHeight = (btnHeight + verticalGap) * _lineNum + verticalGap;
    _mainView = [UIView new];
//    _mainView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.height.equalTo(@(viewHeight));
    }];
    int currentLineNum = 0;//当前是第几列
    float btn_x = 0;//当前btn的x坐标
    float lastBtnWidth = 0;//上一个btn的宽度
    int currentHorizonNum = 0;//当前行数
    for (int i = 0; i < _dataArray.count; i++) {
        UIButton *btn = [UIButton new];
        btn.backgroundColor = RGB(96, 96, 96, 0.1);
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[NSString stringWithFormat:@"%@",_dataArray[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:SmallFontSize];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5.0f;
        float btnWidth = [self getButtonLengthWithString:_dataArray[i]];
        
        if (i>0) {
            lastBtnWidth = [self getButtonLengthWithString:_dataArray[i-1]];
        }
        if (i%5 == 0) {
            currentLineNum = 0;
            btn_x = 0;
            lastBtnWidth = 0;
        } else {
            currentLineNum++;
        }
        
        btn_x = btn_x + horizonGap + lastBtnWidth;
        btn.frame = CGRectMake(btn_x, (verticalGap + btnHeight)*0 + (verticalGap + btnHeight)*currentHorizonNum + verticalGap, btnWidth, btnHeight);
        if (currentLineNum == 4) {
            currentHorizonNum++;
        }
        [self.mainView addSubview:btn];
    }
}

//计算btn的长度
- (float)getButtonLengthWithString:(NSString *)str {
    if (str.length > 0) {
        float length = (str.length * 11) + 20;
        return length;
    }
    return 0;
}

- (void)buttonClicked:(UIButton *)sender {
    if (self.hotWordsBlock) {
        self.hotWordsBlock(sender.titleLabel.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
