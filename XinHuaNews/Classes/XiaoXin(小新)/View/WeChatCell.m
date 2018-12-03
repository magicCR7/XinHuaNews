//
//  WeChatCell.m
//  HanTu
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WeChatCell.h"

#import "MessageModel.h"
#import "Masonry.h"
#import "ConstantPart.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"




#define LEFT_WITH (AppFrameWidth>750?55:52.5)
#define RIGHT_WITH (AppFrameWidth>750?89:73)

// 1s  length 75
// 60s  6~197 6p~230

#define MAX_IMAGE_WH 141.0





#define DEF_ICON @"xiaoXinLogo"





@implementation WeChatCell


+(instancetype)cellWithTableView:(UITableView *)tableView messageModel:(MessageModel *)model{
    
    static NSString *identifier = @"WeChatCell";
    
    WeChatCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell!=nil) {
        cell=nil;
    }
    cell = [[WeChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier messageModel:model];
 
    return cell;
   
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageModel:(MessageModel *)model{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        self.messageModel=model;

        for (UIView *v  in [self.contentView subviews]) {
            [v removeFromSuperview];
        }

         CGFloat masTop=10;
        
        if (model.showMessageTime) {
            
            masTop=37;
        
            UILabel *timeLabel=[[UILabel alloc] init];
            timeLabel.font=[UIFont fontWithName:FONT_REGULAR size:10];
            timeLabel.backgroundColor=COLOR_cecece;
            timeLabel.textColor=COLOR_ffffff;
            timeLabel.text=model.messageTime;
            timeLabel.textAlignment=NSTextAlignmentCenter;
            timeLabel.layer.masksToBounds=YES;
            timeLabel.layer.cornerRadius=4;
            timeLabel.layer.borderColor=[COLOR_cecece CGColor];
            timeLabel.layer.borderWidth=1;
            [self.contentView addSubview:timeLabel];
            [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView.mas_top).offset(10);
                make.centerX.equalTo(self.contentView);
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(17);
            }];
            
        }
        
        
        
        UIImageView *contextBack=[[UIImageView alloc] init];
        contextBack.userInteractionEnabled=YES;
        
        
        self.coversImageView=[[UIImageView alloc] init];
        self.coversImageView.userInteractionEnabled=YES;
    
        if (model.messageType==MessageTypeText) {
            
            // 是用户 还是韩图客服
            if (model.messageSenderType==MessageSenderTypeHantu) {
                
                
                UIImageView *logoImage=[[UIImageView alloc] init];
                logoImage.frame=CGRectMake(10, masTop, 40, 40);
                [logoImage setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:DEF_ICON]];
                [self.contentView addSubview:logoImage];
                
                
                
                CGFloat maxWith=AppFrameWidth-LEFT_WITH-RIGHT_WITH-14-12-4;
                
                UIFont *textFont=[UIFont fontWithName:FONT_REGULAR size:16];
                
                
                NSDictionary *attributes = @{NSFontAttributeName: textFont};
                
                CGRect rect = [model.messageText boundingRectWithSize:CGSizeMake(maxWith, MAXFLOAT)
                               
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                               
                                                           attributes:attributes
                               
                                                              context:nil];
 
                contextBack.frame=CGRectMake(LEFT_WITH, masTop, rect.size.width+26, rect.size.height+26);
                contextBack.image=[[UIImage imageNamed:@"wechatback1"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
                [self.contentView addSubview:contextBack];
         
                UILabel *textMessageLabel=[[UILabel alloc] init];
                textMessageLabel.frame=CGRectMake(LEFT_WITH+12, masTop+14, rect.size.width, rect.size.height);
                textMessageLabel.numberOfLines=0;
                textMessageLabel.lineBreakMode=NSLineBreakByWordWrapping;
                textMessageLabel.font=textFont;
                textMessageLabel.textColor=COLOR_444444;
                textMessageLabel.text=model.messageText;
                [self.contentView addSubview:textMessageLabel];
                
           
            }else if (model.messageSenderType==MessageSenderTypeUser){
                
               UIImageView *logoImage=[[UIImageView alloc] init];
                logoImage.frame=CGRectMake(AppFrameWidth-10-40, masTop, 40, 40);
                [logoImage setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:DEF_ICON]];
                [self.contentView addSubview:logoImage];
                
                CGFloat maxWith=AppFrameWidth-LEFT_WITH-RIGHT_WITH-14-12-4;
                UIFont *textFont=[UIFont fontWithName:FONT_REGULAR size:16];
                NSDictionary *attributes = @{NSFontAttributeName: textFont};
                CGRect rect = [model.messageText boundingRectWithSize:CGSizeMake(maxWith, MAXFLOAT)
                               
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                               
                                                           attributes:attributes
                               
                                                              context:nil];
             
                contextBack.frame=CGRectMake(AppFrameWidth-(rect.size.width+26)-LEFT_WITH, masTop, rect.size.width+26, rect.size.height+26);
                contextBack.image=[[UIImage imageNamed:@"wechatback2"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
                [self.contentView addSubview:contextBack];
               
                
             
                
                UILabel *textMessageLabel=[[UILabel alloc] init];
                textMessageLabel.frame=CGRectMake(AppFrameWidth-(rect.size.width+26)-LEFT_WITH+12, masTop+14, rect.size.width, rect.size.height);
                textMessageLabel.numberOfLines=0;
                textMessageLabel.lineBreakMode=NSLineBreakByWordWrapping;
                textMessageLabel.font=textFont;
                textMessageLabel.textColor=COLOR_444444;
                textMessageLabel.text=model.messageText;
                [self.contentView addSubview:textMessageLabel];
                
            }
#pragma mark - weather
        } else if (model.messageType==MessageTypeWeather){
            if (model.messageSenderType==MessageSenderTypeHantu){
                UIImageView *logoImage=[[UIImageView alloc] init];
                logoImage.frame=CGRectMake(10, masTop, 40, 40);
                [logoImage setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:DEF_ICON]];
                [self.contentView addSubview:logoImage];

                contextBack.frame=CGRectMake(LEFT_WITH, masTop, 250, 280);
                contextBack.image=[[UIImage imageNamed:@"wechatback1"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
                [self.contentView addSubview:contextBack];
                contextBack.layer.masksToBounds = YES;
                
                UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(5,0,245,280)];
                mainView.layer.masksToBounds = YES;
                mainView.layer.cornerRadius = 5;
//                mainView.backgroundColor = [UIColor blueColor];
                [contextBack addSubview:mainView];
                
                UIImageView *topImageView = [[UIImageView alloc] init];
                [topImageView setImage:[UIImage imageNamed:@"3"]];
                [mainView addSubview:topImageView];
                [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.top.offset(0);
                    make.height.equalTo(@80);
                }];
                
                UILabel *nowTempLabel = [UILabel new];
                nowTempLabel.font = [UIFont systemFontOfSize:70];
                nowTempLabel.textColor = [UIColor whiteColor];
                nowTempLabel.text = @"10°";
                nowTempLabel.textAlignment = NSTextAlignmentCenter;
                [mainView addSubview:nowTempLabel];
                [nowTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(topImageView);
                    make.width.equalTo(@110);
                }];
                
                UILabel *weatherLab = [UILabel new];
                weatherLab.text = @"阴转晴";
                weatherLab.textColor = [UIColor whiteColor];
                weatherLab.font = [UIFont systemFontOfSize:22];
                [mainView addSubview:weatherLab];
                [weatherLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(nowTempLabel.mas_right);
                    make.width.greaterThanOrEqualTo(@50);
                    make.height.equalTo(@25);
                    make.top.offset(20);
                }];
                
                UILabel *tempLab = [UILabel new];
                tempLab.text = @"1°~10°";
                tempLab.textColor = [UIColor whiteColor];
                tempLab.font = [UIFont systemFontOfSize:22];
                [mainView addSubview:tempLab];
                [tempLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(nowTempLabel.mas_right);
                    make.width.greaterThanOrEqualTo(@50);
                    make.top.equalTo(weatherLab.mas_bottom);
                    make.bottom.equalTo(nowTempLabel.mas_bottom).offset(-10);
                }];
                
                UILabel *locationLab = [UILabel new];
                locationLab.text = @"济南市今天阴转晴";
                locationLab.font = [UIFont systemFontOfSize:NormalFontSize];
                [mainView addSubview:locationLab];
                [locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(8);
                    make.top.equalTo(topImageView.mas_bottom).offset(15);
                    make.width.greaterThanOrEqualTo(@30);
                    make.height.equalTo(@(NormalFontSize));
                }];
                
                UILabel *nowTempLab2 = [UILabel new];
                nowTempLab2.text = @"实时：10°C";
                nowTempLab2.textColor = RGB(134, 142, 151);
                nowTempLab2.font = [UIFont systemFontOfSize:LittleFontSize];
                [mainView addSubview:nowTempLab2];
                [nowTempLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(8);
                    make.top.equalTo(locationLab.mas_bottom).offset(15);
                    make.width.greaterThanOrEqualTo(@30);
                    make.height.equalTo(@(LittleFontSize));
                }];
                
                UILabel *tempLab2 = [UILabel new];
                tempLab2.text = @"温度：0°C~10°C";
                tempLab2.textColor = RGB(134, 142, 151);
                tempLab2.font = [UIFont systemFontOfSize:LittleFontSize];
                [mainView addSubview:tempLab2];
                [tempLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(8);
                    make.top.equalTo(nowTempLab2.mas_bottom).offset(8);
                    make.width.greaterThanOrEqualTo(@30);
                    make.height.equalTo(@(LittleFontSize));
                }];
                
                UILabel *windLab = [UILabel new];
                windLab.text = @"风力：北风微风";
                windLab.textColor = RGB(134, 142, 151);
                windLab.font = [UIFont systemFontOfSize:LittleFontSize];
                [mainView addSubview:windLab];
                [windLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(8);
                    make.top.equalTo(tempLab2.mas_bottom).offset(8);
                    make.width.greaterThanOrEqualTo(@30);
                    make.height.equalTo(@(LittleFontSize));
                }];
                
                UILabel *airQualityLab = [UILabel new];
                airQualityLab.text = @"空气质量指数：80，良";
                airQualityLab.textColor = RGB(134, 142, 151);
                airQualityLab.font = [UIFont systemFontOfSize:LittleFontSize];
                [mainView addSubview:airQualityLab];
                [airQualityLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(8);
                    make.top.equalTo(windLab.mas_bottom).offset(8);
                    make.width.greaterThanOrEqualTo(@30);
                    make.height.equalTo(@(LittleFontSize));
                }];
                
                UILabel *sourceLab = [UILabel new];
                sourceLab.text = @"来源：中国天气网";
                sourceLab.textColor = RGB(134, 142, 151);
                sourceLab.font = [UIFont systemFontOfSize:LittleFontSize];
                [mainView addSubview:sourceLab];
                [sourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(8);
                    make.top.equalTo(airQualityLab.mas_bottom).offset(8);
                    make.width.greaterThanOrEqualTo(@30);
                    make.height.equalTo(@(LittleFontSize));
                }];
                
                UILabel *lineLab = [UILabel new];
                lineLab.backgroundColor = RGB(134, 142, 151);
                [mainView addSubview:lineLab];
                [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.offset(0);
                    make.top.equalTo(sourceLab.mas_bottom).offset(8);
                    make.height.equalTo(@0.7);
                }];
                
                UIButton *moreButton = [UIButton new];
                [moreButton setTitle:@"查看更多" forState:UIControlStateNormal];
                moreButton.titleLabel.font = [UIFont systemFontOfSize:LittleFontSize];
                [moreButton setTitleColor:RGB(63, 120, 217) forState:UIControlStateNormal];
                [mainView addSubview:moreButton];
                [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.offset(-15);
                    make.bottom.offset(-8);
                    make.top.equalTo(lineLab.mas_bottom).offset(8);
                    make.width.greaterThanOrEqualTo(@10);
                }];
             
            }
#pragma scrllList
        } else if (model.messageType == MessageTypeScrollList) {
            if (model.messageSenderType==MessageSenderTypeHantu){
                UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
                scrollV.backgroundColor = [UIColor whiteColor];
                scrollV.contentSize = CGSizeMake(108*6+8, 0);
                scrollV.showsHorizontalScrollIndicator = NO;

                for (int i=0; i<6; i++) {
                    UIView *oneView = [UIView new];
                    oneView.frame = CGRectMake(8+108*i, 0, 100, 120);
                    [scrollV addSubview:oneView];
                    //添加图片 名字
                    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 100, 80)];
                    [image setImage:[UIImage imageNamed:@"3"]];
                    [oneView addSubview:image];
                    
                    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 97, 100, 15)];
                    titleLab.text = @"电影：神探夏洛克";
                    titleLab.font = [UIFont systemFontOfSize:SmallFontSize];
                    [oneView addSubview:titleLab];
                }
                [self.contentView addSubview:scrollV];
            }
#pragma mark - Ad
        } else if (model.messageType == MessageTypeAd) {
            if (model.messageSenderType==MessageSenderTypeHantu){
                UIImageView *logoImage=[[UIImageView alloc] init];
                logoImage.frame=CGRectMake(10, masTop, 40, 40);
                [logoImage setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:DEF_ICON]];
                [self.contentView addSubview:logoImage];
                
                contextBack.frame=CGRectMake(LEFT_WITH, masTop, 250, 180);
                contextBack.image=[[UIImage imageNamed:@"wechatback1"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
                [self.contentView addSubview:contextBack];
                contextBack.layer.masksToBounds = YES;
                
                UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(5,0,245,180)];
                mainView.layer.masksToBounds = YES;
                mainView.layer.cornerRadius = 5;
                //                mainView.backgroundColor = [UIColor blueColor];
                [contextBack addSubview:mainView];
                
                UIImageView *topImageView = [[UIImageView alloc] init];
                [topImageView setImage:[UIImage imageNamed:@"xieCheng"]];
                [mainView addSubview:topImageView];
                [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.top.offset(0);
                    make.height.equalTo(@90);
                }];
                
                UILabel *bottomLab = [UILabel new];
                bottomLab.numberOfLines = 0;
                bottomLab.text = @"携程旅行网是中国领先的在线旅行服务公司，向超过9000万会员提供酒店预订、酒店点评及特价酒店查询、机票预订、飞机票查询、时刻...";
                bottomLab.textColor = RGB(134, 142, 151);
                bottomLab.font = [UIFont systemFontOfSize:SmallFontSize];
                [mainView addSubview:bottomLab];
                [bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(8);
                    make.right.bottom.offset(-8);
                    make.top.equalTo(topImageView.mas_bottom).offset(-8);
                }];
            }
        } else if (model.messageType==MessageTypeVoice){
 
            self.voiceAnimationImageView=[[UIImageView alloc] init];
            self.voiceAnimationImageView.animationRepeatCount = 0;
            self.voiceAnimationImageView.animationDuration = 2;
            
            // 是用户 还是韩图客服
            if (model.messageSenderType==MessageSenderTypeHantu) {
                UIImageView *logoImage=[[UIImageView alloc] init];
                logoImage.frame=CGRectMake(10, masTop, 40, 40);
                [logoImage setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:DEF_ICON]];
                [self.contentView addSubview:logoImage];
                
                contextBack.frame=CGRectMake(LEFT_WITH, masTop, [self voiceLength:model.duringTime], 40);
                contextBack.image=[[UIImage imageNamed:@"wechatback1"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
                //                textBackImage.userInteractionEnabled=YES;
                [self.contentView addSubview:contextBack];

                self.voiceAnimationImageView.frame=CGRectMake(12, 12, 12, 16);
                self.voiceAnimationImageView.image=[UIImage imageNamed:@"wechatvoice3"];

                self.voiceAnimationImageView.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"wechatvoice3"],[UIImage imageNamed:@"wechatvoice3_1"],[UIImage imageNamed:@"wechatvoice3_0"],[UIImage imageNamed:@"wechatvoice3_1"],[UIImage imageNamed:@"wechatvoice3"],nil];
                [contextBack addSubview:self.voiceAnimationImageView];
                
                
                
                
                
                
            }else if (model.messageSenderType==MessageSenderTypeUser){
                
                
                
                
                UIImageView *logoImage=[[UIImageView alloc] init];
                logoImage.frame=CGRectMake(AppFrameWidth-10-40, masTop, 40, 40);
                [logoImage setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:DEF_ICON]];
                [self.contentView addSubview:logoImage];
                
                
                contextBack.frame=CGRectMake(AppFrameWidth-LEFT_WITH-[self voiceLength:model.duringTime], masTop, [self voiceLength:model.duringTime], 40);
                contextBack.image=[[UIImage imageNamed:@"wechatback2"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
                [self.contentView addSubview:contextBack];
                
               
                self.voiceAnimationImageView.frame=CGRectMake([self voiceLength:model.duringTime]-12-11, 12, 11, 16);
                self.voiceAnimationImageView.image=[UIImage imageNamed:@"wechatvoice4"];
                self.voiceAnimationImageView.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"wechatvoice4"],[UIImage imageNamed:@"wechatvoice4_1"],[UIImage imageNamed:@"wechatvoice4_0"],[UIImage imageNamed:@"wechatvoice4_1"],[UIImage imageNamed:@"wechatvoice4"],nil];
                [contextBack addSubview:self.voiceAnimationImageView];
                
                
            }
            

            
        }else if (model.messageType==MessageTypeImage){
            
            // 是用户 还是韩图客服
            if (model.messageSenderType==MessageSenderTypeHantu) {
                
                
                UIImageView *logoImage=[[UIImageView alloc] init];
                logoImage.frame=CGRectMake(10, masTop, 40, 40);
                [logoImage setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:DEF_ICON]];
                [self.contentView addSubview:logoImage];
                
                
                CGSize imageSize=[WeChatCell imageShowSize:model.imageSmall];
                
                
                UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"wechatback1"] stretchableImageWithLeftCapWidth:10 topCapHeight:25]];
                imageViewMask.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
                
                
              
                contextBack.frame=CGRectMake(LEFT_WITH, masTop, imageSize.width, imageSize.height);
                contextBack.image=model.imageSmall;
                contextBack.layer.mask = imageViewMask.layer;
                [self.contentView addSubview:contextBack];
                
               
                
                
                
            }else if (model.messageSenderType==MessageSenderTypeUser){
                
                
                
                
                UIImageView *logoImage=[[UIImageView alloc] init];
                logoImage.frame=CGRectMake(AppFrameWidth-10-40, masTop, 40, 40);
                [logoImage setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:DEF_ICON]];
                [self.contentView addSubview:logoImage];
                
                
                
                CGSize imageSize=[WeChatCell imageShowSize:model.imageSmall];
                
                UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"wechatback2"] stretchableImageWithLeftCapWidth:10 topCapHeight:25]];
                imageViewMask.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
                
                contextBack.frame=CGRectMake(AppFrameWidth-LEFT_WITH-imageSize.width, masTop, imageSize.width, imageSize.height);
                contextBack.image=model.imageSmall;
                contextBack.layer.mask = imageViewMask.layer;
                [self.contentView addSubview:contextBack];

                
            }

        }

        
        UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressBubbleView:)];
        [contextBack addGestureRecognizer:longPressGesture];
        
        
        UITapGestureRecognizer * singleTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        UITapGestureRecognizer * doubleTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [contextBack addGestureRecognizer:doubleTap];
        [contextBack addGestureRecognizer:singleTap];
        
        
        self.coversImageView.frame=contextBack.frame;
       
       
        if (model.messageSenderType==MessageSenderTypeHantu) {
             self.coversImageView.image=[[UIImage imageNamed:@"wechatback1cover"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
        }else{
             self.coversImageView.image=[[UIImage imageNamed:@"wechatback2cover"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
        }
        
         [self.contentView addSubview:self.coversImageView];
        self.coversImageView.hidden=YES;
        
        UITapGestureRecognizer * singleTap2    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap2:)];
         [self.coversImageView addGestureRecognizer:singleTap2];
        
        
        
            if (model.messageSenderType==MessageSenderTypeUser) {
            
            
                /// 送达状态仅仅针对 用户
                
                
                // 只有送达成功 才会出现 已读 和 未读的情况  text
                if (model.messageSentStatus==MessageSentStatusSended) {
                    
                    UILabel *readStatusLabel=[[UILabel alloc] init];
                    readStatusLabel.font=[UIFont fontWithName:FONT_REGULAR size:12];
                    
                    if (model.messageReadStatus==MessageReadStatusRead) {
                        
                        readStatusLabel.text=@"已读";
                        readStatusLabel.textColor=COLOR_bababa;
                    }else if (model.messageReadStatus==MessageReadStatusUnRead){
                        readStatusLabel.text=@"未读";
                        readStatusLabel.textColor=COLOR_c00000;
                        
                    }
                    
                    [self.contentView addSubview:readStatusLabel];
                    
                    if (model.messageType==MessageTypeVoice) {
                        
                        UILabel *seconds=[[UILabel alloc] init];
                        seconds.textColor=COLOR_999999;
                        seconds.font=[UIFont fontWithName:FONT_REGULAR size:15];
                        seconds.text=[NSString stringWithFormat:@"%d ''",model.duringTime];
                        [self.contentView addSubview:seconds];
                        [seconds mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(contextBack);
                            make.right.mas_equalTo(contextBack.mas_left).offset(-10);;
                        }];
                        
                        [readStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(contextBack);
                            make.right.mas_equalTo(seconds.mas_left).offset(-10);;
                        }];
                        
                    }else{
                        
                        [readStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(contextBack);
                            make.right.mas_equalTo(contextBack.mas_left).offset(-10);;
                        }];
                    }
                
            
                }else if(model.messageSentStatus==MessageSentStatusUnSended){
                    
                    UIButton *unsendButton=[[UIButton alloc] init];
                    [unsendButton setImage:[UIImage imageNamed:@"wechat_resendbut5"] forState:UIControlStateNormal];
                    [unsendButton addTarget:self action:@selector(reSendAction:) forControlEvents:UIControlEventTouchUpInside];
                    [self.contentView addSubview:unsendButton];
                  
                    
                    if (model.messageType==MessageTypeVoice) {
                        
                        UILabel *seconds=[[UILabel alloc] init];
                        seconds.textColor=COLOR_999999;
                        seconds.font=[UIFont fontWithName:FONT_REGULAR size:15];
                        seconds.text=[NSString stringWithFormat:@"%d ''",model.duringTime];
                        [self.contentView addSubview:seconds];
                        [seconds mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(contextBack);
                            make.right.mas_equalTo(contextBack.mas_left).offset(-10);;
                        }];
                        
                        [unsendButton mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(contextBack);
                            make.right.mas_equalTo(seconds.mas_left).offset(-10);;
                        }];
                        
                    }else{
                        [unsendButton mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(contextBack);
                            make.right.mas_equalTo(contextBack.mas_left).offset(-10);;
                        }];
                        
                    }
                
                
               }else if(model.messageSentStatus==MessageSentStatusSending){
                
                  UIActivityIndicatorView *acview=[[UIActivityIndicatorView alloc] init];
                   [acview setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
                  [self.contentView addSubview:acview];
                  [acview mas_makeConstraints:^(MASConstraintMaker *make) {
                      make.centerY.equalTo(contextBack);
                      make.right.mas_equalTo(contextBack.mas_left).offset(-10);;
                   }];
                  [acview startAnimating];
            
            }
        }
        
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuCotrollerWillHidden:) name:UIMenuControllerWillHideMenuNotification object:nil];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuCotrollerDidHidden:) name:UIMenuControllerDidHideMenuNotification object:nil];
    }
    
    
    
 
    
 
    
    return self;
}


-(void)reSendAction:(UIButton *)sender{
    if (self.resendblock) {
        self.resendblock(self.messageModel);
    }
    
}

-(void)handleSingleTap2:(id)sender{
    
    self.coversImageView.hidden=YES;
    
//    [ setMenuVisible:YES animated:NO];
    
    if ([UIMenuController sharedMenuController].isMenuVisible) {
        [UIMenuController sharedMenuController].menuVisible=NO;
    }
    
}

-(void)menuCotrollerWillHidden:(id)sender{
 
    
    if (!self.coversImageView.isHidden) {
          self.coversImageView.hidden=YES;
    }
}
//-(void)menuCotrollerDidHidden:(id)sender{

//     NSLog(@"======###############==");
//}

-(void)setResendClickBlock:(DoubleClickBlock )resendClickBlock{
    
    self.resendblock=resendClickBlock;
}

-(void)setSingleClickBlock:(DoubleClickBlock )singleClickBlock{
    self.singleblock=singleClickBlock;
    
}


-(void)setDoubleClickBlock:(DoubleClickBlock )doubleClickBlock{
    self.doubleblock=doubleClickBlock;
    
}
-(void)handleDoubleTap:(id)sender{
    
    if (self.messageModel.messageType==MessageTypeText) {
        
        if (self.doubleblock) {
            self.doubleblock(self.messageModel);
        }
        
    }
    
}

-(void)handleSingleTap:(id)sender{
    
    if (self.messageModel.messageType!=MessageTypeText) {
        
            if (self.singleblock) {
                self.singleblock(self.messageModel);
            }
    
        if (self.messageModel.messageType==MessageTypeVoice) {
            [self startVoiceAnimation];
            
            __block WeChatCell/*主控制器*/ *weakSelf = self;
            
            
            self.coversImageView.hidden=NO;
            dispatch_time_t delayTime1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
            dispatch_after(delayTime1, dispatch_get_main_queue(), ^{
                self.coversImageView.hidden=YES;
            });
            
            
            dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.messageModel.duringTime * NSEC_PER_SEC));
            
            dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
                [weakSelf stopVoiceAnimation];
            });
        }
        
        
    } 
}
#pragma 长按事件
- (void)longPressBubbleView:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self showMenuControllerInView:self bgView:sender.view];
    }
}
- (void)showMenuControllerInView:(WeChatCell *)inView
                          bgView:(UIView *)supView
{
    

    self.coversImageView.hidden=NO;
    
    
    [self becomeFirstResponder];
    
    MessageModel *messageModel=self.messageModel;
    
    UIMenuItem *copyTextItem1 = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyTextSender1:)];
    UIMenuItem *copyTextItem2 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(copyTextSender2:)];
    UIMenuItem *copyTextItem3 = [[UIMenuItem alloc] initWithTitle:@"保存" action:@selector(copyTextSender2:)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:supView.frame inView:inView];
     [menu setArrowDirection:UIMenuControllerArrowDefault];
    if (messageModel.messageType==MessageTypeText) {
        
       
        
        [menu setMenuItems:@[copyTextItem1,copyTextItem2,copyTextItem3]];
        
    }else if (messageModel.messageType==MessageTypeImage){
        
       
        
        [menu setMenuItems:@[copyTextItem1,copyTextItem2,copyTextItem3]];
        
    }else if(messageModel.messageType==MessageTypeVoice){
        
        
       
      
        [menu setMenuItems:@[copyTextItem1,copyTextItem2,copyTextItem3]];
    }
    
 
   
    
    [menu setMenuVisible:YES animated:YES];
    
}






#pragma mark 剪切板代理方法
-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyTextSender1:)) {
        return true;
    } else  if (action == @selector(copyTextSender2:)) {
        return true;
    } else {
        return false;
    }
}

-(void)copyTextSender1:(id)sender {
    UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
//    pasteboard.string = copiedText;
//    [self.chatCellDelegate showToastViewInCell:self toastText:[MQBundleUtil localizedStringForKey:@"save_text_success"]];
}
-(void)copyTextSender2:(id)sender {
    UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
    //    pasteboard.string = copiedText;
    //    [self.chatCellDelegate showToastViewInCell:self toastText:[MQBundleUtil localizedStringForKey:@"save_text_success"]];
}

-(void)copyImageSender:(id)sender {
//    UIImageWriteToSavedPhotosAlbum(copiedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

//保存到相册的回调
- (void)image:(UIImage *)image
didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    if(error != NULL){
//        [self.chatCellDelegate showToastViewInCell:self toastText:[MQBundleUtil localizedStringForKey:@"save_photo_error"]];
    }else{
//        [self.chatCellDelegate showToastViewInCell:self toastText:[MQBundleUtil localizedStringForKey:@"save_photo_success"]];
    }
}



 
+(CGFloat)tableHeightWithModel:(MessageModel *)model{

    CGFloat masTop=10;
    
    if (model.showMessageTime) {
        
        masTop=37;
    }
         if (model.messageType==MessageTypeText) {
     
        CGFloat maxWith=AppFrameWidth-LEFT_WITH-RIGHT_WITH-14-12-4;
        UIFont *textFont=[UIFont fontWithName:FONT_REGULAR size:16];
        NSDictionary *attributes = @{NSFontAttributeName: textFont};
        
        CGRect rect = [model.messageText boundingRectWithSize:CGSizeMake(maxWith, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height+26+masTop+20;

         }else if (model.messageType==MessageTypeVoice){
             
              return 40+masTop+20;
             
         }else if (model.messageType==MessageTypeImage){
             
               CGSize cgsize=[self imageShowSize:model.imageSmall];
             return 40+cgsize.height+20;
             
         }

    return 0;
}

-(CGFloat)voiceLength:(NSInteger)seconds{
    
    if (seconds==0) {
        return 75;
    }
    
//    6~197 6p~230
    // 75
    
    CGFloat max=AppFrameWidth>750?230:197;

    return 75+(seconds-1)*(max-75)*1.0/60.0;
}



/*
 判断图片长度&宽度
 
 */
+(CGSize)imageShowSize:(UIImage *)image{
    
    CGFloat imageWith=image.size.width;
    CGFloat imageHeight=image.size.height;
    
    //宽度大于高度
    if (imageWith>=imageHeight) {
        // 宽度超过标准宽度
        /*
        if (imageWith>MAX_IMAGE_WH) {
           
        }else{
            
        }
         */

         return CGSizeMake(MAX_IMAGE_WH, imageHeight*MAX_IMAGE_WH/imageWith);
        
        
    }else{
        /*
        if (imageHeight>MAX_IMAGE_WH) {
            
        }else{
            
        }
        */
        return CGSizeMake(imageWith*MAX_IMAGE_WH/imageHeight, MAX_IMAGE_WH);
        
    }

    return CGSizeZero;
}
-(void)startVoiceAnimation{
    [self.voiceAnimationImageView startAnimating];
    
    
}
-(void)stopVoiceAnimation{
    [self.voiceAnimationImageView stopAnimating];
}

-(void)startSentMessageAnimation{
    
}
-(void)stopSentMessageAnimation{
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//调用方法
//
//MessageModel *model=[[MessageModel alloc] init];
//model.showMessageTime=YES;
//model.messageTime=@"11:22";
//model.messageText=@"你好你好你好";
//model.messageSenderType=MessageSenderTypeHantu;
//model.messageType=MessageTypeText;
//[_arrList addObject:model];
//
//model=[[MessageModel alloc] init];
//model.showMessageTime=NO;
//model.messageTime=@"11:23";
//model.messageText=@"n哈哈哈哈哈";
//model.messageSenderType=MessageSenderTypeHantu;
//model.messageType=MessageTypeText;
//[_arrList addObject:model];
//
//model=[[MessageModel alloc] init];
//model.showMessageTime=YES;
//model.messageTime=@"11:25";
//model.messageText=@"你好";
//model.messageSenderType=MessageSenderTypeUser;
//model.messageType=MessageTypeText;
//[_arrList addObject:model];

//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=NO;
//    model.messageTime=@"11:22";
//    model.messageText=@"中央军委主席习近平日";
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeText;
//    model.messageSentStatus=MessageSentStatusUnSended;
//    [_arrList addObject:model];
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=YES;
//    model.messageTime=@"11:22";
//    model.messageText=@"中央军委主席习近平日";
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeText;
//    model.messageSentStatus=MessageSentStatusSended;
//    model.messageReadStatus=MessageReadStatusRead;
//    [_arrList addObject:model];
//
//
//
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=NO;
//    model.messageTime=@"11:22";
//    model.messageText=@"中央军委";
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeText;
//    model.messageSentStatus=MessageSentStatusSended;
//    model.messageReadStatus=MessageReadStatusUnRead;
//    [_arrList addObject:model];
//
//
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=NO;
//    model.messageTime=@"11:22";
//    model.messageText=@"中";
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeText;
//    [_arrList addObject:model];
//
//
//
//
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=NO;
//    model.messageTime=@"11:22";
//    model.duringTime=55;
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeVoice;
//    [_arrList addObject:model];
//
//
//
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=NO;
//    model.messageTime=@"11:22";
//    model.duringTime=55;
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeVoice;
//    [_arrList addObject:model];
//
//
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=YES;
//    model.messageTime=@"11:22";
//    model.duringTime=4;
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeVoice;
//    [_arrList addObject:model];
//
//
//
//
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=NO;
//    model.messageTime=@"11:22";
//    model.duringTime=9;
//    model.messageSentStatus=MessageSentStatusSending;
//    model.messageReadStatus=MessageReadStatusUnRead;
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeVoice;
//    [_arrList addObject:model];
//
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=NO;
//    model.messageTime=@"11:22";
//    model.duringTime=9;
//    model.messageSentStatus=MessageSentStatusUnSended;
//    //    model.messageReadStatus=MessageReadStatusUnRead;
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeVoice;
//    [_arrList addObject:model];
//
//
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=NO;
//    model.messageTime=@"11:22";
//    model.duringTime=9;
//    model.messageSentStatus=MessageSentStatusSended;
//    model.messageReadStatus=MessageReadStatusUnRead;
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeVoice;
//    [_arrList addObject:model];
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=NO;
//    model.messageTime=@"11:22";
//    model.duringTime=9;
//    model.messageSentStatus=MessageSentStatusSended;
//    model.messageReadStatus=MessageReadStatusRead;
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeVoice;
//    [_arrList addObject:model];
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=YES;
//    model.messageTime=@"11:22";
//    model.duringTime=9;
//    model.messageSenderType=MessageSenderTypeHantu;
//    model.messageType=MessageTypeVoice;
//    [_arrList addObject:model];
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=YES;
//    model.messageTime=@"11:22";
//    model.duringTime=9;
//    model.messageSenderType=MessageSenderTypeHantu;
//    model.messageType=MessageTypeImage;
//    model.imageSmall=[UIImage imageNamed:@"WechatIMG4e"];
//    [_arrList addObject:model];
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=YES;
//    model.messageTime=@"11:22";
//    model.duringTime=9;
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeImage;
//    model.messageSentStatus=MessageSentStatusSended;
//    model.messageReadStatus=MessageReadStatusRead;
//    model.imageSmall=[UIImage imageNamed:@"WechatIMG4e"];
//    [_arrList addObject:model];
//
//
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=YES;
//    model.messageTime=@"11:22";
//    model.duringTime=9;
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeImage;
//    model.messageSentStatus=MessageSentStatusSended;
//    model.messageReadStatus=MessageReadStatusUnRead;
//    model.imageSmall=[UIImage imageNamed:@"WechatIMG4e"];
//    [_arrList addObject:model];
//
//
//
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=YES;
//    model.messageTime=@"11:22";
//    model.duringTime=9;
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeImage;
//    model.messageSentStatus=MessageSentStatusSending;
//    model.messageReadStatus=MessageReadStatusRead;
//    model.imageSmall=[UIImage imageNamed:@"WechatIMG4e"];
//    [_arrList addObject:model];
//
//
//
//    model=[[MessageModel alloc] init];
//    model.showMessageTime=YES;
//    model.messageTime=@"11:22";
//    model.duringTime=9;
//    model.messageSenderType=MessageSenderTypeUser;
//    model.messageType=MessageTypeImage;
//    model.messageSentStatus=MessageSentStatusUnSended;
//    model.messageReadStatus=MessageReadStatusRead;
//    model.imageSmall=[UIImage imageNamed:@"WechatIMG4e"];
//    [_arrList addObject:model];

@end
