//
//  HotWordsTableViewCell.h
//  XinHuaNews
//
//  Created by Mc on 2018/10/17.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotWordsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataArray;
@property(nonatomic, copy)void(^hotWordsBlock)(NSString *hotWordsStr) ;


@end
