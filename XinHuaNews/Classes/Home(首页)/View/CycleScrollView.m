//
//  CycleScrollView.m
//  XinHuaNews
//
//  Created by Mc on 2018/9/18.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import "CycleScrollView.h"

#define ITEM_SIZE   5
#define DISTANCE    5
#define LONG 40
#define LONG_CHANGE LONG - ITEM_SIZE
#define PIC_DISTANCE 10
#define PIC_WIDTH self.frame.size.width - PIC_DISTANCE - 20
#define SCROLLVIEW_WIDTH self.x_width - 40

@interface CycleScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) NSMutableArray *pictureUrlArray;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, assign) NSInteger currentImageIndex;

@end

@implementation CycleScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.pictureUrlArray = [[NSMutableArray alloc] initWithArray:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536297085625&di=fc8859c1610123993f2d7522ec5a9968&imgtype=jpg&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D3575286103%2C725974528%26fm%3D214%26gp%3D0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536297117418&di=47422ac81e823e306f7cb8a86aceba7f&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D174092606%2C9164433%26fm%3D214%26gp%3D0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536235867333&di=b181cf1174610809c8670587f523e8ba&imgtype=0&src=http%3A%2F%2Fdesk.fd.zol-img.com.cn%2Fg2%2FM00%2F01%2F0F%2FCg-4WlVxBYqIZ_obAART2HPXZecAAErmQGpOp0ABFPw488.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536235867332&di=d00a39144f3015c9862013a6289b9c6f&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2F20%2F2049%2F204969%2F20496932_980x1200_0.jpg"]];
        self.picNum = self.pictureUrlArray.count;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.clipsToBounds = YES;
    //scrollView
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 0, self.x_width - 40, self.x_height)];
//    scrollV.backgroundColor = [UIColor lightGrayColor];
    scrollV.delegate = self;
    scrollV.pagingEnabled = true;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.clipsToBounds = NO;
    scrollV.contentSize = CGSizeMake((self.x_width - 40) * 4, 0);
    [self addSubview:scrollV];
    self.mainScrollView = scrollV;
    
    //imageview
    for (int i =0; i<self.picNum; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10 + i * (self.x_width - 40), 0, self.x_width -40 - 20, self.x_width - 40)];
//        [imageV setImage:[UIImage imageNamed:@"3"]];
        [imageV sd_setImageWithURL:[NSURL URLWithString:_pictureUrlArray[i]]];
        imageV.backgroundColor = [UIColor blueColor];
        [self.mainScrollView addSubview:imageV];

    }
    
    _circleView = [UIView new];
    _circleView.backgroundColor = [UIColor clearColor];
    [self addSubview:_circleView];
    [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-10);
        make.centerX.offset(0);
        make.height.equalTo(@(ITEM_SIZE+10));
        make.width.equalTo(@(ITEM_SIZE * self.picNum + DISTANCE * (self.picNum-1) +LONG_CHANGE));
    }];
    
    for (int i = 0; i<self.picNum; i++) {
        UIView *pointV = [[UIView alloc] init];
        pointV.backgroundColor = [UIColor whiteColor];
        pointV.layer.masksToBounds = YES;
        pointV.layer.cornerRadius = ITEM_SIZE/2;
        if (i == 0) {
            pointV.frame = CGRectMake(0, 10, LONG, ITEM_SIZE);
        } else {
            pointV.frame = CGRectMake(i*(ITEM_SIZE + DISTANCE) + LONG_CHANGE, 10, ITEM_SIZE, ITEM_SIZE);
        }
        pointV.tag = i;
        [self.circleView addSubview:pointV];
    }
}

- (void)relaodImage {
    
}

@end
