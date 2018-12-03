//
//  WeatherModel.h
//  XinHuaNews
//
//  Created by Mc on 2018/11/26.
//  Copyright © 2018年 Mc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherModel : NSObject

@property (nonatomic, copy) NSString *nowTempStr;
@property (nonatomic, copy) NSString *tempStr;
@property (nonatomic, copy) NSString *windStr;
@property (nonatomic, copy) NSString *weatherStr;
@property (nonatomic, copy) NSString *airQualityStr;
@property (nonatomic, copy) NSString *sourceStr;

@end

NS_ASSUME_NONNULL_END
